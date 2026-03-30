namespace Weibel.JobManager;

using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;

pageextension 70220 "COL JobManReportItemCons." extends JobManReportItemConsumption
{
    layout
    {
        addafter(ItemDescription)
        {
            field("COL VariantCode"; VariantCode)
            {
                Caption = 'Variant Code';
                ApplicationArea = All;
                ToolTip = 'Specifies the variant code.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemVariant: Record "Item Variant";
                begin
                    ItemVariant.SetRange("Item No.", Rec.ItemNo);
                    ItemVariant."Item No." := Rec.ItemNo;
                    ItemVariant.Code := VariantCode;
                    if Page.RunModal(0, ItemVariant) = Action::LookupOK then
                        ValidateVariantCode(ItemVariant.Code);
                end;

                trigger OnValidate()
                begin
                    ValidateVariantCode(VariantCode);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        VariantCode := GetVariantCode(Rec);
    end;

    var
        VariantCode: Code[10];

    local procedure ValidateVariantCode(NewVariantCode: Code[10])
    var
        ProdOrderComponent: Record "Prod. Order Component";
        MissingProdOrderComponentLineErr: Label 'Requested ''%1'' does not exist.', Comment = '%1 = table caption';
    begin
        if not GetProdOrderComponent(ProdOrderComponent, Rec) then
            Error(MissingProdOrderComponentLineErr, ProdOrderComponent.TableCaption());

        if ProdOrderComponent."Variant Code" <> NewVariantCode then begin
            ProdOrderComponent.Validate("Variant Code", NewVariantCode);
            ProdOrderComponent.Modify(true);
        end;

        VariantCode := NewVariantCode;
    end;

    local procedure GetVariantCode(var JobManStampEvent: Record JobManStampEvent): Code[10]
    var
        ProdOrderComponent: Record "Prod. Order Component";
    begin
        ProdOrderComponent.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProdOrderComponent.SetLoadFields("Variant Code");
        if GetProdOrderComponent(ProdOrderComponent, JobManStampEvent) then
            exit(ProdOrderComponent."Variant Code");
    end;

    local procedure GetProdOrderComponent(var ProdOrderComponent: Record "Prod. Order Component"; var JobManStampEvent: Record JobManStampEvent): Boolean
    begin
        exit(ProdOrderComponent.Get(Enum::"Production Order Status"::Released, JobManStampEvent.RefNo, JobManStampEvent.ProdLineNo, JobManStampEvent.ItemRefLineNo));
    end;
}
