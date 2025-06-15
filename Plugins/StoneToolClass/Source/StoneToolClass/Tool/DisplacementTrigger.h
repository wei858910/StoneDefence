﻿// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "StoneToolClass/Core/ToolBase.h"
#include "DisplacementTrigger.generated.h"

UCLASS()
class STONETOOLCLASS_API ADisplacementTrigger : public AToolBase
{
	GENERATED_BODY()

public:
	// Sets default values for this actor's properties
	ADisplacementTrigger();

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

public:
	// Called every frame
	virtual void Tick(float DeltaTime) override;
};
