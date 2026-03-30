codeunit 70150 "COL Purchase Release Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnAfterReleasePurchaseDoc, '', false, false)]
    local procedure "Release Purchase Document_OnAfterReleasePurchaseDoc"(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    var
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        if PreviewMode then
            exit;

        if PurchaseHeader."Document Type" = Enum::"Purchase Document Type"::Order then
            ArchiveManagement.ArchPurchDocumentNoConfirm(PurchaseHeader);
    end;
}