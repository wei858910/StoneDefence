// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "AIController.h"
#include "RuleOfTheAIControllerBase.generated.h"

UCLASS()
class STONEDEFENCE_API ARuleOfTheAIControllerBase : public AAIController
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintImplementableEvent, ScriptCallable)
	AActor* FindTarget();
};
