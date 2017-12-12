unit UVFBitBtn;

interface

uses
  Classes, Forms, Buttons;

type
  IBitBtnTag5 = interface
    function GetBitBtn(CLeft, CTop: integer; CCaption: String; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
  end;

  TBitBtnTag5 = class(TInterfacedObject, IBitBtnTag5)
  private
    TempBitBtn: TBitBtn;
  public
    function GetBitBtn(CLeft, CTop: integer; CCaption: String; ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
  end;

implementation

{ TTempLabelTag5 }


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
      Font.Size := 14;
      Caption := CCaption;
      Width := 150;
      Height:=30;
      Tag := 5;
      OnClick:=ProcedureOnClick;
    end;
  end;
  result := TempBitBtn;
end;

end.
