// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Engine/GameInstance.h"
#include "TowerDefenceGameInstanceBase.generated.h"

/**
 * 
 */
UCLASS()
class STONEDEFENCE_API UTowerDefenceGameInstanceBase : public UGameInstance
{
	GENERATED_BODY()

public:
	virtual void Init() override;
};
