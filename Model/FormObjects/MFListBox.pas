unit MFListBox;

interface

uses
  Messages, SysUtils, Dialogs, Graphics, StdCtrls, Forms, Classes, Controls,
  Data.Win.ADODB, Variants, DateUtils,
  USContentOfTheList;

type
  IMFListBox = interface
    function GetListBox(Cleft, Ñtop, CWidth, CHeight, FontSize: integer;
      CurrentForm: TForm): TListBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure ContentListBox(Year: Word; Month: Word);
    function CheckSelected(i: integer): Boolean;
    procedure SetSelected(i: integer; j: Boolean);
    function GetNumberSelectedString: integer;
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

  TMFListBox = class(TInterfacedObject, IMFListBox)
  private
    TempListBox: TListBox;
  public
    function GetListBox(Cleft, Ñtop, CWidth, CHeight, FontSize: integer;
      CurrentForm: TForm): TListBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure ContentListBox(Year: Word; Month: Word);
    function CheckSelected(i: integer): Boolean;
    procedure SetSelected(i: integer; j: Boolean);
    function GetNumberSelectedString: integer;
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFListBox.ContentListBox(Year: Word; Month: Word);
var
  i: integer;
begin
  TempListBox.Clear;
  for i := 1 to DaysInAMonth(Year, Month) do
  begin
    TempListBox.Items.Add(DateToStr(EncodeDate(Year, Month, i)));
  end;
end;

procedure TMFListBox.destroy;
begin
  if Assigned(TempListBox) then
    FreeAndNil(TempListBox);
end;

procedure TMFListBox.Enabled(i: Boolean);
begin
  TempListBox.Enabled := i;
end;

function TMFListBox.GetListBox(Cleft, Ñtop, CWidth, CHeight, FontSize: integer;
  CurrentForm: TForm): TListBox;
begin
  if not Assigned(TempListBox) then
    TempListBox := TListBox.create(CurrentForm);
  TempListBox.parent := CurrentForm;
  with TempListBox do
  begin
    left := Cleft;
    top := Ñtop;
    Width := CWidth;
    Height := CHeight;
    Font.Size := FontSize;
    ItemHeight := FontSize + 8;
    Font.name := 'Times New Roman';
    Tag := 5;
    MultiSelect := True;
    Visible := False;
  end;
  result := TempListBox;
end;

function TMFListBox.GetNumberSelectedString: integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to TempListBox.Items.Count - 1 do
  begin
    if TempListBox.Selected[i] then
      result := result + 1;
  end;
end;

procedure TMFListBox.SetSelected(i: integer; j: Boolean);
begin
  TempListBox.Selected[i] := j;
end;

function TMFListBox.CheckSelected(i: integer): Boolean;
begin
  result := TempListBox.Selected[i];
end;

function TMFListBox.GetItemIndex: integer;
begin
  result := TempListBox.ItemIndex;
end;

function TMFListBox.GetItemsCount: integer;
begin
  result := TempListBox.Items.Count;
end;

function TMFListBox.GetItemsValue(i: integer): String;
begin
  result := TempListBox.Items[i];
end;

procedure TMFListBox.Visible(i: Boolean);
begin
  TempListBox.Visible := i;
end;

end.
