namespace Weibel.Inventory.Item;

/// <summary>
/// Please note that enum value also states priority, except for 0
/// This is going to be relevant for requirement 4311 and probably for 4312
/// </summary>
enum 70101 "COL Item Export Classification"
{
    Extensible = true;
    AssignmentCompatibility = true;
    value(0; "Unknown")
    {
        Caption = 'Unknown';
    }
    value(1; "Military Product")
    {
        Caption = 'Military Product';
    }
    value(2; "Dual Use")
    {
        Caption = 'Dual Use';
    }
    value(3; "Not Listed")
    {
        Caption = 'Not Listed';
    }
}
