namespace Weibel.Test;

using Weibel.Manufacturing.Planning.Batch;

page 70220 "COL Std Batch Test"
{
    ApplicationArea = All;
    Caption = 'Std Batch Test';
    PageType = Card;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(ItemSelected; ItemSelected)
                {
                    ApplicationArea = All;
                    Caption = 'Item to Process';
                    ToolTip = 'Specifies the item selected for testing.';
                    Editable = true;
                    ShowMandatory = true;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SelectItem)
            {
                ApplicationArea = All;
                Caption = 'Manual CalcLowLevelCode';
                ToolTip = 'Manual_CalcLowLevelCode.';
                Image = Select;

                trigger OnAction()
                begin
                    if ItemSelected = '' then
                        Error('Please select an item to process.');
                    StdBatch.Manual_CalcLowLevelCode(ItemSelected);
                end;
            }
            action(Manual_CalculateRegenerativePlan)
            {
                ApplicationArea = All;
                Caption = 'Manual CalculateRegenerativePlan';
                ToolTip = 'Manual_CalculateRegenerativePlan';
                Image = Select;

                trigger OnAction()
                begin
                    if ItemSelected = '' then
                        Error('Please select an item to process.');
                    StdBatch.Manual_CalculateRegenerativePlan(ItemSelected);
                end;
            }
            action(Manual_CarryOutPurchaseActionMsg)
            {
                ApplicationArea = All;
                Caption = 'Manual CarryOutPurchaseActionMsg';
                ToolTip = 'Manual_CarryOutPurchaseActionMsg';
                Image = Select;

                trigger OnAction()
                begin
                    if ItemSelected = '' then
                        Error('Please select an item to process.');
                    StdBatch.Manual_CarryOutPurchaseActionMsg(ItemSelected);
                end;
            }
            action(Manual_CarryOutProdActionMsg)
            {
                ApplicationArea = All;
                Caption = 'Manual CarryOutProdActionMsg';
                ToolTip = 'Manual_CarryOutProdActionMsg';
                Image = Select;

                trigger OnAction()
                begin
                    if ItemSelected = '' then
                        Error('Please select an item to process.');
                    StdBatch.Manual_CarryOutProdActionMsg(ItemSelected);
                end;
            }

            action(Bath_CarryOutPurchaseActionMsgMPS)
            {
                ApplicationArea = All;
                Caption = 'Calculate Regenerative Plan MPS';
                ToolTip = 'Batch Calculate Regenerative Plan';
                Image = Select;

                trigger OnAction()
                begin
                    StdBatch.Batch_CalculateRegenerativePlanMPS();
                end;
            }
            action(Bath_CarryOutPurchaseActionMsgMRP)
            {
                ApplicationArea = All;
                Caption = 'Calculate Regenerative Plan MRP';
                ToolTip = 'Batch Calculate Regenerative Plan';
                Image = Select;

                trigger OnAction()
                begin
                    StdBatch.Batch_CalculateRegenerativePlanMPR();
                end;
            }
            action(Bath_CarryOutPurchaseActionMsgAll)
            {
                ApplicationArea = All;
                Caption = 'Calculate Regenerative Plan All';
                ToolTip = 'Batch Calculate Regenerative Plan';
                Image = Select;

                trigger OnAction()
                begin
                    StdBatch.Batch_CalculateRegenerativePlanBoth();
                end;
            }
            action(Batch_CarryOut)
            {
                ApplicationArea = All;
                Caption = 'CarryOut';
                ToolTip = 'Batch CarryOut';
                Image = Select;

                trigger OnAction()
                begin
                    StdBatch.Batch_CarryOut();
                end;
            }
            action(Batch_Full)
            {
                ApplicationArea = All;
                Caption = 'Full';
                ToolTip = 'Batch CarryOut';
                Image = Select;

                trigger OnAction()
                begin
                    StdBatch.Batch_Full();
                end;
            }
        }
    }

    var
        StdBatch: Codeunit "COL Std Batch Planning Service";
        ItemSelected: Code[20];
}
