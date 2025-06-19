// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "Modules/ModuleManager.h"

class FSimpleScreenLoadingModule : public IModuleInterface
{
public:

	/** IModuleInterface implementation */
	virtual void StartupModule() override;
	virtual void ShutdownModule() override;

	SIMPLESCREENLOADING_API void SetupScreenLoading();
private:
	void BeginLoadingScreen(const FString& MapName);
	void EndLoadingScreen(UWorld* World);
};
