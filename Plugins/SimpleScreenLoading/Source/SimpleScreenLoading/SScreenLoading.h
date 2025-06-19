#pragma once

/**
 * @brief SScreenLoading 类用于实现一个简单的屏幕加载界面，继承自 SCompoundWidget。
 * 
 * SCompoundWidget 是 Unreal Engine 中用于创建复杂界面元素的基类，
 * 该类可用于构建包含多个子控件的界面，SScreenLoading 类借助此特性构建加载界面。
 */
class SScreenLoading : public SCompoundWidget
{
public:
	// SLATE_BEGIN_ARGS 是 Unreal Engine Slate 框架中的宏，用于定义一个参数列表类。
	// 这个参数列表类将用于配置 SScreenLoading 控件的属性和子控件。
	// 在 Slate 中，使用这种方式可以方便地在创建控件时通过流式语法设置各种参数。
	// 每个 SLATE_BEGIN_ARGS 宏必须与对应的 SLATE_END_ARGS 宏配对使用。
	SLATE_BEGIN_ARGS(SScreenLoading)
	{
	}

	SLATE_END_ARGS()

	void Construct(const FArguments& InArgs, const FString& InMapName);

private:
	TOptional<float> GetProgress() const;

	FString MapName;
};
