// Fill out your copyright notice in the Description page of Project Settings.


#include "TowerDefenceGameInstanceBase.h"

#include "SimpleScreenLoading.h"

void UTowerDefenceGameInstanceBase::Init()
{
	Super::Init();
	FSimpleScreenLoadingModule& SimpleScreenLoadingModule = FModuleManager::LoadModuleChecked<FSimpleScreenLoadingModule>("SimpleScreenLoading");
	SimpleScreenLoadingModule.SetupScreenLoading();
}
