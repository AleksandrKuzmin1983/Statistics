unit USMoldCleaning;

interface

Uses
  Forms, SysUtils, Dialogs;

type
  IMSMoldCleaning = interface
    procedure CleanForm(Form: TForm);
  end;

  TMSMoldCleaning = class(TInterfacedObject, IMSMoldCleaning)
  public
    procedure CleanForm(Form: TForm);
    // constructor Create(Form: TForm);
  end;

implementation

{ TMSMoldCleaning }

// Удаляем с формы все компоненты с тагом 5

{ constructor TMSMoldCleaning.Create(Form: TForm);
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
}
{ TMSMoldCleaning }

procedure TMSMoldCleaning.CleanForm(Form: TForm);
var
  TempVar: integer; // в цикле должна быть именно локальная переменная
  TempObj: TObject;
begin
  // ShowMessage('Всего элементов - ' + IntToStr(Form.ComponentCount-1));
  For TempVar := Form.ComponentCount - 1 downto 34 do
  begin
    // ShowMessage(Form.components[TempVar].Name + ' - ' + IntToStr(TempVar));
    // ShowMessage(IntToStr(Form.components[TempVar].Tag) + ' - ' + IntToStr(TempVar));
    if Form.components[TempVar].Tag = 5 then
    begin
      try
        TempObj := Form.components[TempVar];
        // ShowMessage('Трай ' + Form.components[TempVar].Name + ' - ' + IntToStr(TempVar));
        FreeAndNil(TempObj);
        // Form.components[TempVar].Free;
        // ShowMessage('Уничтожен ' + Form.components[TempVar].Name + ' - ' + IntToStr(TempVar));
        continue;
      except
        showmessage('Не смог удалить компонент с номером ' + Form.components
          [TempVar].Name + ' ' + IntToStr(TempVar));
      end;
    end;
  end;
end;

end.
