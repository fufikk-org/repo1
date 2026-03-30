namespace Weibel.Purchases.Vendor;

using Microsoft.Purchases.Vendor;
using Microsoft.Warehouse.Setup;

tableextension 70168 "COL Vendor" extends Vendor
{
    trigger OnAfterInsert()
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        if WarehouseSetup.Get() then
            if WarehouseSetup."COL Kardex Location Code" <> '' then
                Validate("Location Code", WarehouseSetup."COL Kardex Location Code");
    end;
}
