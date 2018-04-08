unit MFBitBtnSave;

interface

uses
  Classes, Forms, CodeSiteLogging, SysUtils, Buttons;

type
  IMFBitBtnSave = interface
    function GetBitBtnSave(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent;
      CurrentForm: TForm): TBitBtn;
    procedure Visible(i: boolean);
    procedure ChangeEnabled(i: boolean);
  end;

  TMFBitBtnSave = class(TInterfacedObject, IMFBitBtnSave)
  private
    TempBitBtnSave: TBitBtn;
  public
    function GetBitBtnSave(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent;
      CurrentForm: TForm): TBitBtn;
    procedure Visible(i: boolean);
    procedure ChangeEnabled(i: boolean);
  end;

implementation

{ TTempLabelTag5 }

procedure TMFBitBtnSave.ChangeEnabled(i: boolean);
begin
  TempBitBtnSave.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnSave.ChangeEnabled выполнена', i);
end;

function TMFBitBtnSave.GetBitBtnSave(CLeft, CTop: integer;
  ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnSave) then
  begin
    TempBitBtnSave := TBitBtn.create(CurrentForm);
    TempBitBtnSave.parent := CurrentForm;
    with TempBitBtnSave do
    begin
      if CLeft = 0 then
        left := 650
      else
        left := CLeft;
      if CTop = 0 then
        Top := 120
      else
        Top := CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := 'Сохранить';
      Width := 200;
      Height := 30;
      Tag := 5;
      Enabled := False;
      OnClick := ProcedureOnClick;
      name := 'BitBtnSave';
      Visible := False;
    end;
  end;
  result := TempBitBtnSave;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnSave.GetBitBtnSave выполнена');
end;

procedure TMFBitBtnSave.Visible(i: boolean);
begin
  TempBitBtnSave.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnSave.Visible выполнена', i);
end;
end.
