unit BQBTheNumberOfConservedBlood;

interface

uses
  SysUtils, Variants,
  Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBQBTheNumberOfConservedBlood = interface
    function GetValue: string;
  end;

  TBQBTheNumberOfConservedBlood = class(TInterfacedObject,
    IBQBTheNumberOfConservedBlood)
  private
    NumberOfCB: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBQBTheNumberOfConservedBlood.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    TempQuery.SQL.Add
      ('SELECT Sum(Blood.КонК) AS [Sum-КонК], Sum(Plasma.КонП) AS [Sum-КонП], '
      + 'Sum(Tromb.КонТ) AS [Sum-КонТ] ' +
      'FROM ((FactoryCal LEFT JOIN Blood ON FactoryCal.День = Blood.ДатаК) ' +
      'LEFT JOIN Plasma ON FactoryCal.День = Plasma.ДатаП) ' +
      'LEFT JOIN Tromb ON FactoryCal.День = Tromb.ДатаТ ' +
      'WHERE (Blood.ДатаК) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
      DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
      DateEnd) + '#');
    TempQuery.Open;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  NumberOfCB := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value) +
    CheckNull.CheckedValue(TempQuery.Fields[1].value) + CheckNull.CheckedValue
    (TempQuery.Fields[0].value));
  TempQuery.Close;
end;

function TBQBTheNumberOfConservedBlood.GetValue: string;
begin
  result := NumberOfCB;
end;

end.
