// Copyright Epic Games, Inc. All Rights Reserved.

#include "SimpleScreenLoading.h"
#include "MoviePlayer.h"
#include "SimpleScreenLoading/SScreenLoading.h"

#define LOCTEXT_NAMESPACE "FSimpleScreenLoadingModule"

void FSimpleScreenLoadingModule::StartupModule()
{
	// This code will execute after your module is loaded into memory; the exact timing is specified in the .uplugin file per-module
}

void FSimpleScreenLoadingModule::ShutdownModule()
{
	// This function may be called during shutdown to clean up your module.  For modules that support dynamic reloading,
	// we call this function before unloading the module.
}

void FSimpleScreenLoadingModule::SetupScreenLoading()
{
	// 注册一个委托，当引擎即将开始加载地图时触发回调函数
	// FCoreUObjectDelegates::PreLoadMap 是引擎提供的一个委托，在地图开始加载前会广播该委托
	// AddRaw 方法用于将一个原始指针和成员函数绑定到委托上
	// 当引擎准备加载新地图时，会调用 BeginLoadingScreen 方法并传入相应的地图名称
	FCoreUObjectDelegates::PreLoadMap.AddRaw(this, &FSimpleScreenLoadingModule::BeginLoadingScreen);

	// 注册一个委托，当引擎完成地图加载并获取到世界对象后触发回调函数
	// FCoreUObjectDelegates::PostLoadMapWithWorld 是引擎提供的一个委托，在地图加载完成且世界对象准备好后会广播该委托
	// AddRaw 方法用于将一个原始指针和成员函数绑定到委托上
	// 当引擎完成地图加载后，会调用 EndLoadingScreen 方法并传入加载完成后的世界对象
	FCoreUObjectDelegates::PostLoadMapWithWorld.AddRaw(this, &FSimpleScreenLoadingModule::EndLoadingScreen);
}

void FSimpleScreenLoadingModule::BeginLoadingScreen(const FString& MapName)
{
	// 创建一个加载屏幕属性对象，用于配置加载屏幕的各种行为和显示特性
	FLoadingScreenAttributes LoadingScreenArg;

	// 设置加载完成时是否自动关闭加载屏幕
	// 将该属性设置为 false 意味着加载完成后加载屏幕不会自动消失，需要手动控制关闭
	LoadingScreenArg.bAutoCompleteWhenLoadingCompletes = false;

	// 设置加载过程中播放的视频是否允许用户跳过
	// 将该属性设置为 true 表示用户在加载过程中可以跳过正在播放的视频
	LoadingScreenArg.bMoviesAreSkippable = true;

	// 设置是否需要手动停止加载屏幕的显示
	// 将该属性设置为 false 表示加载屏幕不需要手动停止，会根据其他条件自动隐藏
	LoadingScreenArg.bWaitForManualStop = false;

	// 设置视频的播放类型
	// EMoviePlaybackType::MT_LoadingLoop 表示视频会在加载过程中循环播放，直到加载完成或被手动停止
	LoadingScreenArg.PlaybackType = EMoviePlaybackType::MT_LoadingLoop;

	// 设置加载屏幕所使用的自定义 Widget
	// 使用 SNew 宏创建一个新的 SScreenLoading 控件实例，并传入地图名称 MapName 作为构造参数
	// 然后将创建好的 SScreenLoading 控件赋值给 LoadingScreenArg 的 WidgetLoadingScreen 属性，
	// 这样在加载屏幕显示时，就会显示这个自定义的 SScreenLoading 控件
	LoadingScreenArg.WidgetLoadingScreen = SNew(SScreenLoading, MapName);

	// 获取 MoviePlayer 实例，MoviePlayer 是 Unreal Engine 中负责管理加载屏幕和播放视频的系统。
	// 调用 SetupLoadingScreen 方法，将之前配置好的加载屏幕属性 LoadingScreenArg 传递给 MoviePlayer，
	// 以此完成加载屏幕的初始化设置，包括加载屏幕的显示行为、外观等配置。
	GetMoviePlayer()->SetupLoadingScreen(LoadingScreenArg);

	// 调用 MoviePlayer 实例的 PlayMovie 方法，开始显示加载屏幕并播放配置好的视频（如果有）。
	// 此时，根据之前设置的 LoadingScreenArg 属性，加载屏幕会按照指定的方式显示和运行。
	GetMoviePlayer()->PlayMovie();
}

void FSimpleScreenLoadingModule::EndLoadingScreen(UWorld* World)
{
}

#undef LOCTEXT_NAMESPACE

IMPLEMENT_MODULE(FSimpleScreenLoadingModule, SimpleScreenLoading)
