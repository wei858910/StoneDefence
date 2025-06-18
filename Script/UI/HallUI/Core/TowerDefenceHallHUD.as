
class ATowerDefenceHallHUD : AHUD
{
    private TSubclassOf<UUIMainHall> MainHallClass;

    private UUIMainHall MainHall;

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        MainHallClass = Cast<UClass>(LoadObject(nullptr, "/Game/UI/Hall/UBP_MainHall.UBP_MainHall_C"));
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        auto PC = Global::GetDefaultPlayerController();
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