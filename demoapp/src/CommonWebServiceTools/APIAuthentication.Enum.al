/// <summary>
/// enum to select web service authentication method
/// </summary>

namespace Weibel.Common.WebService;

enum 70220 "COL API Authentication"
{
    Extensible = true;

    value(0; Basic)
    {
        Caption = 'Basic';
    }
    value(1; OAuth)
    {
        Caption = 'OAuth';
    }
    value(2; AuthorizationCode)
    {
        Caption = 'AuthorizationCode';
    }
    value(3; None)
    {
        Caption = 'None';
    }
    value(4; ApiKey)
    {
        Caption = 'ApiKey';
    }
}
