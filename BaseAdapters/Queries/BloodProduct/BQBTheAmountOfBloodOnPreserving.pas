unit BQBTheAmountOfBloodOnPreserving;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBQBTheAmountOfBloodOnPreserving = interface
    function GetValue: string;
  end;

  TBQBTheAmountOfBloodOnPreserving = class(TInterfacedObject,
    IBQBTheAmountOfBloodOnPreserving)
  private
    AmountOfBP: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBQBTheAmountOfBloodOnPreserving.create(DateStart, DateEnd: TDate);
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
      ('SELECT Sum(Blood.НаКонК) AS [Sum-НаКонК], Sum(Plasma.НаКонП) AS [Sum-НаКонП], '
      + 'Sum(Tromb.НаКонТ) AS [Sum-НаКонТ] ' +
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
  AmountOfBP := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value) +
    CheckNull.CheckedValue(TempQuery.Fields[1].value) + CheckNull.CheckedValue
    (TempQuery.Fields[0].value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQBTheAmountOfBloodOnPreserving.create выполнена');
end;

function TBQBTheAmountOfBloodOnPreserving.GetValue: string;
begin
  result := AmountOfBP;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQBTheAmountOfBloodOnPreserving.GetValue выполнена');
end;

end.
