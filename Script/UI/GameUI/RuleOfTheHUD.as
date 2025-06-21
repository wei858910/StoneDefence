class ARuleOfTheHUD : AHUD
{
    private TSubclassOf<UUIMainScreen> MainScreenClass;

    private UUIMainScreen MainScreen;

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        MainScreenClass = Cast<UClass>(LoadObject(nullptr, "/Game/UI/Game/UIBP_MainScreen.UIBP_MainScreen_C"));
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        if (IsValid(MainScreenClass))
        {
            auto PC = Utils::GetDefaultPlayerController();
            if (IsValid(PC))
            {
                MainScreen = Cast<UUIMainScreen>(WidgetBlueprint::CreateWidget(MainScreenClass, PC));
                if (IsValid(MainScreen))
                {
                    MainScreen.AddToViewport();
                }
            }
        }
    }
};