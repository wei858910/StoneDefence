class UUIGameMenuSystem : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UButton ReturnGameButton;

    UPROPERTY(BindWidget)
    UButton SaveGameButton;

    UPROPERTY(BindWidget)
    UButton GameSettingButton;

    UPROPERTY(BindWidget)
    UButton GameQuitButton;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        ReturnGameButton.OnClicked.AddUFunction(this, n"ReturnGame");
        SaveGameButton.OnClicked.AddUFunction(this, n"SaveGame");
        GameSettingButton.OnClicked.AddUFunction(this, n"GameSetting");
        GameQuitButton.OnClicked.AddUFunction(this, n"GameQuit");
    }

    UFUNCTION()
    private void ReturnGame()
    {
    }

    UFUNCTION()
    private void SaveGame()
    {
    }

    UFUNCTION()
    private void GameSetting()
    {
    }

    UFUNCTION()
    private void GameQuit()
    {
    }
};