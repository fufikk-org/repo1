namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;

pageextension 70188 "COL Blanket Purchase Order Sub" extends "Blanket Purchase Order Subform"
{
    layout
    {
        modify("Expected Receipt Date")
        {
            Visible = true;
        }
    }
}
