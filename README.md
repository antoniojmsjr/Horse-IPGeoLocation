![Maintained YES](https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=flat-square&color=important)
![Memory Leak Verified YES](https://img.shields.io/badge/Memory%20Leak%20Verified%3F-yes-green.svg?style=flat-square&color=important)
![Delphi Supported Versions](https://img.shields.io/badge/Delphi%20Supported%20Versions-Tokyo%2010.2.3%20and%20above-blue.svg?style=flat-square)
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

Utilizando o [**Boss**](https://github.com/HashLoad/boss) (Dependency manager for Delphi) é possível instalar a biblioteca de forma automática.

* Instalação Manual

Se você optar por instalar manualmente, basta adicionar as seguintes pastas ao seu projeto, em *Project > Options > Delphi Compiler > Target > All Configurations > Search path*

```
..\IPGeoLocation\Source
```

## ⚙️ Instalação Automatizada

Utilizando o [**Boss**](https://github.com/HashLoad/boss) (Dependency manager for Delphi) é possível instalar a biblioteca de forma automática.

*Obs: Se você usa Boss (Dependency manager for Delphi), o [IPGeoLocation](https://github.com/antoniojmsjr/IPGeoLocation/releases/latest) será instalado automaticamente ao instalar **Horse-IPGeoLocation**.*

```
boss install github.com/antoniojmsjr/Horse-IPGeoLocation
```

## ⚙️ Instalação Manual

Se você optar por instalar manualmente, basta adicionar as seguintes pastas ao seu projeto, em *Project > Options > Delphi Compiler > Target > All Configurations > Search path*

```
..\Horse-IPGeoLocation\Source
```

## Uso
```delphi
uses Horse, Horse.IPGeoLocation, Horse.IPGeoLocation.Types;
```
