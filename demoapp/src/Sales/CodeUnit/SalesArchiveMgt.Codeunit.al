namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Microsoft.Utilities;
using Microsoft.Sales.Setup;

codeunit 70233 "COL Sales Archive Mgt."
{
    procedure DoArchiveSalesDoc(var SalesHeader: Record "Sales Header")
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ArchiveManagement: Codeunit ArchiveManagement;
    begin

        if not SalesReceivablesSetup.Get() then
            SalesReceivablesSetup.Init();

        if SalesReceivablesSetup."COL Disable Release Archive" then
            exit;

        case SalesHeader."Document Type" of
            // SalesHeader."Document Type"::Quote:
            //     if SalesReceivablesSetup."Archive Quotes" <> SalesReceivablesSetup."Archive Quotes"::Never then
            //         ArchiveManagement.ArchSalesDocumentNoConfirm(SalesHeader);

            SalesHeader."Document Type"::Order: // Only Order so not overgrowth of archived data size
                if SalesReceivablesSetup."Archive Orders" then
                    ArchiveManagement.ArchSalesDocumentNoConfirm(SalesHeader);

        // SalesHeader."Document Type"::"Blanket Order":
        //     if SalesReceivablesSetup."Archive Blanket Orders" then
        //         ArchiveManagement.ArchSalesDocumentNoConfirm(SalesHeader);

        // SalesHeader."Document Type"::"Return Order":
        //     if SalesReceivablesSetup."Archive Return Orders" then
        //         ArchiveManagement.ArchSalesDocumentNoConfirm(SalesHeader);
        end;

    end;
}
