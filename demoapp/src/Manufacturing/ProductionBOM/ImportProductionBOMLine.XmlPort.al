namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;

xmlport 70101 "COL Import Production BOM Line"
{
    Caption = 'Import Production BOM';
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;
    UseRequestPage = false;
    ObsoleteState = Pending;
    ObsoleteReason = 'Replaced by functionality in src/Manufacturing/ImportBOMLines';

    schema
    {
        textelement(RootNodeName)
        {

            tableelement(ProductionBOMLine; "Production BOM Line")
            {
                fieldelement(Quantity; ProductionBOMLine."Quantity per")
                {
                    FieldValidate = No;
                }
                fieldelement(No; ProductionBOMLine."No.")
                {
                    FieldValidate = No;

                    trigger OnAfterAssignField()
                    begin
                        ItemError := not Item.Get(ProductionBOMLine."No.");
                        ImportProductionBOMlog.InsertLog(ProductionBOMLine."No.", ItemError, LogNo);
                    end;

                }

                textelement(Position)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        ProductionBOMLine."COL Position" := GetFirst250Characters(Position);
                    end;
                }

                trigger OnAfterInitRecord()
                begin
                    if FirstRow then begin
                        FirstRow := false;
                        currXMLport.Skip();
                    end;
                end;

                trigger OnBeforeInsertRecord()
                var
                    ItemVariant: Record "Item Variant";
                begin
                    if ItemError then
                        currXMLport.Skip();
                    ProductionBOMLine."Production BOM No." := BOMHeader;
                    ProductionBOMLine."Version Code" := BOMVersionCode;
                    ProductionBOMLine."Line No." := GetLineNo();

                    ProductionBOMLine.Type := ProductionBOMLine.Type::Item;
                    ProductionBOMLine.Validate("No.");
                    ProductionBOMLine.Validate("Quantity per");
                    ProductionBOMLine.Validate("COL Position");
                    ItemVariant.SetRange("Item No.", ProductionBOMLine."No.");
                    if ItemVariant.FindLast() then
                        ProductionBOMLine."Variant Code" := ItemVariant.Code
                    else
                        ProductionBOMLine."Variant Code" := '';
                end;
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        FirstRow := true;
    end;

    trigger OnPostXmlPort()
    var
        ImportProdBOMlog: Record "COL Import Production BOM Log";
        ItemImportErr: Label 'Item %1 not found. BOM line will not be imported.', Comment = '%1=Item No.';
        StatusMsg: Label 'Import Production BOM completed. Imported %1 lines, %2 errors:\', Comment = '%1=Imported Qty, %2=Imported Errors';
        StatusMessage: Text;
    begin
        ImportProdBOMlog.SetRange("No.", LogNo);
        ImportedQty := ImportProdBOMlog.Count;
        ImportProdBOMlog.SetRange("Error", true);
        ImportedErrors := ImportProdBOMlog.Count;
        StatusMessage := StrSubstNo(StatusMsg, ImportedQty, ImportedErrors);
        if ImportProdBOMlog.FindSet() then
            repeat
                StatusMessage += StrSubstNo(ItemImportErr, ImportProdBOMlog."Item No.") + '\';
            until ImportProdBOMlog.Next() = 0;
        Message(StatusMessage);
    end;

    procedure SetBOMHeader(LBOMHeader: Code[20]; LBOMVersionCode: Code[20])
    begin
        BOMHeader := LBOMHeader;
        BOMVersionCode := LBOMVersionCode;
    end;

    local procedure GetFirst250Characters(Input: Text): Text[250]
    begin
        exit(CopyStr(Input, 1, 250));
    end;

    local procedure GetLineNo(): Integer
    var
        ProductionBOMLine: Record "Production BOM Line";
    begin
        ProductionBOMLine.SetRange("Production BOM No.", BOMHeader);
        ProductionBOMLine.SetRange("Version Code", BOMVersionCode);
        if ProductionBOMLine.FindLast() then
            exit(ProductionBOMLine."Line No." + 10000);
        exit(10000);
    end;

    var
        Item: Record Item;
        ImportProductionBOMlog: Record "COL Import Production BOM Log";
        BOMHeader: Code[20];
        BOMVersionCode: Code[20];
        LogNo: Code[20];
        ImportedQty: Integer;
        ImportedErrors: Integer;
        FirstRow: Boolean;
        ItemError: Boolean;
}

