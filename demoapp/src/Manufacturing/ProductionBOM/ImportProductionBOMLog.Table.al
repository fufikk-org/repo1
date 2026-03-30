namespace Weibel.Manufacturing.ProductionBOM;
table 70129 "COL Import Production BOM Log"
{
    Caption = 'Import Production BOM Log';
    DataClassification = CustomerContent;
    ObsoleteState = Pending;
    ObsoleteReason = 'Replaced by functionality in src/Manufacturing/ImportBOMLines';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(4; "Error"; Boolean)
        {
            Caption = 'Error';
        }
        field(5; "Run Date Time"; DateTime)
        {
            Caption = 'Run Date Time';
        }
        field(6; "Run by User"; Text[250])
        {
            Caption = 'Run by User';
        }
    }
    keys
    {
        key(PK; "No.", "line No.")
        {
            Clustered = true;
        }
    }

    procedure InsertLog(ItemNo: Code[20]; LError: Boolean; var LogNo: Code[20]): Code[20]
    var
        ImportProductionBOMLog: Record "COL Import Production BOM Log";
    begin
        if LogNo = '' then
            LogNo := GetNextNo();

        ImportProductionBOMLog.Init();
        ImportProductionBOMLog."No." := LogNo;
        ImportProductionBOMLog."line No." := GetLineNo(LogNo);
        ImportProductionBOMLog."Item No." := ItemNo;
        ImportProductionBOMLog."Error" := LError;
        ImportProductionBOMLog."Run Date Time" := CreateDateTime(Today(), Time());
        ImportProductionBOMLog."Run by User" := CopyStr(UserId(), 1, 250);
        ImportProductionBOMLog.Insert();
        exit(ImportProductionBOMLog."No.");
    end;

    local procedure GetNextNo(): Code[20]
    var
        ImportProductionBOMLog: Record "COL Import Production BOM Log";
    begin
        if ImportProductionBOMLog.FindLast() then
            exit(Text.IncStr(ImportProductionBOMLog."No."));
        exit('1');
    end;

    local procedure GetLineNo(LogNo: Code[20]): Integer
    var
        ImportProductionBOMLog: Record "COL Import Production BOM Log";
    begin
        ImportProductionBOMLog.SetRange("No.", LogNo);
        if ImportProductionBOMLog.FindLast() then
            exit(ImportProductionBOMLog."line No." + 1)
        else
            exit(1);
    end;
}
