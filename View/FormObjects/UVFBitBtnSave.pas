unit UVFBitBtnSave;

interface

uses
  Classes, Forms, Buttons;

type
  IBitBtnSaveTag5 = interface
    function GetBitBtnSave(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
  end;

  TBitBtnSaveTag5 = class(TInterfacedObject, IBitBtnSaveTag5)
  private
    TempBitBtnSave: TBitBtn;
  public
    function GetBitBtnSave(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
  end;
implementation

{TTempLabelTag5}

procedure TBitBtnSaveTag5.ChangeEnabled(i: Boolean);
begin
  TempBitBtnSave.Enabled:=i;
end;

function TBitBtnSaveTag5.GetBitBtnSave(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnSave) then
  begin
    TempBitBtnSave := TBitBtn.create(CurrentForm);
    TempBitBtnSave.parent := CurrentForm;
    with TempBitBtnSave do
    begin
      if CLeft=0 then left:=700 else left:=CLeft;
      if CTop=0 then Top:=130 else Top:=CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := '���������';
      Width := 150;
      Height:=30;
      Tag := 5;
      Enabled:=False;
      OnClick:=ProcedureOnClick;
    end;
  end;
  result := TempBitBtnSave;
end;
end.
