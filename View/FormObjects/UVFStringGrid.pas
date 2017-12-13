unit UVFStringGrid;

interface

uses
  Vcl.Grids, SysUtils, Graphics, StdCtrls, Forms, Classes, Controls, Variants, WinProcs;

type
  IStringGridTag5 = interface
    function GetStringGrid(Cleft, Ñtop, CWidth, CHeight, CColCount, CRowCount, FontSize: integer; CurrentForm: TForm): TStringGrid;
    function GetValue(CCol, CRow: integer): String;
    function GetRowCount: integer;
    function CurrentRow: integer;
    procedure ResultFormat(PTitleRow: word; PCol1: integer; PCol1Format: word;
      PCol2: integer; PCol2Format: word; PCol3: integer; PCol3Format: word; PCol4: integer;
      PCol4Format: word; PCol5: integer; PCol5Format: word);
    procedure Enabled(i: Boolean);
    procedure NumberOfFixedCol(i: integer);
    procedure WriteCells(ColCell, RowCell: integer; Value: String);
    procedure ColWidth(NumberCol, Value: integer);
    procedure Visible(Value: boolean);
    procedure AddRowCount;
    procedure Free;
  end;

  TStringGridTag5 = class(TInterfacedObject, IStringGridTag5)
  private
    TempStringGrid: TStringGrid;

    Col1, Col2, Col3, Col4, Col5: Integer;
    TitleFormat, Col1Format, Col2Format, Col3Format, Col4Format, Col5Format: word;

    procedure FormatTitleRowCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);

  public
    function GetStringGrid(Cleft, Ñtop, CWidth, CHeight, CColCount, CRowCount, FontSize: integer; CurrentForm: TForm): TStringGrid;
    function GetValue(CCol, CRow: integer): String;
    function GetRowCount: integer;
    function CurrentRow: integer;
    procedure ResultFormat(PTitleRow: word; PCol1: integer; PCol1Format: word;
      PCol2: integer; PCol2Format: word; PCol3: integer; PCol3Format: word; PCol4: integer;
      PCol4Format: word; PCol5: integer; PCol5Format: word);
    procedure Enabled(i: Boolean);
    procedure NumberOfFixedCol(i: integer);
    procedure WriteCells(ColCell, RowCell: integer; Value: String);
    procedure ColWidth(NumberCol, Value: integer);
    procedure Visible(Value: boolean);
    procedure AddRowCount;
    procedure Free;
  end;

implementation

{ TTempLabelTag5 }

procedure TStringGridTag5.AddRowCount;
begin
  TempStringGrid.RowCount:=TempStringGrid.RowCount+1;
end;

procedure TStringGridTag5.ResultFormat(PTitleRow: word; PCol1: integer; PCol1Format: word;
  PCol2: integer; PCol2Format: word; PCol3: integer; PCol3Format: word; PCol4: integer; PCol4Format: word; PCol5: integer; PCol5Format: word);
begin
    TitleFormat:=PTitleRow;
    Col1:=PCol1;
    Col2:=PCol2;
    Col3:=PCol3;
    Col4:=PCol4;
    Col5:=PCol5;
    Col1Format:=PCol1Format;
    Col2Format:=PCol2Format;
    Col3Format:=PCol3Format;
    Col4Format:=PCol4Format;
    Col5Format:=PCol5Format;
end;

procedure TStringGridTag5.FormatTitleRowCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Format: Word;
  C: array[0..255] of Char;
begin
  if ACol = Col1 then Format := Col1Format;
  if ACol = Col2 then Format := Col2Format;
  if ACol = Col3 then Format := Col3Format;
  if ACol = Col4 then Format := Col4Format;
  if ACol = Col5 then Format := Col5Format;
  if (ACol <> Col1) and (ACol <> Col2) and (ACol <> Col3) and (ACol <> Col4) and (ACol <> Col5) then Format := DT_LEFT;
  if ARow = 0 then Format := TitleFormat;
  TempStringGrid.Canvas.FillRect(Rect);
  StrPCopy(C, TempStringGrid.Cells[ACol, ARow]);
  WinProcs.DrawText(TempStringGrid.Canvas.Handle, C, StrLen(C), Rect, Format);
end;

procedure TStringGridTag5.ColWidth(NumberCol, Value: integer);
begin
  TempStringGrid.ColWidths[NumberCol]:=Value;
end;

function TStringGridTag5.CurrentRow: integer;
begin
  Result:=TempStringGrid.Row;
end;

procedure TStringGridTag5.Enabled(i: Boolean);
begin
  TempStringGrid.Enabled:=i;
end;

procedure TStringGridTag5.Free;
begin
  TempStringGrid.Free;
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
    OnDrawCell:=FormatTitleRowCell;
  end;
  result := TempStringGrid;
end;


function TStringGridTag5.GetValue(CCol, CRow: integer): String;
begin
  Result:=TempStringGrid.Cells[CCol, CRow];
end;

procedure TStringGridTag5.NumberOfFixedCol(i: integer);
begin
  TempStringGrid.FixedCols:=i;
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
