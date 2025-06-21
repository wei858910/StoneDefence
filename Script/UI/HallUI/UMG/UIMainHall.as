class UUIMainHall : UUUIRuleOfTheWidgetBase
{
    UPROPERTY(BindWidget)
    UUIHallMenuSystem HallMenuSystem;

    UPROPERTY(BindWidget)
    UBorder MainBorder;

    UPROPERTY(BindWidget)
    USizeBox BoxList;

    UPROPERTY(EditDefaultsOnly, Category = UI)
    TSubclassOf<UUIArchivesSystem> ArchivesSystemClass;

    UPROPERTY(EditDefaultsOnly, Category = UI)
    TSubclassOf<UUIGameSettingsSystem> GameSettingsSystemClass;

    UPROPERTY(EditDefaultsOnly, Category = UI)
    TSubclassOf<UUITutorialSystem> TutorialSystemClass;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        if (IsValid(HallMenuSystem))
        {
            {
                FOnButtonClickedEvent Delegate;
                Delegate.AddUFunction(this, n"GameStart");
                HallMenuSystem.BindGameStart(Delegate);
            }
            {
                FOnButtonClickedEvent Delegate;
                Delegate.AddUFunction(this, n"SecretTerritory");
                HallMenuSystem.BindSecretTerritory(Delegate);
            }
            {
                FOnButtonClickedEvent Delegate;
                Delegate.AddUFunction(this, n"History");
                HallMenuSystem.BindHistory(Delegate);
            }
            {
                FOnButtonClickedEvent Delegate;
                Delegate.AddUFunction(this, n"GameSettings");
                HallMenuSystem.BindGameSettings(Delegate);
            }
            {
                FOnButtonClickedEvent Delegate;
                Delegate.AddUFunction(this, n"TutorialWebsite");
                HallMenuSystem.BindTutorialWebsite(Delegate);
            }
            {
                FOnButtonClickedEvent Delegate;
                Delegate.AddUFunction(this, n"Browser");
                HallMenuSystem.BindBrowser(Delegate);
            }
            {
                FOnButtonClickedEvent Delegate;
                Delegate.AddUFunction(this, n"SpecialContent");
                HallMenuSystem.BindSpecialContent(Delegate);
            }
            {
                FOnButtonClickedEvent Delegate;
                Delegate.AddUFunction(this, n"QuitGame");
                HallMenuSystem.BindQuitGame(Delegate);
            }
        }
    }

    UFUNCTION()
    private void GameStart()
    {
        Gameplay::OpenLevel(n"SelectMap");
    }

    UFUNCTION()
    private void SecretTerritory()
    {
    }

    UFUNCTION()
    private void History()
    {
        Utils::CreateAssistWidget(ArchivesSystemClass, BoxList);
    }

    UFUNCTION()
    private void GameSettings()
    {
        Utils::CreateAssistWidget(GameSettingsSystemClass, BoxList);
    }

    UFUNCTION()
    private void TutorialWebsite()
    {
        Utils::CreateAssistWidget(TutorialSystemClass, BoxList);
    }

    UFUNCTION()
    private void Browser()
    {
    }

    UFUNCTION()
    private void SpecialContent()
    {
    }

    UFUNCTION()
    private void QuitGame()
    {
    }
};