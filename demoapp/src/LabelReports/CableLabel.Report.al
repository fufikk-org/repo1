namespace Weibel.Inventory.Ledger;

using Microsoft.Inventory.Ledger;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;
report 70106 "COL Cable Label"
{
    ApplicationArea = All;
    Caption = 'Cable Label';
    UsageCategory = Administration;
    DefaultRenderingLayout = Label80x40;

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.", "Serial No.";
            UseTemporary = true;

            column(Entry_No_; "Entry No.")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(SerialNo; "Serial No.")
            {
            }
            column(VariantTxtLbl; VariantTxt)
            {
            }
            column(Pn; PnLbl + "Item No." + VariantTxt)
            {
            }
            column(Sn; SnLbl + "Serial No.")
            {
            }
            column(Cage; CageLbl + CageNoLbl)
            {
            }
            column(CageNo; CageNoLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VariantTxt := VariantPrefixLbl + ItemLedgerEntry."Variant Code";
            end;
        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Info)
                {
                    Caption = 'Information';
                    label(NoSerial)
                    {
                        Visible = not SerialFilled;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Serial Number has not been entered.';
                        Style = Attention;
                    }
                    field(VariantCode; VariantCodeReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variant Code';
                        ToolTip = 'Select Variant for to print.';
                        visible = VariantToSelected;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemVariant: Record "Item Variant";
                            ItemVariants: Page "Item Variants";
                        begin
                            ItemVariant.SetRange("Item No.", CurrItemNo);
                            ItemVariants.SetTableView(ItemVariant);
                            ItemVariants.LookupMode := true;
                            if ItemVariants.RunModal() = Action::LookupOK then begin
                                ItemVariants.GetRecord(ItemVariant);
                                VariantCodeReq := ItemVariant."Code";
                                if ItemLedgerEntry.FindFirst() then begin
                                    ItemLedgerEntry."Variant Code" := VariantCodeReq;
                                    ItemLedgerEntry.Modify(false);
                                end;
                            end;
                        end;

                        trigger OnValidate()
                        var
                            ItemVariant: Record "Item Variant";
                        begin
                            if ItemLedgerEntry.FindFirst() then begin
                                ItemVariant.Get(ItemLedgerEntry."Item No.", VariantCodeReq);
                                ItemLedgerEntry."Variant Code" := VariantCodeReq;
                                ItemLedgerEntry.Modify(false);
                            end;
                        end;
                    }
                }



            }
        }
    }
    rendering
    {
        layout(Label80x40)
        {
            Caption = 'Label 80x40';
            Type = RDLC;
            LayoutFile = './src/LabelReports/Layout/COLCable80x40.rdl';
        }
        layout(Label30x40)
        {
            Caption = 'Label 30x40';
            Type = RDLC;
            LayoutFile = './src/LabelReports/Layout/COLCable30x40.rdl';
        }
        layout(Label16x40)
        {
            Caption = 'Label 16x40';
            Type = RDLC;
            LayoutFile = './src/LabelReports/Layout/COLCable16x40.rdl';
        }
    }

    var
        SerialFilled: Boolean;
        VariantToSelected: Boolean;
        VariantTxt: Text;
        VariantCodeReq: Code[10];
        CurrItemNo: Code[20];
        PnLbl: Label 'P/N: ', Locked = true;
        SnLbl: Label 'S/N: ', Locked = true;
        CageLbl: Label 'CAGE: ', Locked = true;
        CageNoLbl: Label 'R1121', Locked = true;
        VariantPrefixLbl: Label ' Rev.', Locked = true;

    procedure SetData(var pItemLedgerEntry: Record "Item Ledger Entry")
    begin
        if pItemLedgerEntry.FindSet() then
            repeat
                if pItemLedgerEntry."Serial No." = '' then
                    SerialFilled := false
                else
                    SerialFilled := true;

                ItemLedgerEntry.TransferFields(pItemLedgerEntry);
                ItemLedgerEntry.Insert();
            until pItemLedgerEntry.Next() = 0;
    end;

    procedure SetData(var pol: Record "Prod. Order Line")
    begin
        ItemLedgerEntry."Entry No." := 1;
        ItemLedgerEntry."Item No." := pol."Item No.";
        ItemLedgerEntry."Serial No." := '';
        ItemLedgerEntry."Variant Code" := pol."Variant Code";
        ItemLedgerEntry.Insert();
    end;

    procedure SetData(var item: Record "Item")
    begin
        VariantToSelected := true;
        CurrItemNo := item."No.";

        ItemLedgerEntry."Entry No." := 1;
        ItemLedgerEntry."Item No." := item."No.";
        ItemLedgerEntry."Serial No." := '';
        ItemLedgerEntry."Variant Code" := '';
        ItemLedgerEntry.Insert();
    end;
}
