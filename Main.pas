unit Main;

interface

uses
  System.Math, DataTab, DBConnectionForm, System.JSON, System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBAccess, MSAccess, MemDS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.DockTabSet, Vcl.Tabs, Data.SqlExpr, Vcl.Buttons, Vcl.Menus,
  Vcl.PlatformDefaultStyleActnCtrls, System.Actions, Vcl.ActnList, Vcl.ActnMan,
  Datasnap.Provider, DADump, MSDump;

type
  TMainForm = class(TForm)

    btnExecute        :TButton;
    MemoQueryText     :TMemo;
    CBoxDatabases     :TComboBox;
    PageControl       :TPageControl;
    Label1            :TLabel;
    Panel1            :TPanel;
    Panel2            :TPanel;
    Button1           :TButton;
    LblDBStatus       :TLabel;
    EdQueryName       :TEdit;
    BtnSaveSQL        :TButton;
    ListBoxQueryFiles :TListBox;
    LblFolderPath     :TLabel;

    BtnDeleteSql      :TButton;
    MainMenu1         :TMainMenu;
    OpenFolder1       :TMenuItem;
    MenuItemChangeDirectory :TMenuItem;
    MenuItemSave      :TMenuItem;

    SaveDialogCsv     :TSaveDialog;
    FileOpenDialog1   :TFileOpenDialog;

    ActionManager1    :TActionManager;
    ChangeWorkingDirectory  :TAction;
    Save        :TAction;
    Delete      :TAction;
    Execute     :TAction;
    Connection  :TAction;
    LoadFile    :TAction;

    procedure FormCreate(Sender: TObject);
    procedure PageControlMouseDown(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState; X, Y: Integer);
    procedure ListBoxQueryFilesClick(Sender: TObject);
    procedure SaveExecute(Sender: TObject);
    procedure ChangeWorkingDirectoryExecute(Sender: TObject);
    procedure DeleteExecute(Sender: TObject);
    procedure ExecuteExecute(Sender: TObject);
    procedure ConnectionExecute(Sender: TObject);
    procedure LoadFileExecute(Sender: TObject);
  private
    QueryCount           :Integer;
    MSConnection         :TMSConnection;
    DBConnectionForm     :TFormDBConnect;
    fSqlFolderPath       :string;
    fServerSavePath      :string;
    procedure ConnectionLost(Sender :TObject);
    procedure Connected(Sender :TObject);
    procedure LoadSQLFolder(Path :string);
    procedure InitFiles();
  public

  end;

var
  MainForm: TMainForm;


implementation

{$R *.dfm}

procedure TMainForm.DeleteExecute(Sender: TObject);
var
  Path     :String;
  i        :Integer;
  Response :Integer;
  FileName :String;
begin
  i := ListBoxQueryFiles.ItemIndex;
  if i < 0 then Exit;
  FileName := ListBoxQueryFiles.Items[i];
  Response := MessageDlg(Format('Are you sure you want to delete %s ?', [FileName]), mtConfirmation,
                [mbYes, mbNo], 0);
  if Response = mrNo then Exit;

  Path := fSqlFolderPath + '\' + FileName;
  try
    DeleteFile(Path);
  except
    on E: Exception do
      ShowMessage('Error deleting file: ' + E.Message);
  end;

  ListBoxQueryFiles.Items.Delete(ListBoxQueryFiles.ItemIndex);
end;

procedure TMainForm.ExecuteExecute(Sender: TObject);
var
  NewTab :TDataTab;
begin
    if not MSConnection.Connected then begin
      ShowMessage('Please get connected first');
      Exit;
    end;

    try
      NewTab := TDataTab.Create(MemoQueryText.Lines.Text, Format('SQL-%d', [QueryCount]),
                                            PageControl, MSConnection, CBoxDatabases.Text);
      PageControl.ActivePage := NewTab;
      QueryCount := QueryCount + 1;
    except
      newTab.Free;
    end;
end;

procedure TMainForm.ConnectionExecute(Sender: TObject);
begin
  try
    DBconnectionForm            := TFormDBConnect.Create(self);
    DBConnectionForm.Connection := MSConnection;
    DBConnectionForm.ShowModal;
  finally
    DBConnectionForm.Free;
  end;
end;

procedure TMainForm.ChangeWorkingDirectoryExecute(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
    LoadSQLFolder(FileOpenDialog1.FileName);
end;

procedure TMainForm.LoadFileExecute(Sender: TObject);
begin
  LoadSQLFolder(fSqlFolderPath);
end;

procedure TMainForm.SaveExecute(Sender: TObject);
var
  FileStream :TFileStream;
  Response  :Integer;
  Path,
  Query     :String;
  Buffer    :TBytes;
begin

  Path := Trim(EdQueryName.Text);
  if Path = '' then Exit;
  if not Path.EndsWith('.sql', True) then Path := Path + '.sql';

  Path := fSqlFolderPath + '\' + Path;
  Query := MemoQueryText.Text;

  if FileExists(Path) then begin
    Response := MessageDlg('This file already exists, do you want to overwrite it?', mtConfirmation, [mbYes, mbNo], 0);
    if Response = mrNo then exit;
  end;
  FileStream    := TFileStream.Create(Path, fmCreate);
  try
    Buffer := TEncoding.UTF8.GetBytes(Query);
    FileStream.Write(Buffer, Length(buffer));
  finally
    FileStream.Free;
  end;
  LoadFileExecute(nil);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MsConnection                 := TMSConnection.Create(self);
  MSConnection.LoginPrompt     := False;
  MSConnection.AfterConnect    := Connected;
  MSConnection.AfterDisconnect := ConnectionLost;
  QueryCount := 0;

  TDataTab.SaveDialog := SaveDialogCsv;

  InitFiles();
  TFormDBConnect.ServerSavePath := fServerSavePath;
  LoadSQLFolder(fSqlFolderPath);
end;

procedure TMainForm.ConnectionLost(Sender :TObject);
begin
  LblDBStatus.Caption := Format('Server: %s Status: ', [MSConnection.Server, 'disconnected']);
end;

procedure TMainForm.Connected(Sender :TObject);
begin
  LblDBStatus.Caption := Format('Server: %s Status: %s', [MSConnection.Server, 'connected']);
  MSconnection.GetDatabaseNames(CBoxDatabases.Items);
  CBoxDatabases.ItemIndex := 0;
end;

procedure TMainForm.InitFiles();
begin
  fSqlFolderPath     := ExtractFilePath(Application.ExeName) + 'Queries';
  fServerSavePath    := ExtractFilePath(Application.ExeName) + 'Servers.json';

  if not DirectoryExists(fSqlFolderPath) then
    ForceDirectories(fSqlFolderPath);

  if not FileExists(fServerSavePath) then
    TFile.WriteAllText(fServerSavePath, '{}');
end;

procedure TMainForm.LoadSQLFolder(Path :String);
var
  SearchRec :TSearchRec;
  Result    :Integer;
begin
  fSqlFolderPath := Path;
  LblFolderPath.Caption := fSqlFolderPath;

  ListBoxQueryFiles.Items.Clear();
  Result := FindFirst(fSqlFolderPath + '\*.sql', faAnyFile, SearchRec);
  try
    while Result = 0 do
    begin
      ListBoxQueryFiles.Items.Add(SearchRec.Name);
      Result := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;
end;

procedure TMainForm.ListBoxQueryFilesClick(Sender: TObject);
var
  FileStream    :TFileStream;
  StreamReader  :TStreamReader;
  QueryName,
  FileQuery,
  FileName      :string;
  i             :Integer;
begin
  i := ListBoxQueryFiles.ItemIndex;
  if i < 0 then Exit;
  
  QueryName := ListBoxQueryFiles.Items[i];
  FileName := fSqlFolderPath + '\' + QueryName;
  EdQueryName.Text := QueryName;

  FileStream := TFileStream.Create(FileName, fmOpenRead);
  StreamReader := TStreamReader.Create(FileStream, TEncoding.UTF8);
  try
    MemoQueryText.Clear;
    MemoQueryText.Lines.LoadFromStream(StreamReader.BaseStream, TEncoding.UTF8);
  finally
    StreamReader.Free;
    FileStream.Free;
  end;
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
