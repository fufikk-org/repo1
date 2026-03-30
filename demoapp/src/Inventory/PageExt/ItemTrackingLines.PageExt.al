namespace Weibel.Inventory.Tracking;

using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Ledger;
using Weibel.Inventory.Ledger;
using Weibel.Inventory.Item;

pageextension 70216 "COL Item Tracking Lines" extends "Item Tracking Lines"
{

    actions
    {
        addafter(Line_PackageNoInfoCard)
        {
            action("COL Print Label")
            {
                ApplicationArea = All;
                Caption = 'Print Label';
                Image = Print;
                ToolTip = 'Print Label for selected line.';

                trigger OnAction()
                begin
                    COLPrintSelectedData();
                end;
            }
            action("COL Print Cable")
            {
                ApplicationArea = All;
                Caption = 'Print Cable Label';
                Image = Print;
                ToolTip = 'Print Cable Labels';

                trigger OnAction()
                var
                    TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
                    CableLabel: Report "COL Cable Label2";
                    EntryNo: Integer;
                begin

                    EntryNo += 1;
                    TempItemLedgerEntry."Entry No." := EntryNo;
                    TempItemLedgerEntry."Item No." := Rec."Item No.";
                    TempItemLedgerEntry."Serial No." := Rec."Serial No.";
                    TempItemLedgerEntry."Variant Code" := Rec."Variant Code";
                    TempItemLedgerEntry.Insert();

                    TempItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                    if Rec."Serial No." <> '' then
                        TempItemLedgerEntry.SetRange("Serial No.", Rec."Serial No.");
                    CableLabel.SetTableView(TempItemLedgerEntry);
                    CableLabel.SetData(TempItemLedgerEntry);
                    CableLabel.RunModal();
                end;
            }
        }

        addlast(Category_Process)
        {
            actionref("COL Print Cable_Promoted"; "COL Print Cable") { }
            actionref("COL Print Label_Promoted"; "COL Print Label") { }
        }
    }

    procedure COLGetTrackingData(var pSerial: Text; var pExpDate: Date)
    begin
        if Rec.FindFirst() then begin
            pSerial := Rec."Serial No.";
            pExpDate := Rec."Expiration Date";
        end;
    end;

    procedure COLGetTrackingData(var TempTrackingSpecification: Record "Tracking Specification" temporary): Boolean
    begin
        COLGetTrackingData(TempTrackingSpecification, '');
    end;

    procedure COLGetTrackingData(var TempTrackingSpecification: Record "Tracking Specification" temporary; SerialNo: Code[50]): Boolean
    var
        EntryNo: Integer;
        TrackFound: Boolean;
    begin
        TempTrackingSpecification.Reset();
        if TempTrackingSpecification.FindLast() then
            EntryNo := TempTrackingSpecification."Entry No." + 1
        else
            EntryNo := 1;

        TrackFound := false;
        if SerialNo <> '' then
            Rec.SetRange("Serial No.", SerialNo);
        if Rec.FindSet() then
            repeat
                TempTrackingSpecification.TransferFields(Rec);
                TempTrackingSpecification."Entry No." := EntryNo;
                TempTrackingSpecification.Insert();
                EntryNo += 1;
                TrackFound := true;
            until Rec.Next() = 0;

        exit(TrackFound);
    end;

    local procedure COLPrintSelectedData()
    var
        tempTrackingSpecification: Record "Tracking Specification" temporary;
        WeibelItemODCLabel: Report "COL Weibel Item ODC Label";
    begin
        CurrPage.SetSelectionFilter(Rec);
        if Rec.FindSet() then
            repeat
                tempTrackingSpecification.TransferFields(Rec);
                tempTrackingSpecification.Insert();
            until Rec.next() = 0;
        Rec.Reset();

        WeibelItemODCLabel.InitFrom(tempTrackingSpecification);
        WeibelItemODCLabel.RunModal();
    end;
}
