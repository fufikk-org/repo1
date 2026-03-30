namespace Weibel.Manufacturing.Archive;

using Microsoft.Foundation.Navigate;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Manufacturing.WorkCenter;

page 70124 "COL Prod. Order Routing Arch."
{
    Caption = 'Prod. Order Routing Archive';
    PageType = List;
    SourceTable = "COL Prod.Or. Routing Line Arch";
    Editable = false;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = Manufacturing;
                    Visible = ProdOrderNoVisible;
                }
                field("Schedule Manually"; Rec."Schedule Manually")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Previous Operation No."; Rec."Previous Operation No.")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Next Operation No."; Rec."Next Operation No.")
                {
                    ApplicationArea = Manufacturing;
                    Editable = NextOperationNoEditable;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Manufacturing;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Manufacturing;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Manufacturing;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Starting Time"; StartingTime)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Starting Time';
                    ToolTip = 'Specifies the Starting Time';
                    Visible = DateAndTimeFieldVisible;

                }
                field("Starting Date"; StartingDate)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Starting Date';
                    ToolTip = 'Specifies the Starting Date';
                    Visible = DateAndTimeFieldVisible;

                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Ending Time"; EndingTime)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Ending Time';
                    ToolTip = 'Specifies the Ending Time';
                    Visible = DateAndTimeFieldVisible;

                }
                field("Ending Date"; EndingDate)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Ending Date';
                    ToolTip = 'Specifies the Ending Date';
                    Visible = DateAndTimeFieldVisible;

                }
                field("Setup Time"; Rec."Setup Time")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Setup Time Unit of Meas. Code"; Rec."Setup Time Unit of Meas. Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Run Time"; Rec."Run Time")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Run Time Unit of Meas. Code"; Rec."Run Time Unit of Meas. Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Wait Time"; Rec."Wait Time")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Wait Time Unit of Meas. Code"; Rec."Wait Time Unit of Meas. Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Move Time"; Rec."Move Time")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Move Time Unit of Meas. Code"; Rec."Move Time Unit of Meas. Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Fixed Scrap Quantity"; Rec."Fixed Scrap Quantity")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Scrap Factor %"; Rec."Scrap Factor %")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Send-Ahead Quantity"; Rec."Send-Ahead Quantity")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Concurrent Capacities"; Rec."Concurrent Capacities")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Unit Cost per"; Rec."Unit Cost per")
                {
                    ApplicationArea = Manufacturing;
                    Editable = UnitCostPerEditable;
                    Visible = false;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Expected Operation Cost Amt."; Rec."Expected Operation Cost Amt.")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Expected Capacity Ovhd. Cost"; Rec."Expected Capacity Ovhd. Cost")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Expected Capacity Need"; Rec."Expected Capacity Need" / ExpCapacityNeed())
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Expected Capacity Need';
                    ToolTip = 'Specifies the Expected Capacity Need';
                    DecimalPlaces = 0 : 5;
                    Visible = false;
                }
                field("Routing Status"; Rec."Routing Status")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Visible = false;
                }
                field("Open Shop Floor Bin Code"; Rec."Open Shop Floor Bin Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("To-Production Bin Code"; Rec."To-Production Bin Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("From-Production Bin Code"; Rec."From-Production Bin Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("COL In Progress Date-Time"; Rec."COL In Progress Date-Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("COL In Progress Set By User"; Rec."COL In Progress Set By User")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("COL Finished Date-Time"; Rec."COL Finished Date-Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("COL Finished By User"; Rec."COL Finished By User")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("COL Prod. Order Item No."; Rec."COL Prod. Order Item No.")
                {
                    ApplicationArea = Manufacturing;
                    Editable = false;
                    Visible = false;
                }
                field("COL Prod. Order Variant Code"; Rec."COL Prod. Order Variant Code")
                {
                    ApplicationArea = Manufacturing;
                    Editable = false;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.GetStartingEndingDateAndTime(StartingTime, StartingDate, EndingTime, EndingDate);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UnitCostPerEditable := Rec.Type = Rec.Type::"Work Center";
    end;

    trigger OnInit()
    begin
        ProdOrderNoVisible := true;
        NextOperationNoEditable := true;
        DateAndTimeFieldVisible := false;
    end;

    trigger OnOpenPage()
    begin
        ProdOrderNoVisible := true;
        if Rec.GetFilter("Prod. Order No.") <> '' then
            ProdOrderNoVisible := Rec.GetRangeMin("Prod. Order No.") <> Rec.GetRangeMax("Prod. Order No.");
        DateAndTimeFieldVisible := false;
    end;

    var
        ProdOrderNoVisible: Boolean;
        NextOperationNoEditable: Boolean;
        UnitCostPerEditable: Boolean;
        StartingTime: Time;
        EndingTime: Time;
        StartingDate: Date;
        EndingDate: Date;
        DateAndTimeFieldVisible: Boolean;

    local procedure ExpCapacityNeed(): Decimal
    var
        WorkCenter: Record "Work Center";
        CalendarMgt: Codeunit "Shop Calendar Management";
    begin
        if Rec."Work Center No." = '' then
            exit(1);
        WorkCenter.Get(Rec."Work Center No.");
        exit(CalendarMgt.TimeFactor(WorkCenter."Unit of Measure Code"));
    end;

    procedure Initialize(NewCaption: Text)
    begin
        CurrPage.Caption(NewCaption);
    end;
}

