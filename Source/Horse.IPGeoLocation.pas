unit Horse.IPGeoLocation;

interface

uses
  System.Classes, System.SysUtils, Web.HTTPApp, Horse,
  Horse.IPGeoLocation.Types, Horse.IPGeoLocation.Core;

function IPGeoLocation(const pProvider: TIPGeoLocationProvider;
                       const pAPIKey: string;
                       const pTimeOut: Integer;
                       const pLanguageCode: string): THorseCallback; overload;

function IPGeoLocation(const pProvider: TIPGeoLocationProvider;
                       const pAPIKey: string;
                       const pTimeOut: Integer): THorseCallback; overload;

function IPGeoLocation(const pProvider: TIPGeoLocationProvider;
                       const pAPIKey: string): THorseCallback; overload;

function IPGeoLocation(const pProvider: TIPGeoLocationProvider;
                       const pAPIKey: string;
                       const pIPDebug: string): THorseCallback; overload;

implementation

uses
  Horse.IPGeoLocation.IP;

var
  gProvider: TIPGeoLocationProvider;
  gAPIKey: string;
  gTimeOut: Integer;
  gLanguageCode: string;
  gIP: string;

procedure Middleware(pReq: THorseRequest; pRes: THorseResponse; pNext: TProc);
var
  lHorseIPGeolocation: THorseIPGeolocation;
  lIP: string;
begin
  lIP := gIP;
  if gIP.Trim.IsEmpty then
    lIP := ClientIP(pReq);

  if not IPIsPublic(lIP) then
  begin
    pNext();
    Exit;
  end;

  lHorseIPGeolocation := nil;
  try
    lHorseIPGeolocation := THorseIPGeolocation.Create(
      lIP, gProvider, gAPIKey, gTimeOut, gLanguageCode);

    pReq.Sessions.SetSession(THorseGeoLocation, lHorseIPGeolocation.GetGeoLocation);
  finally
    lHorseIPGeolocation.Free;
    pNext();
  end;
end;

function IPGeoLocation(const pProvider: TIPGeoLocationProvider;
  const pAPIKey: string;
  const pTimeOut: Integer;
  const pLanguageCode: string): THorseCallback;
begin
  gProvider := pProvider;
  gAPIKey := pAPIKey;
  gTimeOut := pTimeOut;
  gLanguageCode := pLanguageCode;

  Result := Middleware;
end;

function IPGeoLocation(const pProvider: TIPGeoLocationProvider;
  const pAPIKey: string;
  const pTimeOut: Integer): THorseCallback;
begin
  Result := IPGeoLocation(pProvider, pAPIKey, pTimeOut, EmptyStr);
end;

function IPGeoLocation(const pProvider: TIPGeoLocationProvider;
  const pAPIKey: string): THorseCallback;
begin
  Result := IPGeoLocation(pProvider, pAPIKey, 5000, EmptyStr);
end;

function IPGeoLocation(const pProvider: TIPGeoLocationProvider;
  const pAPIKey: string; const pIPDebug: string): THorseCallback;
begin
  gIP := pIPDebug;
  Result := IPGeoLocation(pProvider, pAPIKey, 5000, EmptyStr);
end;

end.
