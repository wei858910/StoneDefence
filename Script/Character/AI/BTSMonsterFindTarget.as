class UBTSMonsterFindTarget : UBTService_BlueprintBase
{
    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyTarget;

    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyDistance;

    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyTargetLocation;

    private TWeakObjectPtr<ARuleOfTheCharacter> Target;

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
        ARuleOfTheAIController AIController = Cast<ARuleOfTheAIController>(OwnerController);
        if (IsValid(AIController))
        {
            UBlackboardComponent MyBlackBoard = AIHelper::GetBlackboard(ControlledPawn);
            if (IsValid(MyBlackBoard))
            {
                ARuleOfTheCharacter NewTarget = Cast<ARuleOfTheCharacter>(AIController.FindTarget());

                // 获取目标
                if (IsValid(NewTarget))
                {
                    if (Target.Get() != NewTarget)
                    {
                        AMonsters MonsterSelf = Cast<AMonsters>(ControlledPawn);
                        if (IsValid(MonsterSelf))
                        {
                            MonsterSelf.CharacterMovement.StopMovementImmediately();
                        }
                        Target = NewTarget;
                    }
                    if (Target.IsValid())
                    {
                        if (!Target.Get().IsDeath())
                        {
                            FVector CurrentLocation = FVector::ZeroVector;
                            FVector TargetDirection = (ControlledPawn.GetActorLocation() - Target.Get().GetActorLocation());
                            TargetDirection.Normalize();
                            FVector TargetLocation = Target.Get().GetActorLocation() + TargetDirection * 800.0;
                            
                            MyBlackBoard.SetValueAsObject(BlackBoardKeyTarget.SelectedKeyName, Target.Get());
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
                if (Target.IsValid())
                {
                    FVector MyLocation = ControlledPawn.GetActorLocation();
                    FVector TargetDistance = MyLocation - Target.Get().GetActorLocation();
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