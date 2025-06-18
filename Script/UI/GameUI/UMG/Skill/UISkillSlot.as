class UUISkillSlot : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UImage SkillIcon;

    UPROPERTY(BindWidget)
    UImage SkillIconCD;

    UPROPERTY(BindWidget)
    UTextBlock SkillNumber;

    UPROPERTY(BindWidget)
    UTextBlock KeyValueNumber;

    UPROPERTY(BindWidget)
    UTextBlock SkillCDValue;

    UPROPERTY(BindWidget)
    UButton ClickButton;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        ClickButton.OnClicked.AddUFunction(this, n"OnClickedWidget");
    }

    UFUNCTION()
    private void OnClickedWidget()
    {
    }
};
