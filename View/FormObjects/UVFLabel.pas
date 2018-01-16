unit UVFLabel;

interface

uses
  SysUtils, StdCtrls, Forms ;

type
  ITempLabelTag5 = interface
    function GetTempLabel(CLeft, CTop: integer; FontSize: integer;
      CCaption: string; CurrentForm: TForm): TLabel;
    procedure Width(i: integer);
    procedure WordWrap(i: boolean);
    procedure Height(i: integer);
    procedure Visible(i: boolean);
    procedure destroy;
  end;


  TTempLabelTag5 = class(TInterfacedObject, ITempLabelTag5)
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

procedure TTempLabelTag5.destroy;
begin
  if Assigned(TempLabel) then
    FreeAndNil(TempLabel);
end;

function TTempLabelTag5.GetTempLabel(CLeft, CTop, FontSize: integer;
  CCaption: String; CurrentForm: TForm): TLabel;
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
  end;
  result:=TempLabel;
end;

procedure TTempLabelTag5.Height(i: integer);
begin
  TempLabel.Height:=i;
end;

procedure TTempLabelTag5.Visible(i: boolean);
begin
  TempLabel.Visible:=i;
end;

procedure TTempLabelTag5.Width(i: integer);
begin
  TempLabel.Width:=i;
end;
procedure TTempLabelTag5.WordWrap(i: boolean);
begin
  TempLabel.WordWrap:=i;
end;

end.
