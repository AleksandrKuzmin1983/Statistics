unit MFBitBtnEdit;

interface

uses
  SysUtils, Classes, Forms, CodeSiteLogging, dialogs, Buttons;

type
  IMFBitBtnEdit = interface
    function GetBitBtnEdit(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent;
      CurrentForm: TForm): TBitBtn;
    function GetTag: Integer;
    procedure ChangeEnabled(i: Boolean);
    procedure ChangeGlyph;
    procedure ChangeTag(CurrTag: Integer);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

  TMFBitBtnEdit = class(TInterfacedObject, IMFBitBtnEdit)
  private
    TempBitBtnEdit: TBitBtn;
    CurrentDir: String;
    function GetCurrentDir: string;
  public
    function GetBitBtnEdit(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent;
      CurrentForm: TForm): TBitBtn;
    function GetTag: Integer;
    procedure ChangeEnabled(i: Boolean);
    procedure ChangeGlyph;
    procedure ChangeTag(CurrTag: Integer);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

function TMFBitBtnEdit.GetCurrentDir: string;
begin
  Result := ExtractFileDir(ExtractFileDir(ParamStr(0))) + '\Systems\Img\';
end;

procedure TMFBitBtnEdit.ChangeGlyph;
begin
  CurrentDir := GetCurrentDir;
  if TempBitBtnEdit.Tag=1 then
    TempBitBtnEdit.Glyph.LoadFromFile(CurrentDir + 'BitBtnEdit1.bmp');
  if TempBitBtnEdit.Tag=2 then
    TempBitBtnEdit.Glyph.LoadFromFile(CurrentDir + 'BitBtnEdit2.bmp');
  if (TempBitBtnEdit.Tag<>1) and (TempBitBtnEdit.Tag<>2) then
    ShowMessage('Пришло не правлильное значение Tag!');

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.ChangeGlyph выполнена', CurrentDir);
end;

procedure TMFBitBtnEdit.ChangeTag(CurrTag: Integer);
begin
  TempBitBtnEdit.Tag:=CurrTag;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.ChangeTag выполнена', CurrTag);
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
    CurrentDir := GetCurrentDir;
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
      Width := 200;
      Height := 30;
      Tag := 1;
      Enabled := False;
      OnClick := ProcedureOnClick;
      NumGlyphs:=3;
      Glyph.LoadFromFile(CurrentDir +
        'BitBtnEdit1.bmp');
      Visible := False;
    end;
  end;
  result := TempBitBtnEdit;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.GetBitBtnEdit выполнена');
end;

function TMFBitBtnEdit.GetTag: Integer;
begin
  result := TempBitBtnEdit.Tag;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.GetCaption выполнена', result);
end;

procedure TMFBitBtnEdit.Visible(i: Boolean);
begin
  TempBitBtnEdit.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnEdit.Visible выполнена', i);
end;

end.
