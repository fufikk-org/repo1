namespace Weibel.Integration.Python;

using Microsoft.Manufacturing.Document;
using Microsoft.Sales.Archive;
using Microsoft.Inventory.Ledger;
using Microsoft.Sales.Document;
using Microsoft.Purchases.Document;
using System.Security.AccessControl;

permissionset 70101 "COL Py Integration"
{
    Assignable = true;
    Caption = 'Python Integration', MaxLength = 30;
    IncludedPermissionSets = "LOGIN";
    Permissions =
        codeunit "Caption Mgt. Handler (PGS)" = X,
        codeunit "Purch. Line CaptionClass Mgmt" = X,
        codeunit "Sales Line CaptionClass Mgmt" = X,

        tabledata "Prod. Order Component" = R,
        table "Prod. Order Component" = X,
        page "COL API Py ProdOrderComponent" = X,

        tabledata "Prod. Order Line" = R,
        table "Prod. Order Line" = X,
        page "COL API Py Prod Order Lines" = X,

        tabledata "Purchase Line" = R,
        table "Purchase Line" = X,
        page "COL API Py Purchase Lines" = X,

        tabledata "Sales Line" = R,
        table "Sales Line" = X,
        page "COL API Py Sales Lines" = X,

        tabledata "Sales Header" = R,
        table "Sales Header" = X,
        page "COL API Py Sales Headers" = X,

        tabledata "Purchase Header" = R,
        table "Purchase Header" = X,
        page "COL API Py Purchase Headers" = X,

        tabledata "Item Ledger Entry" = R,
        table "Item Ledger Entry" = X,
        page "COL API Py Item Ledger Entries" = X,

        tabledata "Prod. Order Routing Line" = R,
        table "Prod. Order Routing Line" = X,
        page "COL API Py ProdOrderRoutLines" = X;
}
