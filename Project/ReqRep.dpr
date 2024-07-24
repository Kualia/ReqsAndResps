program ReqRep;

uses
  Vcl.Forms,
  Main in '..\Main.pas' {MainForm},
  DataTab in '..\DataTab.pas',
  DBConnectionForm in '..\DBConnectionForm.pas' {FormDBConnect};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
