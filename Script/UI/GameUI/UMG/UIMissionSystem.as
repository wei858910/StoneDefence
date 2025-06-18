class UUIMissionSystem : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UTextBlock ConditionBase;

    UPROPERTY(BindWidget)
    UTextBlock ConditionA;

    UPROPERTY(BindWidget)
    UTextBlock ConditionB;

    UPROPERTY(BindWidget)
    UButton ConditionButton;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        ConditionButton.OnClicked.AddUFunction(this, n"Condition");
    }

    UFUNCTION()
    private void Condition()
    {
    }
};