class UBTTaskAttackTarget : UBTTask_BlueprintBase
{
    UFUNCTION(BlueprintOverride)
    void ExecuteAI(AAIController OwnerController, APawn ControlledPawn)
    {
        AMonsterAIController MonsterAIController = Cast<AMonsterAIController>(OwnerController);
        if (IsValid(MonsterAIController))
        {
            UBlackboardComponent MonsterBlackBoard = AIHelper::GetBlackboard(ControlledPawn);
            if (IsValid(MonsterBlackBoard))
            {
                ARuleOfTheCharacter Monster = Cast<ARuleOfTheCharacter>(ControlledPawn);
                if (IsValid(Monster))
                {
                    ARuleOfTheCharacter TowerObject = Cast<ARuleOfTheCharacter>(MonsterBlackBoard.GetValueAsObject(n"Target"));
                    if (IsValid(TowerObject))
                    {

                        Monster.bAttack = true;
                        MonsterAIController.AttackTarget(TowerObject);
                    }
                    else
                    {
                        Monster.bAttack = false;
                    }
                }
            }
        }
    }
};