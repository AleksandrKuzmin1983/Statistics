unit UVFBitBtnAdd;

interface

uses
  SysUtils, Classes, Forms, Buttons;

type
  IBitBtnAddTag5 = interface
    function GetBitBtnAdd(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TBitBtnAddTag5 = class(TInterfacedObject, IBitBtnAddTag5)
  private
    TempBitBtnAdd: TBitBtn;
  public
    function GetBitBtnAdd(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }


procedure TBitBtnAddTag5.ChangeEnabled(i: Boolean);
begin
  TempBitBtnAdd.Enabled:=i;
end;

procedure TBitBtnAddTag5.destroy;
begin
  if Assigned(TempBitBtnAdd) then
    FreeAndNil(TempBitBtnAdd);
end;

function TBitBtnAddTag5.GetBitBtnAdd(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnAdd) then
  begin
    TempBitBtnAdd := TBitBtn.create(CurrentForm);
    TempBitBtnAdd.parent := CurrentForm;
    with TempBitBtnAdd do
    begin
      if CLeft=0 then left:=650 else left:=CLeft;
      if CTop=0 then Top:=80 else Top:=CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := '��������';
      Width := 200;
      Height:=30;
      Tag := 5;
      Enabled:=false;
      OnClick:=ProcedureOnClick;
      name:='BitBtnAdd';
      Visible:=False;
    end;
  end;
  result := TempBitBtnAdd;
end;
procedure TBitBtnAddTag5.Visible(i: boolean);
begin
  TempBitBtnAdd.Visible:=i;
end;

end.
