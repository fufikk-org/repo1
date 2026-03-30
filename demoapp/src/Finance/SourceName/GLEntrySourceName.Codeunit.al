codeunit 70211 "COL G/L Entry Source Name"
{
    Permissions = tabledata "G/L Entry" = RM;

    trigger OnRun()
    var
        GLEntry, GLEntry2 : Record "G/L Entry";
        GLEntrySubs: Codeunit "COL GLEntry Subs";
        SourceType: Enum "Gen. Journal Source Type";
        SourceTypeInt: Integer;
        Window: Dialog;
        LastUpdate: DateTime;
        UpdateSourceNameQst: Label 'Do you want to update ''%1'' on all G/L Entries?', Comment = '%1 = field caption';
        ProgressLbl: Label 'Updating G/L Entries\Source Type #1#\Source No. #2#', Comment = '#1 = source type; #2 = source no.';
    begin
        if not Confirm(UpdateSourceNameQst, false, GLEntry.FieldCaption("COL Source Name")) then
            exit;

        LastUpdate := CurrentDateTime();
        Window.Open(ProgressLbl);

        foreach SourceTypeInt in Enum::"Gen. Journal Source Type".Ordinals() do begin

            SourceType := Enum::"Gen. Journal Source Type".FromInteger(SourceTypeInt);
            Window.Update(1, SourceType);

            if SourceType <> Enum::"Gen. Journal Source Type"::" " then begin
                GLEntry.SetRange("Source Type", SourceType);
                GLEntry.SetCurrentKey("Source Type", "Source No.");

                if not GLEntry.IsEmpty() then begin
                    GLEntry.FindFirst();
                    repeat
                        Window.Update(2, GLEntry."Source No.");
                        GLEntry.SetRange("Source No.", GLEntry."Source No.");
                        GLEntry.FindFirst();

                        GLEntrySubs.SetSourceName(GLEntry);
                        GLEntry2.SetRange("Source Type", GLEntry."Source Type");
                        GLEntry2.SetRange("Source No.", GLEntry."Source No.");
                        GLEntry2.ModifyAll("COL Source Name", GLEntry."COL Source Name");
                        Commit();

                        GLentry.FindLast();
                        GLEntry.SetRange("Source No.");
                    until GLEntry.Next() = 0;
                end;
            end;
        end;

        Window.Close();
    end;
}