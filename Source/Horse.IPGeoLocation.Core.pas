unit Horse.IPGeoLocation.Core;

interface

uses
  REST.JSon.Types, Horse.Request, Horse.IPGeoLocation.Types,

  //IPGeoLocation
  IPGeoLocation.Interfaces, IPGeoLocation.Types;

type

  {$REGION 'THorseIPGeolocation'}
  THorseIPGeolocation = class
  private
    { private declarations }
    FIP: string;
    FProvider: TIPGeoLocationProvider;
    FToken: string;
    FTimeOut: Integer;
    FLanguageCode: string;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pIP: string;
                       const pProvider: TIPGeoLocationProvider;
                       const pToken: string;
                       const pTimeOut: Integer;
                       const pLanguageCode: string);
    function GetGeoLocation: THorseGeoLocation;
  end;
  {$ENDREGION}

function ClientIP(const Req: THorseRequest): string;

implementation

uses
  System.SysUtils, System.Generics.Collections,

  IPGeoLocation;

{$REGION 'THorseIPGeolocation'}
constructor THorseIPGeolocation.Create(const pIP: string;
  const pProvider: TIPGeoLocationProvider;
  const pToken: string;
  const pTimeOut: Integer;
  const pLanguageCode: string);
begin
  FIP := pIP;
  FProvider := pProvider;
  FToken := pToken;
  FTimeOut := pTimeOut;
  FLanguageCode := pLanguageCode;
end;

function THorseIPGeolocation.GetGeoLocation: THorseGeoLocation;
var
  lGeoLocation: IPGeoLocation.Interfaces.IGeoLocation;
begin
  try
    lGeoLocation := TIPGeoLocation.New
      .IP[FIP]
      .Provider[FProvider.AsIPGeolocation]
        .SetTimeout(FTimeOut)
        .SetAPIKey(FToken)
      .Request
        .SetResultLanguageCode(FLanguageCode)
        .Execute;

    Result := THorseGeoLocation.Create(True, lGeoLocation);
  except
    on E: EIPGeoLocationRequestException do
    begin
      Result := THorseGeoLocation.Create(False, E);
    end;
  end;
end;
{$ENDREGION}

{$REGION 'ClientIP'}
function ClientIP(const Req: THorseRequest): string;
var
  LIP: string;
begin
  Result := EmptyStr;

  if not Trim(Req.Headers['HTTP_CLIENT_IP']).IsEmpty then
    Exit(Trim(Req.Headers['HTTP_CLIENT_IP']));

  for LIP in Trim(Req.Headers['HTTP_X_FORWARDED_FOR']).Split([',']) do
    if not Trim(LIP).IsEmpty then
      Exit(Trim(LIP));

  for LIP in Trim(Req.Headers['x-forwarded-for']).Split([',']) do
    if not Trim(LIP).IsEmpty then
      Exit(Trim(LIP));

  if not Trim(Req.Headers['HTTP_X_FORWARDED']).IsEmpty then
    Exit(Trim(Req.Headers['HTTP_X_FORWARDED']));

  if not Trim(Req.Headers['HTTP_X_CLUSTER_CLIENT_IP']).IsEmpty then
    Exit(Trim(Req.Headers['HTTP_X_CLUSTER_CLIENT_IP']));

  if not Trim(Req.Headers['HTTP_FORWARDED_FOR']).IsEmpty then
    Exit(Trim(Req.Headers['HTTP_FORWARDED_FOR']));

  if not Trim(Req.Headers['HTTP_FORWARDED']).IsEmpty then
    Exit(Trim(Req.Headers['HTTP_FORWARDED']));

  if not Trim(Req.Headers['REMOTE_ADDR']).IsEmpty then
    Exit(Trim(Req.Headers['REMOTE_ADDR']));

  if not Trim(Req.RawWebRequest.RemoteIP ).IsEmpty then
    Exit(Trim(Req.RawWebRequest.RemoteIP));

  if not Trim(Req.RawWebRequest.RemoteAddr).IsEmpty then
    Exit(Trim(Req.RawWebRequest.RemoteAddr));

  if not Trim(Req.RawWebRequest.RemoteHost).IsEmpty then
    Exit(Trim(Req.RawWebRequest.RemoteHost));
end;
{$ENDREGION}

end.
