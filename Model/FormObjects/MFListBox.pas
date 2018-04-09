unit MFListBox;

interface

uses
  Messages, SysUtils, CodeSiteLogging, Dialogs, Graphics, StdCtrls, Forms, Classes, Controls,
  Data.Win.ADODB, Variants, DateUtils,
  USContentOfTheList;

type
  IMFListBox = interface
    function GetListBox(Cleft, Сtop, CWidth, CHeight, FontSize: integer;
      CurrentForm: TForm): TListBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure ContentListBox(Year: Word; Month: Word);
    function CheckSelected(i: integer): Boolean;
    procedure SetSelected(index: integer; value: Boolean);
    function GetNumberSelectedString: integer;
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

  TMFListBox = class(TInterfacedObject, IMFListBox)
  private
    TempListBox: TListBox;
  public
    function GetListBox(Cleft, Сtop, CWidth, CHeight, FontSize: integer;
      CurrentForm: TForm): TListBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure ContentListBox(Year: Word; Month: Word);
    function CheckSelected(i: integer): Boolean;
    procedure SetSelected(index: integer; value: Boolean);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.ContentListBox выполнена');
end;

procedure TMFListBox.destroy;
begin
  if Assigned(TempListBox) then
    FreeAndNil(TempListBox);

   CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.destroy выполнена');
end;

procedure TMFListBox.Enabled(i: Boolean);
begin
  TempListBox.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.Enabled выполнена', i);
end;

function TMFListBox.GetListBox(Cleft, Сtop, CWidth, CHeight, FontSize: integer;
  CurrentForm: TForm): TListBox;
begin
  if not Assigned(TempListBox) then
    TempListBox := TListBox.create(CurrentForm);
  TempListBox.parent := CurrentForm;
  with TempListBox do
  begin
    left := Cleft;
    top := Сtop;
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.GetListBox выполнена');
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.GetNumberSelectedString выполнена', result);
end;

procedure TMFListBox.SetSelected(index: integer; value: Boolean);
begin
  TempListBox.Selected[index] := value;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.SetSelected выполнена', index);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.SetSelected выполнена', value);
end;

function TMFListBox.CheckSelected(i: integer): Boolean;
begin
  result := TempListBox.Selected[i];

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.CheckSelected выполнена', result);
end;

function TMFListBox.GetItemIndex: integer;
begin
  result := TempListBox.ItemIndex;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.GetItemIndex выполнена', result);
end;

function TMFListBox.GetItemsCount: integer;
begin
  result := TempListBox.Items.Count;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.GetItemsCount выполнена', result);
end;

function TMFListBox.GetItemsValue(i: integer): String;
begin
  result := TempListBox.Items[i];

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.GetItemsValue выполнена', result);
end;

procedure TMFListBox.Visible(i: Boolean);
begin
  TempListBox.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFListBox.Visible выполнена', i);
end;

end.
