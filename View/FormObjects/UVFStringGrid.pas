unit UVFStringGrid;

interface

uses
  Vcl.Grids, Graphics, StdCtrls, Forms, Classes, Controls, Variants;

type
  IStringGridTag5 = interface
    function GetStringGrid(Cleft, Ñtop, CWidth, CHeight, CColCount, CRowCount, FontSize: integer; CurrentForm: TForm): TStringGrid;
    function GetValue(CCol, CRow: integer): String;
    function GetRowCount: integer;
    procedure WriteCells(ColCell, RowCell: integer; Value: String);
    procedure ColWidth(NumberCol, Value: integer);
    procedure Visible(Value: boolean);
    procedure AddRowCount;
  end;

  TStringGridTag5 = class(TInterfacedObject, IStringGridTag5)
  private
    TempStringGrid: TStringGrid;
  public
    function GetStringGrid(Cleft, Ñtop, CWidth, CHeight, CColCount, CRowCount, FontSize: integer; CurrentForm: TForm): TStringGrid;
    function GetValue(CCol, CRow: integer): String;
    function GetRowCount: integer;
    procedure WriteCells(ColCell, RowCell: integer; Value: String);
    procedure ColWidth(NumberCol, Value: integer);
    procedure Visible(Value: boolean);
    procedure AddRowCount;
  end;

implementation

{ TTempLabelTag5 }

procedure TStringGridTag5.AddRowCount;
begin
  TempStringGrid.RowCount:=TempStringGrid.RowCount+1;
end;

procedure TStringGridTag5.ColWidth(NumberCol, Value: integer);
begin
  TempStringGrid.ColWidths[NumberCol]:=Value;
end;

function TStringGridTag5.GetRowCount: integer;
begin
 Result:=TempStringGrid.RowCount;
end;

function TStringGridTag5.GetStringGrid(Cleft, Ñtop, CWidth, CHeight, CColCount, CRowCount, FontSize: integer; CurrentForm: TForm): TStringGrid;
begin
  if not Assigned(TempStringGrid) then
    TempStringGrid := TStringGrid.create(CurrentForm);
  TempStringGrid.parent := CurrentForm;
  with TempStringGrid do
  begin
    left := Cleft;
    top := Ñtop;
    Width := CWidth;
    Height:= CHeight;
    ColCount:=CColCount;
    RowCount:=CRowCount;
    Font.Size := FontSize;
    Font.name := 'Times New Roman';
//    Font.Style:=[fsbold];
    Options:=[goFixedVertLine]+[goFixedHorzLine]+[goVertLine]+[goHorzLine];
    Color:=clBtnFace;
    FixedColor:=clBtnFace;
    BorderStyle:=bsNone;
    FixedCols:=1;
    FixedRows:=1;
    Visible:=false;
    Tag := 5;
  end;
  result := TempStringGrid;
end;


function TStringGridTag5.GetValue(CCol, CRow: integer): String;
begin
  Result:=TempStringGrid.Cells[CCol, CRow];
end;

procedure TStringGridTag5.Visible(Value: boolean);
begin
  TempStringGrid.Visible:=Value;
end;

procedure TStringGridTag5.WriteCells(ColCell, RowCell: integer; Value: String);
begin
  TempStringGrid.Cells[ColCell, RowCell]:=VarToStr(Value);
end;

end.
