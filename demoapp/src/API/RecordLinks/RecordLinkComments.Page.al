namespace Weibel.API;

using System.Environment.Configuration;
using System.Utilities;

page 70225 "COL Record Link Comments"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'recordLinkComment';
    EntitySetName = 'recordLinkComments';
    PageType = API;
    SourceTable = "Record Link";
    DataAccessIntent = ReadOnly;
    SourceTableTemporary = true;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                }
                field(linkID; Rec."Link ID")
                {
                }
                field("recordID"; Rec."Record ID")
                {
                }
                field(created; Rec.Created)
                {
                }
                field("userID"; Rec."User ID")
                {
                }
                field(noteAsText; GetNoteContentAsText())
                {
                    Editable = false;
                }
                field("type"; Format(Rec."Type", 0, '<Text>'))
                {
                    Editable = false;
                }
                field(description; Rec.Description)
                {
                }
                field(url; Rec.URL1)
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                }
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    var
        RequestedTableId: Integer;
        RequestedSystemId: Guid;
        RequestedTypeFilter: Text;
        TableFilterErr: Label 'Field ''linkId'' needs to specify a single table no. filter.', Locked = true;
        IdFilterErr: Label 'Field ''id'' needs to specify a single id for the systemId filter.', Locked = true;
    begin
        if not DataLoaded then begin
            if Rec.GetFilter("Link ID") = '' then
                Error(TableFilterErr);
            if Rec.GetRangeMin("Link ID") <> Rec.GetRangeMax("Link ID") then
                Error(TableFilterErr);
            RequestedTableId := Rec.GetRangeMin("Link ID");

            if Rec.GetFilter(SystemId) = '' then
                Error(IdFilterErr);
            if Rec.GetRangeMin(SystemId) <> Rec.GetRangeMax(SystemId) then
                Error(IdFilterErr);
            RequestedSystemId := Rec.GetRangeMin(SystemId);

            if Rec.GetFilter(Type) <> '' then
                RequestedTypeFilter := Rec.GetFilter(Type);

            LoadLines(Rec, RequestedTableId, RequestedSystemId, RequestedTypeFilter);
            if not Rec.FindFirst() then
                exit(false);
            DataLoaded := true;
        end;
        exit(true);
    end;

    var
        LinkManagement: Codeunit "Record Link Management";
        DataLoaded: Boolean;

    local procedure GetNoteContentAsText() NoteText: Text
    var
        RecordLink: Record "Record Link";
    begin
        NoteText := '';
        if Rec.Type = Rec.Type::Note then begin
            RecordLink.Get(Rec."Link ID");
            RecordLink.CalcFields(Note);
            NoteText := LinkManagement.ReadNote(RecordLink);
        end;
    end;

    local procedure LoadLines(var TempRecordLink: Record "Record Link" temporary; TableId: Integer; RecordSystemId: Guid; RequestedTypeFilter: Text)
    var
        RecordLink: Record "Record Link";
        RRef: RecordRef;
    begin
        RRef.Open(TableId);
        RRef.GetBySystemId(RecordSystemId);
        TempRecordLink.FilterGroup(4);
        TempRecordLink.Reset();

        // RecordLink.SetRange(Type, RecordLink.Type::Note);
        if RequestedTypeFilter <> '' then
            RecordLink.SetFilter(Type, RequestedTypeFilter);
        RecordLink.SetRange("Record ID", RRef.RecordId());
        RecordLink.SetRange(Company, CompanyName());

        TempRecordLink.DeleteAll();
        if RecordLink.FindSet() then
            repeat
                TempRecordLink := RecordLink;
                TempRecordLink.Insert();
            until RecordLink.Next() = 0;
    end;
}
