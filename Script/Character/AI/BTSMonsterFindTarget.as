class UBTSMonsterFindTarget : UBTSMonsterFindTargetBase
{
    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyTarget;

    UPROPERTY(Category = "BlackBoard")
    FBlackboardKeySelector BlackBoardKeyDistance;

    private TWeakObjectPtr<ARuleOfTheCharacter> Target;

    UFUNCTION(BlueprintOverride)
    void BTSTick(UBehaviorTreeComponent OwnerComp, float DeltaSeconds)
    {
        if (IsValid(OwnerComp))
        {
            AMonsterAIController MonsterAIController = Cast<AMonsterAIController>(OwnerComp.GetOwner());
            if (IsValid(MonsterAIController))
            {
                UBlackboardComponent MyBlackBoard = GetBlackboardComponent(OwnerComp);
                if (IsValid(MyBlackBoard))
                {
                    ARuleOfTheCharacter NewTarget = Cast<ARuleOfTheCharacter>(MonsterAIController.FindTarget());
                    
                    // 获取目标
                    if (IsValid(NewTarget))
                    {
                        if (Target.Get() != NewTarget)
                        {
                            AMonsters MonsterSelf = Cast<AMonsters>(MonsterAIController.GetControlledPawn());
                            if (IsValid(MonsterSelf))
                            {
                                MonsterSelf.CharacterMovement.StopMovementImmediately();
                            }
                            Target = NewTarget;
                        }
                        if (Target.IsValid())
                        {
                            if (Target.Get().IsActive())
                            {
                                MyBlackBoard.SetValueAsObject(n"BlackBoardKeyTarget", Target.Get());
                            }
                            else
                            {
                                MyBlackBoard.SetValueAsObject(n"BlackBoardKeyTarget", nullptr);
                            }
                        }
                        else
                        {
                            MyBlackBoard.SetValueAsObject(n"BlackBoardKeyTarget", nullptr);
                        }
                    }

                    // 获取距离
                    if(Target.IsValid())
                    {
                        FVector MyLocation = MonsterAIController.GetControlledPawn().GetActorLocation();
                        FVector TargetDistance = MyLocation - Target.Get().GetActorLocation();
                        if(TargetDistance.Size() > 2200.)
                        {
                            AMonsters MonsterAI = Cast<AMonsters>(MonsterAIController.GetControlledPawn());
                            if(IsValid(MonsterAI))
                            {
                                MonsterAI.bAttack = false;
                            }
                        }

                        MyBlackBoard.SetValueAsFloat(n"BlackBoardKeyDistance", TargetDistance.Size());
                    }
                    else
                    {
                        MyBlackBoard.SetValueAsFloat(n"BlackBoardKeyDistance", 0.);
                    }
                }
            }
        }
    }
};