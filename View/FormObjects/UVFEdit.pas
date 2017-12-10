unit UVFEdit;

interface

uses
  Graphics, StdCtrls, Forms, Classes, Controls;

type
  IEditTag5 = interface
    function GetEdit(Cleft, �top, CWidth, FontSize: integer; �ReadOnly: boolean; CurrentForm: TForm): TEdit;
    function ReadText: String;
    procedure WriteText(Text: String);
    procedure NumberOnly(i: Boolean);
  end;

  TEditTag5 = class(TInterfacedObject, IEditTag5)
  private
    TempEdit: TEdit;
  public
    function GetEdit(Cleft, �top, CWidth, FontSize: integer; �ReadOnly: boolean; CurrentForm: TForm): TEdit;
    function ReadText: String;
    procedure WriteText(Text: String);
    procedure NumberOnly(i: Boolean);
  end;

implementation

{ TTempLabelTag5 }

function TEditTag5.GetEdit(Cleft, �top, CWidth, FontSize: integer; �ReadOnly: boolean; CurrentForm: TForm): TEdit;
begin
  if not Assigned(TempEdit) then
    TempEdit := TEdit.create(CurrentForm);
  TempEdit.parent := CurrentForm;
  with TempEdit do
  begin
    left := Cleft;
    top := �top;
    Width := CWidth;
    Font.Size := FontSize;
    Font.name := 'Times New Roman';
    Font.Style:=[fsbold];
    Alignment := taRightJustify;
    �ReadOnly := true;
    Text := '0';
    Tag := 5;
  end;
  result := TempEdit;
end;


procedure TEditTag5.NumberOnly(i: Boolean);
begin
  TempEdit.NumbersOnly:=i;
end;

function TEditTag5.ReadText: String;
begin
  Result:=TempEdit.Text;
end;

procedure TEditTag5.WriteText(Text: String);
begin
  TempEdit.Text:=Text;
end;

end.
