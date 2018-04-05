unit MFLabel;

interface

uses
  SysUtils, StdCtrls, CodeSiteLogging, Forms;

type
  IMFLabel = interface
    function GetTempLabel(CLeft, CTop: integer; FontSize: integer;
      CCaption: string; CurrentForm: TForm): TLabel;
    procedure Width(i: integer);
    procedure WordWrap(i: boolean);
    procedure Height(i: integer);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TMFLabel = class(TInterfacedObject, IMFLabel)
  private
    TempLabel: TLabel;
  public
    function GetTempLabel(CLeft, CTop: integer; FontSize: integer;
      CCaption: String; CurrentForm: TForm): TLabel;
    procedure Width(i: integer);
    procedure WordWrap(i: boolean);
    procedure Height(i: integer);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFLabel.destroy;
begin
  if Assigned(TempLabel) then
    FreeAndNil(TempLabel);

   CodeSite.Send(FormatDateTime('c', Now) + ' TMFLabel.destroy выполнена');
end;

function TMFLabel.GetTempLabel(CLeft, CTop, FontSize: integer; CCaption: String;
  CurrentForm: TForm): TLabel;
begin
  if not Assigned(TempLabel) then
    TempLabel := TLabel.create(CurrentForm);
  TempLabel.parent := CurrentForm;
  with TempLabel do
  begin
    left := CLeft;
    top := CTop;
    Font.Size := FontSize;
    Caption := CCaption;
    Font.name := 'Times New Roman';
    Tag := 5;
    Visible := False;
  end;
  result := TempLabel;

   CodeSite.Send(FormatDateTime('c', Now) + ' TMFLabel.GetTempLabel выполнена', result);
end;

procedure TMFLabel.Height(i: integer);
begin
  TempLabel.Height := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFLabel.Height выполнена', i);
end;

procedure TMFLabel.Visible(i: boolean);
begin
  TempLabel.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFLabel.Visible выполнена', i);
end;

procedure TMFLabel.Width(i: integer);
begin
  TempLabel.Width := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFLabel.Width выполнена', i);
end;

procedure TMFLabel.WordWrap(i: boolean);
begin
  TempLabel.WordWrap := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFLabel.WordWrap выполнена', i);
end;

end.
