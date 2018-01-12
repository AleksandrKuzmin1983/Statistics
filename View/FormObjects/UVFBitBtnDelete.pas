unit UVFBitBtnDelete;

interface

uses
  SysUtils, Classes, Forms, Buttons;

type
  IBitBtnDeleteTag5 = interface
    function GetBitBtnDelete(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure destroy;
  end;

  TBitBtnDeleteTag5 = class(TInterfacedObject, IBitBtnDeleteTag5)
  private
    TempBitBtnDelete: TBitBtn;
  public
    function GetBitBtnDelete(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }


procedure TBitBtnDeleteTag5.ChangeEnabled(i: Boolean);
begin
  TempBitBtnDelete.Enabled:=i;
end;

procedure TBitBtnDeleteTag5.destroy;
begin
  if Assigned(TempBitBtnDelete) then
    FreeAndNil(TempBitBtnDelete);
end;

function TBitBtnDeleteTag5.GetBitBtnDelete(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnDelete) then
  begin
    TempBitBtnDelete := TBitBtn.create(CurrentForm);
    TempBitBtnDelete.parent := CurrentForm;
    with TempBitBtnDelete do
    begin
      if CLeft=0 then left:=650 else left:=CLeft;
      if CTop=0 then Top:=180 else Top:=CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := 'Удалить';
      Width := 200;
      Height:=30;
      Tag := 5;
      Enabled:=false;
      OnClick:=ProcedureOnClick;
    end;
  end;
  result := TempBitBtnDelete;
end;
end.
