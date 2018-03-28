unit MFComboBox;

interface

uses
  Messages, SysUtils, Dialogs, Graphics, StdCtrls, Forms, Classes, Controls,
  Data.Win.ADODB, Variants,
  USContentOfTheList;

type
  IMFComboBox = interface
    function GetComboBox(CName: String; Cleft, Ñtop, CWidth, FontSize: integer;
      CurrentForm: TForm): TComboBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure Clear;
    procedure GetOnChange(ProcedureOnChange: TNotifyEvent);
    procedure GetDROPPEDWIDTH(DWIDTH: integer);
    procedure TheContentOfTheList(SQL: String);
    procedure GetListOfTheNameColumns(SQL: String);
    procedure WriteText(Text: String);
    procedure WriteItemIndex(i: integer);
    procedure Visible(i: Boolean);
    procedure DeleteRecord(i: integer);
    procedure AddItem(Text: String);
    procedure destroy;
  end;

  TMFComboBox = class(TInterfacedObject, IMFComboBox)
  private
    ContentOfTheList: TUSContentOfTheList;
    TempComboBox: TComboBox;
    DROPPEDWIDTH: integer;
    procedure WidthDropDownList(Sender: TObject);
  public
    function GetComboBox(CName: String; Cleft, Ñtop, CWidth, FontSize: integer;
      CurrentForm: TForm): TComboBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure Clear;
    procedure GetOnChange(ProcedureOnChange: TNotifyEvent);
    procedure GetDROPPEDWIDTH(DWIDTH: integer);
    procedure TheContentOfTheList(SQL: String);
    procedure GetListOfTheNameColumns(SQL: String);
    procedure WriteText(Text: String);
    procedure WriteItemIndex(i: integer);
    procedure Visible(i: Boolean);
    procedure DeleteRecord(i: integer);
    procedure AddItem(Text: String);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFComboBox.Clear;
begin
  TempComboBox.Clear;
end;

procedure TMFComboBox.DeleteRecord(i: integer);
begin
  TempComboBox.Items.Delete(i);
end;

procedure TMFComboBox.destroy;
begin
  // if Assigned(ContentOfTheList) then
  // FreeAndNil(ContentOfTheList);
  ContentOfTheList := nil;
  if Assigned(TempComboBox) then
    FreeAndNil(TempComboBox);
end;

procedure TMFComboBox.Enabled(i: Boolean);
begin
  TempComboBox.Enabled := i;
end;

function TMFComboBox.GetComboBox(CName: String;
  Cleft, Ñtop, CWidth, FontSize: integer; CurrentForm: TForm): TComboBox;
begin
  if not Assigned(TempComboBox) then
    TempComboBox := TComboBox.create(CurrentForm);
  TempComboBox.parent := CurrentForm;
  with TempComboBox do
  begin
    left := Cleft;
    top := Ñtop;
    Width := CWidth;
    Font.Size := FontSize;
    ItemHeight := FontSize + 8;
    OnDropDown := WidthDropDownList;
    Font.name := 'Times New Roman';
    Style := csOwnerDrawFixed;
    Tag := 5;
    Name := CName;
    Visible := False;
  end;
  result := TempComboBox;
end;

procedure TMFComboBox.GetDROPPEDWIDTH(DWIDTH: integer);
begin
  DROPPEDWIDTH := DWIDTH;
end;

function TMFComboBox.GetItemIndex: integer;
begin
  result := TempComboBox.ItemIndex;
end;

function TMFComboBox.GetItemsCount: integer;
begin
  result := TempComboBox.Items.Count;
end;

function TMFComboBox.GetItemsValue(i: integer): String;
begin
  result := TempComboBox.Items[i];
end;

procedure TMFComboBox.GetListOfTheNameColumns(SQL: String);
var
  i: integer;
begin
  if not Assigned(ContentOfTheList) then
    ContentOfTheList := TUSContentOfTheList.create;
  ContentOfTheList.GetNameOfColumns(SQL);
  if ContentOfTheList.GetCount > 0 then
    for i := 1 to ContentOfTheList.GetCount do
    begin
      TempComboBox.Items.Add(ContentOfTheList.GetContentOfTheList(i - 1));
    end;
end;

procedure TMFComboBox.GetOnChange(ProcedureOnChange: TNotifyEvent);
begin
  TempComboBox.OnChange := ProcedureOnChange;
end;

procedure TMFComboBox.TheContentOfTheList(SQL: String);
var
  i: integer;
begin
  if not Assigned(ContentOfTheList) then
    ContentOfTheList := TUSContentOfTheList.create;
  ContentOfTheList.GetContent(SQL);
  if ContentOfTheList.GetCount > 0 then
    for i := 0 to ContentOfTheList.GetCount - 1 do
    begin
      TempComboBox.Items.Add(ContentOfTheList.GetContentOfTheList(i));
    end;
end;

procedure TMFComboBox.Visible(i: Boolean);
begin
  TempComboBox.Visible := i;
end;

procedure TMFComboBox.WidthDropDownList(Sender: TObject);
begin
  TempComboBox.Perform(CB_SETDROPPEDWIDTH, DROPPEDWIDTH, 0);
end;

procedure TMFComboBox.WriteItemIndex(i: integer);
begin
  TempComboBox.ItemIndex := i;
end;

procedure TMFComboBox.WriteText(Text: String);
begin
  TempComboBox.Text := Text;
end;

procedure TMFComboBox.AddItem(Text: String);
begin
  TempComboBox.Items.Add(Text);
end;

end.
