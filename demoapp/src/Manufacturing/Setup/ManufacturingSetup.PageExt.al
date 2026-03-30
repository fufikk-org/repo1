namespace Weibel.Manufacturing.Setup;

using Microsoft.Manufacturing.Setup;
using Weibel.Common;

pageextension 70110 "COL Manufacturing Setup" extends "Manufacturing Setup"
{
    layout
    {
        addlast(General)
        {
            field("COL Log Prod. Tracking"; Rec."COL Log Prod. Tracking")
            {
                ApplicationArea = All;
            }
        }
        addlast(Planning)
        {

            field("COL NoFinishRemainQty"; Rec."COL NoFinishRemainQty")
            {
                ApplicationArea = All;
            }
        }
        addlast(content)
        {
            group("COL Batch Planning")
            {
                Caption = 'Batch Planning';
                group("COL Template")
                {
                    Caption = 'Template';

                    field("COL Requisition Template Name"; Rec."COL Requisition Template Name")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Requisition Batch Name"; Rec."COL Requisition Batch Name")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Plan. Worksheet Temp. Name"; Rec."COL Plan. Worksheet Temp. Name")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Std. Plan Jnl. Batch Name"; Rec."COL Std. Plan Jnl. Batch Name")
                    {
                        ApplicationArea = All;
                    }
                }
                group("COL Planning")
                {
                    Caption = 'Planning';
                    field("COL Stop and Show First Error"; Rec."COL Stop and Show First Error")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Calculate MPS"; Rec."COL Calculate MPS")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Calculate MRP"; Rec."COL Calculate MRP")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Use Forecast"; Rec."COL Use Forecast")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Exclude Forecast Before (DF)"; Rec."COL Exclude Forecast Before DF")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Exclude Forecast Before"; Rec."COL Exclude Forecast Before")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Order Date (DF)"; Rec."COL Order Date DF")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Plan Horizontal (DF)"; Rec."COL Plan Horizontal")
                    {
                        ApplicationArea = All;
                    }
                    field("COL End Date"; Rec."COL End Date")
                    {
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field("COL Debug No. Filter"; Rec."COL Debug No. Filter")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group("COL BOM Structure")
            {
                Caption = 'BOM Structure';
                field("COL Def.Loc. for BOM Structure"; Rec."COL Def.Loc. for BOM Structure")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        addfirst(Processing)
        {
            group("COL Fields Enable2")
            {
                Caption = 'Production Allowed Fields';
                Image = Action;

                action("COL Editable Fields")
                {
                    ApplicationArea = All;
                    Caption = 'Allowed Production Order Fields';
                    Image = EditLines;
                    ToolTip = 'Opens page to edit Allowed Production Order Fields.';


                    trigger OnAction()
                    var
                        FieldSelect: Codeunit "COL Field Select Mgt";
                    begin
                        FieldSelect.OpenFieldSelectProductionOrder();
                    end;
                }
                action("COL Editable Fields2")
                {
                    ApplicationArea = All;
                    Caption = 'Allowed Prod. Line Fields';
                    Image = EditLines;
                    ToolTip = 'Opens page to edit Allowed Prod. Line Fields.';

                    trigger OnAction()
                    var
                        FieldSelect: Codeunit "COL Field Select Mgt";
                    begin
                        FieldSelect.OpenFieldSelectProductionOrderLines();
                    end;
                }
                action("COL Editable Fields3")
                {
                    ApplicationArea = All;
                    Caption = 'Allowed Prod. Component Fields';
                    Image = EditLines;
                    ToolTip = 'Opens page to edit Allowed Prod. Component Fields.';

                    trigger OnAction()
                    var
                        FieldSelect: Codeunit "COL Field Select Mgt";
                    begin
                        FieldSelect.OpenFieldSelectProductionOrderComponents();
                    end;
                }
                action("COL Editable Fields4")
                {
                    ApplicationArea = All;
                    Caption = 'Allowed Prod. Routes Fields';
                    Image = EditLines;
                    ToolTip = 'Opens page to edit Allowed Prod. Routes Fields.';

                    trigger OnAction()
                    var
                        FieldSelect: Codeunit "COL Field Select Mgt";
                    begin
                        FieldSelect.OpenFieldSelectProductionOrderRoutes();
                    end;
                }
            }
        }
    }


    trigger OnOpenPage()
    begin
        Rec.COLCalculateExcludeForecastBefore();
        CurrPage.Update();
    end;
}
