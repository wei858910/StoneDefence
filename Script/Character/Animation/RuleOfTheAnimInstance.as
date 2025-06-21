class URuleOfTheAnimInstance : UAnimInstance
{
    ARuleOfTheCharacter AnimOwner;

    UPROPERTY(BlueprintReadOnly, Category = "AnimAttribute")
    FRotator TargetRotator = FRotator::ZeroRotator;

    UPROPERTY(BlueprintReadOnly, Category = "AnimAttribute")
    bool bIsDeath = false;

    UPROPERTY(BlueprintReadOnly, Category = "AnimAttribute")
    bool bIsAttack = false;

    UPROPERTY(BlueprintReadOnly, Category = "AnimAttribute")
    float Speed = 0;

    UFUNCTION(BlueprintOverride)
    void BlueprintInitializeAnimation()
    {
        AnimOwner = Cast<ARuleOfTheCharacter>(TryGetPawnOwner());
    }

    UFUNCTION(BlueprintOverride)
    void BlueprintUpdateAnimation(float DeltaTimeX)
    {
        if (IsValid(AnimOwner))
        {
            TargetRotator = AnimOwner.TowersRotator;
            bIsDeath = AnimOwner.IsDeath();
            Speed = AnimOwner.GetVelocity().Size();
            bIsAttack = AnimOwner.bAttack;
        }
    }
};