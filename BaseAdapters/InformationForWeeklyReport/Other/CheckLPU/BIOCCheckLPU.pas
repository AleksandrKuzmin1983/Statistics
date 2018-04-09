unit BIOCCheckLPU;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBIOCCheckLPU = interface
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetCheckLPU(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TResultRecord = Record
  private
    Kod: string;
    Date: String;
    CheckLPU: String;

  end;

  TBIOCCheckLPU = class(TInterfacedObject, IBIOCCheckLPU)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetCheckLPU(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

implementation

procedure TBIOCCheckLPU.GetContent;
var
  i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  SQL := 'SELECT Consultations.Код, Consultations.ДатаКон, Consultations.ПЛПУ '
    + 'FROM Consultations ' + 'WHERE not (Consultations.ПЛПУ = 0) ' +
    'ORDER BY Consultations.ДатаКон desc;';
  Try
    TempQuery.SQL.Add(SQL);
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  try
    TempQuery.Open;
  Except
    ShowMessage('Нет подключения в базе данных!' + chr(13) +
      'Обратитесь к администратору!');
  end;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i := 0 to TempQuery.RecordCount - 1 do
    begin
      ResultMass[i].Kod :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Date :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].CheckLPU :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOCCheckLPU.GetContent выполнена');
end;

function TBIOCCheckLPU.GetRowCount: integer;
begin
  result := Length(ResultMass);

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOCCheckLPU.GetRowCount выполнена');
end;

function TBIOCCheckLPU.GetCheckLPU(i: integer): string;
begin
  result := ResultMass[i].CheckLPU;
end;

function TBIOCCheckLPU.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TBIOCCheckLPU.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
