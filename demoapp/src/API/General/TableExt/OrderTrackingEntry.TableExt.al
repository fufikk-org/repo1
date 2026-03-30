namespace Weibel.Foundation.Navigate;

using Microsoft.Foundation.Navigate;

tableextension 70176 "COL Order Tracking Entry" extends "Order Tracking Entry"
{
    fields
    {
        field(70100; "COL Source Line Id"; Guid)
        {
            Caption = 'Source Line Id';
            DataClassification = CustomerContent;
        }
    }
}
