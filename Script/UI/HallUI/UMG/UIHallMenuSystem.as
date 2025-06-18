class UUIHallMenuSystem : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UButton GameStartButton;

    UPROPERTY(BindWidget)
    UButton HistoryButton;

    UPROPERTY(BindWidget)
    UButton GameSettingsButton;

    UPROPERTY(BindWidget)
    UButton TutorialWebsiteButton;

    UPROPERTY(BindWidget)
    UButton BrowserButton;

    UPROPERTY(BindWidget)
    UButton QuitGameButton;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        GameStartButton.OnClicked.AddUFunction(this, n"GameStart");
        HistoryButton.OnClicked.AddUFunction(this, n"History");
        GameSettingsButton.OnClicked.AddUFunction(this, n"GameSettings");
        TutorialWebsiteButton.OnClicked.AddUFunction(this, n"TutorialWebsite");
        BrowserButton.OnClicked.AddUFunction(this, n"Browser");
        QuitGameButton.OnClicked.AddUFunction(this, n"QuitGame");
    }

    UFUNCTION()
    private void GameStart()
    {
        Gameplay::OpenLevel(n"SelectMap");
    }

    UFUNCTION()
    private void History()
    {
    }

    UFUNCTION()
    private void GameSettings()
    {
    }

    UFUNCTION()
    private void TutorialWebsite()
    {
    }

    UFUNCTION()
    private void Browser()
    {
    }

    UFUNCTION()
    private void QuitGame()
    {
    }
};