unit Horse.IPGeoLocation.IP;

interface

function IPv4IsValid(const pIP: string): Boolean;
function IPv6IsValid(const pIP: string): Boolean;

function IPIsPublic(const pIP: string): Boolean;

implementation

uses
  System.RegularExpressions, System.SysUtils, synaip, IdNetworkCalculator;

//https://ihateregex.io/expr/ipv6
//https://www.regular-expressions.info/ip.html
function IPv4IsValid(const pIP: string): boolean;
const
  cRexIPv4 = '\b(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\b';
begin
  Result := TRegEx.IsMatch(pIP, cRexIPv4);
end;

function IPv6IsValid(const pIP: string): boolean;
const
cRexIPv61 = '\b(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|';
cRexIPv62 = cRexIPv61 + '([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|';
cRexIPv63 = cRexIPv62 + 'fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|';
cRexIPv6 = cRexIPv63 + '(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))\b';
begin
  Result := TRegEx.IsMatch(pIP, cRexIPv6);
end;

function IPv6Equal(const pIP1: TIP6Bytes; const pIP2: TIP6Bytes): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := Low(pIP1) to High(pIP1) do
    Result := ((pIP1[I] = pIP2[I]) and Result);
end;

function IPv6Unspecified(const pIP: TIP6Bytes): boolean;
var
  lIPv6Unspecified: TIP6Bytes;
begin
  lIPv6Unspecified := StrToIp6('0:0:0:0:0:0:0:0');
  Result := IPv6Equal(pIP, lIPv6Unspecified);
end;

function IPv6Loopback(const pIP: TIp6Bytes): Boolean;
var
  lIPv6Loopback: TIp6Bytes;
begin
  lIPv6Loopback := StrToIp6('0:0:0:0:0:0:0:1');
  Result := IPv6Equal(pIP, lIPv6Loopback);
end;

function IPv6Sitelocal(const pIP: TIp6Bytes): Boolean;
begin
  Result := ((pIP[0] = $fe) and ((pIP[1] and $c0) = $c0));
end;

function IPv6Linklocal(const pIP: TIp6Bytes): Boolean;
begin
  Result := ((pIP[0] = $fe) and ((pIP[1] and $c0) = $80));
end;

function IPv6Multicast(const pIP: TIp6Bytes): Boolean;
begin
  Result := (pIP[0] = $ff);
end;

function IPIsPublic(const pIP: string): Boolean;
var
  lIPv6Bytes: TIp6Bytes;
  IPv4NetworkCalculator: TIdNetworkCalculator;
begin
  Result := False;

  if IPv4IsValid(pIP) then
  begin
    IPv4NetworkCalculator := nil;
    try
      //http://e-iter.net/knowledge/indy9/007582.html
      IPv4NetworkCalculator := TIdNetworkCalculator.Create(nil);
      IPv4NetworkCalculator.NetworkAddress.AsString := pIP;

      Result := IPv4NetworkCalculator.IsAddressRoutable;
    finally
      IPv4NetworkCalculator.Free;
    end;
  end
  else //http://ararat.cz/synapse/doku.php
    if IPv6IsValid(pIP) then
    begin
      Result := True;
      lIPv6Bytes := StrToIp6(pIP);

      if IPv6Loopback(lIPv6Bytes) then
        Result := False
      else
        if IPv6Unspecified(lIPv6Bytes) then
          Result := False
        else
          if IPv6Sitelocal(lIPv6Bytes) then
            Result := False
          else
            if IPv6Linklocal(lIPv6Bytes) then
              Result := False;
    end;
end;

end.
