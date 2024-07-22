unit DataTab;

interface

uses
  System.Math,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBAccess, MSAccess, MemDS, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.DockTabSet, Vcl.Tabs;

type
  TDataTab = class(TTabSheet)
  private
    fQuery        :TMSQuery;
    fDataSource   :TMSDataSource;

    fPanel        :TPanel;
    fDBGrid       :TDBGrid;
    fMemoQuery    :TMemo;
    fCBoxReadOnly :TCheckBox;
    procedure SetGridReadonlyProp(Sender :TObject = nil);
    procedure UpdateGridSize(Sender :TObject = nil);
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

  // self
//  self.Align       := TAlign.alClient;
//  self.Parent      := PageControl;
//  self.AlignWithMargins := True;

  //   Create Panel
  fPanel          := TPanel.Create(self);
  fPanel.Parent   := self;
//  fpanel.BorderWidth := 5; //Will be removed
//  fpanel.BorderStyle := bsSingle;
  fPanel.Align    := TAlign.alClient;
  fPanel.AlignWithMargins := True;


//
  // Create Grid
  fDBGrid         := TDBGrid.Create(fPanel);
  fDBGrid.Parent  := fPanel;
  fDbGrid.ReadOnly := True;

  // memo query
  fMemoQuery      := Tmemo.Create(fPanel);
  fMemoQuery.Parent := fPanel;
  fMemoQuery.Align := TAlign.alBottom;
  fMemoQuery.ReadOnly := True;

  // Checkbox
  fCBoxReadOnly := TCheckBox.Create(fPanel);
  fCBoxReadOnly.Parent := fpanel;
  fCBoxReadOnly.Align := TAlign.alBottom;
  fCBoxReadOnly.Caption := 'Read only';
  fCBoxReadOnly.Checked := True;
  fCBoxReadOnly.OnClick := SetGridReadonlyProp;

  // Query
  fQuery.Connection    := Connection;
  fQuery.SQL.Text      := 'Use ' + Database + ';  ' + QueryStr;
  fQuery.Open;
//  fquery.Connection.Database :=

  fDataSource.DataSet  := fQuery;
  fDBGrid.DataSource   := fDataSource;
  fPanel.OnResize      := UpdateGridSize;
  UpdateGridSize();

end;

procedure TDataTab.UpdateGridSize(Sender :TObject = nil);
var
  GridWidth  :Integer;
  IdColWidth :Integer;
  ColWidth   :Integer;
  maxw, minw :Integer;
  I          :Integer;
begin
  //get from settings
  IdColWidth := 30;
  maxw       := 200;
  minw       := 90;

  //columns
  fDBGrid.Width := FLOOR(fDBGrid.Parent.Width);
  fDBGrid.Height := FLOOR(fDBGrid.Parent.Height * 0.75);
  GridWidth  := fDBGrid.Width - 40;
  if fDBGrid.Columns.Count > 1 then
    ColWidth :=  FLOOR((GridWidth - IdColWidth) / (fDBGrid.Columns.Count - 1))
  else begin ColWidth := maxw; IdColWidth := maxw; end;

       if ColWidth > maxw then ColWidth := maxw
  else if ColWidth < minw then ColWidth := minw;

  fDBGrid.Columns[0].Width := IdColWidth;
  for I := 1 to (fDBGrid.Columns.count -1) do
    fDBGrid.Columns[I].Width := ColWidth;

  //height
end;

procedure TDataTab.SetGridReadonlyProp(Sender :TObject = nil);
begin
  fDBGrid.ReadOnly := fCBoxReadOnly.Checked;
end;


end.
