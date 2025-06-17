class ATowerDefenceGameCamera : APawn
{
    default PrimaryActorTick.bStartWithTickEnabled = false;

    UPROPERTY(DefaultComponent, RootComponent, Category = "Camera")
    USpringArmComponent CameraBoom;
    default CameraBoom.TargetArmLength = 800.f;
    default CameraBoom.RelativeRotation = FRotator(-60., 0., 0.);

    UPROPERTY(DefaultComponent, Attach = CameraBoom, Category = "Camera")
    UCameraComponent MainCamera;

    // 摄像机碰撞
    UPROPERTY(DefaultComponent, Attach = CameraBoom, Category = "Camera")
    UBoxComponent MarkBox;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
    }
};