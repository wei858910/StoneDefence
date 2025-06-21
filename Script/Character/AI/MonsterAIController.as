class AMonsterAIController : ARuleOfTheAIController
{
    UPROPERTY()
    UBehaviorTree BT;

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        BT = Cast<UBehaviorTree>(FindObject(nullptr, "/Game/Character/Monster/AI/BT_Monster.BT_Monster"));
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        if (IsValid(BT))
        {
            RunBehaviorTree(BT);
        }
    }

    ATowers GetNearestTower(TArray<ATowers>& TowersArray)
    {
        if (TowersArray.Num() > 0)
        {
            float   TowerTargetDistance = MAX_dbl;
            int32   TowerIndex = -1;
            FVector MyLocation = GetControlledPawn().GetActorLocation();

            for (int32 i = 0; i < TowersArray.Num(); i++)
            {
                ATowers TowerCharacter = TowersArray[i];
                if (IsValid(TowerCharacter))
                {
                    FVector TowerLocation = TowerCharacter.GetActorLocation();
                    FVector TempVector = TowerLocation - MyLocation;
                    float   TowerAndMonsterDistance = TempVector.Size();
                    if (TowerAndMonsterDistance < TowerTargetDistance)
                    {
                        TowerTargetDistance = TowerAndMonsterDistance;
                        TowerIndex = i;
                    }
                }
            }
            if (TowerIndex != MAX_dbl)
            {
                return TowersArray[TowerIndex];
            }
        }
        return nullptr;
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

        ATowers MainTower = GetNearestTower(TargetMainTowersArray);
        ATowers NormalTower = GetNearestTower(TargetTowersArray);

        if (IsValid(MainTower))
        {
            return MainTower;
        }

        return NormalTower;
    }
};