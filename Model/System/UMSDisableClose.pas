unit UMSDisableClose;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, Generics.Collections, Contnrs, Bde.DBTables,
  Vcl.ComCtrls,
  GetDataSoursUnit1,
  VQNNumberOfDonations,
  VQBBloodProduct,
  VQPProcurementOfTheComponentsTotal,
  VQHHarvestingOfBloodComponentsByTypes,
  UMSMoldCleaning;

  type
    DisableClose = class
    private
      SysMenu:HMENU;
    public
      procedure DisableCloseMenu;
    end;

implementation

{ DisableClose }

procedure DisableClose.DisableCloseMenu;
begin
  SysMenu := GetSystemMenu( Handle, false );
  Windows.EnableMenuItem( SysMenu, SC_CLOSE, MF_DISABLED or MF_GRAYED );
  GetSystemMenu( Handle, false );
  Perform( WM_NCPAINT, Handle, 0 );
end;

end.
