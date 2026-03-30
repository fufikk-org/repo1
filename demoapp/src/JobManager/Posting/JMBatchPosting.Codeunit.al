codeunit 70196 "COL JM BatchPosting"
{
    TableNo = JobManStampEvent;
    trigger OnRun()
    var
        JobManNavPost: Codeunit JobManNavPost;
    begin
        JobManNavPost.RunEvent(Rec, false, '');
    end;
}