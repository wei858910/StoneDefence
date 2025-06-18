class ATowerDefencePlayerController : ATowerDefencePlayerControllerBase
{
    UPROPERTY(Category = "Input")
    UInputMappingContext IMC;

    UPROPERTY(Category = "Input")
    UInputAction IAMouseWheel;

    UPROPERTY(DefaultComponent, Category = "Input")
    UEnhancedInputComponent EnhancedInputComponent;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        EnhancedInputComponent = UEnhancedInputComponent::Create(this);
        this.PushInputComponent(EnhancedInputComponent);
        UEnhancedInputLocalPlayerSubsystem EnhancedInputSystem = UEnhancedInputLocalPlayerSubsystem::Get(this);
        if (EnhancedInputSystem != nullptr)
        {
            IMC = Cast<UInputMappingContext>(LoadObject(nullptr, "/Game/Input/IMC.IMC"));
            IAMouseWheel = Cast<UInputAction>(LoadObject(nullptr, "/Game/Input/IA_MouseWheel.IA_MouseWheel"));
            if (IMC != nullptr && IAMouseWheel != nullptr)
            {
                EnhancedInputSystem.AddMappingContext(IMC, 0, FModifyContextOptions());
                EnhancedInputComponent.BindAction(IAMouseWheel, ETriggerEvent::Triggered, FEnhancedInputActionHandlerDynamicSignature(this, n"OnMouseWheelMove"));
            }
        }
    }

    UFUNCTION()
    private void OnMouseWheelMove(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction)
    {
        float WheelValue = ActionValue.GetAxis1D();
        Print(f"{WheelValue}");

        ATowerDefenceGameCamera GameCamera = Cast<ATowerDefenceGameCamera>(GetControlledPawn());
        if (GameCamera == nullptr)
            return;

        float32 ZoomSpeed = 20.f;

        if (WheelValue > 0)
        {
            // Wheel Up
            GameCamera.Zoom(true, ZoomSpeed);
        }
        else
        {
            // Wheel Down
            GameCamera.Zoom(false, ZoomSpeed);
        }
    }
};