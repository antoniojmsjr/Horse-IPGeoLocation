unit Horse.IPGeoLocation.Types;

interface

uses
  System.SysUtils, System.Generics.Collections, REST.Json.Types, REST.Json,
  Horse.Session,

  //IPGeoLocation
  IPGeoLocation.Interfaces, IPGeoLocation.Types;

type

  {$REGION 'TIPGeoLocationProvider'}
  {$SCOPEDENUMS ON}
  TIPGeoLocationProvider = (Unknown,
                            IPInfo,
                            IPGeoLocation,
                            IP2Location,
                            IPApi,
                            IPStack,
                            IPIfy,
                            IPGeolocationAPI,
                            IPData,
                            IPWhois,
                            IPDig,
                            IPTwist,
                            IPLabstack,
                            IP_API,
                            DB_IP);
  {$SCOPEDENUMS OFF}
  {$ENDREGION}

  {$REGION 'TIPGeoLocationException'}
  {$SCOPEDENUMS ON}
  TIPGeoLocationException = (EXCEPTION_UNKNOWN,
                             EXCEPTION_OTHERS,
                             EXCEPTION_HTTP,
                             EXCEPTION_PARAMS_NOT_FOUND,
                             EXCEPTION_API,
                             EXCEPTION_JSON_INVALID,
                             EXCEPTION_NO_CONTENT);
  {$SCOPEDENUMS OFF}
  {$ENDREGION}

  {$REGION 'TIPGeoLocationProviderHelper'}
  TIPGeoLocationProviderHelper = record helper for TIPGeoLocationProvider
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function AsString: string;
    function AsInteger: Integer;
    function AsIPGeolocation: TIPGeoLocationProviderKind;
  end;
  {$ENDREGION}

  {$REGION 'TIPGeoLocationException'}
  TIPGeoLocationExceptionHelper = record helper for TIPGeoLocationException
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function AsString: string;
    function AsInteger: Integer;
    function AsIPGeolocation: TIPGeoLocationExceptionKind;
  end;
  {$ENDREGION}

  {$REGION 'THorseGeoLocationStatus'}
  THorseGeoLocationStatus = class
  private
    { private declarations }
    [JsonName('success')]
    FSuccess: Boolean;
    function GetSuccess: Boolean;
    function ToJSON: string;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pSuccess: Boolean);
    property Success: Boolean read GetSuccess;
  end;
  {$ENDREGION}

  {$REGION 'THorseGeoLocationError'}
  THorseGeoLocationError = class(TInterfacedObject)
  private
    { private declarations }
    [JsonName('ip')]
    FIP: string;
    [JsonName('ip_version')]
    FIPVersion: string;
    [JsonName('provider')]
    FProvider: string;
    [JsonName('datetime')]
    FDateTime: TDateTime;
    [JsonName('kind')]
    FKind: TIPGeoLocationException;
    [JsonName('url')]
    FURL: string;
    [JsonName('method')]
    FMethod: string;
    [JsonName('status_code')]
    FStatusCode: Integer;
    [JsonName('status_text')]
    FStatusText: string;
    [JsonName('message')]
    FMessage: string;
    function GetIP: string;
    function GetIPVersion: string;
    function GetProvider: String;
    function GetDateTime: TDateTime;
    function GetKind: TIPGeoLocationException;
    function GetURL: string;
    function GetMethod: string;
    function GetStatusCode: Integer;
    function GetStatusText: string;
    function GetMessage: string;
    function ToJSON: string;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pException: IPGeoLocation.Types.EIPGeoLocationRequestException);
    property IP: string read GetIP;
    property IPVersion: string read GetIPVersion;
    property Provider: string read GetProvider;
    property DateTime: TDateTime read GetDateTime;
    property Kind: TIPGeoLocationException read GetKind;
    property URL: string read GetURL;
    property Method: string read GetMethod;
    property StatusCode: Integer read GetStatusCode;
    property StatusText: string read GetStatusText;
    property Message: string read GetMessage;
  end;
  {$ENDREGION}

  {$REGION 'THorseGeoLocation'}
  THorseGeoLocation = class(TSession)
  private
    { private declarations }
    [JSONMarshalledAttribute(False)]
    FStatus: THorseGeoLocationStatus;
    [JSONMarshalledAttribute(False)]
    FError: THorseGeoLocationError;
    [JsonName('ip')]
    FIP: string;
    [JsonName('ip_version')]
    FIPVersion: string;
    [JsonName('provider')]
    FProvider: string;
    [JsonName('datetime')]
    FDateTime: TDateTime;
    [JsonName('hostname')]
    FHostName: string;
    [JsonName('country_code')]
    FCountryCode: string;
    [JsonName('country_code3')]
    FCountryCode3: string;
    [JsonName('country_name')]
    FCountryName: string;
    [JsonName('country_flag')]
    FCountryFlag: string;
    [JsonName('state')]
    FState: string;
    [JsonName('city')]
    FCity: string;
    [JsonName('district')]
    FDistrict: string;
    [JsonName('zip_code')]
    FZipCode: string;
    [JsonName('latitude')]
    FLatitude: Extended;
    [JsonName('longitude')]
    FLongitude: Extended;
    [JsonName('timezone_name')]
    FTimeZoneName: string;
    [JsonName('timezone_offset')]
    FTimeZoneOffset: string;
    [JsonName('isp')]
    FISP: string;
    function GetStatus: THorseGeoLocationStatus;
    function GetError: THorseGeoLocationError;
    function GetIP: string;
    function GetIPVersion: string;
    function GetProvider: string;
    function GetDateTime: TDateTime;
    function GetHostName: string;
    function GetCountryCode: string;
    function GetCountryCode3: string;
    function GetCountryName: string;
    function GetCountryFlag: string;
    function GetState: string;
    function GetCity: string;
    function GetDistrict: string;
    function GetZipCode: string;
    function GetLatitude: Extended;
    function GetLongitude: Extended;
    function GetTimeZoneName: string;
    function GetTimeZoneOffset: string;
    function GetISP: string;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pSuccess: Boolean;
                       const pGeoLocation: IPGeoLocation.Interfaces.IGeoLocation); overload;
    constructor Create(const pSuccess: Boolean;
                       const pException: IPGeoLocation.Types.EIPGeoLocationRequestException); overload;
    destructor Destroy; override;
    function ToJSON: string;
    property Status: THorseGeoLocationStatus read GetStatus;
    property Error: THorseGeoLocationError read GetError;
    property IP: string read GetIP;
    property IPVersion: string read GetIPVersion;
    property Provider: string read GetProvider;
    property DateTime: TDateTime read GetDateTime;
    property HostName: string read GetHostName;
    property CountryCode: string read GetCountryCode;
    property CountryCode3: string read GetCountryCode3;
    property CountryName: string read GetCountryName;
    property CountryFlag: string read GetCountryFlag;
    property State: string read GetState;
    property City: string read GetCity;
    property District: string read GetDistrict;
    property ZipCode: string read GetZipCode;
    property Latitude: Extended read GetLatitude;
    property Longitude: Extended read GetLongitude;
    property TimeZoneName: string read GetTimeZoneName;
    property TimeZoneOffset: string read GetTimeZoneOffset;
    property ISP: string read GetISP;
  end;
  {$ENDREGION}

function GetExceptionFromIPGeoLocationExceptionKind(const pKind: TIPGeoLocationExceptionKind): TIPGeoLocationException;

implementation

uses
  System.JSON;

function GetExceptionFromIPGeoLocationExceptionKind(const pKind: TIPGeoLocationExceptionKind): TIPGeoLocationException;
begin
  case pKind of
    TIPGeoLocationExceptionKind.EXCEPTION_OTHERS: Result := TIPGeoLocationException.EXCEPTION_OTHERS;
    TIPGeoLocationExceptionKind.EXCEPTION_HTTP: Result := TIPGeoLocationException.EXCEPTION_HTTP;
    TIPGeoLocationExceptionKind.EXCEPTION_PARAMS_NOT_FOUND: Result := TIPGeoLocationException.EXCEPTION_PARAMS_NOT_FOUND;
    TIPGeoLocationExceptionKind.EXCEPTION_API: Result := TIPGeoLocationException.EXCEPTION_API;
    TIPGeoLocationExceptionKind.EXCEPTION_JSON_INVALID: Result := TIPGeoLocationException.EXCEPTION_JSON_INVALID;
    TIPGeoLocationExceptionKind.EXCEPTION_NO_CONTENT: Result := TIPGeoLocationException.EXCEPTION_NO_CONTENT;
  else
    Result := TIPGeoLocationException.EXCEPTION_UNKNOWN;
  end;
end;

{$REGION 'TIPGeoLocationProviderHelper'}
function TIPGeoLocationProviderHelper.AsIPGeolocation: TIPGeoLocationProviderKind;
begin
  case Self of
    TIPGeoLocationProvider.IPInfo: Result := TIPGeoLocationProviderKind.IPInfo;
    TIPGeoLocationProvider.IPGeoLocation: Result := TIPGeoLocationProviderKind.IPGeoLocation;
    TIPGeoLocationProvider.IP2Location: Result := TIPGeoLocationProviderKind.IP2Location;
    TIPGeoLocationProvider.IPApi: Result := TIPGeoLocationProviderKind.IPApi;
    TIPGeoLocationProvider.IPStack: Result := TIPGeoLocationProviderKind.IPStack;
    TIPGeoLocationProvider.IPIfy: Result := TIPGeoLocationProviderKind.IPIfy;
    TIPGeoLocationProvider.IPGeolocationAPI: Result := TIPGeoLocationProviderKind.IPGeolocationAPI;
    TIPGeoLocationProvider.IPData: Result := TIPGeoLocationProviderKind.IPData;
    TIPGeoLocationProvider.IPWhois: Result := TIPGeoLocationProviderKind.IPWhois;
    TIPGeoLocationProvider.IPDig: Result := TIPGeoLocationProviderKind.IPDig;
    TIPGeoLocationProvider.IPTwist: Result := TIPGeoLocationProviderKind.IPTwist;
    TIPGeoLocationProvider.IPLabstack: Result := TIPGeoLocationProviderKind.IPLabstack;
    TIPGeoLocationProvider.IP_API: Result := TIPGeoLocationProviderKind.IP_API;
    TIPGeoLocationProvider.DB_IP: Result := TIPGeoLocationProviderKind.DB_IP;
  else
    Result := TIPGeoLocationProviderKind.Unknown;
  end;
end;

function TIPGeoLocationProviderHelper.AsInteger: Integer;
begin
  Result := AsIPGeolocation.AsInteger;
end;

function TIPGeoLocationProviderHelper.AsString: string;
begin
  Result := AsIPGeolocation.AsString;
end;
{$ENDREGION}

{$REGION 'TIPGeoLocationExceptionHelper'}
function TIPGeoLocationExceptionHelper.AsIPGeolocation: TIPGeoLocationExceptionKind;
begin
  case Self of
    TIPGeoLocationException.EXCEPTION_OTHERS: Result := TIPGeoLocationExceptionKind.EXCEPTION_OTHERS;
    TIPGeoLocationException.EXCEPTION_HTTP: Result := TIPGeoLocationExceptionKind.EXCEPTION_HTTP;
    TIPGeoLocationException.EXCEPTION_PARAMS_NOT_FOUND: Result := TIPGeoLocationExceptionKind.EXCEPTION_PARAMS_NOT_FOUND;
    TIPGeoLocationException.EXCEPTION_API: Result := TIPGeoLocationExceptionKind.EXCEPTION_API;
    TIPGeoLocationException.EXCEPTION_JSON_INVALID: Result := TIPGeoLocationExceptionKind.EXCEPTION_JSON_INVALID;
    TIPGeoLocationException.EXCEPTION_NO_CONTENT: Result := TIPGeoLocationExceptionKind.EXCEPTION_NO_CONTENT;
  else
    Result := TIPGeoLocationExceptionKind.EXCEPTION_UNKNOWN;
  end;
end;

function TIPGeoLocationExceptionHelper.AsInteger: Integer;
begin
  Result := AsIPGeolocation.AsInteger;
end;

function TIPGeoLocationExceptionHelper.AsString: string;
begin
  Result := AsIPGeolocation.AsString;
end;
{$ENDREGION}

{$REGION 'THorseGeoLocationStatus'}
constructor THorseGeoLocationStatus.Create(const pSuccess: Boolean);
begin
  FSuccess := pSuccess;
end;

function THorseGeoLocationStatus.GetSuccess: Boolean;
begin
  Result := FSuccess;
end;

function THorseGeoLocationStatus.ToJSON: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;
{$ENDREGION}

{$REGION 'THorseGeoLocationError'}
constructor THorseGeoLocationError.Create(
  const pException: IPGeoLocation.Types.EIPGeoLocationRequestException);
begin
  FIP := pException.IP;
  FIPVersion := pException.IPVersion;
  FProvider := pException.Provider;
  FDateTime := pException.DateTime;
  FKind := GetExceptionFromIPGeoLocationExceptionKind(pException.Kind);
  FURL := pException.URL;
  FMethod := pException.Method;
  FStatusCode := pException.StatusCode;
  FStatusText := pException.StatusText;
  FMessage := pException.Message;
end;

function THorseGeoLocationError.GetDateTime: TDateTime;
begin
  Result := FDateTime;
end;

function THorseGeoLocationError.GetIP: string;
begin
  Result := FIP;
end;

function THorseGeoLocationError.GetIPVersion: string;
begin
  Result := FIPVersion;
end;

function THorseGeoLocationError.GetKind: TIPGeoLocationException;
begin
  Result := FKind;
end;

function THorseGeoLocationError.GetMessage: string;
begin
  Result := FMessage;
end;

function THorseGeoLocationError.GetMethod: string;
begin
  Result := FMethod;
end;

function THorseGeoLocationError.GetProvider: String;
begin
  Result := FProvider;
end;

function THorseGeoLocationError.GetStatusCode: Integer;
begin
  Result := FStatusCode;
end;

function THorseGeoLocationError.GetStatusText: string;
begin
  Result := FStatusText;
end;

function THorseGeoLocationError.GetURL: string;
begin
  Result := FURL;
end;

function THorseGeoLocationError.ToJSON: string;
begin
  Result := TJson.ObjectToJsonString(Self, [joDateFormatISO8601]);
end;
{$ENDREGION}

{$REGION 'THorseGeoLocation'}
constructor THorseGeoLocation.Create(const pSuccess: Boolean;
  const pGeoLocation: IPGeoLocation.Interfaces.IGeoLocation);
begin
  FStatus := THorseGeoLocationStatus.Create(pSuccess);

  FIP := pGeoLocation.IP;
  FIPVersion := pGeoLocation.IPVersion;
  FProvider := pGeoLocation.Provider;
  FDateTime := pGeoLocation.DateTime;

  FHostName := pGeoLocation.HostName;
  FCountryCode := pGeoLocation.CountryCode;
  FCountryCode3 := pGeoLocation.CountryCode3;
  FCountryName := pGeoLocation.CountryName;
  FCountryFlag := pGeoLocation.CountryFlag;
  FState := pGeoLocation.State;
  FCity := pGeoLocation.City;
  FDistrict := pGeoLocation.District;
  FZipCode := pGeoLocation.ZipCode;
  FLatitude := pGeoLocation.Latitude;
  FLongitude := pGeoLocation.Longitude;
  FTimeZoneName := pGeoLocation.TimeZoneName;
  FTimeZoneOffset := pGeoLocation.TimeZoneOffset;
  FISP := pGeoLocation.ISP;
end;

constructor THorseGeoLocation.Create(const pSuccess: Boolean;
  const pException: IPGeoLocation.Types.EIPGeoLocationRequestException);
begin
  FStatus := THorseGeoLocationStatus.Create(pSuccess);

  FError := THorseGeoLocationError.Create(pException);
end;

destructor THorseGeoLocation.Destroy;
begin
  if Assigned(FStatus) then
    FStatus.Free;
  if Assigned(FError) then
    FError.Free;
  inherited Destroy;
end;

function THorseGeoLocation.GetCity: string;
begin
  Result := FCity;
end;

function THorseGeoLocation.GetCountryCode: string;
begin
  Result := FCountryCode;
end;

function THorseGeoLocation.GetCountryCode3: string;
begin
  Result := FCountryCode3;
end;

function THorseGeoLocation.GetCountryFlag: string;
begin
  Result := FCountryFlag;
end;

function THorseGeoLocation.GetCountryName: string;
begin
  Result := FCountryName;
end;

function THorseGeoLocation.GetDateTime: TDateTime;
begin
  Result := FDateTime;
end;

function THorseGeoLocation.GetDistrict: string;
begin
  Result := FDistrict;
end;

function THorseGeoLocation.GetError: THorseGeoLocationError;
begin
  Result := FError;
end;

function THorseGeoLocation.GetHostName: string;
begin
  Result := FHostName;
end;

function THorseGeoLocation.GetIP: string;
begin
  Result := FIP;
end;

function THorseGeoLocation.GetIPVersion: string;
begin
  Result := FIPVersion;
end;

function THorseGeoLocation.GetISP: string;
begin
  Result := FISP;
end;

function THorseGeoLocation.GetLatitude: Extended;
begin
  Result := FLatitude;
end;

function THorseGeoLocation.GetLongitude: Extended;
begin
  Result := FLongitude;
end;

function THorseGeoLocation.GetProvider: string;
begin
  Result := FProvider;
end;

function THorseGeoLocation.GetState: string;
begin
  Result := FState;
end;

function THorseGeoLocation.GetStatus: THorseGeoLocationStatus;
begin
  Result := FStatus;
end;

function THorseGeoLocation.GetTimeZoneName: string;
begin
  Result := FTimeZoneName;
end;

function THorseGeoLocation.GetTimeZoneOffset: string;
begin
  Result := FTimeZoneOffset;
end;

function THorseGeoLocation.GetZipCode: string;
begin
  Result := FZipCode;
end;

function THorseGeoLocation.ToJSON: string;
var
  lGeoLocationJSON: string;
  lJSONObject: TJSONObject;
begin
  lJSONObject := TJSONObject.Create;
  try
    if Assigned(FStatus) then
      lJSONObject.AddPair(TJSONPair.Create('status', TJSONObject.ParseJSONValue(FStatus.ToJSON)));

    if Assigned(FError) then
      lJSONObject.AddPair(TJSONPair.Create('error', TJSONObject.ParseJSONValue(FError.ToJSON)));

    if not Assigned(FError) then
    begin
      lGeoLocationJSON := TJson.ObjectToJsonString(Self, [joDateFormatISO8601]);
      lJSONObject.AddPair(TJSONPair.Create('geolocation', TJSONObject.ParseJSONValue(lGeoLocationJSON)));
    end;

    Result := lJSONObject.ToString;
  finally
    lJSONObject.Free;
  end;
end;
{$ENDREGION}

end.
