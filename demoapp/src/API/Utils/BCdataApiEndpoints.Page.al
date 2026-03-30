namespace Weibel.API;

using Weibel.Utilities;
using System.Reflection;

page 70198 "COL BCdata Api Endpoints"
{
    PageType = API;
    Caption = 'BCdata Api Endpoints';
    SourceTable = "COL Page Control Buffer";
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Editable = false;
    DataAccessIntent = ReadOnly;
    EntityName = 'endpoint';
    EntitySetName = 'endpoints';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(pageInfo; Rec."Page Info")
                {
                }
                field(pageId; Rec."Page Id")
                {
                }
                field(apiPublisher; Rec."Api Publisher")
                {
                }
                field(apiGroup; Rec."Api Group")
                {
                }
                field(apiVersion; Rec."Api Version")
                {
                }
                field(entitySetName; Rec."Entity Set Name")
                {
                }
                field(sourceTable; Rec."Source Table")
                {
                }
                field(url; Rec.Url)
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        PageMetadata: Record "Page Metadata";
        AllObj: Record AllObj;
        PageInfoLbl: Label '%1/%2/%3/%4', Locked = true;
    begin
        PageMetadata.SetRange(PageType, PageMetadata.PageType::API);
        PageMetadata.SetRange(APIPublisher, 'weibel');
        if PageMetadata.FindSet() then
            repeat
                Rec.Init();
                Rec."Page Id" := PageMetadata.ID;
                Rec."Api Group" := PageMetadata.APIGroup;
                Rec."Api Publisher" := PageMetadata.APIPublisher;
                Rec."Api Version" := PageMetadata.APIVersion;
                Rec."Entity Set Name" := PageMetadata.EntitySetName;
                if PageMetadata.SourceTable > 0 then
                    if AllObj.Get(AllObj."Object Type"::Table, PageMetadata.SourceTable) then
                        Rec."Source Table" := AllObj."Object Name";
                Rec."Source Table View" := PageMetadata.SourceTableView;
                Rec.Indentation := 0;
                Rec.Url := CopyStr(GetUrl(ClientType::Api, CompanyName(), ObjectType::Page, PageMetadata.ID), 1, MaxStrLen(Rec.Url));
                Rec."Page Info" := StrSubstNo(PageInfoLbl, Rec."Api Publisher", Rec."Api Group", Rec."Api Version", Rec."Entity Set Name");
                Rec.Insert();
            until PageMetadata.Next() = 0;
    end;
}