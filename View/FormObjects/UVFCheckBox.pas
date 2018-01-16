unit UVFCheckBox;

interface

uses
  Graphics, StdCtrls, Forms, Classes, Controls;

type
  ICheckBoxTag5 = interface
    function GetCheckBox(Cleft, Ñtop, CWidth, CHeight,  FontSize: integer; CChecked: boolean; CCaption: string; CurrentForm: TForm): TCheckBox;
    function Checked: boolean;
    function CheckedString: String;
    procedure OnClick(ProcedureOnClick: TNotifyEvent);
  end;

  TCheckBoxTag5 = class(TInterfacedObject, ICheckBoxTag5)
  private
    TempCheckBox: TCheckBox;
  public
    function GetCheckBox(Cleft, Ñtop, CWidth, CHeight,  FontSize: integer; CChecked: boolean; CCaption: string; CurrentForm: TForm): TCheckBox;
    function Checked: boolean;
    function CheckedString: String;
    procedure OnClick(ProcedureOnClick: TNotifyEvent);
  end;

implementation

{ TTempLabelTag5 }

function TCheckBoxTag5.Checked: boolean;
begin
  Result:=TempCheckBox.Checked;
end;

function TCheckBoxTag5.CheckedString: String;
begin
  if TempCheckBox.Checked then result:='true' else result:='false';
end;

function TCheckBoxTag5.GetCheckBox(Cleft, Ñtop, CWidth, CHeight,  FontSize: integer; CChecked: boolean; CCaption: string; CurrentForm: TForm): TCheckBox;
begin
  if not Assigned(TempCheckBox) then
    TempCheckBox := TCheckBox.create(CurrentForm);
  TempCheckBox.parent := CurrentForm;
  with TempCheckBox do
  begin
    left := Cleft;
    top := Ñtop;
    Width := CWidth;
    Height:=CHeight;
    Font.Size := FontSize;
    Font.name := 'Times New Roman';
    Checked := CChecked;
    Caption := CCaption;
    WordWrap := True;
    Tag := 5;
    name:='CheckBox';
  end;
  result := TempCheckBox;
end;
procedure TCheckBoxTag5.OnClick(ProcedureOnClick: TNotifyEvent);
begin
  TempCheckBox.OnClick:=ProcedureOnClick;
end;
end.
