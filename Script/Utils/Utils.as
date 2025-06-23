
namespace Utils
{
    APlayerController GetDefaultPlayerController()
    {
        return Gameplay::GetPlayerController(0);
    }

    ATowerDefencePlayerController GetDefencePlayerController()
    {
        return Cast<ATowerDefencePlayerController>(GetDefaultPlayerController());
    }

    ATowerDefenceGameState GetDefenceGameState()
    {
        return Cast<ATowerDefenceGameState>(Gameplay::GetGameState());
    }

    UWidget CreateAssistWidget(UClass AssistClass, USizeBox WidgetArray)
    {
        UWidget UserObjectElement = nullptr;

        if (false)
        {
            // 播放淡入动画
        }

        if (IsValid(WidgetArray.GetChildAt(0)))
        {
            if (WidgetArray.GetChildAt(0).IsA(AssistClass))
            {
                // 播放淡出动画

                return UserObjectElement;
            }
            else
            {
                WidgetArray.ClearChildren();
            }
        }
        auto PC = GetDefaultPlayerController();
        if (IsValid(PC))
        {
            UserObjectElement = WidgetBlueprint::CreateWidget(AssistClass, PC);
            if (IsValid(UserObjectElement))
            {
                if (IsValid(WidgetArray.AddChild(UserObjectElement)))
                {
                }
                else
                {
                    UserObjectElement.RemoveFromParent();
                    UserObjectElement = nullptr;
                }
            }
        }

        return UserObjectElement;
    }

    ACharacterBase GetNearestTarget(const TArray<ACharacterBase>& TargetArray, const FVector& Location)
    {
        if (TargetArray.Num() > 0)
        {
            float TargetDistance = MAX_dbl;
            int32 TargetIndex = -1;

            for (int32 i = 0; i < TargetArray.Num(); i++)
            {
                ACharacterBase Target = TargetArray[i];
                if (IsValid(Target))
                {
                    FVector TargetLocation = Target.GetActorLocation();
                    float   NewTargetDistance = (TargetLocation - Location).Size();
                    if (NewTargetDistance < TargetDistance)
                    {
                        TargetDistance = NewTargetDistance;
                        TargetIndex = i;
                    }
                }
            }
            if (TargetIndex != MAX_dbl)
            {
                return TargetArray[TargetIndex];
            }
        }
        return nullptr;
    }

} // namespace Utils