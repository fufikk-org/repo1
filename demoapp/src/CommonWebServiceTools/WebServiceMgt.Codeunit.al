/// <summary>
/// codeunit to manage a calls to web service
/// </summary>
namespace Weibel.Common.WebService;
using System.Text;
using System.Security.Authentication;
using System.Reflection;

codeunit 70221 "COL Web Service Mgt"
{
    var
        DummyRequestHeaders: Dictionary of [Text, Text];

    procedure CallWebService(RequestText: Text; WebURL: Text; HttpMethods: Enum "COL HTTP Methods"; APIUser: Text; APIPassword: Text; ContentType: Text; COLAPIAuthentication: Enum "COL API Authentication"): Text;
    begin
        exit(CallWebService(RequestText, WebURL, HttpMethods, APIUser, APIPassword, ContentType, COLAPIAuthentication, 0, false, false, DummyRequestHeaders));
    end;

    procedure CallWebService(RequestText: Text; WebURL: Text; HttpMethods: Enum "COL HTTP Methods"; APIUser: Text; APIPassword: Text; ContentType: Text; COLAPIAuthentication: Enum "COL API Authentication"; var RequestHeaders: Dictionary of [Text, Text]): Text;
    begin
        exit(CallWebService(RequestText, WebURL, HttpMethods, APIUser, APIPassword, ContentType, COLAPIAuthentication, 0, false, false, RequestHeaders));
    end;

    procedure CallWebService(RequestText: Text; WebURL: Text; HttpMethods: Enum "COL HTTP Methods"; APIUser: Text; APIPassword: Text; ContentType: Text; COLAPIAuthentication: Enum "COL API Authentication"; TimeOut: Integer): Text;
    begin
        exit(CallWebService(RequestText, WebURL, HttpMethods, APIUser, APIPassword, ContentType, COLAPIAuthentication, TimeOut, false, false, DummyRequestHeaders));
    end;

    procedure CallWebService(RequestText: Text; WebURL: Text; HttpMethods: Enum "COL HTTP Methods"; APIUser: Text; APIPassword: Text; ContentType: Text; COLAPIAuthentication: Enum "COL API Authentication"; SnapshotIsolation: Boolean): Text;
    begin
        exit(CallWebService(RequestText, WebURL, HttpMethods, APIUser, APIPassword, ContentType, COLAPIAuthentication, 0, SnapshotIsolation, false, DummyRequestHeaders));
    end;

    procedure CallWebService(RequestText: Text; WebURL: Text; HttpMethods: Enum "COL HTTP Methods"; APIUser: Text; APIPassword: Text; ContentType: Text; COLAPIAuthentication: Enum "COL API Authentication"; SnapshotIsolation: Boolean; ReadUncommittedIsolation: Boolean): Text;
    begin
        exit(CallWebService(RequestText, WebURL, HttpMethods, APIUser, APIPassword, ContentType, COLAPIAuthentication, 0, SnapshotIsolation, ReadUncommittedIsolation, DummyRequestHeaders));
    end;

    /// <summary>
    /// call to webservices 
    /// </summary>
    /// <param name="RequestText">Text.</param>
    /// <param name="WebURL">Text.</param>
    /// <param name="HttpMethods">Enum "COL HTTP Methods".</param>
    /// <param name="APIUser">Text.</param>
    /// <param name="APIPassword">Text.</param>
    /// <param name="ContentType">Text.</param>
    /// <param name="COLAPIAuthentication">Enum "COL API Authentication".</param>
    /// <param name="TimeOut"></param>
    /// <param name="SnapshotIsolation">Defines if isolation header should be added to a request: https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/webservices/use-odata-batch</param>
    /// <returns>Return value of type Text.</returns>
    local procedure CallWebService(RequestText: Text; WebURL: Text; HttpMethods: Enum "COL HTTP Methods"; APIUser: Text; APIPassword: Text; ContentType: Text; COLAPIAuthentication: Enum "COL API Authentication"; TimeOut: Integer; SnapshotIsolation: Boolean; ReadUncommittedIsolation: Boolean; var RequestHeaders: Dictionary of [Text, Text]): Text;
    var
        HttpClientVar: HttpClient;
        HttpResponse: HttpResponseMessage;
        HttpContentVar: HttpContent;
        HttpHeadersVar: HttpHeaders;
        HttpRequestVar: HttpRequestMessage;
        JsonText: Text;
        RetError: Text;
        RequestHeaderKey: Text;
        JObjectResp: JsonObject;
        JToken: JsonToken;
        JToken2: JsonToken;
        SnapshotErr: Label 'Snapshot isolation can only be used with POST requests.';
        ReadUncommittedErr: Label 'ReadUncommitted isolation can only be used with POST requests.';
        SnapshotAndReadUncommittedErr: Label 'Snapshot and ReadUncommitted isolation cannot be set at the same time.';
    begin
        case COLAPIAuthentication of
            COLAPIAuthentication::Basic:
                AddHttpBasicAuthHeader(APIUser, APIPassword, HttpClientVar);
            COLAPIAuthentication::OAuth:
                AddHttpOAuthAuthHeader(APIPassword, HttpClientVar);
            COLAPIAuthentication::AuthorizationCode:
                AddHttpAuthCodeAuthHeader(APIPassword, HttpClientVar);
            COLAPIAuthentication::ApiKey:
                AddHttpApiKeyAuthHeader(APIPassword, HttpClientVar);
        end;

        if TimeOut > 0 then
            HttpClientVar.Timeout(TimeOut);

        if SnapshotIsolation and (HttpMethods <> HttpMethods::POST) then
            Error(SnapshotErr);

        if ReadUncommittedIsolation and (HttpMethods <> HttpMethods::POST) then
            Error(ReadUncommittedErr);

        if SnapshotIsolation and ReadUncommittedIsolation then
            Error(SnapshotAndReadUncommittedErr);

        case HttpMethods of
            HttpMethods::POST:
                begin
                    HttpContentVar.WriteFrom(RequestText);

                    HttpContentVar.GetHeaders(HttpHeadersVar);

                    HttpHeadersVar.Clear();
                    HttpHeadersVar.Add('Content-Type', ContentType);

                    foreach RequestHeaderKey in RequestHeaders.Keys() do
                        HttpHeadersVar.Add(RequestHeaderKey, RequestHeaders.Get(RequestHeaderKey));

                    if SnapshotIsolation then
                        HttpHeadersVar.Add('Isolation', 'snapshot');

                    if ReadUncommittedIsolation then
                        HttpHeadersVar.Add('Isolation', 'ReadUncommitted');

                    if not HttpClientVar.Post(WebURL, HttpContentVar, HttpResponse) then
                        Error(CantConnectToWebServiceErr, WebURL, GetLastErrorText());
                end;
            HttpMethods::GET:
                if not HttpClientVar.Get(WebURL, HttpResponse) then
                    Error(CantConnectToWebServiceErr, WebURL, GetLastErrorText());

            HttpMethods::DELETE:
                if not HttpClientVar.Delete(WebURL, HttpResponse) then
                    Error(CantConnectToWebServiceErr, WebURL, GetLastErrorText());

            HttpMethods::PATCH:
                begin
                    HttpContentVar.WriteFrom(RequestText);
                    HttpContentVar.GetHeaders(HttpHeadersVar);
                    HttpHeadersVar.Clear();
                    HttpHeadersVar.Add('Content-Type', ContentType);
                    HttpRequestVar.Content(HttpContentVar);
                    HttpRequestVar.Method('PATCH');

                    HttpClientVar.SetBaseAddress(WebURL);
                    HttpClientVar.DefaultRequestHeaders.Add('If-Match', '*');

                    if not HttpClientVar.Send(HttpRequestVar, HttpResponse) then
                        Error(CantConnectToWebServiceErr, WebURL, GetLastErrorText());
                end;
        end;

        if not HttpResponse.IsSuccessStatusCode() then
            if HttpResponse.HttpStatusCode() > 0 then begin
                if HttpResponse.Content().ReadAs(RetError) then begin
                    if not JObjectResp.ReadFrom(RetError) then
                        Error('Invalid response: %1, %2, %3', RetError, HttpResponse.ReasonPhrase(), HttpResponse.HttpStatusCode());
                    if JObjectResp.Get('error', JToken) then begin
                        JToken.SelectToken('message', JToken2);
                        RetError := '(' + JToken2.AsValue().AsText() + ') ' + HttpResponse.ReasonPhrase();
                        Error(CallToWsReturnErr, RetError, HttpResponse.HttpStatusCode());
                    end;
                end
                else
                    Error(CallToWsReturnErr, HttpResponse.ReasonPhrase(), HttpResponse.HttpStatusCode());
            end
            else
                Error(CallToWsReturnErr, HttpResponse.ReasonPhrase(), HttpResponse.HttpStatusCode());


        HttpResponse.Content().ReadAs(JsonText);

        exit(JsonText);
    end;

    local procedure AddHttpBasicAuthHeader(UserName: Text; Password: Text; var HttpClient: HttpClient);
    var
        Base64Convert: Codeunit "Base64 Convert";
        AuthString: Text;
    begin
        AuthString := StrSubstNo(UserPassLbl, UserName, Password);
        AuthString := Base64Convert.ToBase64(AuthString);
        AuthString := StrSubstNo(BasicLbl, AuthString);
        HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
    end;

    local procedure AddHttpOAuthAuthHeader(Password: Text; var HttpClient: HttpClient);
    begin
        HttpClient.Timeout(30000); // 30 sec
        HttpClient.DefaultRequestHeaders.Add('Authorization', StrSubstNo(BearerLbl, Password));
    end;

    local procedure AddHttpApiKeyAuthHeader(Password: Text; var HttpClient: HttpClient);
    begin
        HttpClient.Timeout(30000); // 30 sec
        HttpClient.DefaultRequestHeaders.Add('ApiKey', Password);
        HttpClient.DefaultRequestHeaders.Add('Accept', '*/*');
    end;

    procedure GetAccessToken(AADClientID: Text; AADClientSecret: Text; TenantGuid: Text; RequestUrl: Text): SecretText
    var
        OAuth2: Codeunit OAuth2;
        RedirectUrl: Text;
        AccessToken: SecretText;
        Scopes: List of [Text];
        OAuth2UrlTxt: Label 'https://login.microsoftonline.com/%1/oauth2/v2.0/token', Locked = true, Comment = '%1 = tenant id';
        ResourceUrlTxt: Label 'https://api.businesscentral.dynamics.com/.default', Locked = true;
    begin

        Scopes.Add(ResourceUrlTxt);

        OAuth2.GetDefaultRedirectURL(RedirectUrl);
        if not OAuth2.AcquireTokenWithClientCredentials(AADClientID, AADClientSecret,
                StrSubstNo(OAuth2UrlTxt, TenantGuid), RedirectUrl, Scopes, AccessToken) then
            Error(OAuth2.GetLastErrorMessage());
        exit(AccessToken);
    end;

    procedure GetAccessToken(AADClientID: Text; AADClientSecret: Text; TenantGuid: Text): SecretText
    var
        DummyRequestUrl: Text;
    begin
        exit(GetAccessToken(AADClientID, AADClientSecret, TenantGuid, DummyRequestUrl));
    end;

    local procedure AddHttpAuthCodeAuthHeader(Password: Text; var HttpClient: HttpClient);
    begin
        HttpClient.DefaultRequestHeaders().Add('Authorization', Password);
    end;

    local procedure EncodeURLPart(URL: Text) EncodedPart: Text
    var
        TypeHelper: Codeunit "Type Helper";
        UrlPartBuilder: TextBuilder;
        TextToEncode: Text;
        EndPos: Integer;
    begin
        //Append and remove ? from string
        if StrPos(URL, '?') = 1 then begin
            UrlPartBuilder.Append(CopyStr(URL, 1, 1));
            URL := CopyStr(URL, 2, StrLen(URL));
        end;

        //Look for $ and = in the beginning substring and append without encoding
        if (StrPos(URL, '$') = 1) and (StrPos(URL, '=') > 0) then begin
            UrlPartBuilder.Append(CopyStr(URL, 1, StrPos(URL, '=')));
            URL := CopyStr(URL, (StrPos(URL, '=') + 1), StrLen(URL));
        end;

        //Look for parentheses in the substring and Encode string before first parentheses
        if StrPos(URL, '(') > 0 then begin
            //If ) is before (
            if (StrPos(URL, ')') <> 0) and (StrPos(URL, ')') < StrPos(URL, '(')) then
                EndPos := StrPos(URL, ')')
            else
                EndPos := StrPos(URL, '(');

        end else
            //Check if in ()
            if StrPos(URL, ')') > 0 then
                EndPos := StrPos(URL, ')')
            else
                EndPos := 0;

        if EndPos <> 0 then begin
            TextToEncode := CopyStr(URL, 1, EndPos - 1);
            UrlPartBuilder.Append(TypeHelper.UrlEncode(TextToEncode));
            UrlPartBuilder.Append(CopyStr(URL, EndPos, 1));
            URL := CopyStr(URL, EndPos + 1, StrLen(URL));
            if URL <> '' then
                UrlPartBuilder.Append(EncodeURLPart(URL));
        end else begin
            TextToEncode := CopyStr(URL, 1, StrLen(URL));
            UrlPartBuilder.Append(TypeHelper.UrlEncode(TextToEncode));
        end;
        //Exit textbuilder to text.
        EncodedPart := UrlPartBuilder.ToText();
    end;

    var
        BasicLbl: Label 'Basic %1', Locked = true;
        BearerLbl: Label 'Bearer %1', Locked = true, Comment = '%1 = token';
        UserPassLbl: Label '%1:%2', Locked = true;
        CantConnectToWebServiceErr: Label 'Cannot connect to Web Service: %1 (Error: %2)', Comment = '%1 = Web Service Url. %2 - Error Message';
        CallToWsReturnErr: Label 'Error : %1, %2', Comment = '%1 = Error Code, %2 = Error Message';

}
