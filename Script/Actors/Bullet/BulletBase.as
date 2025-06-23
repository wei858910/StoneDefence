class ABulletBase : AActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    USceneComponent Root;

    UPROPERTY(DefaultComponent)
    USphereComponent BoxDamage;

    UPROPERTY(DefaultComponent, Attach = BoxDamage)
    UStaticMeshComponent BulletMesh;

    UPROPERTY(DefaultComponent)
    UProjectileMovementComponent ProjectileMovement;
    default ProjectileMovement.MaxSpeed = 2000.f;
    default ProjectileMovement.InitialSpeed = 1600.f;
    default ProjectileMovement.ProjectileGravityScale = 0.f;
    default ProjectileMovement.UpdatedComponent = BoxDamage;

    default InitialLifeSpan = 4.f;

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        BoxDamage.OnComponentBeginOverlap.AddUFunction(this, n"OnBeginOverlap");
    }

    UFUNCTION()
    private void OnBeginOverlap(UPrimitiveComponent OverlappedComponent, AActor OtherActor, UPrimitiveComponent OtherComp, int OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
    {
    }
};