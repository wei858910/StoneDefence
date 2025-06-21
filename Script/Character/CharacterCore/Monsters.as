class AMonsters : ARuleOfTheCharacter
{
    default CapsuleComponent.SetCollisionProfileName(n"MonsterProfile");
    default Mesh.SetCollisionProfileName(n"NoCollision");

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
};