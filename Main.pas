unit Main;

interface

uses
  System.Math, DataTab, DBConnectionForm, System.JSON, System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBAccess, MSAccess, MemDS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.DockTabSet, Vcl.Tabs, Data.SqlExpr;

type
  TMainForm = class(TForm)

    btnExecute: TButton;
    MemoQueryText: TMemo;
    CBoxDatabases: TComboBox;
    PageControl: TPageControl;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    LblDBStatus: TLabel;
    EdQueryName: TEdit;
    BtnSaveSQL: TButton;

    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PageControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    QueryCount          :Integer;
    MSConnection        :TMSConnection;
    DBConnectionForm    :TFormDBConnect;
    SqlFolderPath       :string;
    ServerSavePath      :string;
    ExportFolderPath    :string;
    procedure ConnectionLost(Sender :TObject);
    procedure Connected(Sender :TObject);
    procedure InitFiles();
  public

  end;

var
  MainForm: TMainForm;


implementation

{$R *.dfm}

procedure TMainForm.btnExecuteClick(Sender: TObject);
var
  NewTab :TDataTab;
begin
    if not MSConnection.Connected then begin
      ShowMessage('Please get connected first');
      Exit;
    end;

    QueryCount := QueryCount + 1;
    NewTab := TDataTab.Create(MemoQueryText.Lines.Text, Format('SQL-%d', [QueryCount]),
                                            PageControl, MSConnection, CBoxDatabases.Text);
    PageControl.ActivePage := NewTab;
end;


procedure TMainForm.Button1Click(Sender: TObject);
begin
  try
    DBconnectionForm            := TFormDBConnect.Create(self);
    DBConnectionForm.Connection := MSConnection;
    DBConnectionForm.ShowModal;
  finally
    DBConnectionForm.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MsConnection                 := TMSConnection.Create(self);
  MSConnection.LoginPrompt     := False;
  MSConnection.AfterConnect    := Connected;
  MSConnection.AfterDisconnect := ConnectionLost;
  QueryCount := 0;

  InitFiles();
  TFormDBConnect.ServerSavePath := ServerSavePath;

  MemoQueryText.Text := 'SELECT top 10 BusinessEntityID [ID], FirstName, LastName FROM Person.Person ORDER BY [ID]';
end;

procedure TMainForm.ConnectionLost(Sender :TObject);
begin
  LblDBStatus.Caption := Format('Database: %s Status: ', [MSConnection.Server, 'disconnected']);
end;

procedure TMainForm.Connected(Sender :TObject);
begin
  LblDBStatus.Caption := Format('Database: %s Status: %s', [MSConnection.Server, 'connected']);
  MSconnection.GetDatabaseNames(CBoxDatabases.Items);
  CBoxDatabases.ItemIndex := 0;
end;

procedure TMainForm.InitFiles();
begin
  SqlFolderPath     := ExtractFilePath(Application.ExeName) + 'Queries';
  ServerSavePath    := ExtractFilePath(Application.ExeName) + 'Servers.json';
  ExportFolderPath  := ExtractFilePath(Application.ExeName) + 'Exports';

  if not DirectoryExists(SqlFolderPath) then
    ForceDirectories(SqlFolderPath);

  if not DirectoryExists(ExportFolderPath) then
    ForceDirectories(ExportFolderPath);

  if not FileExists(ServerSavePath) then
    TFile.WriteAllText(ServerSavePath, '{}');
end;

procedure TMainForm.PageControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pageIndex :Integer;
begin
  if Button <> mbMiddle then Exit;

  pageIndex := PageControl.IndexOfTabAt(X, Y);
  PageControl.Pages[pageIndex].Free;
end;

end.
