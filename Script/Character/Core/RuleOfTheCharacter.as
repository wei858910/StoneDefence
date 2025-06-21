class ARuleOfTheCharacter : ACharacter
{
    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    USceneComponent HomingPoint;

    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    UWidgetComponent Widget;

    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    UArrowComponent OpenFirePoint;

    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    UBoxComponent TraceShowCharacterInformation;
    default TraceShowCharacterInformation.SetCollisionProfileName(n"Scanning");
    default TraceShowCharacterInformation.SetBoxExtent(FVector(38., 38., 100.));

    UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    FRotator TowersRotator;

    UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "AnimAttribute")
    bool bAttack = false;

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        OpenFirePoint.AttachToComponent(Mesh, n"OpenFire", EAttachmentRule::KeepRelative);
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
    }

    UFUNCTION(BlueprintOverride)
    void AnyDamage(float Damage, const UDamageType DamageType, AController InstigatedBy, AActor DamageCauser)
    {
    }

    UFUNCTION()
    protected bool IsDeath()
    {
        return false;
    }

    UFUNCTION()
    protected float GetHealth()
    {
        return 0.;
    }

    UFUNCTION()
    protected float GetMaxHealth()
    {
        return 0.;
    }

    UFUNCTION()
    protected bool IsTeam()
    {
        return false;
    }

    USceneComponent GetHomingPoint() const
    {
        return HomingPoint;
    }

    UArrowComponent GetFirePoint() const
    {
        return OpenFirePoint;
    }

    UFUNCTION(BlueprintPure, Category = "Towers|Attribute")
    bool IsActive()
    {
        return !IsDeath();
    }

    EGameCharacterType GetType()
    {
        return EGameCharacterType::MAX;
    }
};
