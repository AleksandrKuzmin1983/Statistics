unit MFEdit;

interface

uses
  SysUtils, CodeSiteLogging, Graphics, StdCtrls, Forms, Classes, Controls;

type
  IMFEdit = interface
    function GetEdit(Cleft, Сtop, CWidth, FontSize: integer; СReadOnly: boolean;
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
    function GetEdit(Cleft, Сtop, CWidth, FontSize: integer; СReadOnly: boolean;
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFEdit.destroy выполнена');
end;

procedure TMFEdit.Enabled(i: boolean);
begin
  TempEdit.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFEdit.Enabled выполнена', i);
end;

function TMFEdit.GetEdit(Cleft, Сtop, CWidth, FontSize: integer;
  СReadOnly: boolean; CurrentForm: TForm): TEdit;
begin
  if not Assigned(TempEdit) then
    TempEdit := TEdit.create(CurrentForm);
  TempEdit.parent := CurrentForm;
  with TempEdit do
  begin
    left := Cleft;
    top := Сtop;
    Width := CWidth;
    Font.Size := FontSize;
    Font.name := 'Times New Roman';
    Font.Style := [fsbold];
    Alignment := taRightJustify;
    ReadOnly := СReadOnly;
    Text := '0';
    Tag := 5;
    Visible := false;
  end;
  result := TempEdit;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFEdit.GetEdit выполнена', Result);
end;

procedure TMFEdit.NumberOnly(i: boolean);
begin
  TempEdit.NumbersOnly := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFEdit.NumberOnly выполнена', i);
end;

function TMFEdit.ReadText: String;
begin
  result := TempEdit.Text;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFEdit.ReadText выполнена', result);
end;

procedure TMFEdit.Visible(i: boolean);
begin
  TempEdit.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFEdit.Visible выполнена', i);
end;

procedure TMFEdit.WriteText(Text: String);
begin
  TempEdit.Text := Text;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFEdit.WriteText выполнена', text);
end;
end.
