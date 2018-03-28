unit MFBitBtnDelete;

interface

uses
  SysUtils, Classes, Forms, Buttons;

type
  IMFBitBtnDelete = interface
    function GetBitBtnDelete(CLeft, CTop: integer;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

  TMFBitBtnDelete = class(TInterfacedObject, IMFBitBtnDelete)
  private
    TempBitBtnDelete: TBitBtn;
  public
    function GetBitBtnDelete(CLeft, CTop: integer;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFBitBtnDelete.ChangeEnabled(i: Boolean);
begin
  TempBitBtnDelete.Enabled := i;
end;

procedure TMFBitBtnDelete.destroy;
begin
  if Assigned(TempBitBtnDelete) then
    FreeAndNil(TempBitBtnDelete);
end;

function TMFBitBtnDelete.GetBitBtnDelete(CLeft, CTop: integer;
  ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnDelete) then
  begin
    TempBitBtnDelete := TBitBtn.create(CurrentForm);
    TempBitBtnDelete.parent := CurrentForm;
    with TempBitBtnDelete do
    begin
      if CLeft = 0 then
        left := 650
      else
        left := CLeft;
      if CTop = 0 then
        Top := 180
      else
        Top := CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := 'Удалить';
      Width := 200;
      Height := 30;
      Tag := 5;
      Enabled := false;
      OnClick := ProcedureOnClick;
      name := 'BitBtnDelete';
      Visible := false;
    end;
  end;
  result := TempBitBtnDelete;
end;

procedure TMFBitBtnDelete.Visible(i: Boolean);
begin
  TempBitBtnDelete.Visible := i;
end;

end.
