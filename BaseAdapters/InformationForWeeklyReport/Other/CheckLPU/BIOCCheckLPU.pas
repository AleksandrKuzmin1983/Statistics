unit BIOCCheckLPU;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IMIOCCheckLPU = interface
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetCheckLPU(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TResultRecord=Record
  private
    Kod: string;
    Date: String;
    CheckLPU: String;

  end;

  TMIOCCheckLPU = class(TInterfacedObject,
    IMIOCCheckLPU)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetCheckLPU(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

implementation

procedure TMIOCCheckLPU.GetContent;
var i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  SQL:='SELECT Consultations.���, Consultations.�������, Consultations.���� ' +
  'FROM Consultations ' +
  'WHERE not (Consultations.���� = 0) ' +
  'ORDER BY Consultations.������� desc;';
  Try
    TempQuery.SQL.Add(SQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  try
    TempQuery.Open;
  Except
    ShowMessage('��� ����������� � ���� ������!' + chr(13) + '���������� � ��������������!');
  end;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Kod:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Date:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].CheckLPU:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

function TMIOCCheckLPU.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TMIOCCheckLPU.GetCheckLPU(i: integer): string ;
begin
  result := ResultMass[i].CheckLPU;
end;

function TMIOCCheckLPU.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TMIOCCheckLPU.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.