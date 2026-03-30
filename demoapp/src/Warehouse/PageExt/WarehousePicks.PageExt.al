namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;
using Microsoft.Warehouse.Setup;

pageextension 70275 "COL Warehouse Picks" extends "Warehouse Picks"
{
    actions
    {
        addafter(Print)
        {
            action("COL Print")
            {
                ApplicationArea = Warehouse;
                Caption = 'Print Selected';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    PrintMultiple();
                end;
            }
        }

        addafter(Print_Promoted)
        {
            actionref("COLPrint_Promoted"; "COL Print")
            {
            }
        }
    }

    local procedure PrintMultiple()
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        WarehouseActivityHeader2: Record "Warehouse Activity Header";
        StaticCreatePicSM: Codeunit "COL Create Pic SM";
        FilterTxt: Text;
        FilterLbl: Label '%1..%2', Locked = true;
        FirstWH, LastWH : Code[20];
    begin
        CurrPage.SetSelectionFilter(WarehouseActivityHeader);
        WarehouseActivityHeader.SetCurrentKey("No.");
        WarehouseActivityHeader.Ascending(true);
        if WarehouseActivityHeader.FindFirst() then begin
            FirstWH := WarehouseActivityHeader."No.";
            if WarehouseActivityHeader.FindLast() then
                LastWH := WarehouseActivityHeader."No.";
        end
        else
            exit;

        WarehouseActivityHeader2.SetRange(Type, WarehouseActivityHeader.Type::Pick);
        if FirstWH = LastWH then
            FilterTxt := FirstWH
        else
            FilterTxt := StrSubstNo(FilterLbl, FirstWH, LastWH);

        StaticCreatePicSM.PrintPickWarehouse(FilterTxt);
    end;
}
