unit DataTab;

interface

uses
  System.Math, System.Diagnostics, System.RegularExpressions, System.Actions, Vcl.ActnList, Vcl.ActnMan,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, DBClient, Vcl.Grids, Vcl.DBGrids,
  DBAccess, MSAccess, MemDS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.DockTabSet, Vcl.Tabs, Datasnap.Provider;

type
  TDataTab = class(TTabSheet)
  private
    //Query
    fQuery           :TMSQuery;
    fDataSource      :TMSDataSource;

    //Layout
    fPanel           :TPanel;
    fPanel2          :TPanel;
    fDBGrid          :TDBGrid;
    fMemoMessage     :TMemo;
    fMemoQuery       :TMemo;
    fCBoxReadOnly    :TCheckBox;
    fBtnExportAsCsv  :TButton;

    //Action
    ActionManager    :TActionManager;
    actDeleteRow     :TAction;

    procedure actDeleteRowExecute(Sender :TObject = nil);

    procedure SetGridReadonlyProp(Sender :TObject = nil);
    procedure UpdateGridSize(Sender :TObject = nil);
    procedure OpenQuery(Connection :TMSConnection; Database, QueryStr :String);
    procedure Layout();
    procedure ExportCsv(Sender :TObject = nil);
  public
    constructor Create(QueryStr, TabName :string; PageControl :TPageControl;
                  Connection :TMSConnection; Database :string);
    destructor Destroy(); override;
    class var SaveDialog :TSaveDialog;
end;


implementation

destructor TDataTab.Destroy();
begin
  fQuery.Close;
  //...
  inherited Destroy();
end;

constructor TDataTab.Create(QueryStr, TabName :string;
                            PageControl :TPageControl;
                            Connection :TMSConnection;
                            Database   :String);
begin
  Inherited Create(PageControl);
  Self.PageControl      := PageControl;
  Self.Caption          := TabName;

  ActionManager         := TActionManager.Create(self);

  actDeleteRow            := TAction.Create(ActionManager);
  actDeleteRow.ShortCut   := VK_DELETE;
  actDeleteRow.OnExecute  := actDeleteRowExecute;
  actDeleteRow.ExecuteAction(actDeleteRow);

  Layout();
  OpenQuery(Connection, Database, QueryStr);
  UpdateGridSize();
end;

procedure TDataTAb.Layout();
begin
    self.Align := alClient;

  //   Create Panel
  fPanel          := TPanel.Create(self);
  fPanel.Parent   := self;
  fPanel.Align    := TAlign.alTop;
  fPanel.BorderStyle := bsNone;

//  fPanel.AlignWithMargins := True;

  fPanel2          := TPanel.Create(self);
  fPanel2.Parent   := self;
  fPanel2.Align    := TAlign.alClient;
  fPanel2.BorderStyle := bsNone;
  fpanel2.Margins.Top := 30;
  fPanel2.AlignWithMargins := True;

  // Create Grid
  fDBGrid          := TDBGrid.Create(fPanel);
  fDBGrid.Parent   := fPanel;
  fDbGrid.ReadOnly := True;

  // memo message
  fMemoMessage          := TMemo.Create(fPanel2);
  fMemoMessage.Parent   := fPanel2;
  fMemoMessage.Align    := TAlign.alLeft;
  fMemoMessage.Anchors  := [TAnchorKind.akLeft, TAnchorKind.akBottom];
  fMemoMessage.ReadOnly := True;
  fMemoMessage.ScrollBars := ssVertical;
  fMemoMessage.Lines.Add('Messages:');

  // memo query
  fMemoQuery          := Tmemo.Create(fPanel2);
  fMemoQuery.Parent   := fPanel2;
  fMemoQuery.Align    := TAlign.alRight;
  fMemoQuery.Anchors  := [TAnchorKind.akRight, TAnchorKind.akBottom];
  fMemoQuery.Width    := 320;
  fMemoQuery.ReadOnly := True;
  fMemoQuery.ScrollBars := ssVertical;
  fMemoQuery.Lines.Add('Query:');


  // Checkbox
  fCBoxReadOnly := TCheckBox.Create(fPanel);
  fCBoxReadOnly.Parent := fPanel;
  fCBoxReadOnly.Align := TAlign.alBottom;
  fCBoxReadOnly.Caption := 'Read only';
  fCBoxReadOnly.Checked := True;
  fCBoxReadOnly.OnClick := SetGridReadonlyProp;

  // Export Btn
  fBtnExportAsCsv := TButton.Create(fpanel);
  fBtnExportAsCsv.Parent  := fPanel;
  fBtnExportAsCsv.Align   := TAlign.alBottom;
  fBtnExportAsCsv.Caption := 'Export csv';
  fBtnExportAsCsv.OnClick   := ExportCsv;



  fPanel.OnResize      := UpdateGridSize;
end;

procedure TDataTab.ExportCsv(Sender :TObject = nil);
var
  CsvFile  :TStringList;
  Row      :TStringList;
  i        :Integer;
  FilePath :String;
begin
  actDeleteRowExecute();
  exit;
  SaveDialog.FileName := self.Caption + '.csv';
  if SaveDialog.Execute then
    FilePath := SaveDialog.FileName;

  if Trim(FilePath) = '' then Exit;
  if not Pos('.', FilePath) > 0 then FilePath := FilePath + '.csv';

//  dataset.First;
  CsvFile := TStringList.Create();
  Row     := TStringList.Create();
  try
    for i := 0 to fQuery.FieldCount - 1 do
        Row.Add(fQuery.Fields[i].FieldName);
    CSVFile.Add(Row.CommaText);
    Row.Clear;

    fQuery.First;
    while not fQuery.Eof do
    begin
      for i := 0 to fQuery.FieldCount - 1 do
        Row.Add(fQuery.FieldList.Fields[i].AsString);
      CsvFile.Add(Row.CommaText);
      Row.Clear();
      fQuery.Next;
    end;

    fQuery.First;
    CSVFile.SaveToFile(FilePath);
  finally
    CsvFile.Free;
    Row.Free;
  end;
end;

procedure TDataTab.UpdateGridSize(Sender :TObject = nil);
var
  GridWidth  :Integer;
  IdColWidth :Integer;
  ColWidth   :Integer;
  maxw, minw :Integer;
  I          :Integer;
begin
  //TODO: get from settings
  IdColWidth := 30;
  maxw       := 200;
  minw       := 90;

  //columns
  fDBGrid.Width := FLOOR(fDBGrid.Parent.Width);
  fDBGrid.Height := FLOOR(fDBGrid.Parent.Height - 40);
  GridWidth  := fDBGrid.Width - 40;
  if fDBGrid.Columns.Count > 1 then
    ColWidth :=  FLOOR((GridWidth - IdColWidth) / (fDBGrid.Columns.Count - 1))
  else begin ColWidth := maxw; IdColWidth := maxw; end;

       if ColWidth > maxw then ColWidth := maxw
  else if ColWidth < minw then ColWidth := minw;

  fDBGrid.Columns[0].Width := IdColWidth;
  for I := 1 to (fDBGrid.Columns.count -1) do
    fDBGrid.Columns[I].Width := ColWidth;

  fPanel.Height     := FLOOR(self.Height * 0.70);
  fPanel2.Height   := Self.Height - fpanel.Height;
end;

procedure TDataTab.SetGridReadonlyProp(Sender :TObject = nil);
begin
  fDBGrid.ReadOnly := fCBoxReadOnly.Checked;
end;

procedure TDataTab.OpenQuery(Connection :TMSConnection; Database, QueryStr :String);
var
  Timer: TStopwatch;
  CurrentDataSource :TDataSource;
  DataSetProvider        :TDataSetProvider;

begin
  fDataSource      := TMSDataSource.Create(self);
  fQuery           := TMSQuery.Create(self);

  Timer := TStopwatch.StartNew;
  try
    fQuery.Connection := Connection;
    fQuery.SQL.Text := 'Use ' + Database + '; ' + QueryStr;
    fQuery.Open;
  finally
    Timer.Stop;
    fMemoMessage.Lines.Add(Format('Elapsed Query Time: %s (ms)', [Timer.ElapsedMilliseconds.ToString]));
    fMemoMessage.Lines.Add(Format('Number of Rows: %d', [fQuery.RecordCount]));
  end;
  fMemoQuery.Lines.Add(QueryStr);

  fDataSource.DataSet  := fquery;
  fDBGrid.DataSource   := fDataSource;
end;

procedure TDataTab.actDeleteRowExecute(Sender :TObject = nil);
begin
  try
    ShowMessage('Trying');
    fQuery.Delete;
    ShowMessage('DELETED');
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

end.
