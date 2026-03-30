namespace Weibel.Manufacturing.Archive;

page 70122 "COL Prod.Or. Comment Archive"
{
    Caption = 'Comment Sheet';
    PageType = List;
    Editable = false;
    SourceTable = "COL Prod. Order Comment Arch";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Date"; Rec.Date)
                {
                    ApplicationArea = Manufacturing;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Manufacturing;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
            }
        }
    }
}

