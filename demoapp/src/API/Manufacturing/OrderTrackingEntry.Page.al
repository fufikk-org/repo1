namespace Weibel.Foundation.Navigate;

using Microsoft.Foundation.Navigate;
using Microsoft.Manufacturing.Document;

page 70273 "COL Order Tracking Entry"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'colOrderTrackingEntry';
    DelayedInsert = true;
    EntityName = 'colOrderTracking';
    EntitySetName = 'colOrderTrackings';
    PageType = API;
    SourceTable = "Order Tracking Entry";
    SourceTableTemporary = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(poRef; Rec."COL Source Line Id")
                {
                }
                field(systemId; Rec.SystemId)
                {
                }
                field(entryNo; Rec."Entry No.")
                {
                }
                field(name; Rec.Name)
                {
                }
                field(suppliedBy; Rec."Supplied by")
                {
                }
                field(level; Rec.Level)
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(startingDate; Format(Rec."Starting Date", 0, 9))
                {
                }
                field(endingDate; Format(Rec."Ending Date", 0, 9))
                {
                }
                field(quantity; Format(Rec.Quantity, 0, 9))
                {
                }
                field(fromType; Rec."From Type")
                {
                }
                field(fromSubType; Rec."From Subtype")
                {
                }
                field(fromId; Rec."From ID")
                {
                }
                field(fromRefNo; Rec."From Ref. No.")
                {
                }
                field(forType; Rec."For Type")
                {
                }
                field(forSubType; Rec."For Subtype")
                {
                }
                field(forID; Rec."For ID")
                {
                }
                field(forRefNo; Rec."For Ref. No.")
                {
                }
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    var
        ProdOrderLine: Record "Prod. Order Line";
        poGuid: Guid;
    begin
        Rec.FilterGroup(4);
        poGuid := Rec.GetFilter("COL Source Line Id");
        Rec.FilterGroup(0);
        ProdOrderLine.GetBySystemId(poGuid);
        if not LineFiled then begin
            FillOrderTracking(ProdOrderLine, poGuid);

            if not Rec.FindFirst() then
                exit(false);
            LineFiled := true;
        end;

        exit(true);
    end;

    procedure FillOrderTracking(SourceRecordVar: Variant; var poGuid: Guid)
    var

        TempOrderTracking2: Record "Order Tracking Entry" temporary;
        OrderTrackingManagement: Codeunit OrderTrackingManagement;
    begin


        TempOrderTracking.DeleteAll();
        OrderTrackingManagement.SetSourceRecord(SourceRecordVar);
        OrderTrackingManagement.FindRecords();
        if OrderTrackingManagement.FindRecord('=>', TempOrderTracking2) then
            repeat
                Rec.TransferFields(TempOrderTracking2);
                Rec."COL Source Line Id" := poGuid;
                Rec.Insert();
            until OrderTrackingManagement.GetNextRecord(1, TempOrderTracking2) = 0;
    end;

    var
        TempOrderTracking: Record "Order Tracking Entry" temporary;
        LineFiled: Boolean;
}
