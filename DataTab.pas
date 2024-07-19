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
    Query     :TMSQuery;
    DBGrid    :TDBGrid;


  public
    constructor Create(Connection :TMSConnection);
  end;

implementation

constructor TDataTab.Create;
begin

  DBGrid.Create(nil);
  DBGrid.Create(nil);

end;




end.
