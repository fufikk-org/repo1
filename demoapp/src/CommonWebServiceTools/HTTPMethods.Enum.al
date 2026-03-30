/// <summary>
/// enum to select web service method
/// </summary>
/// 
namespace Weibel.Common.WebService;

enum 70221 "COL HTTP Methods"
{
    Extensible = true;

    value(0; POST)
    {
        Caption = 'POST', Locked = true;
    }
    value(1; GET)
    {
        Caption = 'GET', Locked = true;
    }
    value(2; PUT)
    {
        Caption = 'PUT', Locked = true;
    }
    value(3; DELETE)
    {
        Caption = 'DELETE', Locked = true;
    }
    value(4; PATCH)
    {
        Caption = 'PATCH', Locked = true;
    }
}
