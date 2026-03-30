namespace Weibel.Service.Document;

using Microsoft.Service.Document;
using Weibel.Foundation.Reporting;
using Weibel.Sales.Document;
using Weibel.Common;
using Weibel.Packaging;
using Microsoft.Projects.Project.Job;

pageextension 70128 "COL Service Order" extends "Service Order"
{
    layout
    {
        addlast(General)
        {
            field("COL Original Contractual Date"; Rec."COL Original Contractual Date")
            {
                ApplicationArea = All;
            }
            field("COL Shipping Status"; Rec."COL Shipping Status")
            {
                ApplicationArea = All;
            }
            field("COL Order State"; Rec."COL Order State")
            {
                ApplicationArea = All;
            }
            field("COL Project No. PGS"; Rec."Project No. PGS")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Project No.';
                Editable = false;

                trigger OnDrillDown()
                var
                    Job: Record "Job";
                    ProjectCardWithTaskPGS: Page "Project Card With Task (PGS)";
                begin
                    if Rec."Project No. PGS" = '' then
                        exit;
                    Job.SetRange("No.", Rec."Project No. PGS");
                    ProjectCardWithTaskPGS.SetTableView(Job);
                    ProjectCardWithTaskPGS.Run();
                end;
            }
            group("COL PackagingInformation")
            {
                Caption = 'Packaging Information';

                grid("COL Packaging Grid")
                {
                    group("COL No. of Packages Group")
                    {
                        Caption = 'No. of Packages';

                        field("COL No. of Packages"; Rec."COL No. of Packages")
                        {
                            ApplicationArea = All;
                            Caption = 'Calculated';
                        }
                        field("COL No. of Packages Manual"; Rec."COL No. of Packages Manual")
                        {
                            ApplicationArea = All;
                            Caption = 'User Defined';
                        }
                    }
                    group("COL Total Weight Group")
                    {
                        Caption = 'Total Gross Weight';
                        field("COL Total Gross Weight"; Rec."COL Total Gross Weight")
                        {
                            ApplicationArea = All;
                            Caption = 'Calculated';
                        }
                        field("COL Total Gross Weight Manual"; Rec."COL Total Gross Weight Manual")
                        {
                            ApplicationArea = All;
                            Caption = 'User Defined';
                        }
                    }
                }
            }

            group("COL Classification")
            {
                Caption = 'Classification';
                field("COL License Required"; LicenseRequired)
                {
                    ApplicationArea = All;
                    Caption = 'License Required';
                    ToolTip = 'Specifies if a License is Required.';
                    Editable = false;
                }
                field("COL Export Classification Code"; Rec."COL Export Classification Code")
                {
                    ApplicationArea = All;
                }
                field("COL Export Permit No."; Rec."COL Export Permit No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Document Date")
        {
            field("COL Quote Valid Until Date"; Rec."COL Quote Valid Until Date")
            {
                ApplicationArea = Service;
            }
        }
        addafter("Shipping")
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
                                Caption = 'Customer End User E-mail';
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
        addlast(processing)
        {
            action("COL Print Shipment Label")
            {
                ApplicationArea = All;
                Caption = 'Print Shipment Label';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Print Shipment Label.';

                trigger OnAction()
                var
                    DocumentPrint: Codeunit "COL Document-Print";
                begin
                    DocumentPrint.PrintServiceHeaderShipmentLabel(Rec);
                end;
            }
            action("COL Change Bill-to Customer")
            {
                Caption = 'Change Bill-to Customer';
                Image = ChangeCustomer;
                ToolTip = 'Change bill-to customer and preserve line information.';
                ApplicationArea = All;
                Enabled = IsChangeCustomerEnabled;

                trigger OnAction()
                var
                    ChangeCustomerMgt: Codeunit "COL Srv. Change Customer Mgt.";
                begin
                    ChangeCustomerMgt.ChangeBillToCustomer(Rec);
                end;
            }
        }
        addafter("&Customer Card")
        {
            action("COL CreateEndUser")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create End User Customer';
                Image = NewCustomer;
                //PromotedCategory = Category8;
                Enabled = Rec."COL End User Type" = Rec."COL End User Type"::"New End User";
                ToolTip = 'Create new end user from page details';

                trigger OnAction()
                var
                    CommonCustMgt: Codeunit "COL Common Cust. Mgt";
                begin
                    CommonCustMgt.CreateEndUserCust(Rec);
                end;
            }
        }
        addafter(PostBatch)
        {
            action("COL ProformaInvoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pro Forma Invoice';
                Ellipsis = true;
                Image = ViewPostedOrder;
                ToolTip = 'View or print the pro forma service invoice.';

                trigger OnAction()
                var
                    DocumentPrint: Codeunit "COL Document-Print";
                begin
                    DocumentPrint.PrintProformaServiceInvoice(Rec);
                end;
            }
        }
        addlast("O&rder")
        {
            action("COL Packages")
            {
                Caption = 'Package Dimensions';
                ToolTip = 'Open and edit list of packages related to current document.';
                Image = CalculateShipment;
                ApplicationArea = All;
                RunObject = page "COL Package Dimension List";
                RunPageLink = "Document Type" = const("Service Order"), "Document No." = field("No.");
            }
        }

        addlast(Category_Process)
        {
            actionref("COL Print Shipment Label_Promoted"; "COL Print Shipment Label") { }
            actionref("COL CreateEndUser_Promoted"; "COL CreateEndUser") { }
            actionref("COL Change Bill-to Customer_Promoted"; "COL Change Bill-to Customer") { }
        }
        addlast(Category_CategoryPrint)
        {
            actionref("COL ProformaInvoice_Promoted"; "COL ProformaInvoice") { }
        }
        addlast(Category_Category7)
        {
            actionref("COL ProformaInvoice_Promoted_Posting"; "COL ProformaInvoice") { }
        }
        addlast(Category_Category8) // Order
        {
            actionref("COL Packages_Promoted"; "COL Packages") { }
        }
    }

    trigger OnOpenPage()
    var
        RecreateSrvLinesSub: Codeunit "COL Recreate Srv. Lines Sub";
    begin
        IsChangeCustomerEnabled := RecreateSrvLinesSub.IsValidDocumentType(Enum::"Service Document Type"::Order);
    end;

    trigger OnAfterGetRecord()
    begin
        LicenseRequired := Rec.COLGetHighestPriority();
    end;

    var
        LicenseRequired: Text;
        IsChangeCustomerEnabled: Boolean;
}