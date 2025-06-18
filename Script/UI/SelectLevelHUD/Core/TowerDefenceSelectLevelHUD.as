class ATowerDefenceSelectLevelHUD : AHUD
{
    private
    TSubclassOf<UUISelectLevelMain> SelectLevelMainClass;

    private
    UUISelectLevelMain SelectLevelMain;

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        SelectLevelMainClass = Cast<UClass>(LoadObject(nullptr, "/Game/UI/Select/UIBP_SelectLevelMain.UIBP_SelectLevelMain_C"));
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        if (IsValid(SelectLevelMainClass))
        {
            auto PC = Global::GetDefaultPlayerController();
            if (IsValid(PC))
            {
                SelectLevelMain = Cast<UUISelectLevelMain>(WidgetBlueprint::CreateWidget(SelectLevelMainClass, PC));
                if (IsValid(SelectLevelMain))
                {
                    SelectLevelMain.AddToViewport();
                }
            }
        }
    }
};