unit MFBitBtn;

interface

uses
  Classes, Forms, SysUtils, CodeSiteLogging, Buttons;

type
  IMFBitBtn = interface
    function GetBitBtn(CLeft, CTop: integer;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TMFBitBtn = class(TInterfacedObject, IMFBitBtn)
  private
    TempBitBtn: TBitBtn;
  public
    function GetBitBtn(CLeft, CTop: integer;
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtn.destroy выполнена');
end;

function TMFBitBtn.GetBitBtn(CLeft, CTop: integer;
  ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
var
  CurrentDir: String;
begin
  if not Assigned(TempBitBtn) then
  begin
    TempBitBtn := TBitBtn.create(CurrentForm);
    TempBitBtn.parent := CurrentForm;
    CurrentDir := ExtractFileDir(ExtractFileDir(ParamStr(0)));
    with TempBitBtn do
    begin
      left := CLeft;
      top := CTop;
      Font.name := 'Times New Roman';
      Font.Size := 18;
      Width := 200;
      Height := 50;
      Tag := 5;
      OnClick := ProcedureOnClick;
      NumGlyphs:=3;
      Glyph.LoadFromFile(CurrentDir +
        '\Systems\Img\BitBtn.bmp');
      Visible := False;
    end;
  end;
  result := TempBitBtn;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtn.GetBitBtn выполнена');
end;

procedure TMFBitBtn.Visible(i: boolean);
begin
  TempBitBtn.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtn.Visible выполнена', i);
end;

end.
