class UUIMainScreen : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UUIGameMenuSystem GameMenuSystem;

    UPROPERTY(BindWidget)
    UUIGameInfoPrintSystem GameInfoPrintSystem;

    UPROPERTY(BindWidget)
    UUIMiniMapSystem MiniMapSystem;

    UPROPERTY(BindWidget)
    UUIMissionSystem MissionSystem;

    UPROPERTY(BindWidget)
    UUIPlayerSkillSystem PlayerSkillSystem;

    UPROPERTY(BindWidget)
    UUIRucksackSystem RucksackSystem;

    UPROPERTY(BindWidget)
    UUIToolBarSystem ToolBarSystem;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        
    }
};