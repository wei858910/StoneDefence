class ABulletBase : AActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    USceneComponent Root;

    UPROPERTY(DefaultComponent)
    USphereComponent BoxDamage;
    default BoxDamage.SetCollisionProfileName(n"BulletProfile");

    UPROPERTY(DefaultComponent, Attach = BoxDamage)
    UStaticMeshComponent BulletMesh;
    default BulletMesh.SetCollisionProfileName(n"NoCollision");

    UPROPERTY(DefaultComponent)
    UProjectileMovementComponent ProjectileMovement;
    default ProjectileMovement.MaxSpeed = 2000.f;
    default ProjectileMovement.InitialSpeed = 1600.f;
    default ProjectileMovement.ProjectileGravityScale = 0.f;
    default ProjectileMovement.UpdatedComponent = BoxDamage;

    UPROPERTY(Category = "Bullet")
    EBulletType BulletType = EBulletType::BulletDirectLine;

    // 子弹伤害特效(碰撞后产生的特效)
    UPROPERTY(Category = "Bullet")
    UParticleSystem DamageParticle;

    // 开火特效
    UPROPERTY(Category = "Bullet")
    UParticleSystem OpenFireParticle;

    UPROPERTY(Category = "Bullet")
    USoundCue Explosion;

    default InitialLifeSpan = 4.f;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        switch (BulletType)
        {
            case EBulletType::BulletDirectLine:
            case EBulletType::BulletLine:
                Gameplay::SpawnEmitterAtLocation(OpenFireParticle, GetActorLocation());
                break;
            case EBulletType::BulletChain:
                ProjectileMovement.StopMovementImmediately();
                // 将碰撞体的碰撞检测功能关闭，
                BoxDamage.SetCollisionEnabled(ECollisionEnabled::NoCollision);
                break;
            default:
                break;
        }

        BoxDamage.OnComponentBeginOverlap.AddUFunction(this, n"OnBeginOverlap");
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
        if (!IsValid(Instigator))
            return;

        switch (BulletType)
        {
            case EBulletType::BulletTrack:
            {
                ApplyBulletTrack();
                break;
            }
            case EBulletType::BulletRange:
            {
                ACharacterBase InstigatorCharacter = Cast<ACharacterBase>(Instigator);
                if (IsValid(InstigatorCharacter))
                {
                    ApplyBulletRange(InstigatorCharacter.GetActorLocation());
                    SetActorTickEnabled(false);
                }
                break;
            }
            case EBulletType::BulletRangeThrow:
            {
                ApplyBulletRangeThrow();
                SetActorTickEnabled(false);

                break;
            }
            default:
                break;
        }
    }

    UFUNCTION()
    private void OnBeginOverlap(UPrimitiveComponent OverlappedComponent, AActor OtherActor, UPrimitiveComponent OtherComp, int OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
    {
        ACharacterBase InstigatorCharacter = Cast<ACharacterBase>(Instigator);
        if (IsValid(InstigatorCharacter))
        {
            ACharacterBase OtherCharacter = Cast<ACharacterBase>(OtherActor);
            if (IsValid(OtherCharacter))
            {
                if (InstigatorCharacter.IsTeam() != OtherCharacter.IsTeam())
                {
                    if (!OtherCharacter.IsDeath())
                    {
                        switch (BulletType)
                        {
                            case EBulletType::BulletLine:
                            case EBulletType::BulletTrack:
                                Gameplay::SpawnEmitterAtLocation(DamageParticle, SweepResult.Location);
                                Gameplay::PlaySound2D(Explosion);
                                Gameplay::ApplyDamage(OtherCharacter, 100.f, InstigatorCharacter.Controller, InstigatorCharacter, UDamageType);
                                DestroyActor();
                                break;
                            case EBulletType::BulletRangeThrow:
                                ApplyBulletRange(GetActorLocation());
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
        }
    }

    private void ApplyBulletTrack()
    {
        AAIControllerBase InstigatorCharacterController = Cast<AAIControllerBase>(Instigator.Controller);
        if (IsValid(InstigatorCharacterController))
        {
            ACharacterBase TargetCharacter = InstigatorCharacterController.Target.Get();
            ProjectileMovement.HomingAccelerationMagnitude = 4000.0;
            ProjectileMovement.SetHomingTargetComponent(TargetCharacter.GetHomingPoint());
            SetActorTickEnabled(false);
        }
    }

    private void ApplyBulletRange(const FVector& OriginLocation)
    {
        ACharacterBase InstigatorCharacter = Cast<ACharacterBase>(Instigator);
        if (IsValid(InstigatorCharacter))
        {
            ProjectileMovement.StopMovementImmediately();
            TArray<ACharacterBase> AllActorsArr;
            TArray<ACharacterBase> IgnorActorsArr;
            TArray<ACharacterBase> TargetActorsArr;
            GetAllActorsOfClass(ACharacterBase, AllActorsArr);

            FVector CurrentLocation = GetActorLocation();

            for (auto ItemActor : AllActorsArr)
            {
                FVector ItemLocation = ItemActor.GetActorLocation();
                FVector DistanceVector = ItemLocation - CurrentLocation;
                if (DistanceVector.Size() <= 1400.f)
                {
                    if (ItemActor.IsTeam() == InstigatorCharacter.IsTeam())
                    {
                        IgnorActorsArr.Add(ItemActor);
                    }
                    else
                    {
                        // 生成伤害特效
                        Gameplay::SpawnEmitterAtLocation(DamageParticle, ItemLocation);
                        TargetActorsArr.Add(ItemActor);
                    }
                }
            }
            Gameplay::ApplyRadialDamageWithFalloff(100.f, 10.f, OriginLocation, 400.f, 1000.f, 1.f, UDamageType, IgnorActorsArr, Instigator);
            DestroyActor();
        }
    }

    private void ApplyBulletRangeThrow()
    {
        ACharacterBase InstigatorCharacter = Cast<ACharacterBase>(Instigator);
        if (IsValid(InstigatorCharacter))
        {
            AAIControllerBase InstigatorCharacterController = Cast<AAIControllerBase>(InstigatorCharacter.Controller);
            if (IsValid(InstigatorController))
            {
                ACharacterBase TargetCharacter = InstigatorCharacterController.Target.Get();
                if (IsValid(TargetCharacter))
                {
                    ProjectileMovement.ProjectileGravityScale = 1.f;
                    FVector ToTargetVector = TargetCharacter.GetActorLocation() - GetActorLocation();
                    float   InTime = (ToTargetVector.Size() / ProjectileMovement.InitialSpeed);
                    float   Y = ProjectileMovement.GetGravityZ() * InTime;
                    float   X = ProjectileMovement.InitialSpeed * InTime;
                    float   V = Math::Sqrt(X * X + Y * Y);

                    float    CosRadian = Math::Acos(ToTargetVector.Size() / V * (InTime * (PI * 0.1f)));
                    FRotator Rot = GetActorRotation();
                    Rot.Pitch = CosRadian * (180.f / PI);
                    SetActorRotation(Rot);
                    ProjectileMovement.SetVelocityInLocalSpace(FVector(1.0, 0.0, 0.0) * ProjectileMovement.InitialSpeed);
                }
            }
        }
    }
};