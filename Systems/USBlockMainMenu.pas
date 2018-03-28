unit USBlockMainMenu;

interface

Uses
  Menus, Forms;

type
  IUSBlockMainMenu = interface
    Procedure BlockMainMenu(i: Boolean; Form: TForm);
  end;

  TUSBlockMainMenu = class(TInterfacedObject, IUSBlockMainMenu)
  public
    Procedure BlockMainMenu(i: Boolean; Form: TForm);
  end;

implementation

{ TBlockMainMenu }

procedure TUSBlockMainMenu.BlockMainMenu(i: Boolean; Form: TForm);
var
  k, j: integer; // в цикле должна быть именно локальная переменная
begin
  For k := 0 to Form.ComponentCount - 1 do
  begin
    if Form.components[k].Tag = 4 then
    begin
      for j := 0 to (Form.components[k] as TMainMenu).Items.Count - 1 do
        (Form.components[k] as TMainMenu).Items[j].Enabled := i;
      exit;
    end;
  end;
end;

end.
