unit UVFComboBox;

interface

uses
  Messages, Dialogs, Graphics, StdCtrls, Forms, Classes, Controls, Data.Win.ADODB, Variants,
  UMSGContentOfTheList;

type
  IComboboxTag5 = interface
    function GetComboBox(Cleft, Ñtop, CWidth, FontSize: integer; CurrentForm: TForm): TComboBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure Clear;
    procedure GetOnChange(ProcedureOnChange: TNotifyEvent);
    procedure GetDROPPEDWIDTH(DWIDTH: Integer);
    procedure WriteText(Text: String);
    procedure TheContentOfTheList(SQL: String);
    procedure WriteItemIndex(i: integer);
  end;

  TComboboxTag5 = class(TInterfacedObject, IComboboxTag5)
  private
    ContentOfTheList: TContentOfTheList;
    TempComboBox: TComboBox;
    DROPPEDWIDTH: Integer;
    procedure WidthDropDownList(Sender: TObject);
  public
    function GetComboBox(Cleft, Ñtop, CWidth, FontSize: integer; CurrentForm: TForm): TComboBox;
    function GetItemsCount: integer;
    function GetItemIndex: integer;
    function GetItemsValue(i: integer): String;
    procedure Enabled(i: Boolean);
    procedure Clear;
    procedure GetOnChange(ProcedureOnChange: TNotifyEvent);
    procedure GetDROPPEDWIDTH(DWIDTH: Integer);
    procedure TheContentOfTheList(SQL: String);
    procedure WriteText(Text: String);
    procedure WriteItemIndex(i: integer);
  end;

implementation

{ TTempLabelTag5 }

procedure TComboboxTag5.Clear;
begin
  TempComboBox.Clear;
end;

procedure TComboboxTag5.Enabled(i: Boolean);
begin
  TempComboBox.Enabled:=i;
end;

function TComboboxTag5.GetComboBox(Cleft, Ñtop, CWidth, FontSize: integer; CurrentForm: TForm): TComboBox;
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
    for i:=1 to ContentOfTheList.GetCount do
    begin
      TempComboBox.Items.Add(ContentOfTheList.GetContentOfTheList(i));
    end;
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

end.
