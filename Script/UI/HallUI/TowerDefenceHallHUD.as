
class ATowerDefenceHallHUD : AHUD
{
    private TSubclassOf<UUIMainHall> MainHallClass;

    private UUIMainHall MainHall;

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        MainHallClass = Cast<UClass>(LoadObject(nullptr, "/Game/UI/Hall/UIBP_MainHall.UIBP_MainHall_C"));
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        auto PC = Utils::GetDefaultPlayerController();
        if (PC != nullptr)
        {
            MainHall = Cast<UUIMainHall>(WidgetBlueprint::CreateWidget(MainHallClass, PC));
            if (MainHall != nullptr)
            {
                MainHall.AddToViewport();
            }
        }
    }
};