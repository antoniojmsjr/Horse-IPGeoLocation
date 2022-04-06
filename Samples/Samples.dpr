program Samples;

uses
  Vcl.Forms,
  Main.Form in 'Main.Form.pas' {FrmMain};

{$R *.res}

begin
  //Verificação Memory Leak
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
