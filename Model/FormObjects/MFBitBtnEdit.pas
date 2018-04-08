unit MFBitBtnEdit;

interface

uses
  SysUtils, Classes, Forms, CodeSiteLogging, Buttons;

type
  IMFBitBtnEdit = interface
    function GetBitBtnEdit(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent;
      CurrentForm: TForm): TBitBtn;
    function GetCaption: String;
    procedure ChangeEnabled(i: Boolean);
    procedure ChangeCaption(Caption: string);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

  TMFBitBtnEdit = class(TInterfacedObject, IMFBitBtnEdit)
  private
    TempBitBtnEdit: TBitBtn;
  public
    function GetBitBtnEdit(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent;
      CurrentForm: TForm): TBitBtn;
    function GetCaption: String;
    procedure ChangeEnabled(i: Boolean);
    procedure ChangeCaption(Caption: string);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFBitBtnEdit.ChangeCaption(Caption: string);
begin
  TempBitBtnEdit.Caption := Caption;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.ChangeCaption выполнена', Caption);
end;

procedure TMFBitBtnEdit.ChangeEnabled(i: Boolean);
begin
  TempBitBtnEdit.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.ChangeEnabled выполнена', i);
end;

procedure TMFBitBtnEdit.destroy;
begin
  if Assigned(TempBitBtnEdit) then
    FreeAndNil(TempBitBtnEdit);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.destroy выполнена');
end;

function TMFBitBtnEdit.GetBitBtnEdit(CLeft, CTop: integer;
  ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnEdit) then
  begin
    TempBitBtnEdit := TBitBtn.create(CurrentForm);
    TempBitBtnEdit.parent := CurrentForm;
    with TempBitBtnEdit do
    begin
      if CLeft = 0 then
        left := 650
      else
        left := CLeft;
      if CTop = 0 then
        Top := 130
      else
        Top := CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := 'Изменить';
      Width := 200;
      Height := 30;
      Tag := 5;
      Enabled := False;
      OnClick := ProcedureOnClick;
      name := 'BitBtnEdit';
      Visible := False;
    end;
  end;
  result := TempBitBtnEdit;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.GetBitBtnEdit выполнена');
end;

function TMFBitBtnEdit.GetCaption: String;
begin
  result := TempBitBtnEdit.Caption;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.GetCaption выполнена', result);
end;

procedure TMFBitBtnEdit.Visible(i: Boolean);
begin
  TempBitBtnEdit.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.Visible выполнена', i);
end;

end.
