class UUISelectLevelMain : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UButton ReturnMenuButton;

    UPROPERTY(BindWidget)
    UCanvasPanel SelectMap;

    private
    TArray<UUILevelButton> AllLevelButton;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        InitSelectLevelButton();
        ReturnMenuButton.OnClicked.AddUFunction(this, n"ReturnMenu");
    }

    protected
    void InitSelectLevelButton()
    {
        if (IsValid(SelectMap))
        {
            for (auto ChildWidget : SelectMap.AllChildren)
            {
                auto LevelButtonWidget = Cast<UUILevelButton>(ChildWidget);
                if (IsValid(LevelButtonWidget))
                {
                    AllLevelButton.Add(LevelButtonWidget);
                }
            }
        }
    }

    UFUNCTION()
    protected
    void ReturnMenu()
    {
        Gameplay::OpenLevel(n"HallMap");
    }
};
