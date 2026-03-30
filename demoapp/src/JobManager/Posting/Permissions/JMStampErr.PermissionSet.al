namespace Weibel.JobManager;

permissionset 70221 "COL JM StampErr"
{
    Assignable = true;
    Caption = 'Stamp Posting Errors';
    Permissions =
        tabledata "COL JM Stamp Error Buf" = RIMD,
        table "COL JM Stamp Error Buf" = X,
        page "COL JM Stamp Error Log List" = X;
}
