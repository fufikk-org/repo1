namespace Weibel.Manufacturing.Routing;

using Microsoft.Manufacturing.Routing;

tableextension 70156 "COL Routing Line" extends "Routing Line"
{
    fields
    {
        field(70100; "COL First Operation"; Boolean)
        {
            Caption = 'First Operation';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RoutingLine: Record "Routing Line";
                OneRoutingAtTimeErr: Label 'There can only be one first operation in a routing.';
            begin
                if Rec."COL First Operation" then begin
                    RoutingLine.SetRange("Routing No.", Rec."Routing No.");
                    RoutingLine.SetRange("Version Code", Rec."Version Code");
                    RoutingLine.SetRange("COL First Operation", true);
                    RoutingLine.SetFilter("Operation No.", '<>%1', Rec."Operation No.");
                    if not RoutingLine.IsEmpty() then
                        Error(OneRoutingAtTimeErr);
                end;
            end;
        }
    }
}