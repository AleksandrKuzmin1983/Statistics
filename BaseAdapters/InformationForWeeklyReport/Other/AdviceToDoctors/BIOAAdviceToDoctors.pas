unit BIOAAdviceToDoctors;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBIOAAdviceToDoctors = interface
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetTransfuziolog(i: integer): string;
    function GetLaboratoryScientist(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TResultRecord = Record
  private
    Kod: string;
    Date: String;
    Transfuziolog: String;
    LaboratoryScientist: String;
  end;

  TBIOAAdviceToDoctors = class(TInterfacedObject, IBIOAAdviceToDoctors)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetTransfuziolog(i: integer): string;
    function GetLaboratoryScientist(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOAAdviceToDoctors.GetContent;
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
  SQL := 'SELECT Consultations.Код, Consultations.ДатаКон, Consultations.ВТ, Consultations.ВЛ '
    + 'FROM Consultations ' +
    'WHERE not ((Consultations.ВТ = 0) and (Consultations.ВЛ = 0)) ' +
    'ORDER BY Consultations.ДатаКон desc;';
  Try
    TempQuery.SQL.Add(SQL);
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  Try
    TempQuery.Open;
  Except
    ShowMessage('Нет подключения в базе данных!' + chr(13) +
      'Обратитесь к администратору!');
  End;
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
      ResultMass[i].Transfuziolog :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].LaboratoryScientist :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

function TBIOAAdviceToDoctors.GetRowCount: integer;
begin
  result := Length(ResultMass);
end;

function TBIOAAdviceToDoctors.GetLaboratoryScientist(i: integer): string;
begin
  result := ResultMass[i].LaboratoryScientist;
end;

function TBIOAAdviceToDoctors.GetTransfuziolog(i: integer): string;
begin
  result := ResultMass[i].Transfuziolog;
end;

function TBIOAAdviceToDoctors.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TBIOAAdviceToDoctors.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
