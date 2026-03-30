namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using System.Environment.Configuration;
using System.IO;
using Microsoft.Manufacturing.Routing;


codeunit 70151 "COL Copy Item Sub."
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Page, Page::"Copy Item", 'OnAfterInitCopyItemBuffer', '', false, false)]
    local procedure OnAfterInitCopyItemBuffer(var CopyItemBuffer: Record "Copy Item Buffer");
    begin
        CopyItemBuffer."Target Item No." := ''; // CopyItemBuffer."Source Item No.";
        if CopyItemBuffer."Target Item No." <> '' then
            CopyItemBuffer."Target No. Series" := '';
        CopyItemBuffer."Units of Measure" := true;
        CopyItemBuffer."COL Item Template Code" := ''; // WeibelSetup."COL Copy Item Template Code";
        CopyItemBuffer."COL New Process" := true;
        CopyItemBuffer."COL Production BOM" := false;
        CopyItemBuffer."COL Routing" := false;
        CopyItemBuffer."COL Links" := false;
        CopyItemBuffer."COL Notes" := false;

        CopyItemBuffer.Dimensions := false;
        CopyItemBuffer.Picture := false;
        CopyItemBuffer.Comments := false;
        CopyItemBuffer."Sales Prices" := false;
        CopyItemBuffer."Sales Line Discounts" := false;
        CopyItemBuffer."Purchase Prices" := false;
        CopyItemBuffer."Purchase Line Discounts" := false;
        CopyItemBuffer.Troubleshooting := false;
        CopyItemBuffer."Resource Skills" := false;
        CopyItemBuffer."Item Variants" := false;
        CopyItemBuffer.Translations := false;
        CopyItemBuffer."Extended Texts" := false;
        CopyItemBuffer."BOM Components" := false;
        CopyItemBuffer."Item Vendors" := false;
        CopyItemBuffer.Attributes := false;
        CopyItemBuffer."Item References" := false;
        CopyItemBuffer.Modify();

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Item", 'OnAfterCopyItem', '', false, false)]
    local procedure OnAfterCopyItem(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    begin
        TargetItem."COL Created By User" := CopyStr(UserId(), 1, MaxStrLen(TargetItem."COL Created By User"));
        TargetItem."COL Creation Date" := Today();

        SetTemplate(CopyItemBuffer, TargetItem);
        CopyProdBOM(CopyItemBuffer, SourceItem, TargetItem);
        CopyRouting(CopyItemBuffer, SourceItem, TargetItem);
        CopyLinks(CopyItemBuffer, SourceItem, TargetItem);
        CopyNotes(CopyItemBuffer, SourceItem, TargetItem);
    end;

    local procedure CopyLinks(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    begin
        if not CopyItemBuffer."COL Links" then
            exit;

        CopyRecLink(SourceItem, TargetItem, false);
    end;

    local procedure CopyNotes(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    begin
        if not CopyItemBuffer."COL Links" then
            exit;

        CopyRecLink(SourceItem, TargetItem, true);
    end;

    local procedure CopyRecLink(SourceItem: Record Item; var TargetItem: Record Item; Link: Boolean)
    var
        RecordLink: Record "Record Link";
        NewRecordLink: Record "Record Link";
        RecRef: RecordRef;
        NewRecRef: RecordRef;
    begin

        RecRef.GetTable(SourceItem);
        NewRecRef.GetTable(TargetItem);

        RecordLink.Reset();
        RecordLink.SetRange("Record ID", RecRef.RecordId);
        RecordLink.SetRange(Company, CompanyName());
        if Link then
            RecordLink.SetRange(Type, RecordLink.Type::Link)
        else
            RecordLink.SetRange(Type, RecordLink.Type::Note);

        if RecordLink.FindSet() then
            repeat
                NewRecordLink := RecordLink;
                NewRecordLink."Link ID" := 0;
                NewRecordLink."Record ID" := NewRecRef.RecordId;
                NewRecordLink.Insert();
            until RecordLink.Next() = 0;
    end;

    local procedure CopyProdBOM(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    var
        ProdBOMHeader: Record "Production BOM Header";
        NewProdBOMHeader: Record "Production BOM Header";
        ProductionBOMCopy: Codeunit "Production BOM-Copy";
        VersionManagement: Codeunit VersionManagement;
    begin
        if not CopyItemBuffer."COL Production BOM" then begin
            TargetItem."Production BOM No." := '';
            TargetItem.Modify();
            exit;
        end;

        if SourceItem."Production BOM No." = '' then
            exit;

        if not ProdBOMHeader.Get(SourceItem."Production BOM No.") then
            exit;

        NewProdBOMHeader := ProdBOMHeader;
        NewProdBOMHeader."No." := TargetItem."No.";
        NewProdBOMHeader.Status := NewProdBOMHeader.Status::New;
        NewProdBOMHeader.Insert(true);

        ProductionBOMCopy.CopyBOM(SourceItem."Production BOM No.", VersionManagement.GetBOMVersion(ProdBOMHeader."No.", WorkDate(), true), NewProdBOMHeader, '');
        TargetItem."Production BOM No." := NewProdBOMHeader."No.";
        TargetItem.Modify();
    end;

    local procedure CopyRouting(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    var
        RoutingHeader: Record "Routing Header";
        NewRoutingHeader: Record "Routing Header";
        CopyRoutingCu: Codeunit "Routing Line-Copy Lines";
        VersionManagement: Codeunit VersionManagement;
    begin
        if not CopyItemBuffer."COL Routing" then begin
            TargetItem."Routing No." := '';
            TargetItem.Modify();
            exit;
        end;

        if SourceItem."Production BOM No." = '' then
            exit;

        if not RoutingHeader.Get(SourceItem."Production BOM No.") then
            exit;

        NewRoutingHeader := RoutingHeader;
        NewRoutingHeader."No." := TargetItem."No.";
        NewRoutingHeader.Status := NewRoutingHeader.Status::New;
        NewRoutingHeader.Insert(true);

        CopyRoutingCu.CopyRouting(SourceItem."Production BOM No.", VersionManagement.GetRtngVersion(RoutingHeader."No.", WorkDate(), true), NewRoutingHeader, '');
        TargetItem."Routing No." := NewRoutingHeader."No.";
        TargetItem.Modify();
    end;

    local procedure SetTemplate(var CopyItemBuffer: Record "Copy Item Buffer"; var TargetItem: Record Item)
    var
        ConfigTemplateHeader: Record "Config. Template Header";
        ConfigTemplateManagement: Codeunit "Config. Template Management";
        RecRef: RecordRef;
    begin
        if CopyItemBuffer."COL Item Template Code" = '' then
            exit;

        if not ConfigTemplateHeader.Get(CopyItemBuffer."COL Item Template Code") then
            exit;

        RecRef.GetTable(TargetItem);

        ConfigTemplateManagement.UpdateRecord(ConfigTemplateHeader, RecRef);
        RecRef.SetTable(TargetItem);
        TargetItem.Modify();
    end;
}
