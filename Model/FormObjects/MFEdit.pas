unit MFEdit;

interface

uses
  SysUtils, Graphics, StdCtrls, Forms, Classes, Controls;

type
  IMFEdit = interface
    function GetEdit(Cleft, Ñtop, CWidth, FontSize: integer; ÑReadOnly: boolean;
      CurrentForm: TForm): TEdit;
    function ReadText: String;
    procedure WriteText(Text: String);
    procedure NumberOnly(i: boolean);
    procedure Enabled(i: boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TMFEdit = class // (TInterfacedObject, IEditTag5)
  private
    TempEdit: TEdit;
  public
    function GetEdit(Cleft, Ñtop, CWidth, FontSize: integer; ÑReadOnly: boolean;
      CurrentForm: TForm): TEdit;
    function ReadText: String;
    procedure WriteText(Text: String);
    procedure NumberOnly(i: boolean);
    procedure Enabled(i: boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFEdit.destroy;
begin
  if Assigned(TempEdit) then
    FreeAndNil(TempEdit);
end;

procedure TMFEdit.Enabled(i: boolean);
begin
  TempEdit.Enabled := i;
end;

function TMFEdit.GetEdit(Cleft, Ñtop, CWidth, FontSize: integer;
  ÑReadOnly: boolean; CurrentForm: TForm): TEdit;
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
    Font.Style := [fsbold];
    Alignment := taRightJustify;
    ReadOnly := ÑReadOnly;
    Text := '0';
    Tag := 5;
    Visible := false;
  end;
  result := TempEdit;
end;

procedure TMFEdit.NumberOnly(i: boolean);
begin
  TempEdit.NumbersOnly := i;
end;

function TMFEdit.ReadText: String;
begin
  result := TempEdit.Text;
end;

procedure TMFEdit.Visible(i: boolean);
begin
  TempEdit.Visible := i;
end;

procedure TMFEdit.WriteText(Text: String);
begin
  TempEdit.Text := Text;
end;

end.
