namespace Weibel.Manufacturing.ProductionBOM;

xmlport 70102 "COL Import BOM Line Buffer"
{
    Caption = 'Import BOM Line File';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = '<TAB>';
    UseRequestPage = false;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(ProdBOMLineBuffer; "COL Prod. BOM Line Buffer")
            {
                UseTemporary = true;
                textelement(Field1)
                {
                }
                textelement(Field2)
                {
                }
                textelement(Field3)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    LineNo += 1;

                    if LastUpdate - CurrentDateTime() > 500 then begin
                        Window.Update(1, LineNo);
                        LastUpdate := CurrentDateTime();
                    end;

                    if LineNo = 1 then
                        currXMLport.Skip();

                    ProdBOMLineBuffer."Line No." := LineNo;
                    if not Evaluate(ProdBOMLineBuffer.Quantity, Field1) then
                        ProdBOMLineBuffer.Quantity := 0;
                    ProdBOMLineBuffer."Item No." := CopyStr(Field2, 1, MaxStrLen(ProdBOMLineBuffer."Item No."));
                    ProdBOMLineBuffer.Position := CopyStr(Field3, 1, MaxStrLen(ProdBOMLineBuffer.Position));
                end;
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        Window.Open(ProgressLbl);
        LastUpdate := CurrentDateTime();
    end;

    trigger OnPostXmlPort()
    begin
        Window.Close();
    end;

    var
        LineNo: Integer;
        Window: Dialog;
        LastUpdate: DateTime;
        ProgressLbl: Label 'Lines: #1#', Comment = '#1 = line number';

    procedure GetImportedLines(var TempProdBOMLineBuffer: Record "COL Prod. BOM Line Buffer" temporary)
    begin
        TempProdBOMLineBuffer.Copy(ProdBOMLineBuffer, true);
    end;
}