unit UVFBitBtn;

interface

uses
  Classes, DateUtils, SysUtils, Vcl.ComCtrls, Forms, Buttons;

type
  IBitBtnTag5 = interface
    function GetBitBtn(ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
  end;

  TBitBtnTag5 = class(TInterfacedObject, IBitBtnTag5)
  private
    TempBitBtn: TBitBtn;
  public
    function GetBitBtn(ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
  end;

implementation

{ TTempLabelTag5 }


function TBitBtnTag5.GetBitBtn(ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtn) then
  begin
    TempBitBtn := TBitBtn.create(CurrentForm);
    TempBitBtn.parent := CurrentForm;
    with TempBitBtn do
    begin
      left := 385;
      top := 510;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := '������������';
      Width := 150;
      Height:=30;
      Tag := 5;
      OnClick:=ProcedureOnClick;
    end;
  end;
  result := TempBitBtn;
end;

end.
