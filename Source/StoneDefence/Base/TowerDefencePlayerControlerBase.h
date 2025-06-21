// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/PlayerController.h"
#include "StoneToolClass/Tool/ScreenMove.h"
#include "TowerDefencePlayerControlerBase.generated.h"

/**
 * 
 */
UCLASS()
class STONEDEFENCE_API ATowerDefencePlayerControllerBase : public APlayerController
{
	GENERATED_BODY()

public:
	ATowerDefencePlayerControllerBase();

	virtual void BeginPlay() override;
	virtual void Tick(float DeltaSeconds) override;

	/**
	 * @brief 设置输入模式为游戏和UI
	 */
	void SetInputModeGameAndUI();

protected:
	FScreenMoveUtils ScreenMoveUtils;
};
