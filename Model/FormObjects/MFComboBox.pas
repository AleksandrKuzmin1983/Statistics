unit MFComboBox;

interface

uses
  Messages, SysUtils, Dialogs, Graphics, StdCtrls, Forms, Classes, CodeSiteLogging, Controls,
  Data.Win.ADODB, Variants,
  USContentOfTheList;

type
  IMFComboBox = interface
    function GetComboBox(CName: String; Cleft, �top, CWidth, FontSize: integer;
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
    function GetComboBox(CName: String; Cleft, �top, CWidth, FontSize: integer;
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.Clear ���������');
end;

procedure TMFComboBox.DeleteRecord(i: integer);
begin
  TempComboBox.Items.Delete(i);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.DeleteRecord ���������', i);
end;

procedure TMFComboBox.destroy;
begin
  ContentOfTheList := nil;
  if Assigned(TempComboBox) then
    FreeAndNil(TempComboBox);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.destroy ���������');
end;

procedure TMFComboBox.Enabled(i: Boolean);
begin
  TempComboBox.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.Enabled ���������', i);
end;

function TMFComboBox.GetComboBox(CName: String;
  Cleft, �top, CWidth, FontSize: integer; CurrentForm: TForm): TComboBox;
begin
  if not Assigned(TempComboBox) then
    TempComboBox := TComboBox.create(CurrentForm);
  TempComboBox.parent := CurrentForm;
  with TempComboBox do
  begin
    left := Cleft;
    top := �top;
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.GetComboBox ���������');
end;

procedure TMFComboBox.GetDROPPEDWIDTH(DWIDTH: integer);
begin
  DROPPEDWIDTH := DWIDTH;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.GetDROPPEDWIDTH ���������');
end;

function TMFComboBox.GetItemIndex: integer;
begin
  result := TempComboBox.ItemIndex;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.GetItemIndex ���������', result);
end;

function TMFComboBox.GetItemsCount: integer;
begin
  result := TempComboBox.Items.Count;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.GetItemsCount ���������', result);
end;

function TMFComboBox.GetItemsValue(i: integer): String;
begin
  result := TempComboBox.Items[i];

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.GetItemsValue ���������', result);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.GetListOfTheNameColumns ���������', SQL);
end;

procedure TMFComboBox.GetOnChange(ProcedureOnChange: TNotifyEvent);
begin
  TempComboBox.OnChange := ProcedureOnChange;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.Clear ���������');
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.GetOnChange ���������', SQL);
end;

procedure TMFComboBox.Visible(i: Boolean);
begin
  TempComboBox.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.Visible ���������', i);
end;

procedure TMFComboBox.WidthDropDownList(Sender: TObject);
begin
  TempComboBox.Perform(CB_SETDROPPEDWIDTH, DROPPEDWIDTH, 0);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.WidthDropDownList ���������');
end;

procedure TMFComboBox.WriteItemIndex(i: integer);
begin
  TempComboBox.ItemIndex := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.WriteItemIndex ���������', i);
end;

procedure TMFComboBox.WriteText(Text: String);
begin
  TempComboBox.Text := Text;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.WriteText ���������', Text);
end;

procedure TMFComboBox.AddItem(Text: String);
begin
  TempComboBox.Items.Add(Text);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFComboBox.AddItem ���������', Text);
end;
end.
