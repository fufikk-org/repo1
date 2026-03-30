namespace Weibel.Warehouse.Document;

using Microsoft.Warehouse.Document;
using Weibel.Inventory.Item;

pageextension 70265 "COL Whse. Shipment Subform" extends "Whse. Shipment Subform"
{
    actions
    {
        addlast("&Line")
        {
            action("COL WarehouseDocLabel")
            {
                Caption = 'Shipment Item Label';
                ToolTip = 'Print shipment item labels for all items';
                Image = PrintCover;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PrintShipmentLabel();
                end;
            }
        }
    }

#pragma warning disable AA0228
    local procedure PrintWeibelItemLabel()
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WeibelItemODCLabel: Report "COL Weibel Item ODC Label";
    begin
        WarehouseShipmentHeader.Get(Rec."No.");
        WeibelItemODCLabel.InitFrom(WarehouseShipmentHeader);
        WeibelItemODCLabel.RunModal();
    end;
#pragma warning restore AA0228

    local procedure PrintShipmentLabel()
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WeibelItemODCLabel: Report "COL Warehouse Doc. Label";
    begin
        WarehouseShipmentHeader.Get(Rec."No.");
        WeibelItemODCLabel.InitFrom(WarehouseShipmentHeader);
        WeibelItemODCLabel.RunModal();
    end;
}
