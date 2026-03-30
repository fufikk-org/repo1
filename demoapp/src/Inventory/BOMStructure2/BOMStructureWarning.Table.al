namespace Weibel.Inventory.BOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.Routing;

table 70143 "COL BOM Structure Warning"
{
    Caption = 'BOM Warning';
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies a unique identifier for the warning entry.';
        }
        field(2; "Parent Entry No."; Integer)
        {
            Caption = 'Parent Entry No.';
            ToolTip = 'Specifies the Entry No. of the parent BOM Structure record this warning relates to.';
        }
        field(3; "Warning Description"; Text[250])
        {
            Caption = 'Warning Description';
            ToolTip = 'Specifies the value of the Warning Description field.';
        }
        field(4; "Table Id"; Integer)
        {
            Caption = 'Table Id';
            ToolTip = 'Specifies the ID of the table that the warning is related to.';
        }
        field(5; "Record Position"; Text[250])
        {
            Caption = 'Record Position';
            ToolTip = 'Specifies the position or location of the record in the BOM structure that triggered the warning.';
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Parent Entry No.")
        {
            Clustered = true;
        }
    }

    procedure SetWarning(WarningText: Text; var TempBOMStructure: Record "COL BOM Structure" temporary)
    begin
        InitWarningEntry(WarningText, TempBOMStructure, 0, '');
        Insert();
        MarkLineWithError(TempBOMStructure);
    end;

    procedure SetWarning(WarningText: Text; var TempBOMStructure: Record "COL BOM Structure" temporary; NewTableId: Integer; NewRecordPosition: Text)
    begin
        InitWarningEntry(WarningText, TempBOMStructure, NewTableId, NewRecordPosition);
        Insert();
        MarkLineWithError(TempBOMStructure);
    end;

    local procedure MarkLineWithError(var TempBOMStructure: Record "COL BOM Structure" temporary)
    begin
        if not TempBOMStructure."Has Warnings" then begin
            TempBOMStructure."Has Warnings" := true;
            TempBOMStructure.Modify();
        end;
    end;

    local procedure InitWarningEntry(WarningText: Text; var TempBOMStructure: Record "COL BOM Structure" temporary; NewTableId: Integer; NewRecordPosition: Text)
    begin
        "Entry No." := "Entry No." + 1;
        "Parent Entry No." := TempBOMStructure."Entry No.";
        "Warning Description" := CopyStr(WarningText, 1, MaxStrLen("Warning Description"));
        "Table Id" := NewTableId;
        if NewTableId = 0 then
            Clear("Record Position")
        else
            "Record Position" := CopyStr(NewRecordPosition, 1, MaxStrLen("Record Position"));
    end;

    procedure ShowWarning()
    var
        ProdBOMHeader: Record "Production BOM Header";
        RoutingHeader: Record "Routing Header";
        StockkeepingUnit: Record "Stockkeeping Unit";
        RecRef: RecordRef;
    begin
        if "Table ID" = 0 then
            exit;

        RecRef.Open("Table ID");
        RecRef.SetPosition("Record Position");

        case "Table ID" of
            Database::"Production BOM Header":
                begin
                    RecRef.SetTable(ProdBOMHeader);
                    ProdBOMHeader.SetRecFilter();
                    Page.RunModal(Page::"Production BOM", ProdBOMHeader);
                end;
            Database::"Routing Header":
                begin
                    RecRef.SetTable(RoutingHeader);
                    RoutingHeader.SetRecFilter();
                    Page.RunModal(Page::Routing, RoutingHeader);
                end;
            Database::"Stockkeeping Unit":
                begin
                    RecRef.SetTable(StockkeepingUnit);
                    StockkeepingUnit.SetRecFilter();
                    Page.RunModal(Page::"Stockkeeping Unit Card", StockkeepingUnit);
                end;
        end;
    end;
}

