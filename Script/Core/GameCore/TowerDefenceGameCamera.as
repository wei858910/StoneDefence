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

    float32 MaxArmLength = 800.f;
    float32 MinArmLength = 400.f;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
    }

    void Zoom(bool bDrection, const float32& ZoomSpeed)
    {

        if (bDrection)
        {
            if (CameraBoom.TargetArmLength > MinArmLength)
            {
                CameraBoom.TargetArmLength -= ZoomSpeed;
            }
        }
        else
        {
            if (CameraBoom.TargetArmLength < MaxArmLength)
            {
                CameraBoom.TargetArmLength += ZoomSpeed;
            }
        }
    }
};