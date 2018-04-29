unit MFStringGrid;

interface

uses
  Vcl.Grids, SysUtils, Graphics, StdCtrls, Forms, Classes, CodeSiteLogging, Controls, Variants,
  WinProcs;

type
  IMFStringGrid = interface
    function GetStringGrid(Cleft, �top, CWidth, CHeight, CColCount, CRowCount,
      FontSize: integer; CurrentForm: TForm): TStringGrid;
    function GetValue(CCol, CRow: integer): String;
    function GetRowCount: integer;
    function CurrentRow: integer;
    procedure ResultFormat(PTitleRow: word; PCol1: integer; PCol1Format: word;
      PCol2: integer; PCol2Format: word; PCol3: integer; PCol3Format: word;
      PCol4: integer; PCol4Format: word; PCol5: integer; PCol5Format: word);
    procedure Enabled(i: Boolean);
    procedure NumberOfFixedCol(i: integer);
    procedure WriteCells(ColCell, RowCell: integer; Value: String);
    procedure ColWidth(NumberCol, Value: integer);
    procedure Visible(Value: Boolean);
    procedure AddRowCount;
    procedure DeleteLastRow(NumberDelRow: integer);
    procedure destroy;
  end;

  TMFStringGrid = class(TInterfacedObject, IMFStringGrid)
  private
    TempStringGrid: TStringGrid;

    Col1, Col2, Col3, Col4, Col5: integer;
    TitleFormat, Col1Format, Col2Format, Col3Format, Col4Format,
      Col5Format: word;

    procedure FormatTitleRowCell(Sender: TObject; ACol, ARow: integer;
      Rect: TRect; State: TGridDrawState);
  public
    function GetStringGrid(Cleft, �top, CWidth, CHeight, CColCount, CRowCount,
      FontSize: integer; CurrentForm: TForm): TStringGrid;
    function GetValue(CCol, CRow: integer): String;
    function GetRowCount: integer;
    function CurrentRow: integer;
    procedure ResultFormat(PTitleRow: word; PCol1: integer; PCol1Format: word;
      PCol2: integer; PCol2Format: word; PCol3: integer; PCol3Format: word;
      PCol4: integer; PCol4Format: word; PCol5: integer; PCol5Format: word);
    procedure Enabled(i: Boolean);
    procedure NumberOfFixedCol(i: integer);
    procedure WriteCells(ColCell, RowCell: integer; Value: String);
    procedure ColWidth(NumberCol, Value: integer);
    procedure Visible(Value: Boolean);
    procedure AddRowCount;
    procedure DeleteLastRow(NumberDelRow: integer);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFStringGrid.AddRowCount;
begin
  TempStringGrid.RowCount := TempStringGrid.RowCount + 1;

//  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.AddRowCount ���������', TempStringGrid.RowCount);
end;

procedure TMFStringGrid.ResultFormat(PTitleRow: word; PCol1: integer;
  PCol1Format: word; PCol2: integer; PCol2Format: word; PCol3: integer;
  PCol3Format: word; PCol4: integer; PCol4Format: word; PCol5: integer;
  PCol5Format: word);
begin
  TitleFormat := PTitleRow;
  Col1 := PCol1;
  Col2 := PCol2;
  Col3 := PCol3;
  Col4 := PCol4;
  Col5 := PCol5;
  Col1Format := PCol1Format;
  Col2Format := PCol2Format;
  Col3Format := PCol3Format;
  Col4Format := PCol4Format;
  Col5Format := PCol5Format;
end;

procedure TMFStringGrid.FormatTitleRowCell(Sender: TObject; ACol, ARow: integer;
  Rect: TRect; State: TGridDrawState);
var
  Format: word;
  C: array [0 .. 255] of Char;
begin
  if ACol = Col1 then
    Format := Col1Format;
  if ACol = Col2 then
    Format := Col2Format;
  if ACol = Col3 then
    Format := Col3Format;
  if ACol = Col4 then
    Format := Col4Format;
  if ACol = Col5 then
    Format := Col5Format;
  if (ACol <> Col1) and (ACol <> Col2) and (ACol <> Col3) and (ACol <> Col4) and
    (ACol <> Col5) then
    Format := DT_LEFT;
  if ARow = 0 then
    Format := TitleFormat;
  TempStringGrid.Canvas.FillRect(Rect);
  StrPCopy(C, TempStringGrid.Cells[ACol, ARow]);
  WinProcs.DrawText(TempStringGrid.Canvas.Handle, C, StrLen(C), Rect, Format);
end;

procedure TMFStringGrid.ColWidth(NumberCol, Value: integer);
begin
  TempStringGrid.ColWidths[NumberCol] := Value;

//  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.ColWidth ���������', Value);
end;

function TMFStringGrid.CurrentRow: integer;
begin
  Result := TempStringGrid.Row;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.CurrentRow ���������', Result);
end;

procedure TMFStringGrid.DeleteLastRow(NumberDelRow: integer);
var
  i: integer;
begin
  with TempStringGrid do
  begin
    for i := 0 to ColCount - 1 do
      Cells[NumberDelRow, RowCount - 1] := '';
    RowCount := RowCount - 1;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.DeleteLastRow ���������');
end;

procedure TMFStringGrid.destroy;
begin
  if Assigned(TempStringGrid) then
    FreeAndNil(TempStringGrid);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.destroy ���������');
end;

procedure TMFStringGrid.Enabled(i: Boolean);
begin
  TempStringGrid.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.Enabled ���������', i);
end;

function TMFStringGrid.GetRowCount: integer;
begin
  Result := TempStringGrid.RowCount;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.GetRowCount ���������', Result);
end;

function TMFStringGrid.GetStringGrid(Cleft, �top, CWidth, CHeight, CColCount,
  CRowCount, FontSize: integer; CurrentForm: TForm): TStringGrid;
begin
  if not Assigned(TempStringGrid) then
    TempStringGrid := TStringGrid.create(CurrentForm);
  TempStringGrid.parent := CurrentForm;
  with TempStringGrid do
  begin
    left := Cleft;
    top := �top;
    Width := CWidth;
    Height := CHeight;
    ColCount := CColCount;
    RowCount := CRowCount;
    Font.Size := FontSize;
    Font.name := 'Times New Roman';
    Options := [goFixedVertLine] + [goFixedHorzLine] + [goVertLine] +
      [goHorzLine];
    Color := clBtnFace;
    FixedColor := clBtnFace;
    BorderStyle := bsNone;
    FixedCols := 1;
    FixedRows := 1;
    ParentColor:=true;
    Visible := false;
    Tag := 5;
    OnDrawCell := FormatTitleRowCell;
  end;
  Result := TempStringGrid;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.GetStringGrid ���������');
end;

function TMFStringGrid.GetValue(CCol, CRow: integer): String;
begin
  Result := TempStringGrid.Cells[CCol, CRow];

//  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.GetValue ���������', Result);
end;

procedure TMFStringGrid.NumberOfFixedCol(i: integer);
begin
  TempStringGrid.FixedCols := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.NumberOfFixedCol ���������', i);
end;

procedure TMFStringGrid.Visible(Value: Boolean);
begin
  TempStringGrid.Visible := Value;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.Visible ���������', Value);
end;

procedure TMFStringGrid.WriteCells(ColCell, RowCell: integer; Value: String);
begin
  TempStringGrid.Cells[ColCell, RowCell] := VarToStr(Value);

{  CodeSite.Send(FormatDateTime('c', Now) + ' TMFStringGrid.WriteCells ��������� TempStringGrid.Cells[' + IntToStr(ColCell) +
    ' ,' + IntToStr(RowCell) + '] =', VarToStr(Value));       }
end;

end.
