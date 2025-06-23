class ABulletBase : AActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    USceneComponent Root;

    UPROPERTY(DefaultComponent)
    USphereComponent BoxDamage;

    UPROPERTY(DefaultComponent)
    UStaticMeshComponent BulletMesh;

    UPROPERTY(DefaultComponent)
    UProjectileMovementComponent ProjectileMovement;
    default ProjectileMovement.MaxSpeed = 2000.0;
    default ProjectileMovement.InitialSpeed = 1600.0;
    default ProjectileMovement.ProjectileGravityScale = 0.0;
    default ProjectileMovement.UpdatedComponent = BoxDamage;

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