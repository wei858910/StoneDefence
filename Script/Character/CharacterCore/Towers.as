class ATowers : ARuleOfTheCharacter
{
    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    UParticleSystemComponent ParticleMesh;
    default ParticleMesh.SetCollisionProfileName(n"NoCollision");

    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    UStaticMeshComponent StaticMeshBuilding;
    default StaticMeshBuilding.SetCollisionProfileName(n"NoCollision");

    UPROPERTY(DefaultComponent, VisibleAnywhere, BlueprintReadOnly, Category = "BaseAttribute")
    UChaosDestructionListener DestructibleMeshBuilding;

    default CapsuleComponent.SetCollisionProfileName(n"TowersProfile");
    default Mesh.SetCollisionProfileName(n"NoCollision");

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        Super::ConstructionScript();
        ParticleMesh.AttachToComponent(RootComponent, AttachmentRule = EAttachmentRule::KeepRelative);
        StaticMeshBuilding.AttachToComponent(RootComponent, AttachmentRule = EAttachmentRule::KeepRelative);
    }

    UFUNCTION(BlueprintOverride)
    protected void AnyDamage(float Damage, const UDamageType DamageType, AController InstigatedBy, AActor DamageCauser)
    {
        Super::AnyDamage(Damage, DamageType, InstigatedBy, DamageCauser);
    }
};
