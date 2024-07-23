unit DataTab;

interface

uses
  System.Math, System.Diagnostics,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBAccess, MSAccess, MemDS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.DockTabSet, Vcl.Tabs;

type
  TDataTab = class(TTabSheet)
  private
    fQuery        :TMSQuery;
    fDataSource   :TMSDataSource;
//    fDataSet      :

    fPanel        :TPanel;
    fPanel2       :TPanel;
    fDBGrid       :TDBGrid;
    fMemoMessage  :TMemo;
    fMemoQuery    :TMemo;
    fCBoxReadOnly :TCheckBox;
    procedure SetGridReadonlyProp(Sender :TObject = nil);
    procedure UpdateGridSize(Sender :TObject = nil);
    procedure OpenQuery(Connection :TMSConnection; Database, QueryStr :String);
    procedure Layout();
  public
    constructor Create(QueryStr, TabName :string; PageControl :TPageControl;
                  Connection :TMSConnection; Database :string);
    destructor Destroy(); override;
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
  fDataSource      := TMSDataSource.Create(self);
  fQuery           := TMSQuery.Create(self);
  Self.PageControl := PageControl;
  Self.Caption     := TabName;

  Layout();
  // Query
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
  fCBoxReadOnly.Parent := fpanel;
  fCBoxReadOnly.Align := TAlign.alBottom;
  fCBoxReadOnly.Caption := 'Read only';
  fCBoxReadOnly.Checked := True;
  fCBoxReadOnly.OnClick := SetGridReadonlyProp;
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
begin
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
  fDataSource.DataSet  := fQuery;
  fDBGrid.DataSource   := fDataSource;
  fPanel.OnResize      := UpdateGridSize;
end;

end.
