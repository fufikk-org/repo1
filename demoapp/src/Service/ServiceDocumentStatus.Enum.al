namespace Weibel.Service.Document;

enum 70100 "COL Service Document Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(2; Released)
    {
        Caption = 'Released';
    }
}