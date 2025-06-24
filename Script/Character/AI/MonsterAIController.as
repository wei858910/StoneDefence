class AMonsterAIController : AAIControllerBase
{
    UPROPERTY()
    UBehaviorTree BT;
    default BT = Cast<UBehaviorTree>(FindObject(nullptr, "/Game/Character/Monster/AI/BT_Monster.BT_Monster"));

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        if (IsValid(BT))
        {
            RunBehaviorTree(BT);
        }
    }

    AActor FindTarget() override
    {
        TArray<ATowers> TargetMainTowersArray;
        TArray<ATowers> TargetTowersArray;

        GetAllActorsOfClass(ATowers, TargetTowersArray);
        for (auto& Item : TargetTowersArray)
        {
            if (Item.GetType() == EGameCharacterType::MAIN_TOWER)
            {
                TargetMainTowersArray.Add(Item);
            }
        }

        for (auto& Item : TargetTowersArray)
        {
            if (Item.GetType() == EGameCharacterType::MAIN_TOWER)
            {
                TargetTowersArray.Remove(Item);
            }
        }

        ATowers MainTower = Cast<ATowers>(Utils::GetNearestTarget(TargetMainTowersArray, ControlledPawn.GetActorLocation()));
        ATowers NormalTower = Cast<ATowers>(Utils::GetNearestTarget(TargetTowersArray, ControlledPawn.GetActorLocation()));

        if (IsValid(MainTower))
        {
            return MainTower;
        }

        return NormalTower;
    }

    void AttackTarget(ACharacterBase TargetCharacter) override
    {
        
    }
};