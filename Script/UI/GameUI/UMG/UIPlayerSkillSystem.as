class UUIPlayerSkillSystem : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UUISkillSlot FreezeSkill;

    UPROPERTY(BindWidget)
    UUISkillSlot ExplosionSkill;

    UPROPERTY(BindWidget)
    UUISkillSlot RecoverySkill;

    UPROPERTY(BindWidget)
    UUISkillSlot RecoveryMainTowerSkill;

    private
    FKey FreezeSkillKey;

    private
    FKey ExplosionSkillKey;

    private
    FKey RecoverySkillKey;

    private
    FKey RecoveryMainTowerSkillKey;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        auto KeyMapping = UInputSettings.GetDefaultObject().ActionMappings.FindIndex(FInputActionKeyMapping());
    }
};