namespace Weibel.Warehouse.Activity;

// CU To store state during the pick creation process 
codeunit 70225 "COL Create Pic SM"
{
    SingleInstance = true;

    var
        ErrorWasDisplayed: Boolean;


    procedure SetErrorDisplayed(NewErrorWasDisplayed: Boolean)
    begin
        ErrorWasDisplayed := NewErrorWasDisplayed;
    end;

    procedure IsErrorDisplayed(): Boolean
    begin
        exit(ErrorWasDisplayed);
    end;
}
