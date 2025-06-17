#include "ScreenMove.h"

bool FScreenMoveUtils::ListenScreenMove(const APlayerController* PlayerController, const float& ScreenMoveSpeed)
{
	return MoveDirection(PlayerController, CursorMove(PlayerController), ScreenMoveSpeed);
}

EScreenMoveState FScreenMoveUtils::CursorMove(const APlayerController* PlayerController)
{
	if (PlayerController)
	{
		// 屏幕尺寸
		int32 SizeX = INDEX_NONE;
		int32 SizeY = INDEX_NONE;

		PlayerController->GetViewportSize(SizeX, SizeY);

		// 鼠标位置
		float MousePositionX = INDEX_NONE;
		float MousePositionY = INDEX_NONE;

		PlayerController->GetMousePosition(MousePositionX, MousePositionY);

		// 计算鼠标位置是否在屏幕边缘
		if (MousePositionX >= 0 && MousePositionX <= SizeX && MousePositionY >= 0 && MousePositionY <= SizeY)
		{
			constexpr float EdgeThreshold = 10.0f;
			if (FMath::IsNearlyEqual(MousePositionX, 0.0f, EdgeThreshold) && FMath::IsNearlyEqual(MousePositionY, 0.0f, EdgeThreshold))
			{
				return EScreenMoveState::Screen_LeftUp;
			}
			else if (FMath::IsNearlyEqual(MousePositionX, 0.0f, EdgeThreshold) && FMath::IsNearlyEqual(MousePositionY, SizeY, EdgeThreshold))
			{
				return EScreenMoveState::Screen_LeftDown;
			}
			else if (FMath::IsNearlyEqual(MousePositionX, SizeX, EdgeThreshold) && FMath::IsNearlyEqual(MousePositionY, 0.0f, EdgeThreshold))
			{
				return EScreenMoveState::Screen_RightUp;
			}
			else if (FMath::IsNearlyEqual(MousePositionX, SizeX, EdgeThreshold) && FMath::IsNearlyEqual(MousePositionY, SizeY, EdgeThreshold))
			{
				return EScreenMoveState::Screen_RightDown;
			}
			else if (FMath::IsNearlyEqual(MousePositionX, 0.0f, EdgeThreshold))
			{
				return EScreenMoveState::Screen_Left;
			}
			else if (FMath::IsNearlyEqual(MousePositionX, SizeX, EdgeThreshold))
			{
				return EScreenMoveState::Screen_Right;
			}
			else if (FMath::IsNearlyEqual(MousePositionY, 0.0f, EdgeThreshold))
			{
				return EScreenMoveState::Screen_Up;
			}
			else if (FMath::IsNearlyEqual(MousePositionY, SizeY, EdgeThreshold))
			{
				return EScreenMoveState::Screen_Down;
			}
		}
	}

	return EScreenMoveState::Screen_None;
}

bool FScreenMoveUtils::MoveDirection(const APlayerController* PlayerController, EScreenMoveState ScreenMoveState, const float& ScreenMoveSpeed)
{
	FVector OffsetValue = FVector::ZeroVector;
	if (PlayerController && PlayerController->GetPawn())
	{
		switch (ScreenMoveState)
		{
		case EScreenMoveState::Screen_None:
			break;
		case EScreenMoveState::Screen_LeftUp:
			OffsetValue = FVector(ScreenMoveSpeed, -ScreenMoveSpeed, 0.0f);
			break;
		case EScreenMoveState::Screen_LeftDown:
			OffsetValue = FVector(-ScreenMoveSpeed, -ScreenMoveSpeed, 0.0f);
			break;
		case EScreenMoveState::Screen_RightUp:
			OffsetValue = FVector(ScreenMoveSpeed, ScreenMoveSpeed, 0.0f);
			break;
		case EScreenMoveState::Screen_RightDown:
			OffsetValue = FVector(-ScreenMoveSpeed, ScreenMoveSpeed, 0.0f);
			break;
		case EScreenMoveState::Screen_Left:
			OffsetValue = FVector(0.0f, -ScreenMoveSpeed, 0.0f);
			break;
		case EScreenMoveState::Screen_Right:
			OffsetValue = FVector(0.0f, ScreenMoveSpeed, 0.0f);
			break;
		case EScreenMoveState::Screen_Up:
			OffsetValue = FVector(ScreenMoveSpeed, 0.0f, 0.0f);
			break;
		case EScreenMoveState::Screen_Down:
			OffsetValue = FVector(-ScreenMoveSpeed, 0.0f, 0.0f);
			break;
		default:
			break;
		}
		PlayerController->GetPawn()->AddActorWorldOffset(OffsetValue);
	}

	return OffsetValue != FVector::ZeroVector;
}
