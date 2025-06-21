class UBTSMonsterFindTarget : UBTService_BlueprintBase
{
    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyTarget;

    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyDistance;

    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyTargetLocation;

    private TWeakObjectPtr<ARuleOfTheCharacter> Target;

    UFUNCTION(BlueprintOverride)
    void TickAI(AAIController OwnerController, APawn ControlledPawn, float DeltaSeconds)
    {
        AMonsterAIController MonsterAIController = Cast<AMonsterAIController>(OwnerController);
        if (IsValid(MonsterAIController))
        {

            UBlackboardComponent MyBlackBoard = AIHelper::GetBlackboard(ControlledPawn);
            if (IsValid(MyBlackBoard))
            {
                ARuleOfTheCharacter NewTarget = Cast<ARuleOfTheCharacter>(MonsterAIController.FindTarget());

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
                            MyBlackBoard.SetValueAsObject(BlackBoardKeyTarget.SelectedKeyName, Target.Get());
                            FVector TargetLocation = Target.Get().GetActorLocation();
                            Print(TargetLocation.ToColorString(), DeltaSeconds);
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