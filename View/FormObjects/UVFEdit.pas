unit UVFEdit;

interface

uses
  SysUtils, Graphics, StdCtrls, Forms, Classes, Controls;

type
  IEditTag5 = interface
    function GetEdit(Cleft, Ñtop, CWidth, FontSize: integer; ÑReadOnly: boolean; CurrentForm: TForm): TEdit;
    function ReadText: String;
    procedure WriteText(Text: String);
    procedure NumberOnly(i: Boolean);
    procedure Enabled(i: Boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TEditTag5 = class//(TInterfacedObject, IEditTag5)
  private
    TempEdit: TEdit;
  public
    function GetEdit(Cleft, Ñtop, CWidth, FontSize: integer; ÑReadOnly: boolean; CurrentForm: TForm): TEdit;
    function ReadText: String;
    procedure WriteText(Text: String);
    procedure NumberOnly(i: Boolean);
    procedure Enabled(i: Boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TEditTag5.destroy;
begin
  if Assigned(TempEdit) then
    FreeAndNil(TempEdit);
end;

procedure TEditTag5.Enabled(i: Boolean);
begin
  TempEdit.Enabled:=i;
end;

function TEditTag5.GetEdit(Cleft, Ñtop, CWidth, FontSize: integer; ÑReadOnly: boolean; CurrentForm: TForm): TEdit;
begin
  if not Assigned(TempEdit) then
    TempEdit := TEdit.create(CurrentForm);
  TempEdit.parent := CurrentForm;
  with TempEdit do
  begin
    left := Cleft;
    top := Ñtop;
    Width := CWidth;
    Font.Size := FontSize;
    Font.name := 'Times New Roman';
    Font.Style:=[fsbold];
    Alignment := taRightJustify;
    ReadOnly := ÑReadOnly;
    Text := '0';
    Tag := 5;
    Visible:=false;
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

procedure TEditTag5.Visible(i: boolean);
begin
  TempEdit.Visible:=i;
end;

procedure TEditTag5.WriteText(Text: String);
begin
  TempEdit.Text:=Text;
end;

end.
