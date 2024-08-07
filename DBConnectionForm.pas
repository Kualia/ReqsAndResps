unit DBConnectionForm;

interface

uses
  DBAccess, MSAccess, System.JSON,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormDBConnect = class(TForm)
    Label1: TLabel;
    EdServer: TEdit;
    Label2: TLabel;
    EdPort: TEdit;
    Label3: TLabel;
    EdUser: TEdit;
    Label4: TLabel;
    EdPassword: TEdit;
    CBoxServers: TComboBox;
    BtnConnect: TButton;
    Label5: TLabel;
    Label6: TLabel;
    CbDatabase: TComboBox;
    CBSave: TCheckBox;
    Label7: TLabel;
    EdSaveName: TEdit;
    BtnDeleteServer: TButton;
    procedure BtnConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBoxServersChange(Sender: TObject);
    procedure BtnDeleteServerClick(Sender: TObject);
  private
    fServers  :TJSONObject;
    procedure SaveServer();
    procedure RemoveServer();
    procedure GetServers();

  public
    Connection :TMSConnection;
    class var ServerSavePath :string;
    { Public declarations }
  end;

var
  FormDBConnect: TFormDBConnect;

implementation

uses Generics.Collections, System.IOUtils;

{$R *.dfm}

procedure TFormDBConnect.BtnConnectClick(Sender: TObject);
begin
  Connection.ConnectString := FORMAT('Server=%s;Database=%s;User Id=%s;Password=%s;'
                                                ,[EdServer.Text+' ,'+EdPort.Text
                                                ,CbDatabase.Text
                                                ,EdUser.Text
                                                ,EdPassword.Text]);

  try
    Connection.Connected := True;
    if CBSave.Checked then SaveServer();
    self.Close;
  except
    on E: Exception do begin
      ShowMessage('DB Connection failed: ' + E.Message);
      Connection.Connected := False;
    end;
  end;

end;

procedure TFormDBConnect.BtnDeleteServerClick(Sender: TObject);
begin
  if CBoxServers.ItemIndex < 0 then Exit;
  RemoveServer();
end;

procedure TFormDBConnect.CBoxServersChange(Sender: TObject);
var
  server :TJSONObject;
begin
  server := fServers.GetValue<TJSONObject>(CBoxServers.Text);

  EdServer.Text   := Server.GetValue<String>('Server');
  EdPort.Text     := Server.GetValue<String>('Port');
  EdUser.Text     := Server.GetValue<String>('User');
  EdPassword.Text := Server.GetValue<String>('Password');
end;

procedure TFormDBConnect.FormCreate(Sender: TObject);
begin
  GetServers();
end;

procedure TFormDBConnect.GetServers();
var
 pair :TJSONPair;
 i    :Integer;
 begin
  fServers := TJSONObject.ParseJSONValue(TFile.ReadAllText(ServerSavePath, TEncoding.UTF8)) as TJSONObject;
  CBoxServers.Clear;

  for i:= 0 to fServers.Count-1 do
    CBoxServers.Items.add(fServers.Pairs[i].JsonString.value);

end;


procedure TFormDBConnect.SaveServer();
var
  Server  :TJSONObject;
  ServerName :String;
begin
  ServerName := Trim(EdSaveName.Text);

  try
    if ServerName = '' then begin
      ShowMessage('Please enter a valid server name, Saving failed');
      Exit;
    end;

    Server := TJSONObject.Create;
    Server.AddPair('Server',  EdServer.Text);
    Server.AddPair('Port',    Edport.Text);
    Server.AddPair('User',    EdUser.Text);
    Server.AddPair('Password',EdPassword.Text);
    fServers.AddPair(EdSaveName.Text, Server);
    TFile.WriteAllText(ServerSavePath, fServers.Format(2));
  finally
    fServers.Free;
  end;

end;

procedure TFormDBConnect.RemoveServer();
var
  i :Integer;
begin
  fServers.RemovePair(CBoxServers.Text);
  TFile.WriteAllText(ServerSavePath, fServers.Format(2));


  for i := CBoxservers.Items.Count - 1 downto 0 do
  begin
    if CBoxservers.Items[i] = CBoxServers.Text then
    begin
      CBoxservers.Items.Delete(i);
      Exit;
    end;
  end;
end;

end.
