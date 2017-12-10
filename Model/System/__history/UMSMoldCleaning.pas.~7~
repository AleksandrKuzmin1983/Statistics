unit UMSMoldCleaning;

interface

Uses
  Forms;

type
  TMSMoldCleaning = class
  public
    constructor Create(Form: TForm);
  end;

implementation

{ TMSMoldCleaning }

// Удаляем с формы все компоненты с тагом 5

constructor TMSMoldCleaning.Create(Form: TForm);
var
  TempVar: integer; // в цикле должна быть именно локальная переменная
begin
  For TempVar := Form.ComponentCount - 1 downto 1 do
  begin
    if Form.components[TempVar].Tag = 5 then
    begin
      Form.components[TempVar].Free;
      continue;
    end;
  end;
end;

end.
