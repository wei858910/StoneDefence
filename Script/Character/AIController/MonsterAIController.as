class AMonsterAIController : ARuleOfTheAIControllerBase
{
    UFUNCTION(BlueprintOverride)
    AActor FindTarget()
    {
        return nullptr;
    }
};