unit MFListBox;

interface

uses
  Messages, SysUtils, Dialogs, Graphics, StdCtrls, Forms, Classes, Controls,
  Data.Win.ADODB, Variants, DateUtils,
  USContentOfTheList;

type
  IListBoxTag5 = interface
    function GetListBox(Cleft, Ñtop, CWidth, CHeight, FontSize: integer; CurrentForm: TForm): TListBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure ContentListBox(Year: Word; Month: Word);
    function CheckSelected(i: integer): boolean;
    procedure SetSelected(i: integer; j: boolean);
    function GetNumberSelectedString: Integer;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TListBoxTag5 = class(TInterfacedObject, IListBoxTag5)
  private
    TempListBox: TListBox;
  public
    function GetListBox(Cleft, Ñtop, CWidth, CHeight, FontSize: integer; CurrentForm: TForm): TListBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure ContentListBox(Year: Word; Month: Word);
    function CheckSelected(i: integer): boolean;
    procedure SetSelected(i: integer; j: boolean);
    function GetNumberSelectedString: Integer;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TListBoxTag5.ContentListBox(Year: Word; Month: Word);
var
  i: integer;
begin
  TempListBox.Clear;
  for i := 1 to DaysInAMonth(Year, Month) do
  begin
    TempListBox.Items.Add(DateToStr(EncodeDate(Year,Month,i)));
  end;
end;

procedure TListBoxTag5.destroy;
begin
  if Assigned(TempListBox) then
    FreeAndNil(TempListBox);
end;

procedure TListBoxTag5.Enabled(i: Boolean);
begin
  TempListBox.Enabled:=i;
end;

function TListBoxTag5.GetListBox(Cleft, Ñtop, CWidth, CHeight, FontSize: integer; CurrentForm: TForm): TListBox;
begin
  if not Assigned(TempListBox) then
    TempListBox := TListBox.create(CurrentForm);
  TempListBox.parent := CurrentForm;
  with TempListBox do
  begin
    left := Cleft;
    top := Ñtop;
    Width := CWidth;
    Height:= CHeight;
    Font.Size := FontSize;
    ItemHeight := FontSize+8;
    Font.name := 'Times New Roman';
    Tag := 5;
    MultiSelect:=True;
    Visible:=False;
  end;
  result := TempListBox;
end;

function TListBoxTag5.GetNumberSelectedString: Integer;
var
  i: integer;
begin
  result:=0;
  for i := 0 to TempListBox.Items.Count-1 do
  begin
    if TempListBox.Selected[i] then result:=result+1;
  end;
end;

procedure TListBoxTag5.SetSelected(i: integer; j: boolean);
begin
  TempListBox.Selected[i]:=j;
end;

function TListBoxTag5.CheckSelected(i: integer): boolean;
begin
  Result:=TempListBox.Selected[i];
end;

function TListBoxTag5.GetItemIndex: integer;
begin
  Result:=TempListBox.ItemIndex;
end;

function TListBoxTag5.GetItemsCount: integer;
begin
  Result:=TempListBox.Items.Count;
end;

function TListBoxTag5.GetItemsValue(i: integer): String;
begin
  Result:=TempListBox.Items[i];
end;

procedure TListBoxTag5.Visible(i: boolean);
begin
  TempListBox.Visible:=i;
end;

end.
