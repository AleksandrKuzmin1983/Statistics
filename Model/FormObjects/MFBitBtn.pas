unit MFBitBtn;

interface

uses
  Classes, Forms, SysUtils, Buttons;

type
  IMFBitBtn = interface
    function GetBitBtn(CLeft, CTop: integer; CCaption: String;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TMFBitBtn = class(TInterfacedObject, IMFBitBtn)
  private
    TempBitBtn: TBitBtn;
  public
    function GetBitBtn(CLeft, CTop: integer; CCaption: String;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFBitBtn.destroy;
begin
  if Assigned(TempBitBtn) then
    FreeAndNil(TempBitBtn);
end;

function TMFBitBtn.GetBitBtn(CLeft, CTop: integer; CCaption: String;
  ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
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
      Height := 50;
      Tag := 5;
      OnClick := ProcedureOnClick;
      Visible := False;
    end;
  end;
  result := TempBitBtn;
end;

procedure TMFBitBtn.Visible(i: boolean);
begin
  TempBitBtn.Visible := i;
end;

end.
