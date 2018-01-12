unit UVFBitBtnEdit;

interface

uses
  SysUtils, Classes, Forms, Buttons;

type
  IBitBtnEditTag5 = interface
    function GetBitBtnEdit(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    function GetCaption: String;
    procedure ChangeEnabled(i: Boolean);
    procedure ChangeCaption(Caption: string);
    procedure destroy;
  end;

  TBitBtnEditTag5 = class(TInterfacedObject, IBitBtnEditTag5)
  private
    TempBitBtnEdit: TBitBtn;
  public
    function GetBitBtnEdit(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    function GetCaption: String;
    procedure ChangeEnabled(i: Boolean);
    procedure ChangeCaption(Caption: string);
    procedure destroy;
  end;
implementation

{TTempLabelTag5}

procedure TBitBtnEditTag5.ChangeCaption(Caption: string);
begin
  TempBitBtnEdit.Caption:=Caption;
end;

procedure TBitBtnEditTag5.ChangeEnabled(i: Boolean);
begin
  TempBitBtnEdit.Enabled:=i;
end;

procedure TBitBtnEditTag5.destroy;
begin
  if Assigned(TempBitBtnEdit) then
    FreeAndNil(TempBitBtnEdit);
end;

function TBitBtnEditTag5.GetBitBtnEdit(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnEdit) then
  begin
    TempBitBtnEdit := TBitBtn.create(CurrentForm);
    TempBitBtnEdit.parent := CurrentForm;
    with TempBitBtnEdit do
    begin
      if CLeft=0 then left:=650 else left:=CLeft;
      if CTop=0 then Top:=130 else Top:=CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := 'Изменить';
      Width := 200;
      Height:=30;
      Tag := 5;
      Enabled:=False;
      OnClick:=ProcedureOnClick;
    end;
  end;
  result := TempBitBtnEdit;
end;
function TBitBtnEditTag5.GetCaption: String;
begin
  Result:=TempBitBtnEdit.Caption;
end;

end.
