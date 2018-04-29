unit MFBitBtnAdd;

interface

uses
  SysUtils, Classes, Forms, CodeSiteLogging, Buttons;

type
  IMFBitBtnAdd = interface
    function GetBitBtnAdd(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent;
      CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

  TMFBitBtnAdd = class(TInterfacedObject, IMFBitBtnAdd)
  private
    TempBitBtnAdd: TBitBtn;
  public
    function GetBitBtnAdd(CLeft, CTop: integer; ProcedureOnClick: TNotifyEvent;
      CurrentForm: TForm): TBitBtn;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFBitBtnAdd.ChangeEnabled(i: Boolean);
begin
  TempBitBtnAdd.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.ChangeEnabled выполнена', i);
end;

procedure TMFBitBtnAdd.destroy;
begin
  if Assigned(TempBitBtnAdd) then
    FreeAndNil(TempBitBtnAdd);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.destroy выполнена');
end;

function TMFBitBtnAdd.GetBitBtnAdd(CLeft, CTop: integer;
  ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
var
  CurrentDir: String;
begin
  if not Assigned(TempBitBtnAdd) then
  begin
    TempBitBtnAdd := TBitBtn.create(CurrentForm);
    TempBitBtnAdd.parent := CurrentForm;
    CurrentDir := ExtractFileDir(ExtractFileDir(ParamStr(0)));
    with TempBitBtnAdd do
    begin
      if CLeft = 0 then
        left := 650
      else
        left := CLeft;
      if CTop = 0 then
        Top := 80
      else
        Top := CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Width := 200;
      Height := 30;
      NumGlyphs:=3;
      Glyph.LoadFromFile(CurrentDir +
        '\Systems\Img\BitBtnAdd.bmp');
      Tag := 5;
      Enabled := false;
      OnClick := ProcedureOnClick;
      Visible := false;
    end;
  end;
  result := TempBitBtnAdd;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.GetBitBtnAdd выполнена');
end;

procedure TMFBitBtnAdd.Visible(i: Boolean);
begin
  TempBitBtnAdd.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.Visible выполнена', i);
end;

end.
