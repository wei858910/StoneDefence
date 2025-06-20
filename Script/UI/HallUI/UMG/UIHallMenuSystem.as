class UUIHallMenuSystem : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UButton GameStartButton;

    UPROPERTY(BindWidget)
    UButton SecretTerritoryButton;

    UPROPERTY(BindWidget)
    UButton HistoryButton;

    UPROPERTY(BindWidget)
    UButton GameSettingsButton;

    UPROPERTY(BindWidget)
    UButton TutorialWebsiteButton;

    UPROPERTY(BindWidget)
    UButton BrowserButton;

    UPROPERTY(BindWidget)
    UButton SpecialContentButton;

    UPROPERTY(BindWidget)
    UButton QuitGameButton;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
    }

    void BindGameStart(FOnButtonClickedEvent OnClickedEvent)
    {
        GameStartButton.OnClicked = OnClickedEvent;
    }

    void BindSecretTerritory(FOnButtonClickedEvent OnClickedEvent)
    {
        SecretTerritoryButton.OnClicked = OnClickedEvent;
    }

    void BindHistory(FOnButtonClickedEvent OnClickedEvent)
    {
        HistoryButton.OnClicked = OnClickedEvent;
    }

    void BindGameSettings(FOnButtonClickedEvent OnClickedEvent)
    {
        GameSettingsButton.OnClicked = OnClickedEvent;
    }

    void BindTutorialWebsite(FOnButtonClickedEvent OnClickedEvent)
    {
        TutorialWebsiteButton.OnClicked = OnClickedEvent;
    }

    void BindBrowser(FOnButtonClickedEvent OnClickedEvent)
    {
        BrowserButton.OnClicked = OnClickedEvent;
    }

    void BindSpecialContent(FOnButtonClickedEvent OnClickedEvent)
    {
        SpecialContentButton.OnClicked = OnClickedEvent;
    }

    void BindQuitGame(FOnButtonClickedEvent OnClickedEvent)
    {
        QuitGameButton.OnClicked = OnClickedEvent;
    }
};
