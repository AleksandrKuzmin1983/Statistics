unit MFCheckBox;

interface

uses
  Graphics, SysUtils, StdCtrls, Forms, Classes, Controls;

type
  ICheckBoxTag5 = interface
    function GetCheckBox(Cleft, Ñtop, CWidth, CHeight,  FontSize: integer; CChecked: boolean; CCaption: string; CurrentForm: TForm): TCheckBox;
    function GetChecked: boolean;
    function CheckedString: String;
    procedure WriteChecked(i: boolean);
    procedure OnClick(ProcedureOnClick: TNotifyEvent);
    procedure Enabled(i: boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TCheckBoxTag5 = class(TInterfacedObject, ICheckBoxTag5)
  private
    TempCheckBox: TCheckBox;
  public
    function GetCheckBox(Cleft, Ñtop, CWidth, CHeight,  FontSize: integer; CChecked: boolean; CCaption: string; CurrentForm: TForm): TCheckBox;
    function GetChecked: boolean;
    function CheckedString: String;
    procedure WriteChecked(i: boolean);
    procedure OnClick(ProcedureOnClick: TNotifyEvent);
    procedure Enabled(i: boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

function TCheckBoxTag5.GetChecked: boolean;
begin
  Result:=TempCheckBox.Checked;
end;

function TCheckBoxTag5.CheckedString: String;
begin
  if TempCheckBox.Checked then result:='true' else result:='false';
end;

procedure TCheckBoxTag5.destroy;
begin
  if Assigned(TempCheckBox) then
     FreeAndNil(TempCheckBox);
end;

procedure TCheckBoxTag5.Enabled(i: boolean);
begin
  TempCheckBox.Enabled:=i;
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
    Visible:=False;
  end;
  result := TempCheckBox;
end;

procedure TCheckBoxTag5.OnClick(ProcedureOnClick: TNotifyEvent);
begin
  TempCheckBox.OnClick:=ProcedureOnClick;
end;
procedure TCheckBoxTag5.Visible(i: boolean);
begin
  TempCheckBox.Visible:=i;
end;

procedure TCheckBoxTag5.WriteChecked(i: boolean);
begin
  TempCheckBox.Checked:=i;
end;

end.
