class UUIInventory : UUIRuleOfTheWidget
{
    UPROPERTY(BindWidget)
    UUniformGridPanel SlotArrayInventory;

    UPROPERTY(EditDefaultsOnly, Category = UI)
    TSubclassOf<UUIInventorySlot> InventorySlotClass;

    private
    TArray<UUIInventorySlot> InventorySlotArray;

    UFUNCTION(BlueprintOverride)
    void Construct()
    {
        LayoutInventorySlot(3, 7);
    }

    void LayoutInventorySlot(int32 ColumnNumber, int32 RowNumber)
    {
        auto PC = Utils::GetDefaultPlayerController();
        if (PC == nullptr)
            return;

        if (IsValid(InventorySlotClass))
        {
            for (int32 MyRow = 0; MyRow < RowNumber; MyRow++)
            {
                for (int32 MyColumn = 0; MyColumn < ColumnNumber; MyColumn++)
                {
                    UUIInventorySlot SlotWidget = Cast<UUIInventorySlot>(WidgetBlueprint::CreateWidget(InventorySlotClass, PC));
                    if (IsValid(SlotWidget))
                    {
                        UUniformGridSlot GridSlot = SlotArrayInventory.AddChildToUniformGrid(SlotWidget);
                        if (IsValid(GridSlot))
                        {
                            GridSlot.SetColumn(MyColumn);
                            GridSlot.SetRow(MyRow);
                            GridSlot.SetHorizontalAlignment(EHorizontalAlignment::HAlign_Fill);
                            GridSlot.SetVerticalAlignment(EVerticalAlignment::VAlign_Fill);
                        }
                        InventorySlotArray.Add(SlotWidget);
                    }
                }
            }
        }
    }
};