#pragma once

#include "CoreMinimal.h"

enum EScreenMoveState
{
	Screen_None,
	Screen_Left,
	Screen_Right,
	Screen_Up,
	Screen_Down,
	Screen_LeftUp,
	Screen_LeftDown,
	Screen_RightUp,
	Screen_RightDown,
	Screen_Max
};

class APlayerController;

struct STONETOOLCLASS_API FScreenMoveUtils
{
	/**
	 * @brief 监听屏幕移动
	 * @param PlayerController 玩家控制器
	 * @param ScreenMoveSpeed 移动速度
	 * @return 是否移动成功
	 */
public:
	bool ListenScreenMove(const APlayerController* PlayerController, const float& ScreenMoveSpeed = 100.0f);

protected:
	/**
	 * @brief 检测鼠标位置
	 * @param PlayerController 玩家控制器
	 * @return 鼠标位置状态
	 */
	EScreenMoveState CursorMove(const APlayerController* PlayerController);

	/**
	 * @brief 移动屏幕
	 * @param PlayerController 玩家控制器
	 * @param ScreenMoveState 移动方向
	 * @param ScreenMoveSpeed 移动速度
	 * @return 是否移动成功
	 */
	bool MoveDirection(const APlayerController* PlayerController, EScreenMoveState ScreenMoveState, const float& ScreenMoveSpeed = 100.0f);
};
