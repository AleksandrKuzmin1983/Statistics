unit UMSBlockMainMenu;

interface

Uses
  Menus, Forms;

type
  IBlockMainMenu = interface
    Procedure BlockMainMenu(i: Boolean; Form: TForm);
  end;

  TBlockMainMenu = class(TInterfacedObject, IBlockMainMenu)
  public
    Procedure BlockMainMenu(i: Boolean; Form: TForm);
  end;



implementation

{ TBlockMainMenu }

procedure TBlockMainMenu.BlockMainMenu(i: Boolean; Form: TForm);
var
  k, j: integer; // в цикле должна быть именно локальная переменная
begin
  For k := 0 to Form.ComponentCount - 1 do
  begin
    if Form.components[k].Tag = 4 then
    begin
      for j:=0 to (Form.Components[k] as TMainMenu).Items.Count-1 do
        (Form.Components[k] as TMainMenu).Items[j].Enabled:=i;
      exit;
    end;
  end;
end;
end.
