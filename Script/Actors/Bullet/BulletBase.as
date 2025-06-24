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
                Gameplay::SpawnEmitterAtLocation(OpenFireParticle, GetActorLocation());
                break;
            case EBulletType::BulletLine:
                Gameplay::SpawnEmitterAtLocation(OpenFireParticle, GetActorLocation());
                break;
            case EBulletType::BulletTrackLine:
            {
                Gameplay::SpawnEmitterAtLocation(OpenFireParticle, GetActorLocation());
                // 开启此标志后，子弹会自动追踪目标
                ProjectileMovement.bIsHomingProjectile = true;
                // 设置为 true 时，子弹的旋转会跟随其速度方向，
                // 使得子弹在飞行过程中始终朝向其运动方向，保证视觉效果的合理性
                ProjectileMovement.bRotationFollowsVelocity = true;
                break;
            }
            case EBulletType::BulletRangeLine:
                ProjectileMovement.StopMovementImmediately();
                break;
            case EBulletType::BulletRange:
                break;
            case EBulletType::BulletChain:
                // 立即停止子弹的运动
                // 可能是在特定逻辑触发后需要让子弹停止飞行
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
        if (BulletType == EBulletType::BulletTrackLine)
        {
            if (IsValid(Instigator))
            {
                AAIControllerBase AIControllerBase = Cast<AAIControllerBase>(Instigator.Controller);
                if (IsValid(AIControllerBase))
                {
                    ACharacterBase TargetCharacter = AIControllerBase.Target.Get();
                    ProjectileMovement.HomingAccelerationMagnitude = 4000.0;
                    ProjectileMovement.SetHomingTargetComponent(TargetCharacter.GetHomingPoint());
                    SetActorTickEnabled(false);
                }
            }
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
                            case EBulletType::BulletTrackLine:
                                Gameplay::SpawnEmitterAtLocation(DamageParticle, SweepResult.Location);
                                Gameplay::PlaySound2D(Explosion);
                                Gameplay::ApplyDamage(OtherCharacter, 100.f, InstigatorCharacter.Controller, InstigatorCharacter, UDamageType);
                                DestroyActor();
                                break;
                            case EBulletType::BulletRange:
                            {
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
                                Gameplay::ApplyRadialDamageWithFalloff(100.f, 10.f, InstigatorCharacter.GetActorLocation(), 400.f, 1000.f, 1.f, UDamageType, IgnorActorsArr, Instigator);
                                DestroyActor();
                                break;
                            }
                            default:
                                break;
                        }
                    }
                }
            }
        }
    }
};