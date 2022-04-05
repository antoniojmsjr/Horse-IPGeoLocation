![Maintained YES](https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=flat-square&color=important)
![Memory Leak Verified YES](https://img.shields.io/badge/Memory%20Leak%20Verified%3F-yes-green.svg?style=flat-square&color=important)
![Delphi Supported Versions](https://img.shields.io/badge/Delphi%20Supported%20Versions-Tokyo%2010.2.3%20and%20above-blue.svg?style=flat-square)
![HorseVersion](https://img.shields.io/badge/Horse%20minimum%20version-v3.0.1-blue.svg?style=flat-square)
![Stars](https://img.shields.io/github/stars/antoniojmsjr/Horse-IPGeoLocation.svg?style=flat-square)
![Forks](https://img.shields.io/github/forks/antoniojmsjr/Horse-IPGeoLocation.svg?style=flat-square)
![Issues](https://img.shields.io/github/issues/antoniojmsjr/Horse-IPGeoLocation.svg?style=flat-square&color=blue)
![Release](https://img.shields.io/github/v/release/antoniojmsjr/Horse-IPGeoLocation?label=Latest%20release&style=flat-square&color=important)

# Horse-IPGeoLocation

**Horse-IPGeoLocation** é um middleware de geolocalização baseada em endereço IP, desenvolvido parar o framework [Horse](https://github.com/HashLoad/horse).

## ❓ O que é a geolocalização de IP?

A geolocalização baseada em endereços IP é uma técnica usada para estimar a localização geográfica de um dispositivo conectado à Internet usando o endereço IP do mesmo. Este mecanismo depende de que o endereço IP do dispositivo apareça em um banco de dados com sua respectiva localização, endereço postal, cidade, país, região ou coordenadas geográficas, que são alguns dos níveis de detalhe que podem ser registrados.

## ⭕ Pré-requisito

Para utilizar o **Horse-IPGeoLocation** é necessário a instalação do framework [IPGeoLocation](https://github.com/antoniojmsjr/IPGeoLocation/releases/latest).

* Instalação Automatizada

Utilizando o [**Boss**](https://github.com/HashLoad/boss/releases/latest) (Dependency manager for Delphi) é possível instalar a biblioteca de forma automática.

* Instalação Manual

Se você optar por instalar manualmente, basta adicionar as seguintes pastas ao seu projeto, em *Project > Options > Delphi Compiler > Target > All Configurations > Search path*

```
..\IPGeoLocation\Source
```

## ⚙️ Instalação Automatizada

Utilizando o [**Boss**](https://github.com/HashLoad/boss/releases/latest) (Dependency manager for Delphi) é possível instalar a biblioteca de forma automática.

*Obs: Se você usa Boss (Dependency manager for Delphi), o [IPGeoLocation](https://github.com/antoniojmsjr/IPGeoLocation/releases/latest) será instalado automaticamente ao instalar **Horse-IPGeoLocation**.*

```
boss install github.com/antoniojmsjr/Horse-IPGeoLocation
```

## ⚙️ Instalação Manual

Se você optar por instalar manualmente, basta adicionar as seguintes pastas ao seu projeto, em *Project > Options > Delphi Compiler > Target > All Configurations > Search path*

*Obs: Se você usar a instalação manual, será necessário a instalação do framework [IPGeoLocation](https://github.com/antoniojmsjr/IPGeoLocation/releases/latest).*

```
..\Horse-IPGeoLocation\Source
```

## 🧬 Provedores IPGeolocation

Lista dos principais provedores de IPGeolocation homologados para utilização: [Visualização](https://github.com/antoniojmsjr/IPGeoLocation#provedores-homologados)

## ⚡️ Uso

#### Uso e definição do middleware

```delphi
uses Horse, Horse.IPGeoLocation, Horse.IPGeoLocation.Types;

//PARA TESTAR IPGeolocation LOCALMENTE
if (DebugHook <> 0) then
  THorse.Use(IPGeoLocation(TIPGeoLocationProvider.IPInfo, 'APY Key', '8.8.8.8'))
else
  THorse.Use(IPGeoLocation(TIPGeoLocationProvider.IPInfo, 'APY Key'));
```

```delphi
function IPGeoLocation(const pProvider: TIPGeoLocationProvider;
                       const pToken: string;
                       const pAPIKey: Integer;
                       const pLanguageCode: string): THorseCallback;
```
* `pProvider`: Identificação do provedor de IPGeolocation homologado.
* `pAPIKey`: ApiKey gerado no site do provedor de IPGeolocation identificado no `pProvider`. [opcional]
* `pTimeOut`: Tempo em milissegundos para finalização da requisição. [opcional]
* `pLanguageCode`: Identificação do código de idioma utilizado no retorno do JSON. Ex.: pt-br/en-us. [opcional]
* `pIPDebug`: IP para testar com requisição local.
  * Requisições locais ou IP privados ao servidor Horse, não é executado o middleware IPGeolocation.

#### Exemplo de visualização do JSON de retorno da requisição do IPGeolocation.

```delphi
uses Horse, Horse.IPGeoLocation, Horse.IPGeoLocation.Types;

THorse.Get('ipgeo/json',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
  var
    lHorseGeoLocation: THorseGeoLocation;
  begin
    if Req.Sessions.TryGetSession(lHorseGeoLocation) then
      Res.Send(lHorseGeoLocation.ToJSON)
    else
      Res.Send(Req.RawWebRequest.RemoteAddr);
  end);
```

#### Exemplo de visualização do mapa(Google) gerado com o retorno da requisição do IPGeolocation.

```delphi
uses Horse, Horse.IPGeoLocation, Horse.IPGeoLocation.Types;

THorse.Get('ipgeo/gmaps',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
  const
    cURLMaps = 'https://maps.google.com/maps?q=%g,%g'; //1º: LATITUDE/2º: LONGITUDE
  var
    lHorseGeoLocation: THorseGeoLocation;
    lFormatSettings: TFormatSettings;
    lURLMaps: string;
  begin
    lFormatSettings:= TFormatSettings.Create('en-US');

    if Req.Sessions.TryGetSession(lHorseGeoLocation) then
    begin
      lURLMaps := Format(cURLMaps, [lHorseGeoLocation.Latitude, lHorseGeoLocation.Longitude], lFormatSettings);
      Res.RedirectTo(lURLMaps);
    end
    else
      Res.Send(Req.RawWebRequest.RemoteAddr);
  end);
```

#### Exemplo de visualização do mapa(Waze) gerado com o retorno da requisição do IPGeolocation.

```delphi
uses Horse, Horse.IPGeoLocation, Horse.IPGeoLocation.Types;

THorse.Get('ipgeo/wmaps',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
  const
    cURLMaps = 'https://waze.com/ul?ll=%g,%g&z=10'; //1º: LATITUDE/2º: LONGITUDE
  var
    lHorseGeoLocation: THorseGeoLocation;
    lFormatSettings: TFormatSettings;
    lURLMaps: string;
  begin
    lFormatSettings:= TFormatSettings.Create('en-US');

    if Req.Sessions.TryGetSession(lHorseGeoLocation) then
    begin
      lURLMaps := Format(cURLMaps, [lHorseGeoLocation.Latitude, lHorseGeoLocation.Longitude], lFormatSettings);
      Res.RedirectTo(lURLMaps);
    end
    else
      Res.Send(Req.RawWebRequest.RemoteAddr);
  end);
```
## ⚠️ Licença
`Horse-IPGeoLocation` is free and open-source software licensed under the [![License](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://github.com/antoniojmsjr/Horse-IPGeoLocation/blob/master/LICENSE)
