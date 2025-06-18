class UUILevelButton : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UBorder LevelBorder;

    UPROPERTY(BindWidget)
    UButton NextLevelButton;

    UPROPERTY(BindWidget)
    UProgressBar LevelProBar;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        NextLevelButton.OnClicked.AddUFunction(this, n"SelectLevel");
    }

    UFUNCTION()
    void SelectLevel()
    {
        Gameplay::OpenLevel(n"TestMap");
    }
};