#include "SScreenLoading.h"

#include "Widgets/Notifications/SProgressBar.h"

void SScreenLoading::Construct(const FArguments& InArgs, const FString& InMapName)
{
	MapName = InMapName;
	ChildSlot
	[
		SNew(SProgressBar)
		.Percent(this, &SScreenLoading::GetProgress)
	];
}

TOptional<float> SScreenLoading::GetProgress() const
{
	// 调用 GetAsyncLoadPercentage 函数，该函数用于获取指定资源的异步加载百分比。
	// 传入 *MapName 作为参数，即当前加载界面所关联的地图名称的指针解引用，以获取该地图的加载进度。
	// 将获取到的加载百分比存储在局部变量 LoadPercent 中。
	const float LoadPercent = GetAsyncLoadPercentage(*MapName);

	return LoadPercent * 0.01f;
}
