// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 56010 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        AppPublishedMsg: Label 'App published: Hello world again 4';
    begin
        Message(AppPublishedMsg);
    end;
}
