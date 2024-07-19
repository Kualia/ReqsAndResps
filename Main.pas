unit Main;

interface

uses
  System.Math,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBAccess, MSAccess, MemDS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.DockTabSet, Vcl.Tabs;

type
  TMainForm = class(TForm)
    MSConnection: TMSConnection;
    MSQuery: TMSQuery;
    MSDataSource: TMSDataSource;

    DBGrid: TDBGrid;
    btnExecute: TButton;
    MemoQueryText: TMemo;
    ComboBox1: TComboBox;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnExecuteClick(Sender: TObject);
begin
  MSQuery.SQL.Text     := MemoQueryText.Lines.Text;
  MSQuery.Open;
  MSDataSource.DataSet := MSQuery;
  DBGrid.DataSource    := MSDataSource;
  ShowMessage(MSQuery.RecordCount.ToString);
end;

procedure TMainForm.DBGridDblClick(Sender: TObject);
var
  GridWidth  :Integer;
  IdColWidth :Integer;
  ColWidth   :Integer;
  maxw, minw :Integer;
  I          :Integer;
  begin
  IdColWidth := 30;
  maxw       := 200;
  minw       := 100;

  DBGrid.Options := DBGrid.Options + [dgColumnResize];

  GridWidth  := DBGrid.Width;

  if DBGrid.Columns.Count > 1 then
    ColWidth :=  FLOOR((GridWidth - IdColWidth) / (DBGrid.Columns.Count - 1))
  else ColWidth := maxw;

       if ColWidth > maxw then ColWidth := maxw
  else if ColWidth < minw then ColWidth := minw;


  DBGrid.Columns[0].Width := IdColWidth;
  for I := 1 to (DBGrid.Columns.count -1) do
    DBGrid.Columns[I].Width := ColWidth;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
//
  MsConnection             := TMSConnection.Create(nil);
  MSConnection.Server      := '';
  MSConnection.Username    := '';
  MSConnection.Password    := '';
  MSConnection.Database    := '';
  MSConnection.LoginPrompt := False;
  MSConnection.Connected   := True;

//con.ConnectString := 'Data Source=server;User ID=username;Password=password;Initial Catalog=database';

  MSConnection.open;
  MSQuery            := TMSQuery.Create(nil);
  MSQuery.Connection := MSConnection;

  MemoQueryText.Text := 'SELECT top 10 BusinessEntityID [ID], FirstName, LastName FROM Person.Person ORDER BY [ID]';

  MSDataSource := TMSDataSource.Create(nil);
end;


end.
