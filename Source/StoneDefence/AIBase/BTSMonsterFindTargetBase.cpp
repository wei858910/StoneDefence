// Fill out your copyright notice in the Description page of Project Settings.


#include "BTSMonsterFindTargetBase.h"

void UBTSMonsterFindTargetBase::TickNode(UBehaviorTreeComponent& OwnerComp, uint8* NodeMemory, float DeltaSeconds)
{
	Super::TickNode(OwnerComp, NodeMemory, DeltaSeconds);
	BTSTick(&OwnerComp, DeltaSeconds);
}

UBlackboardComponent* UBTSMonsterFindTargetBase::GetBlackboardComponent(UBehaviorTreeComponent* OwnerComp)
{
	if (OwnerComp)
	{
		return OwnerComp->GetBlackboardComponent();
	}
	return nullptr;
}

void UBTSMonsterFindTargetBase::BTSTick_Implementation(UBehaviorTreeComponent* OwnerComp, float DeltaSeconds)
{
}
