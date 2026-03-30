namespace Weibel.API;

using Microsoft.Projects.Project.Job;

page 70151 "COL Projects"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'project';
    EntitySetName = 'projects';
    PageType = API;
    SourceTable = Job;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                }
                field(searchDescription; Rec."Search Description")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                }
                field(creationDate; Rec."Creation Date")
                {
                }
                field(startingDate; Rec."Starting Date")
                {
                }
                field(endingDate; Rec."Ending Date")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(personResponsible; Rec."Person Responsible")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(jobPostingGroup; Rec."Job Posting Group")
                {
                }
                field(blocked; Rec.Blocked)
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
                {
                }
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(binCode; Rec."Bin Code")
                {
                }
                field(languageCode; Rec."Language Code")
                {
                }
                field(scheduledResQty; Rec."Scheduled Res. Qty.")
                {
                }
                field(scheduledResGrQty; Rec."Scheduled Res. Gr. Qty.")
                {
                }
                field(billToName; Rec."Bill-to Name")
                {
                }
                field(billToAddress; Rec."Bill-to Address")
                {
                }
                field(billToAddress2; Rec."Bill-to Address 2")
                {
                }
                field(billToCity; Rec."Bill-to City")
                {
                }
                field(billToCounty; Rec."Bill-to County")
                {
                }
                field(billToPostCode; Rec."Bill-to Post Code")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(billToCountryRegionCode; Rec."Bill-to Country/Region Code")
                {
                }
                field(billToName2; Rec."Bill-to Name 2")
                {
                }
                field(taskBillingMethod; Rec."Task Billing Method")
                {
                }
                field(reserve; Rec.Reserve)
                {
                }
                field(image; Rec.Image)
                {
                }
                field(shipToPhoneNo; Rec."Ship-to Phone No.")
                {
                }
                field(wipMethod; Rec."WIP Method")
                {
                }
                field(currencyCode; Rec."Currency Code")
                {
                }
                field(billToContactNo; Rec."Bill-to Contact No.")
                {
                }
                field(billToContact; Rec."Bill-to Contact")
                {
                }
                field(totalWIPCostAmount; Rec."Total WIP Cost Amount")
                {
                }
                field(totalWIPCostGLAmount; Rec."Total WIP Cost G/L Amount")
                {
                }
                field(wipEntriesExist; Rec."WIP Entries Exist")
                {
                }
                field(wipPostingDate; Rec."WIP Posting Date")
                {
                }
                field(wipGLPostingDate; Rec."WIP G/L Posting Date")
                {
                }
                field(invoiceCurrencyCode; Rec."Invoice Currency Code")
                {
                }
                field(exchCalculationCost; Rec."Exch. Calculation (Cost)")
                {
                }
                field(exchCalculationPrice; Rec."Exch. Calculation (Price)")
                {
                }
                field(allowScheduleContractLines; Rec."Allow Schedule/Contract Lines")
                {
                }
                field(complete; Rec.Complete)
                {
                }
                field(recogSalesAmount; Rec."Recog. Sales Amount")
                {
                }
                field(recogSalesGLAmount; Rec."Recog. Sales G/L Amount")
                {
                }
                field(recogCostsAmount; Rec."Recog. Costs Amount")
                {
                }
                field(recogCostsGLAmount; Rec."Recog. Costs G/L Amount")
                {
                }
                field(totalWIPSalesAmount; Rec."Total WIP Sales Amount")
                {
                }
                field(totalWIPSalesGLAmount; Rec."Total WIP Sales G/L Amount")
                {
                }
                field(wipCompletionCalculated; Rec."WIP Completion Calculated")
                {
                }
                field(nextInvoiceDate; Rec."Next Invoice Date")
                {
                }
                field(applyUsageLink; Rec."Apply Usage Link")
                {
                }
                field(wipWarnings; Rec."WIP Warnings")
                {
                }
                field(wipPostingMethod; Rec."WIP Posting Method")
                {
                }
                field(appliedCostsGLAmount; Rec."Applied Costs G/L Amount")
                {
                }
                field(appliedSalesGLAmount; Rec."Applied Sales G/L Amount")
                {
                }
                field(calcRecogSalesAmount; Rec."Calc. Recog. Sales Amount")
                {
                }
                field(calcRecogCostsAmount; Rec."Calc. Recog. Costs Amount")
                {
                }
                field(calcRecogSalesGLAmount; Rec."Calc. Recog. Sales G/L Amount")
                {
                }
                field(calcRecogCostsGLAmount; Rec."Calc. Recog. Costs G/L Amount")
                {
                }
                field(wipCompletionPosted; Rec."WIP Completion Posted")
                {
                }
                field(overBudget; Rec."Over Budget")
                {
                }
                field(projectManager; Rec."Project Manager")
                {
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                }
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                }
                field(sellToCustomerName2; Rec."Sell-to Customer Name 2")
                {
                }
                field(sellToAddress; Rec."Sell-to Address")
                {
                }
                field(sellToAddress2; Rec."Sell-to Address 2")
                {
                }
                field(sellToCity; Rec."Sell-to City")
                {
                }
                field(sellToContact; Rec."Sell-to Contact")
                {
                }
                field(sellToPostCode; Rec."Sell-to Post Code")
                {
                }
                field(sellToCounty; Rec."Sell-to County")
                {
                }
                field(sellToCountryRegionCode; Rec."Sell-to Country/Region Code")
                {
                }
                field(sellToPhoneNo; Rec."Sell-to Phone No.")
                {
                }
                field(sellToEMail; Rec."Sell-to E-Mail")
                {
                }
                field(sellToContactNo; Rec."Sell-to Contact No.")
                {
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                }
                field(shipToName; Rec."Ship-to Name")
                {
                }
                field(shipToName2; Rec."Ship-to Name 2")
                {
                }
                field(shipToAddress; Rec."Ship-to Address")
                {
                }
                field(shipToAddress2; Rec."Ship-to Address 2")
                {
                }
                field(shipToCity; Rec."Ship-to City")
                {
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                }
                field(shipToCounty; Rec."Ship-to County")
                {
                }
                field(shipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                }
                field(noOfArchivedVersions; Rec."No. of Archived Versions")
                {
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                }
                field(yourReference; Rec."Your Reference")
                {
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                }
                field(costCalculationMethod; Rec."Cost Calculation Method")
                {
                }
                field(completelyPicked; Rec."Completely Picked")
                {
                }
                field(colOriginalContractualDate; Rec."COL Original Contractual Date")
                {
                }
                field(colEndUserType; Rec."COL End User Type")
                {
                }
                field(colExistingEndUserNo; Rec."COL Existing End User No.")
                {
                }
                field(colEndUserName; Rec."COL End User Name")
                {
                }
                field(colEndUserName2; Rec."COL End User Name 2")
                {
                }
                field(colEndUserAddress; Rec."COL End User Address")
                {
                }
                field(colEndUserAddress2; Rec."COL End User Address 2")
                {
                }
                field(colEndUserCity; Rec."COL End User City")
                {
                }
                field(colEndUserPostCode; Rec."COL End User Post Code")
                {
                }
                field(colEndUserCounty; Rec."COL End User County")
                {
                }
                field(colEndUserCountryRegion; Rec."COL End User Country/Region")
                {
                }
                field(colEndUserEMail; Rec."COL End User E-Mail")
                {
                }
                field(colChangeReason; Rec."COL Change Reason")
                {
                }
                field(resourceTaskPostingPGS; Rec."Resource Task Posting PGS")
                {
                }
                field(resourceInvoiceTypePGS; Rec."Resource Invoice Type PGS")
                {
                }
                field(totalPaymentValuePGS; Rec."Total Payment Value PGS")
                {
                }
                field(internalProjectPGS; Rec."Internal Project PGS")
                {
                }
                field(estimatedDeliveryDatePGS; Rec."Estimated Delivery Date PGS")
                {
                }
                field(itemInvoiceTypePGS; Rec."Item Invoice Type PGS")
                {
                }
                field(expenseInvoiceTypePGS; Rec."Expense Invoice Type PGS")
                {
                }
                field(stdMillageToCustomerPGS; Rec."Std. Millage to Customer PGS")
                {
                }
                field(pipelinePGS; Rec."Pipeline PGS")
                {
                }
                field(pipelineDescriptionPGS; Rec."Pipeline Description PGS")
                {
                }
                field(projectBudgetedCostPGS; Rec."Project Budgeted Cost PGS")
                {
                }
                field(projectBudgetedPricePGS; Rec."Project Budgeted Price PGS")
                {
                }
                field(projectUsageCostPGS; Rec."Project Usage (Cost) PGS")
                {
                }
                field(projectUsagePricePGS; Rec."Project Usage (Price) PGS")
                {
                }
                field(projectInvoicedPricePGS; Rec."Project Invoiced Price PGS")
                {
                }
                field(ressGrpBudgetQuantityPGS; Rec."Ress.Grp.Budget Quantity PGS")
                {
                }
                field(ressBudgetQuantityPGS; Rec."Ress.Budget Quantity PGS")
                {
                }
                field(overallCompletionPGS; Rec."Overall Completion % PGS")
                {
                }
                field(salespersonCodePGS; Rec."Salesperson Code PGS")
                {
                }
                field(projectManagerxPGS; Rec."Project Managerx PGS")
                {
                }
                field(wipAmountPGS; Rec."WIP Amount PGS")
                {
                }
                field(recognitionAmountPGS; Rec."Recognition Amount PGS")
                {
                }
                field(customerProspectPGS; Rec."Customer/Prospect PGS")
                {
                }
                field(customerSplitPercentPGS; Rec."Customer Split Percent PGS")
                {
                }
                field(useCustomerSplitPGS; Rec."Use Customer Split PGS")
                {
                }
                field(mainProjectNoPGS; Rec."Main Project No. PGS")
                {
                }
                field(mainProjectTaskCodePGS; Rec."Main Project Task Code PGS")
                {
                }
                field(projectBudgetedQtyPGS; Rec."Project Budgeted Qty. PGS")
                {
                }
                field(projectUsageQtyPGS; Rec."Project Usage (Qty.) PGS")
                {
                }
                field(activeBudgVersCreatedPGS; Rec."Active Budg Vers Created PGS")
                {
                }
                field(externalProjectNoPGS; Rec."External Project No. PGS")
                {
                }
                field(estimatedCompletionPGS; Rec."Estimated Completion % PGS")
                {
                }
                field(calcCapitalizationPGS; Rec."Calc. Capitalization PGS")
                {
                }
                field(calcRecognitionPGS; Rec."Calc. Recognition PGS")
                {
                }
                field(estWIPAmtPGS; Rec."Est. WIP Amt. PGS")
                {
                }
                field(estProjectUsagePostingPGS; Rec."Est. Project Usage Posting PGS")
                {
                }
                field(activeBudgetVersionPGS; Rec."Active Budget Version PGS")
                {
                }
                field(privateProjectPGS; Rec."Private Project PGS")
                {
                }
                field(connectedToProjectPGS; Rec."Connected to Project PGS")
                {
                }
                field(connectToProjBudgExpPGS; Rec."Connect to Proj Budg. Exp. PGS")
                {
                }
                field(connectToProjBudgPricePGS; Rec."Connect to Proj Budg Price PGS")
                {
                }
                field(connectToProjUsageExpPGS; Rec."Connect to Proj Usage(Exp) PGS")
                {
                }
                field(conToProjUsagePricePGS; Rec."Con. to Proj. Usage(Price) PGS")
                {
                }
                field(conToProjInvPricePGS; Rec."Con. to Proj. Inv. Price PGS")
                {
                }
                field(budgetVerWIPPGS; Rec."Budget Ver. WIP PGS")
                {
                }
                field(useContractAmountPGS; Rec."Use contract amount PGS")
                {
                }
                field(wipCheckedPGS; Rec."WIP Checked PGS")
                {
                }
                field(wipCheckedByPGS; Rec."WIP Checked by PGS")
                {
                }
                field(wipCheckedDatePGS; Rec."WIP Checked date PGS")
                {
                }
                field(customerProjectPGS; Rec."Customer Project PGS")
                {
                }
                field(soldHoursPGS; Rec."Sold hours PGS")
                {
                }
                field(soldUnitPriceLCYPGS; Rec."Sold unit price (LCY) PGS")
                {
                }
                field(soldHourAmountLCYPGS; Rec."Sold hour amount (LCY) PGS")
                {
                }
                field(remainingQtyPGS; Rec."Remaining Qty. PGS")
                {
                }
                field(projectTypePGS; Rec."Project Type PGS")
                {
                }
                field(newUnitPriceLCYPGS; Rec."New Unit Price (LCY) PGS")
                {
                }
                field(hoursUpdatedPGS; Rec."Hours updated PGS")
                {
                }
                field(hoursUpdatedByPGS; Rec."Hours updated by PGS")
                {
                }
                field(resourceDiscountPGS; Rec."Resource Discount % PGS")
                {
                }
                field(itemDiscountPGS; Rec."Item Discount % PGS")
                {
                }
                field(expenseDiscountPGS; Rec."Expense Discount % PGS")
                {
                }
                field(hourBudgetPGS; Rec."Hour Budget PGS")
                {
                }
                field(applicationMethodPGS; Rec."Application Method PGS")
                {
                }
                field(completionDatePGS; Rec."Completion Date PGS")
                {
                }
                field(projectUsagePostingPGS; Rec."Project Usage Posting PGS")
                {
                }
                field(adjustedPayInvPGS; Rec."Adjusted Pay. Inv. PGS")
                {
                }
                field(resourceGroupDiscountPGS; Rec."Resource Group Discount % PGS")
                {
                }
                field(quoteBudgetVersionPGS; Rec."Quote Budget Version PGS")
                {
                }
                field(budgVersionToBreakdownPGS; Rec."Budg. Version To Breakdown PGS")
                {
                }
                field(anchorBudgetVersionPGS; Rec."Anchor Budget Version PGS")
                {
                }
                field(resUsePostedCurrencyPGS; Rec."Res. use posted currency PGS")
                {
                }
                field(expUsePostedCurrencyPGS; Rec."Exp. use posted currency PGS")
                {
                }
                field(itemUsePostedCurrencyPGS; Rec."Item use posted currency PGS")
                {
                }
                field(useAdvanceWIPPGS; Rec."Use Advance WIP PGS")
                {
                }
                field(wipMethodUsagePGS; Rec."WIP Method Usage PGS")
                {
                }
                field(wipCostSalePriceItemPGS; Rec."WIP Cost/Sale price Item PGS")
                {
                }
                field(wipUsageBudgetItemPGS; Rec."WIP Usage/ Budget Item PGS")
                {
                }
                field(wipCostSalePriceResPGS; Rec."WIP Cost/Sale price Res. PGS")
                {
                }
                field(wipUsageBudgetResPGS; Rec."WIP Usage/ Budget Res. PGS")
                {
                }
                field(wipCostSalePriceExpPGS; Rec."WIP Cost/Sale price Exp. PGS")
                {
                }
                field(wipUsageBudgetExpPGS; Rec."WIP Usage/ Budget Exp. PGS")
                {
                }
                field(itemEstimatedCompletionPGS; Rec."Item Estimated Completion% PGS")
                {
                }
                field(resEstimatedCompletionPGS; Rec."Res. Estimated Completion% PGS")
                {
                }
                field(expEstimatedCompletionPGS; Rec."Exp. Estimated Completion% PGS")
                {
                }
                field(filterEntryTypePGS; Rec."Filter Entry type PGS")
                {
                }
                field(excludeResWIPPGS; Rec."Exclude Res. WIP PGS")
                {
                }
                field(excludeItemWIPPGS; Rec."Exclude Item WIP PGS")
                {
                }
                field(excludeExpWIPPGS; Rec."Exclude Exp. WIP PGS")
                {
                }
                field(wipAmountBudgetPGS; Rec."WIP Amount Budget PGS")
                {
                }
                field(recognitionAmountBudgetPGS; Rec."Recognition Amount Budget PGS")
                {
                }
                field(postedCapitalizationPGS; Rec."Posted Capitalization PGS")
                {
                }
                field(postedRecognitionPGS; Rec."Posted Recognition PGS")
                {
                }
                field(budgetCostAmountPGS; Rec."Budget Cost Amount PGS")
                {
                }
                field(timesheetCurrencyCodePGS; Rec."Timesheet Currency Code PGS")
                {
                }
                field(toInvoicePriceLCYPGS; Rec."To Invoice (Price LCY) PGS")
                {
                }
                field(toInvoiceCostLCYPGS; Rec."To Invoice (Cost LCY) PGS")
                {
                }
                field(approvedPGS; Rec."Approved PGS")
                {
                }
                field(approvedByPGS; Rec."Approved By PGS")
                {
                }
                field(approvedDatePGS; Rec."Approved Date PGS")
                {
                }
                field(approvedAmountPGS; Rec."Approved Amount PGS")
                {
                }
                field(notApprovedAmountPGS; Rec."Not Approved Amount PGS")
                {
                }
                field(budgetAlertAmountPGS; Rec."Budget Alert Amount PGS")
                {
                }
                field(projectTaskAlertAmountPGS; Rec."Project Task Alert Amount PGS")
                {
                }
                field(etcBudgetPGS; Rec."ETC Budget PGS")
                {
                }
                field(eacBudgetPGS; Rec."EAC Budget PGS")
                {
                }
                field(costTypePGS; Rec."Cost Type PGS")
                {
                }
                field(limitTimeEntryProjListPGS; Rec."Limit TimeEntry Proj. List PGS")
                {
                }
                field(limitTimeEntryTaskListPGS; Rec."Limit Time Entry Task List PGS")
                {
                }
                field(projectsFilterationPGS; Rec."Projects Filteration PGS")
                {
                }
                field(allowResGrpChangePGS; Rec."Allow Res. Grp Change PGS")
                {
                }
                field(etcRiskFactorTMPGS; Rec."ETC Risk Factor % (TM) PGS")
                {
                }
                field(capitalizeNonChargeablePGS; Rec."Capitalize Non Chargeable PGS")
                {
                }
                field(addProjectPermissionsPGS; Rec."Add Project Permissions PGS")
                {
                }
                field(billingCyclePGS; Rec."Billing Cycle PGS")
                {
                }
                field(lastInvoicedDatePGS; Rec."Last Invoiced Date PGS")
                {
                }
                field(emailAlertsPGS; Rec."Email Alerts PGS")
                {
                }
                field(alertOptionPGS; Rec."Alert Option PGS")
                {
                }
                field(budgetUsageUpdatedPGS; Rec."Budget Usage Updated PGS")
                {
                }
                field(percComplResPGS; Rec."Perc Compl Res PGS")
                {
                }
                field(percComplItemPGS; Rec."Perc Compl Item PGS")
                {
                }
                field(percComplExpPGS; Rec."Perc Compl Exp PGS")
                {
                }
                field(percComplOverPGS; Rec."PercCompl Over PGS")
                {
                }
                field(percComplBasedOnPGS; Rec."PercCompl Based On PGS")
                {
                }
                field(percComplBillingLevelPGS; Rec."PercCompl Billing Level PGS")
                {
                }
                field(percComplBillingTaskPGS; Rec."PercCompl Billing Task PGS")
                {
                }
                field(contractAmountPGS; Rec."Contract Amount PGS")
                {
                }
                field(paymentValuePGS; Rec."Payment Value PGS")
                {
                }
                field(resourceValuePGS; Rec."Resource Value PGS")
                {
                }
                field(itemValuePGS; Rec."Item Value PGS")
                {
                }
                field(expenseValuePGS; Rec."Expense Value PGS")
                {
                }
                field(totalValuePGS; Rec."Total Value PGS")
                {
                }
                field(contractInvoicingAccountPGS; Rec."Contract Invoicing Account PGS")
                {
                }
                field(retentionPGS; Rec."Retention % PGS")
                {
                }
                field(invChargeableZeroPricePGS; Rec."Inv. Chargeable Zero Price PGS")
                {
                }
                field(usePercCompPGS; Rec."Use Perc Comp PGS")
                {
                }
                field(opportunityNoPGS; Rec."Opportunity No. PGS")
                {
                }
                field(inclNonChargSalTotalPGS; Rec."Incl. Non-Charg. Sal total PGS")
                {
                }
                field(budgetsRequireApprovalPGS; Rec."Budgets require approval PGS")
                {
                }
                field(level1ApproverPGS; Rec."Level 1 Approver PGS")
                {
                }
                field(level2ApproverPGS; Rec."Level 2 Approver PGS")
                {
                }
                field(level3ApproverPGS; Rec."Level 3 Approver PGS")
                {
                }
                field(externalTimeSystemPGS; Rec."External Time System PGS")
                {
                }
                field(integrationProjectNamePGS; Rec."Integration Project Name PGS")
                {
                }
                field(integrationProjectPKPGS; Rec."Integration Project PK PGS")
                {
                }
                field(allocationMethodPGS; Rec."Allocation Method PGS")
                {
                }
                field(allocationRatePGS; Rec."Allocation Rate PGS")
                {
                }
                field(revenueRecognitionMethodPGS; Rec."Revenue Recognition Method PGS")
                {
                }
                field(fpRevenueRecogMethodPGS; Rec."FP Revenue Recog. Method PGS")
                {
                }
                field(wipCalculationBasedOnPGS; Rec."WIP Calculation Based On PGS")
                {
                }
                field(invoiceSetupExist2PGS; Rec."Invoice Setup Exist 2 PGS")
                {
                }
                field(planningIntegrationPGS; Rec."Planning Integration PGS")
                {
                }
                field(purchaseReceiptPostingPGS; Rec."Purchase Receipt Posting PGS")
                {
                }
                field(projectManagerNamePGS; Rec."Project Manager Name PGS")
                {
                }
                field(personResponsibleNamePGS; Rec."Person Responsible Name PGS")
                {
                }
                field(salOrdInvoicedPGS; Rec."Sal Ord Invoiced PGS")
                {
                }
                field(salOrdUsagePGS; Rec."Sal Ord Usage PGS")
                {
                }
                field(salInvUsagePGS; Rec."Sal Inv Usage PGS")
                {
                }
                field(addressPGS; Rec."Address PGS")
                {
                }
                field(address2PGS; Rec."Address 2 PGS")
                {
                }
                field(cityPGS; Rec."City PGS")
                {
                }
                field(statePGS; Rec."State PGS")
                {
                }
                field(postCodePGS; Rec."Post Code PGS")
                {
                }
                field(countryRegionCodePGS; Rec."Country/Region Code PGS")
                {
                }
                field(progressBillingIDPGS; Rec."Progress Billing ID PGS")
                {
                }
                field(resourceUsageCostPGS; Rec."Resource Usage Cost PGS")
                {
                }
                field(itemUsageCostPGS; Rec."Item Usage Cost PGS")
                {
                }
                field(expenseUsageCostPGS; Rec."Expense Usage Cost PGS")
                {
                }
                field(resourceUsageQtyPGS; Rec."Resource Usage Qty. PGS")
                {
                }
                field(itemUsageQtyPGS; Rec."Item Usage Qty PGS")
                {
                }
                field(expenseUsageQtyPGS; Rec."Expense Usage Qty PGS")
                {
                }
                field(resBudgetCostPGS; Rec."Res. Budget Cost PGS")
                {
                }
                field(itemBudgetCostPGS; Rec."Item Budget Cost PGS")
                {
                }
                field(expenseBudgetCostPGS; Rec."Expense Budget Cost PGS")
                {
                }
                field(itemBudgetQuantityPGS; Rec."Item Budget Quantity PGS")
                {
                }
                field(expenseBudgetQuantityPGS; Rec."Expense Budget Quantity PGS")
                {
                }
                field(fpFullContractValuePGS; Rec."FP Full Contract Value PGS")
                {
                }
                field(editPermissionPGS; Rec."Edit Permission PGS")
                {
                }
                field(netRemainingAmountPGS; Rec."Net Remaining Amount PGS")
                {
                }
                field(netRemainingAmountLCYPGS; Rec."Net Remaining Amount (LCY) PGS")
                {
                }
                field(fpExcludeResourcesPGS; Rec."FP Exclude Resources PGS")
                {
                }
                field(fpExcludeItemsPGS; Rec."FP Exclude Items PGS")
                {
                }
                field(fpExcludeExpensesPGS; Rec."FP Exclude Expenses PGS")
                {
                }
                field(wipSplitKeyPGS; Rec."Wip Split Key PGS")
                {
                }
                field(wipSplitTypePGS; Rec."Wip Split Type PGS")
                {
                }
                field(invResSpecPGS; Rec."Inv. Res. Spec. PGS")
                {
                }
                field(jobCategoryCodePGS; Rec."Job Category Code PGS")
                {
                }
                field(approvalStatusPGS; Rec."Approval Status PGS")
                {
                }
                field(showAsTreePGS; Rec."Show as Tree PGS")
                {
                }
                field(totalApprovedValuePGS; Rec."Total Approved Value PGS")
                {
                }
                field(ceOpportuntiyIDPGS; Rec."CE Opportuntiy ID PGS")
                {
                }
                field(postOverUnderBillingPGS; Rec."Post Over/Under Billing PGS")
                {
                }
                field(overUnderBillingTaskPGS; Rec."Over/Under Billing Task PGS")
                {
                }
                field(wipFixedInvoicedToDatePGS; Rec."WIP Fixed Invoiced to Date PGS")
                {
                }
                field(estOverUnderbilledPGS; Rec."Est. Over/Underbilled PGS")
                {
                }
                field(wipCategoryEUPEU; Rec."WIP Category EUPEU")
                {
                }
                field(colFogBugzJiraNo; Rec."COL FogBugz/Jira No.")
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(systemId; Rec.SystemId)
                {
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                }
            }
        }
    }
}
