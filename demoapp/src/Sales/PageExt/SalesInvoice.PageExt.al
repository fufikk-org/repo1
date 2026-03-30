namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Weibel.Common;
using Weibel.Intercompany;

pageextension 70123 "COL Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("COL Warranty Code"; Rec."COL Warranty Code")
            {
                ApplicationArea = All;
            }
            field("COL Warranty Description"; Rec."COL Warranty Description")
            {
                ApplicationArea = All;
            }
            field("COL Terms and Cond. Code"; Rec."COL Terms and Cond. Code")
            {
                ApplicationArea = All;
            }
            group("COL Classification")
            {
                Caption = 'Classification';
                field("COL Export Classification Code"; Rec."COL Export Classification Code")
                {
                    ApplicationArea = All;
                }
                field("COL Export Permit No."; Rec."COL Export Permit No.")
                {
                    ApplicationArea = All;
                }
            }
            group("COL Weibel")
            {
                Caption = 'Weibel';
                field("COL Project Name"; Rec."COL Project Name")
                {
                    ApplicationArea = All;
                }
            }
        }

        addafter("Sell-to Contact")
        {
            field("COL Original Contractual Date"; Rec."COL Original Contractual Date")
            {
                ApplicationArea = All;
            }
        }

        addafter("External Document No.")
        {
            field("COL Original Promised Date"; Rec."COL Original Promised Date")
            {
                ApplicationArea = All;
                Editable = OriginalPromisedDateEditable;

                trigger OnValidate()
                var
                begin
                    UpdateEditable();
                end;
            }
        }

        addafter("Salesperson Code")
        {
            field("COL Sales Finance Category"; Rec."COL Sales Finance Category")
            {
                ApplicationArea = All;
            }
            field("COL Sales Order Category"; Rec."COL Sales Order Category")
            {
                ApplicationArea = All;
            }
        }

        addafter("Shipping and Billing")
        {
            group("COL End User Details")
            {
                Caption = 'End User Details';
                group("COL Details")
                {
                    ShowCaption = false;
                    group("COL User Type")
                    {
                        ShowCaption = false;
                        field("COL EndUserOptions"; Rec."COL End User Type")
                        {
                            ApplicationArea = Basic, Suite;
                        }
                        group("COL CustomerEndUser")
                        {
                            ShowCaption = false;
                            Visible = Rec."COL End User Type" = Rec."COL End User Type"::"Existing End User";

                            field("COL Existing End User No."; Rec."COL Existing End User No.")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL CF_1"; Rec."COL End User Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Name';
                            }
                            field("COL CF_2"; Rec."COL End User Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Address';
                            }
                            field("COL CF_3"; Rec."COL End User Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Address 2';
                            }
                            field("COL CF_4"; Rec."COL End User City")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User City';
                            }
                            field("COL CF_5"; Rec."COL End User County")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User County';
                            }
                            field("COL CF_6"; Rec."COL End User Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Post Code';
                            }
                            field("COL CF_7"; Rec."COL End User Country/Region")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Country';
                            }
                            field("COL CF_8"; Rec."COL End User E-Mail")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User County';
                            }
                        }
                        group("COL NewEndUser")
                        {
                            ShowCaption = false;
                            Visible = Rec."COL End User Type" = Rec."COL End User Type"::"New End User";

                            field("COL NCF_1"; Rec."COL End User Name")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_2"; Rec."COL End User Address")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_3"; Rec."COL End User Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_4"; Rec."COL End User City")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_5"; Rec."COL End User County")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_6"; Rec."COL End User Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_7"; Rec."COL End User Country/Region")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_8"; Rec."COL End User E-Mail")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                        }
                    }
                }

            }

            group("COL Group Client")
            {
                Caption = 'Weibel Group Sales';

                field("COL GS. Company"; Rec."COL GS. Company")
                {
                    ApplicationArea = Basic, Suite;
                    LookupPageId = "COL Intercompany Companies";
                }
                field("COL GS. Customer No."; Rec."COL GS. Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_0"; Rec."COL GS. Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_1"; Rec."COL GS. Name 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_2"; Rec."COL GS. Address")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_3"; Rec."COL GS. Address 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_4"; Rec."COL GS. City")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_5"; Rec."COL GS. County")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_6"; Rec."COL GS. Post Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_7"; Rec."COL GS. Country/Region")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        addafter(Function_CustomerCard)
        {
            action("COL CreateEndUser")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create End User Customer';
                Image = NewCustomer;
                PromotedCategory = Category7;
                PromotedOnly = true;
                Enabled = Rec."COL End User Type" = Rec."COL End User Type"::"New End User";
                Promoted = true;
                ToolTip = 'Create new end user from page details';

                trigger OnAction()
                var
                    CommonCustMgt: Codeunit "COL Common Cust. Mgt";
                begin
                    CommonCustMgt.CreateEndUserCust(Rec);
                end;
            }
            action("COL Change Org. Prom. Date")
            {
                ApplicationArea = All;
                Caption = 'Update Original Promised Date';
                PromotedCategory = Category7;
                PromotedOnly = true;
                Promoted = true;
                Image = ChangeDate;
                ToolTip = 'Update Original Promised Date.';

                trigger OnAction()
                begin
                    Rec.COLChangeOriginalPromDate();
                    UpdateEditable();
                end;
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        UpdateEditable();
    end;

    var
        OriginalPromisedDateEditable: Boolean;

    local procedure UpdateEditable()
    begin
        OriginalPromisedDateEditable := Rec."COL Original Promised Date" = 0D;
    end;
}
