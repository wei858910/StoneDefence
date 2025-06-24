class AAIControllerBase : AAIController
{
    TWeakObjectPtr<ACharacterBase> Target;

    AActor FindTarget()
    {
        return nullptr;
    }

    void AttackTarget(ACharacterBase TargetCharacter)
    {
    }
};