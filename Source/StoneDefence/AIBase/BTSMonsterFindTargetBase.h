// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "BehaviorTree/BTService.h"
#include "BTSMonsterFindTargetBase.generated.h"

/**
 * 
 */
UCLASS()
class STONEDEFENCE_API UBTSMonsterFindTargetBase : public UBTService
{
	GENERATED_BODY()

public:
	virtual void TickNode(UBehaviorTreeComponent& OwnerComp, uint8* NodeMemory, float DeltaSeconds) override;

	UFUNCTION(BlueprintNativeEvent)
	void BTSTick(UBehaviorTreeComponent* OwnerComp, float DeltaSeconds);

	UFUNCTION(ScriptCallable)
	UBlackboardComponent* GetBlackboardComponent(UBehaviorTreeComponent* OwnerComp);
};
