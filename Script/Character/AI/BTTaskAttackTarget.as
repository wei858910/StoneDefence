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
                ACharacterBase Monster = Cast<ACharacterBase>(ControlledPawn);
                if (IsValid(Monster))
                {
                    ACharacterBase TowerObject = Cast<ACharacterBase>(MonsterBlackBoard.GetValueAsObject(n"Target"));
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