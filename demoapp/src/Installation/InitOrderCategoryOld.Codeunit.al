namespace Weibel.Foundation.OrderCategoryOld;

codeunit 70208 "COL Init Order Category (Old)"
{
    internal procedure InitOrderCategories()
    var
        OrderCategoryOld: Record "COL Order Category (Old)";
        CategoryDict: Dictionary of [Code[20], Text[100]];
        CategoryCode: Code[20];
    begin
        CategoryDict.Add('AFM FIELD SERVICES', 'Field Services');
        CategoryDict.Add('AFM IN-HOUSE REPAIRS', 'RMA');
        CategoryDict.Add('AFM MISSION SUPPORT', 'Mission Support');
        CategoryDict.Add('AFM PRE-OWNED EQUIPM', 'Sale of used equipment');
        CategoryDict.Add('AFM RENTAL', 'Rental / paid demos ');
        CategoryDict.Add('AFM SPARE PARTS', 'Spare Parts Sales');
        CategoryDict.Add('AFM SUPPORT AGREEMEN', 'Annual Maintenance Agreements');
        CategoryDict.Add('AFM SYSTEM UPGRADES', 'Upgrades');
        CategoryDict.Add('AFM TRAINING', 'Training');
        CategoryDict.Add('FCR', 'Fire Control Radar');
        CategoryDict.Add('IP', 'Intern IP ordre');
        CategoryDict.Add('MFSR', 'Medium to Long Range Surveillance Radar');
        CategoryDict.Add('MSL/MFTR', 'Tracking');
        CategoryDict.Add('MSTS', 'Multi Sensor Tracking System');
        CategoryDict.Add('MVR', 'Muzzle Velocity Radars');
        CategoryDict.Add('OD', 'Intern OD ordre');
        CategoryDict.Add('SL', 'Doppler Fixed Head');
        CategoryDict.Add('SRSR (DRONE, SHORAD)', 'Short Range Surveillance Radar');

        foreach CategoryCode in CategoryDict.Keys() do begin
            OrderCategoryOld.Init();
            OrderCategoryOld.Code := CategoryCode;
            OrderCategoryOld.Description := CategoryDict.Get(CategoryCode);
            OrderCategoryOld.Insert();
        end;
    end;
}