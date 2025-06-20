
namespace Global
{
    APlayerController GetDefaultPlayerController()
    {
        return Gameplay::GetPlayerController(0);
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
} // namespace Global