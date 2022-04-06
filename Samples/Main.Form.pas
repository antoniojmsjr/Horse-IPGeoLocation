unit Main.Form;

interface

uses
  Winapi.Windows, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.SysUtils,
  Vcl.ExtCtrls, ShellApi;

type
  TFrmMain = class(TForm)
    btnStop: TBitBtn;
    btnStart: TBitBtn;
    lblPort: TLabel;
    edtPort: TEdit;
    lblLinkJson: TLinkLabel;
    lblLinkGoogleMaps: TLinkLabel;
    lblLinkWazeMaps: TLinkLabel;
    procedure btnStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartClick(Sender: TObject);
    procedure LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
  private
    procedure Status;
    procedure Start;
    procedure Stop;
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  Horse, Horse.IPGeoLocation, Horse.IPGeoLocation.Types;

{$R *.dfm}

procedure TFrmMain.Start;
begin

  //PARA TESTAR IPGeolocation LOCALMENTE
  if (DebugHook <> 0) then
    THorse.Use(IPGeoLocation(TIPGeoLocationProvider.IPInfo, EmptyStr, '8.8.8.8'))
  else
    THorse.Use(IPGeoLocation(TIPGeoLocationProvider.IPInfo, EmptyStr));

  THorse.Get('ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('pong');
    end);

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

  //GOOGLE MAPS
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

  //WAZE MAPS
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

  THorse.Listen(StrToInt(edtPort.Text));
end;

procedure TFrmMain.Status;
begin
  btnStop.Enabled := THorse.IsRunning;
  btnStart.Enabled := not THorse.IsRunning;
  edtPort.Enabled := not THorse.IsRunning;
end;

procedure TFrmMain.Stop;
begin
  THorse.StopListen;
end;

procedure TFrmMain.btnStartClick(Sender: TObject);
var
  lURL: string;
begin
  lURL := Format('http://localhost:%s/ipgeo/json', [edtPort.Text]);
  lblLinkJson.Caption := Format('<a href="%s">Exemplo IPGeoloaction :: JSON</a>', [lURL]);

  lURL := Format('http://localhost:%s/ipgeo/gmaps', [edtPort.Text]);
  lblLinkGoogleMaps.Caption := Format('<a href="%s">Exemplo IPGeoloaction :: Google Maps</a>', [lURL]);

  lURL := Format('http://localhost:%s/ipgeo/wmaps', [edtPort.Text]);
  lblLinkWazeMaps.Caption := Format('<a href="%s">Exemplo IPGeoloaction :: Waze Maps</a>', [lURL]);

  Start;
  Status;
end;

procedure TFrmMain.btnStopClick(Sender: TObject);
begin
  lblLinkJson.Caption := '...';
  lblLinkGoogleMaps.Caption := '...';
  lblLinkWazeMaps.Caption := '...';

  Stop;
  Status;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if THorse.IsRunning then
    Stop;
end;

procedure TFrmMain.LinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  ShellExecute(0, 'OPEN', PChar(Link), nil, nil, SW_SHOWNORMAL);
end;

end.
