class ATowers : ARuleOfTheCharacter
{
    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    UParticleSystemComponent ParticleMesh;

    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    UStaticMeshComponent StaticMeshBuilding;

    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    UChaosDestructionListener DestructibleMeshBuilding;

    UFUNCTION(BlueprintOverride)
    protected void AnyDamage(float Damage, const UDamageType DamageType, AController InstigatedBy, AActor DamageCauser)
    {
        Super::AnyDamage(Damage, DamageType, InstigatedBy, DamageCauser);
    }
};
