class AMonsters : ACharacterBase
{
    default CapsuleComponent.SetCollisionProfileName(n"MonsterProfile");
    default Mesh.SetCollisionProfileName(n"NoCollision");
    default AIControllerClass = AMonsterAIController;

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        Super::ConstructionScript();
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        Super::BeginPlay();
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
        Super::Tick(DeltaSeconds);
    }

    EGameCharacterType GetType() override
    {
        return EGameCharacterType::MONSTER;
    }

    bool IsTeam() override
    {
        return false;
    }
};