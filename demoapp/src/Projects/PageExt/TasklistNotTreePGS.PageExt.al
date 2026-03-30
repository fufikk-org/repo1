namespace Weibel.Projects.Project.Job;

using Weibel.Service.Document;
using Microsoft.Service.Document;

pageextension 70170 "COL Tasklist Not Tree (PGS)" extends "Tasklist Not Tree (PGS)"
{
    layout
    {
        addafter("Usage Value Type PGS")
        {
            field("COL Service Item No."; Rec."COL Service Item No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("COL Service Item Description"; Rec."COL Service Item Description")
            {
                ApplicationArea = Basic, Suite;
            }
            field("COL Service Order"; Rec."COL Service Order")
            {
                ApplicationArea = Basic, Suite;

                trigger OnDrillDown()
                var
                    ServiceHeader: Record "Service Header";
                    ServiceOrder: Page "Service Order";
                begin
                    if Rec."COL Service Order" = '' then
                        exit;
                    ServiceHeader.SetRange("No.", Rec."COL Service Order");
                    ServiceOrder.SetTableView(ServiceHeader);
                    ServiceOrder.Run();
                end;
            }
            field("COL Service Order Status"; OrderStatus)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Status';
                ToolTip = 'Specifies the Service Order Status';
                Editable = false;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            group("COL Create Service Order")
            {
                Caption = 'Create Service Order';
                action("COL CreateSO")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Service Order';
                    Image = NewCustomer;
                    ToolTip = 'Create Service Order from Project Lines';

                    trigger OnAction()
                    var
                        CreateSOMgt: Codeunit "COL Create Service Document";
                    begin
                        CreateSOMgt.CreateServiceOrderFrom(Rec, true);
                    end;
                }
            }
        }
    }

    var
        OrderStatus: Text;

    trigger OnAfterGetRecord()
    begin
        if Rec."COL Service Order" <> '' then begin
            Rec.CalcFields("COL Service Order Status");
            OrderStatus := Format(Rec."COL Service Order Status");
        end
        else
            OrderStatus := '_';
    end;
}
