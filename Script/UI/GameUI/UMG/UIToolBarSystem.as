class UUIToolBarSystem : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UTextBlock GameGold;

    UPROPERTY(BindWidget)
    UTextBlock TowersDeathNumber;

    UPROPERTY(BindWidget)
    UTextBlock GameCount;

    UPROPERTY(BindWidget)
    UTextBlock KillSoldier;

    UPROPERTY(BindWidget)
    UTextBlock GameLevelSurplusQuantity;

    UPROPERTY(BindWidget)
    UProgressBar GSQProgressBar;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
    }
};