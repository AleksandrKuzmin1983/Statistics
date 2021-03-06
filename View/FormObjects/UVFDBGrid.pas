unit UVFDBGrid;

interface

uses
Data.DB, Data.Win.ADODB,

  Vcl.DBGrids, Graphics, StdCtrls, Forms, Classes, Controls, Variants,
  UMCGetDataSource;

type
  IGridDBTag5 = interface
    function GetGridDB(Cleft, �top, CWidth, CHeight, FontSize: integer; CurrentForm: TForm): TDBGrid;
    function GetValue(NumberField: integer): Variant;
    procedure Visible(NumberCol: integer; i: Boolean);
    procedure WriteValue(NumberField: integer; Value: Variant);
    procedure EditValue;
    procedure InsertValue;
    procedure PostValue;
    procedure OpenConnect(SQL: string);
    procedure CloseConnect;
    procedure TitleColumn(NumberColumn: integer; NameColumn: string);
    procedure WidthColumn(NumberColumn, WidthCol: integer);
    procedure Enable(i: Boolean);
  end;

  TGridDBTag5 = class(TInterfacedObject, IGridDBTag5)
  private
    TempDBGrid: TDBGrid;
    TempDataSource: IGetDataSource;
  public
    function GetGridDB(Cleft, �top, CWidth, CHeight, FontSize: integer; CurrentForm: TForm): TDBGrid;
    function GetValue(NumberField: integer): Variant;
    procedure Visible(NumberCol: integer; i: Boolean);
    procedure WriteValue(NumberField: integer; Value: Variant);
    procedure EditValue;
    procedure InsertValue;
    procedure PostValue;
    procedure OpenConnect(SQL: string);
    procedure CloseConnect;
    procedure TitleColumn(NumberColumn: integer; NameColumn: string);
    procedure WidthColumn(NumberColumn, WidthCol: integer);
    procedure Enable(i: Boolean);
  end;

implementation

{ TTempLabelTag5 }

procedure TGridDBTag5.CloseConnect;
begin
  TempDataSource.CloseConnect;
end;

procedure TGridDBTag5.OpenConnect(SQL: string);
begin
  if not Assigned(TempDataSource) then
    TempDataSource := TGetDataSource.create(SQL);
  TempDBGrid.DataSource:=TempDataSource.GetDataSource;
  TempDataSource.OpenConnect;
end;

procedure TGridDBTag5.PostValue;
begin
  TempDataSource.Post;
end;

procedure TGridDBTag5.TitleColumn(NumberColumn: integer; NameColumn: string);
begin
  TempDBGrid.Columns[NumberColumn].Title.Caption:=NameColumn;
end;

procedure TGridDBTag5.Visible(NumberCol: integer; i: Boolean);
begin
  TempDBGrid.Columns[NumberCol].Visible:=i
end;

procedure TGridDBTag5.WidthColumn(NumberColumn, WidthCol: integer);
begin
  TempDBGrid.Columns[NumberColumn].Width:=WidthCol;
end;

procedure TGridDBTag5.WriteValue(NumberField: integer; Value: Variant);
begin
  TempDBGrid.DataSource.DataSet.Fields[NumberField].Value:=Value;
end;

procedure TGridDBTag5.EditValue;
begin
  TempDBGrid.DataSource.DataSet.Edit;
end;

procedure TGridDBTag5.Enable(i: Boolean);
begin
  TempDBGrid.Enabled:=i;
end;

function TGridDBTag5.GetGridDB(Cleft, �top, CWidth, CHeight, FontSize: integer; CurrentForm: TForm): TDBGrid;
begin
  if not Assigned(TempDBGrid) then
    TempDBGrid := TDBGrid.create(CurrentForm);
  TempDBGrid.parent := CurrentForm;
  with TempDBGrid do
  begin
    left := Cleft;
    top := �top;
    Width := CWidth;
    Height:= CHeight;
    Font.Size := FontSize;
    Font.name := 'Times New Roman';
    ReadOnly:=true;
    TitleFont.Size := FontSize;
    TitleFont.name := 'Times New Roman';
    TitleFont.Style:=[fsbold];
    Tag := 5;
  end;
  result := TempDBGrid;
end;

function TGridDBTag5.GetValue(NumberField: integer): Variant;
begin
  Result:=TempDBGrid.DataSource.DataSet.Fields[NumberField].Value;
end;

procedure TGridDBTag5.InsertValue;
begin
  TempDataSource.Insert ;
end;

end.
