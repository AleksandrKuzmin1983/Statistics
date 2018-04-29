unit MFBitBtnBlock;

interface

uses
  SysUtils, Classes, Forms, CodeSiteLogging, Dialogs, Buttons;

type
  IMFBitBtnBlock = interface
    function GetBitBtnBlock(CLeft, CTop: integer;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
   procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure ChangeGlyph;
    procedure ChangeTag(CurrTag: Integer);
    function GetTag: Integer;
    procedure destroy;
  end;

  TMFBitBtnBlock = class(TInterfacedObject, IMFBitBtnBlock)
  private
    TempBitBtnBlock: TBitBtn;
    CurrentDir: String;
    function GetCurrentDir: string;
  public
    function GetBitBtnBlock(CLeft, CTop: integer;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure ChangeGlyph;
    procedure ChangeTag(CurrTag: Integer);
    function GetTag: Integer;
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

function TMFBitBtnBlock.GetCurrentDir: string;
begin
  Result := ExtractFileDir(ExtractFileDir(ParamStr(0))) + '\Systems\Img\';
end;


procedure TMFBitBtnBlock.Visible(i: Boolean);
begin
  TempBitBtnBlock.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnBlock.Visible выполнена', i);
end;

procedure TMFBitBtnBlock.ChangeEnabled(i: Boolean);
begin
  TempBitBtnBlock.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnBlock.ChangeEnabled выполнена', i);
end;

procedure TMFBitBtnBlock.destroy;
begin
  if Assigned(TempBitBtnBlock) then
    FreeAndNil(TempBitBtnBlock);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnBlock.destroy выполнена');
end;

function TMFBitBtnBlock.GetBitBtnBlock(CLeft, CTop: integer;
  ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnBlock) then
  begin
    TempBitBtnBlock := TBitBtn.create(CurrentForm);
    TempBitBtnBlock.parent := CurrentForm;
    CurrentDir := GetCurrentDir;
    with TempBitBtnBlock do
    begin
      if CLeft = 0 then
        left := 650
      else
        left := CLeft;
      if CTop = 0 then
        Top := 230
      else
        Top := CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Width := 200;
      Height := 30;
      NumGlyphs:=3;
      Glyph.LoadFromFile(CurrentDir +
        'BitBtnBlock1.bmp');
      Tag := 1;
      OnClick := ProcedureOnClick;
      Visible := False;
    end;
  end;
  Result := TempBitBtnBlock;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnBlock.GetBitBtnBlock выполнена');
end;

procedure TMFBitBtnBlock.ChangeGlyph;
begin
  CurrentDir := GetCurrentDir;
  if TempBitBtnBlock.Tag=1 then
    TempBitBtnBlock.Glyph.LoadFromFile(CurrentDir + 'BitBtnBlock1.bmp');
  if TempBitBtnBlock.Tag=2 then
    TempBitBtnBlock.Glyph.LoadFromFile(CurrentDir + 'BitBtnBlock2.bmp');
  if (TempBitBtnBlock.Tag<>1) and (TempBitBtnBlock.Tag<>2) then
    ShowMessage('Пришло не правлильное значение Tag!');

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnBlock.ChangeGlyph выполнена', CurrentDir);
end;

procedure TMFBitBtnBlock.ChangeTag(CurrTag: Integer);
begin
  TempBitBtnBlock.Tag:=CurrTag;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnBlock.ChangeTag выполнена', CurrTag);
end;

function TMFBitBtnBlock.GetTag: Integer;
begin
  result := TempBitBtnBlock.Tag;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnBlock.GetTag выполнена', result);
end;
end.
