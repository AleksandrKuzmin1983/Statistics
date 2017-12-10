unit UVFBitBtnBlock;

interface

uses
  Classes, Forms, Buttons;

type
  IBitBtnBlockTag5 = interface
    function GetBitBtnBlock(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeCaption(i: Boolean);
    function GetCaption: Boolean;
    procedure ChangeEnabled(i: Boolean);
  end;

  TBitBtnBlockTag5 = class(TInterfacedObject, IBitBtnBlockTag5)
  private
    TempBitBtnBlock: TBitBtn;
  public
    function GetBitBtnBlock(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeCaption(i: Boolean);
    function GetCaption: Boolean;
    procedure ChangeEnabled(i: Boolean);
  end;

implementation

{ TTempLabelTag5 }


function TBitBtnBlockTag5.GetCaption: Boolean;
begin
  if TempBitBtnBlock.Caption='Разблокировать'
    then Result:=True
      else Result:=False;
end;

procedure TBitBtnBlockTag5.ChangeCaption(i: Boolean);
begin
  if i then TempBitBtnBlock.Caption:='Заблокировать'
    else TempBitBtnBlock.Caption:='Разблокировать'
end;

procedure TBitBtnBlockTag5.ChangeEnabled(i: Boolean);
begin
  TempBitBtnBlock.Enabled:=i;
end;

function TBitBtnBlockTag5.GetBitBtnBlock(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnBlock) then
  begin
    TempBitBtnBlock := TBitBtn.create(CurrentForm);
    TempBitBtnBlock.parent := CurrentForm;
    with TempBitBtnBlock do
    begin
      if CLeft=0 then left:=700 else left:=CLeft;
      if CTop=0 then Top:=230 else Top:=CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := 'Разблокировать';
      Width := 150;
      Height:=30;
      Tag := 5;
      OnClick:=ProcedureOnClick;
    end;
  end;
  result := TempBitBtnBlock;
end;
end.
