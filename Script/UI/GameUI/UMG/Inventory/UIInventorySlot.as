class UUIInventorySlot : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UImage TowersIcon;

    UPROPERTY(BindWidget)
    UImage TowersCD;

    UPROPERTY(BindWidget)
    UTextBlock TowersPrepareBuildingNumber;

    UPROPERTY(BindWidget)
    UTextBlock TowersCompletionOfConstructionNumber;

    UPROPERTY(BindWidget)
    UTextBlock TowersCDValue;

    UPROPERTY(BindWidget)
    UButton TowersInventorySlotButton;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        TowersInventorySlotButton.OnClicked.AddUFunction(this, n"OnClickedWidget");
    }

    UFUNCTION()
    private void OnClickedWidget()
    {
    }
};