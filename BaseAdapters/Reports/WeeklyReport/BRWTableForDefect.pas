unit BRWTableForDefect;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBRWTableForDefect = interface
    function GetTypeOfProduct(i: integer): string;
    function GetTypeOfDefect(i: integer): string;
    function GetVolume(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
    procedure destroy;
  end;

  TResultRecord = Record
  private
    TypeOfProduct: string;
    TypeOfDefect: String;
    Volume: String;
  end;

  TBRWTableForDefect = class(TInterfacedObject, IBRWTableForDefect)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQueryErSusp: TADOQuery;
    TempQueryPlasma: TADOQuery;
    TempQueryWholeBlood: TADOQuery;
    CheckNull: IUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetTypeOfProduct(i: integer): string;
    function GetTypeOfDefect(i: integer): string;
    function GetVolume(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBRWTableForDefect.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQueryErSusp) then
    TempQueryErSusp.Free;
  if Assigned(TempQueryPlasma) then
    TempQueryPlasma.Free;
  if Assigned(TempQueryWholeBlood) then
    TempQueryWholeBlood.Free;
  CheckNull := nil;
end;

procedure TBRWTableForDefect.GetContent;
var
  i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQueryErSusp) then
    TempQueryErSusp := TADOQuery.create(nil);
  TempQueryErSusp.Connection := TempConnect.GetConnect;
  TempQueryErSusp.Close;
  TempQueryErSusp.SQL.Clear;
  SQL := 'SELECT [���� ����������� � ������ ������].����, [���� ����������� � ������ ������].����, '
    + 'Sum([���� ����������� � ������ ������].����)/1000 AS [Sum-����] ' +
    'FROM [���� ����������� � ������ ������] ' +
    'WHERE ((([���� ����������� � ������ ������].����)>=0) AND ' +
    '(([���� ����������� � ������ ������]![����])<>(SELECT TypeDef FROM TypeOfDefects WHERE idDef=1) '
    + 'And ([���� ����������� � ������ ������]![����])<>(SELECT TypeDef FROM TypeOfDefects WHERE idDef=2) '
    + 'And ([���� ����������� � ������ ������]![����])<>(SELECT TypeDef FROM TypeOfDefects WHERE idDef=3)) '
    + 'AND (([���� ����������� � ������ ������].������)<=Date()-Weekday(Date())+1 '
    + 'And ([���� ����������� � ������ ������].������)>=Date()-Weekday(Date())-5)) '
    + 'OR ((([���� ����������� � ������ ������]![����]) Is Null) ' +
    'AND (([���� ����������� � ������ ������].������)=#1/1/2015#)) ' +
    'GROUP BY [���� ����������� � ������ ������].����, [���� ����������� � ������ ������].����;';
  Try
    TempQueryErSusp.SQL.Add(SQL);
  Except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  try
    TempQueryErSusp.Open;
  Except
    ShowMessage('��� ����������� � ���� ������!' + chr(13) +
      '���������� � ��������������!');
  end;

  if not Assigned(TempQueryPlasma) then
    TempQueryPlasma := TADOQuery.create(nil);
  TempQueryPlasma.Connection := TempConnect.GetConnect;
  TempQueryPlasma.Close;
  TempQueryPlasma.SQL.Clear;
  SQL := 'SELECT [���� ����������� � ������ ������].���, [���� ����������� � ������ ������].���, '
    + 'Sum([���� ����������� � ������ ������].���)/1000 AS [Sum-���] ' +
    'FROM [���� ����������� � ������ ������] ' +
    'WHERE ((([���� ����������� � ������ ������].���)>=0) AND ' +
    '(([���� ����������� � ������ ������]![���])<>(SELECT TypeDef FROM TypeOfDefects WHERE idDef=1) '
    + 'And ([���� ����������� � ������ ������]![���])<>(SELECT TypeDef FROM TypeOfDefects WHERE idDef=2) '
    + 'And ([���� ����������� � ������ ������]![���])<>(SELECT TypeDef FROM TypeOfDefects WHERE idDef=3)) '
    + 'AND (([���� ����������� � ������ ������].������)<=Date()-Weekday(Date())+1 '
    + 'And ([���� ����������� � ������ ������].������)>=Date()-Weekday(Date())-5)) '
    + 'OR ((([���� ����������� � ������ ������]![���]) Is Null) ' +
    'AND (([���� ����������� � ������ ������].������)=#1/1/2015#)) ' +
    'GROUP BY [���� ����������� � ������ ������].���, [���� ����������� � ������ ������].���;';
  Try
    TempQueryPlasma.SQL.Add(SQL);
  Except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  try
    TempQueryPlasma.Open;
  Except
    ShowMessage('��� ����������� � ���� ������!' + chr(13) +
      '���������� � ��������������!');
  end;

  if not Assigned(TempQueryWholeBlood) then
    TempQueryWholeBlood := TADOQuery.create(nil);
  TempQueryWholeBlood.Connection := TempConnect.GetConnect;
  TempQueryWholeBlood.Close;
  TempQueryWholeBlood.SQL.Clear;
  SQL := 'SELECT [���� ����������� � ������ ������].����, Sum([����]/1000) AS ���� '
    + 'FROM [���� ����������� � ������ ������] ' +
    'WHERE ((([���� ����������� � ������ ������].����)>=0) AND ' +
    '(([���� ����������� � ������ ������]![����])<>(SELECT TypeDef FROM TypeOfDefects WHERE idDef=1) '
    + 'And ([���� ����������� � ������ ������]![����])<>(SELECT TypeDef FROM TypeOfDefects WHERE idDef=2) '
    + 'And ([���� ����������� � ������ ������]![����])<>(SELECT TypeDef FROM TypeOfDefects WHERE idDef=3)) '
    + 'AND (([���� ����������� � ������ ������].������)<=Date()-Weekday(Date())+1 '
    + 'And ([���� ����������� � ������ ������].������)>=Date()-Weekday(Date())-5)) '
    + 'OR ((([���� ����������� � ������ ������].������)=#1/1/2015#) ' +
    'AND (([���� ����������� � ������ ������]![����]) Is Null)) ' +
    'GROUP BY [���� ����������� � ������ ������].����;';
  Try
    TempQueryWholeBlood.SQL.Add(SQL);
  Except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  try
    TempQueryWholeBlood.Open;
  Except
    ShowMessage('��� ����������� � ���� ������!' + chr(13) +
      '���������� � ��������������!');
  end;

  if (TempQueryErSusp.RecordCount + TempQueryPlasma.RecordCount +
    TempQueryWholeBlood.RecordCount) > 3 then
  begin
    SetLength(ResultMass, TempQueryErSusp.RecordCount +
      TempQueryPlasma.RecordCount + TempQueryWholeBlood.RecordCount - 3);
    TempQueryErSusp.Recordset.MoveFirst;
    TempQueryErSusp.Next;
    for i := 0 to TempQueryErSusp.RecordCount - 2 do
    begin
      ResultMass[i].TypeOfProduct := ' (��. �����)';
      ResultMass[i].TypeOfDefect :=
        VarToStr(CheckNull.CheckedValue(TempQueryErSusp.Fields[1].value));
      ResultMass[i].Volume :=
        VarToStr(FormatFloat('0.000',
        CheckNull.CheckedValue(TempQueryErSusp.Fields[2].value)));
      TempQueryErSusp.Next;
    end;

    TempQueryPlasma.Recordset.MoveFirst;
    TempQueryPlasma.Next;
    for i := TempQueryErSusp.RecordCount - 1 to TempQueryErSusp.RecordCount +
      TempQueryPlasma.RecordCount - 3 do
    begin
      ResultMass[i].TypeOfProduct := ' (���)';
      ResultMass[i].TypeOfDefect :=
        VarToStr(CheckNull.CheckedValue(TempQueryPlasma.Fields[1].value));
      ResultMass[i].Volume :=
        VarToStr(FormatFloat('0.000',
        CheckNull.CheckedValue(TempQueryPlasma.Fields[2].value)));
      TempQueryPlasma.Next;
    end;
    if Length(ResultMass) = TempQueryErSusp.RecordCount +
      TempQueryPlasma.RecordCount - 2 then
    begin
      TempQueryErSusp.Close;
      TempQueryPlasma.Close;
      TempQueryWholeBlood.Close;
      exit;
    end;

    TempQueryWholeBlood.Recordset.MoveFirst;
    TempQueryWholeBlood.Next;
    for i := TempQueryErSusp.RecordCount + TempQueryPlasma.RecordCount -
      2 to TempQueryErSusp.RecordCount + TempQueryPlasma.RecordCount +
      TempQueryWholeBlood.RecordCount - 4 do
    begin
      ResultMass[i].TypeOfProduct := ' (���. ��.)';
      ResultMass[i].TypeOfDefect :=
        VarToStr(CheckNull.CheckedValue(TempQueryWholeBlood.Fields[0].value));
      ResultMass[i].Volume :=
        VarToStr(FormatFloat('0.000',
        CheckNull.CheckedValue(TempQueryWholeBlood.Fields[1].value)));
      TempQueryWholeBlood.Next;
    end;

  end;
  TempQueryErSusp.Close;
  TempQueryPlasma.Close;
  TempQueryWholeBlood.Close;
end;

function TBRWTableForDefect.GetTypeOfDefect(i: integer): string;
begin
  result := ResultMass[i].TypeOfDefect;
end;

function TBRWTableForDefect.GetRowCount: integer;
begin
  result := Length(ResultMass);
end;

function TBRWTableForDefect.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TBRWTableForDefect.GetTypeOfProduct(i: integer): string;
begin
  result := ResultMass[i].TypeOfProduct;
end;

end.
