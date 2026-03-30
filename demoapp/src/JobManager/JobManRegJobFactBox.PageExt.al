namespace Weibel.JobManager;
using Microsoft.Manufacturing.Document;

pageextension 70257 "COL JobManRegJobFactBox" extends JobManRegJobFactBox
{
    layout
    {
        modify(RefNo)
        {
            trigger OnDrillDown()
            var
                ProductionOrder: Record "Production Order";
                ReleasedProductionOrder: Page "Released Production Order";
            begin
                if Rec.RefType = Rec.RefType::Production then begin
                    ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                    ProductionOrder.SetRange("No.", Rec.RefNo);
                    ProductionOrder.FindFirst();
                    ReleasedProductionOrder.SetTableView(ProductionOrder);
                    ReleasedProductionOrder.Run();
                end;
            end;
        }
    }
}
