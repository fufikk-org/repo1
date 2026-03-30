namespace Weibel.Warehouse.Worksheet;

using Microsoft.Warehouse.Worksheet;
using Weibel.Manufacturing.Routing.Handler;
using Weibel.Warehouse.Activity;

pageextension 70159 "COL Pick Worksheet" extends "Pick Worksheet"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Routing Link Code"; Rec."COL Routing Link Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the routing link code when you calculate the production order.';
            }
        }
    }

    actions
    {
        modify(CreatePick)
        {
            Visible = false;
        }
        addafter(CreatePick)
        {
            action("COL CreatePick")
            {
                ApplicationArea = Warehouse;
                Caption = 'Create Pick';
                Ellipsis = true;
                Image = CreateInventoryPickup;
                ToolTip = 'Create warehouse pick documents for the specified picks. ';

                trigger OnAction()
                begin
                    CreatePicSM.SetErrorDisplayed(false);
                    UnbindSubscription(CreatePickEvents);
                    Clear(CreatePickEvents);
                    BindSubscription(CreatePickEvents);
                    Codeunit.Run(Codeunit::"Whse. Create Pick", Rec);
                    UnbindSubscription(CreatePickEvents);
                end;
            }
        }
        modify(CreatePick_Promoted)
        {
            Visible = false;
        }
        addafter(CreatePick_Promoted)
        {
            actionref("COL CreatePick_Promoted"; "COL CreatePick") { }
        }
    }

    var
        CreatePickEvents: Codeunit "COL Create Pick Events";
        CreatePicSM: Codeunit "COL Create Pic SM";

}
