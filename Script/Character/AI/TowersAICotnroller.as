class ATowersAICotnroller : ARuleOfTheAIController
{
    protected float Heartbeat = 0.0;

    protected TArray<AMonsters> MonstersArray;

    protected TWeakObjectPtr<AMonsters> TargetMonster = nullptr;

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
        ATowers Tower = Cast<ATowers>(ControlledPawn);
        if (!IsValid(Tower) || Tower.IsDeath())
            return;

        Heartbeat += DeltaSeconds;
        if (Heartbeat > 0.5)
        {
            Heartbeat = 0.0;
            FindMonstersInRange(1600.0);
        }

        if (MonstersArray.Num() > 0)
        {
            if (!TargetMonster.IsValid())
            {
                TargetMonster = Cast<AMonsters>(FindTarget());
            }

            if (TargetMonster.IsValid())
            {
                Tower.TowersRotator = FRotator::MakeFromX(TargetMonster.Get().GetActorLocation() - ControlledPawn.GetActorLocation());
                AttackTarget(TargetMonster.Get());
            }
        }
    }

    AActor FindTarget() override
    {
        ATowers Tower = Cast<ATowers>(ControlledPawn);
        if (!IsValid(Tower) || Tower.IsDeath())
            return nullptr;

        if (MonstersArray.Num() > 0)
        {
            Tower.bAttack = true;
            AMonsters NearestMonster = Cast<AMonsters>(Utils::GetNearestTarget(MonstersArray, ControlledPawn.GetActorLocation()));
            return NearestMonster;
        }
        else
        {
            Tower.bAttack = false;
        }

        return nullptr;
    }

    void FindMonstersInRange(float Distance)
    {
        ATowers Tower = Cast<ATowers>(ControlledPawn);
        if (!IsValid(Tower) || Tower.IsDeath())
            return;

        MonstersArray.Empty();
        TArray<AMonsters> TempMonstersArray;
        GetAllActorsOfClass(AMonsters, TempMonstersArray);
        for (auto& Monster : TempMonstersArray)
        {
            if (!Monster.IsDeath())
            {
                float ToMonsterDistance = (Monster.GetActorLocation() - ControlledPawn.GetActorLocation()).Size();
                if (ToMonsterDistance <= Distance)
                {
                    MonstersArray.Add(Monster);
                }
            }
        }
    }

    void AttackTarget(ARuleOfTheCharacter Target) override
    {
        ATowers Tower = Cast<ATowers>(ControlledPawn);
        if (MonstersArray.Num() > 0)
        {
            Tower.bAttack = true;
        }
        else
        {
            Tower.bAttack = false;
        }
    }
};