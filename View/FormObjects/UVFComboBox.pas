unit UVFComboBox;

interface

uses
  Messages, SysUtils, Dialogs, Graphics, StdCtrls, Forms, Classes, Controls, Data.Win.ADODB, Variants,
  UMSGContentOfTheList;

type
  IComboboxTag5 = interface
    function GetComboBox(CName: String; Cleft, Ñtop, CWidth, FontSize: integer; CurrentForm: TForm): TComboBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure Clear;
    procedure GetOnChange(ProcedureOnChange: TNotifyEvent);
    procedure GetDROPPEDWIDTH(DWIDTH: Integer);
    procedure TheContentOfTheList(SQL: String);
    procedure GetListOfTheNameColumns(SQL: String);
    procedure WriteText(Text: String);
    procedure WriteItemIndex(i: integer);
    procedure Visible(i: boolean);
    procedure DeleteRecord(i: integer);
    procedure AddItem(Text: String);
    procedure destroy;
  end;

  TComboboxTag5 = class(TInterfacedObject, IComboboxTag5)
  private
    ContentOfTheList: TContentOfTheList;
    TempComboBox: TComboBox;
    DROPPEDWIDTH: Integer;
    procedure WidthDropDownList(Sender: TObject);
  public
    function GetComboBox(CName: String; Cleft, Ñtop, CWidth, FontSize: integer; CurrentForm: TForm): TComboBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure Clear;
    procedure GetOnChange(ProcedureOnChange: TNotifyEvent);
    procedure GetDROPPEDWIDTH(DWIDTH: Integer);
    procedure TheContentOfTheList(SQL: String);
    procedure GetListOfTheNameColumns(SQL: String);
    procedure WriteText(Text: String);
    procedure WriteItemIndex(i: integer);
    procedure Visible(i: boolean);
    procedure DeleteRecord(i: integer);
    procedure AddItem(Text: String);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TComboboxTag5.Clear;
begin
  TempComboBox.Clear;
end;

procedure TComboboxTag5.DeleteRecord(i: integer);
begin
  TempComboBox.Items.Delete(i);
end;

procedure TComboboxTag5.destroy;
begin
//  if Assigned(ContentOfTheList) then
//    FreeAndNil(ContentOfTheList);
  ContentOfTheList:=nil;
  if Assigned(TempComboBox) then
    FreeAndNil(TempComboBox);
end;

procedure TComboboxTag5.Enabled(i: Boolean);
begin
  TempComboBox.Enabled:=i;
end;

function TComboboxTag5.GetComboBox(CName: String; Cleft, Ñtop, CWidth, FontSize: integer; CurrentForm: TForm): TComboBox;
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
    ItemHeight := FontSize+8;
    OnDropDown:=WidthDropDownList;
    Font.name := 'Times New Roman';
    Style:=csOwnerDrawFixed;
    Tag := 5;
    Name:=CName;
    Visible:= False;
  end;
  result := TempComboBox;
end;


procedure TComboboxTag5.GetDROPPEDWIDTH(DWIDTH: Integer);
begin
  DROPPEDWIDTH:=DWIDTH;
end;

function TComboboxTag5.GetItemIndex: integer;
begin
  Result:=TempComboBox.ItemIndex;
end;

function TComboboxTag5.GetItemsCount: integer;
begin
  Result:=TempComboBox.Items.Count;
end;

function TComboboxTag5.GetItemsValue(i: integer): String;
begin
  Result:=TempComboBox.Items[i];
end;

procedure TComboboxTag5.GetListOfTheNameColumns(SQL: String);
var
  i: integer;
begin
  if not Assigned(ContentOfTheList) then
    ContentOfTheList := TContentOfTheList.create;
  ContentOfTheList.GetNameOfColumns(SQL);
  if ContentOfTheList.GetCount>0 then
    for i:=1 to ContentOfTheList.GetCount do
    begin
      TempComboBox.Items.Add(ContentOfTheList.GetContentOfTheList(i-1));
    end;
end;

procedure TComboboxTag5.GetOnChange(ProcedureOnChange: TNotifyEvent);
begin
  TempComboBox.OnChange:=ProcedureOnChange;
end;

procedure TComboboxTag5.TheContentOfTheList(SQL: String);
var
  i: integer;
begin
  if not Assigned(ContentOfTheList) then
    ContentOfTheList := TContentOfTheList.create;
  ContentOfTheList.GetContent(SQL);
  if ContentOfTheList.GetCount>0 then
    for i:=0 to ContentOfTheList.GetCount-1 do
    begin
      TempComboBox.Items.Add(ContentOfTheList.GetContentOfTheList(i));
    end;
end;

procedure TComboboxTag5.Visible(i: boolean);
begin
  TempComboBox.Visible:=i;
end;

procedure TComboboxTag5.WidthDropDownList(Sender: TObject);
begin
    TempComboBox.Perform(CB_SETDROPPEDWIDTH, DROPPEDWIDTH, 0);
end;

procedure TComboboxTag5.WriteItemIndex(i: integer);
begin
  TempComboBox.ItemIndex:=i;
end;

procedure TComboboxTag5.WriteText(Text: String);
begin
  TempComboBox.Text:=Text;
end;

procedure TComboboxTag5.AddItem(Text: String);
begin
  TempComboBox.Items.Add(Text);
end;

end.
