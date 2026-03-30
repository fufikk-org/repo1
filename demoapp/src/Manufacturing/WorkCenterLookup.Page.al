page 70207 "COL Work Center Lookup"
{
    ApplicationArea = Manufacturing;
    Caption = 'Work Center Lookup';
    CardPageID = "Work Center Card";
    Editable = false;
    PageType = List;
    SourceTable = "Work Center";
    SourceTableTemporary = true;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the name of the work center.';
                }
                field("Alternate Work Center"; Rec."Alternate Work Center")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies an alternate work center.';
                }
                field("Work Center Group Code"; Rec."Work Center Group Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the work center group, if the work center or underlying machine center is assigned to a work center group.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the cost of one unit of the selected item or resource.';
                    Visible = false;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the percentage of the center''s cost that includes indirect costs, such as machine maintenance.';
                    Visible = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the amount of work that can be done in a specified time period. The capacity of a work center indicates how many machines or persons are working at the same time. If you enter 2, for example, the work center will take half of the time compared to a work center with the capacity of 1. ';
                }
                field(Efficiency; Rec.Efficiency)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the efficiency factor as a percentage of the work center.';
                    Visible = false;
                }
                field("Maximum Efficiency"; Rec."Maximum Efficiency")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the maximum efficiency factor of the work center.';
                    Visible = false;
                }
                field("Minimum Efficiency"; Rec."Minimum Efficiency")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the minimum efficiency factor of the work center.';
                    Visible = false;
                }
                field("Simulation Type"; Rec."Simulation Type")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the simulation type for the work center.';
                    Visible = false;
                }
                field("Shop Calendar Code"; Rec."Shop Calendar Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the shop calendar code that the planning of this work center refers to.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the overhead rate of this work center.';
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies when the work center card was last modified.';
                    Visible = false;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies how consumption of the item (component) is calculated and handled in production processes. Manual: Enter and post consumption in the consumption journal manually. Forward: Automatically posts consumption according to the production order component lines when the first operation starts. Backward: Automatically calculates and posts consumption according to the production order component lines when the production order is finished. Pick + Forward / Pick + Backward: Variations with warehousing.';
                    Visible = false;
                }
                field("Subcontractor No."; Rec."Subcontractor No.")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the number of a subcontractor who supplies this work center.';
                    Visible = false;
                }
            }
        }
    }

    procedure COLSetTable(var pWorkCenter: Record "Work Center")
    begin
        if pWorkCenter.FindSet() then
            repeat
                Rec.TransferFields(pWorkCenter);
                Rec.Insert();
            until pWorkCenter.Next() = 0;
    end;
}

