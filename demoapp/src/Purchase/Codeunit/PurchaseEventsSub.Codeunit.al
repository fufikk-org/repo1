namespace Weibel.Events.Sub;

using Microsoft.Purchases.Document;
using Microsoft.Foundation.Reporting;
using Weibel.Purchases.Setup;
using Microsoft.Purchases.Setup;
using System.EMail;

codeunit 70203 "COL Purchase Events Sub."
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterBuyFromAddressEqualsPayToAddress, '', false, false)]
    local procedure "Purchase Header_OnAfterBuyFromAddressEqualsPayToAddress"(PurchaseHeader: Record "Purchase Header"; var Result: Boolean)
    begin
        // no need to check, data in sell and bill to is different
        if not Result then
            exit;

        Result := Result and (PurchaseHeader."Pay-to Name" = PurchaseHeader."Buy-from Vendor Name") and
            (PurchaseHeader."Pay-to Name 2" = PurchaseHeader."Buy-from Vendor Name 2");
    end;

}