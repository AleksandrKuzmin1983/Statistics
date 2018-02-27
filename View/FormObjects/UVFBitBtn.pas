unit UVFBitBtn;

interface

uses
  Classes, Forms, SysUtils, Buttons;

type
  IBitBtnTag5 = interface
    function GetBitBtn(CLeft, CTop: integer; CCaption: String; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TBitBtnTag5 = class(TInterfacedObject, IBitBtnTag5)
  private
    TempBitBtn: TBitBtn;
  public
    function GetBitBtn(CLeft, CTop: integer; CCaption: String; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }


procedure TBitBtnTag5.destroy;
begin
  if Assigned(TempBitBtn) then
    FreeAndNil(TempBitBtn);
end;

function TBitBtnTag5.GetBitBtn(CLeft, CTop: integer; CCaption: String; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtn) then
  begin
    TempBitBtn := TBitBtn.create(CurrentForm);
    TempBitBtn.parent := CurrentForm;
    with TempBitBtn do
    begin
      left := CLeft;
      top := CTop;
      Font.name := 'Times New Roman';
      Font.Size := 18;
      Caption := CCaption;
      Width := 200;
      Height:=50;
      Tag := 5;
      OnClick:=ProcedureOnClick;
      Visible:=False;
    end;
  end;
  result := TempBitBtn;
end;

procedure TBitBtnTag5.Visible(i: boolean);
begin
  TempBitBtn.Visible:=i;
end;

end.
