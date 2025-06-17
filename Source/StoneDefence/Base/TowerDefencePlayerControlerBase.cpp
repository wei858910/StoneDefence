// Fill out your copyright notice in the Description page of Project Settings.


#include "TowerDefencePlayerControlerBase.h"

ATowerDefencePlayerControllerBase::ATowerDefencePlayerControllerBase()
{
	bShowMouseCursor = true;
}

void ATowerDefencePlayerControllerBase::BeginPlay()
{
	Super::BeginPlay();
	SetInputModeGameAndUI();
}

void ATowerDefencePlayerControllerBase::Tick(float DeltaSeconds)
{
	Super::Tick(DeltaSeconds);
	float ScreenMoveSpeed = 20.f;
	ScreenMoveUtils.ListenScreenMove(this, ScreenMoveSpeed);
}

void ATowerDefencePlayerControllerBase::SetInputModeGameAndUI()
{
	// 创建一个输入模式对象，该模式允许玩家同时与游戏和 UI 进行交互
	FInputModeGameAndUI InputModeData;
	// 设置鼠标始终锁定在视口内，防止鼠标移出游戏窗口
	InputModeData.SetLockMouseToViewportBehavior(EMouseLockMode::LockAlways);
	// 设置在捕获输入时不隐藏鼠标光标，确保玩家在操作时能看到鼠标指针
	InputModeData.SetHideCursorDuringCapture(false);
	// 将当前的输入模式设置为刚刚配置好的 InputModeData
	SetInputMode(InputModeData);
}
