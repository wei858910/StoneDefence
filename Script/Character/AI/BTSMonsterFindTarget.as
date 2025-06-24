class UBTSMonsterFindTarget : UBTService_BlueprintBase
{
    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyTarget;

    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyDistance;

    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyTargetLocation;

    float Heartbeat = 0.0;

    UFUNCTION(BlueprintOverride)
    void TickAI(AAIController OwnerController, APawn ControlledPawn, float DeltaSeconds)
    {
        Heartbeat += DeltaSeconds;
        if (Heartbeat > 0.5)
        {
            Heartbeat = 0.0;
            GetTargetInfo(OwnerController, ControlledPawn);
        }
    }

    void GetTargetInfo(AAIController OwnerController, APawn ControlledPawn)
    {
        AAIControllerBase AIController = Cast<AAIControllerBase>(OwnerController);
        if (IsValid(AIController))
        {
            UBlackboardComponent MyBlackBoard = AIHelper::GetBlackboard(ControlledPawn);
            if (IsValid(MyBlackBoard))
            {
                ACharacterBase NewTarget = Cast<ACharacterBase>(AIController.FindTarget());

                // 获取目标
                if (IsValid(NewTarget))
                {
                    if (AIController.Target.Get() != NewTarget)
                    {
                        AMonsters MonsterSelf = Cast<AMonsters>(ControlledPawn);
                        if (IsValid(MonsterSelf))
                        {
                            MonsterSelf.CharacterMovement.StopMovementImmediately();
                        }
                        AIController.Target = NewTarget;
                    }
                    if (AIController.Target.IsValid())
                    {
                        if (!AIController.Target.Get().IsDeath())
                        {
                            FVector CurrentLocation = FVector::ZeroVector;
                            FVector TargetDirection = (ControlledPawn.GetActorLocation() - AIController.Target.Get().GetActorLocation());
                            TargetDirection.Normalize();
                            FVector TargetLocation = AIController.Target.Get().GetActorLocation() + TargetDirection * 800.0;

                            MyBlackBoard.SetValueAsObject(BlackBoardKeyTarget.SelectedKeyName, AIController.Target.Get());
                            MyBlackBoard.SetValueAsVector(BlackBoardKeyTargetLocation.SelectedKeyName, TargetLocation);
                        }
                        else
                        {
                            MyBlackBoard.SetValueAsObject(BlackBoardKeyTarget.SelectedKeyName, nullptr);
                            MyBlackBoard.SetValueAsVector(BlackBoardKeyTargetLocation.SelectedKeyName, FVector::ZeroVector);
                        }
                    }
                    else
                    {
                        MyBlackBoard.SetValueAsObject(BlackBoardKeyTarget.SelectedKeyName, nullptr);
                        MyBlackBoard.SetValueAsVector(BlackBoardKeyTargetLocation.SelectedKeyName, FVector::ZeroVector);
                    }
                }

                // 获取距离
                if (AIController.Target.IsValid())
                {
                    FVector MyLocation = ControlledPawn.GetActorLocation();
                    FVector TargetDistance = MyLocation - AIController.Target.Get().GetActorLocation();
                    if (TargetDistance.Size() > 2200.)
                    {
                        AMonsters MonsterAI = Cast<AMonsters>(ControlledPawn);
                        if (IsValid(MonsterAI))
                        {
                            MonsterAI.bAttack = false;
                        }
                    }

                    MyBlackBoard.SetValueAsFloat(BlackBoardKeyDistance.SelectedKeyName, TargetDistance.Size());
                }
                else
                {
                    MyBlackBoard.SetValueAsFloat(BlackBoardKeyDistance.SelectedKeyName, 0.);
                }
            }
        }
    }
};