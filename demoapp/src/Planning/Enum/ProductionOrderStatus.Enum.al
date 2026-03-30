namespace weibel.Inventory.Tracking;

enum 70118 "COL Production Order Status"
{
    Extensible = true;

    value(0; "Simulated") { Caption = 'Simulated'; }
    value(1; "Planned") { Caption = 'Planned'; }
    value(2; "Firm Planned") { Caption = 'Firm Planned'; }
    value(3; "Released") { Caption = 'Released'; }
    value(4; "Finished") { Caption = 'Finished'; }
    value(5; " ") { Caption = ' ', Locked = true; }
}
