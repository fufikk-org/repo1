namespace Weibel.Common;

enum 70113 "COL Email Type"
{
    Extensible = true;

    value(0; "")
    {
        Caption = '', locked = true;
    }
    value(1; "Purch. Missing Conf. Reminder")
    {
        Caption = 'Purch. Missing Conf. Reminder';
    }
    value(2; "Purch. Overdue Delivery Reminder")
    {
        Caption = 'Purch. Overdue Delivery Reminder';
    }
    value(3; "Missing Conf. and Overdue Delivery")
    {
        Caption = 'Missing Conf. and Overdue Delivery';
    }
}
