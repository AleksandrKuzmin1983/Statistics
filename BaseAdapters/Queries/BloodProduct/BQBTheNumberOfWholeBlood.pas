unit BQBTheNumberOfWholeBlood;

interface

uses
  SysUtils, Variants,
  Dialogs, Data.Win.ADODB, CodeSiteLogging, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBQBTheNumberOfWholeBlood = interface
    function GetValue: string;
  end;

  TBQBTheNumberOfWholeBlood = class(TInterfacedObject,
    IBQBTheNumberOfWholeBlood)
  private
    NumberOfWB: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
    // procedure free;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBQBTheNumberOfWholeBlood.create(DateStart, DateEnd: TDate);
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
      ('SELECT Sum(Blood.ЦелК) AS [Sum-ЦелК], Sum(Plasma.ЦелП) AS [Sum-ЦелП], '
      + 'Sum(Tromb.ЦелТ) AS [Sum-ЦелТ] ' +
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
  NumberOfWB := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value) +
    CheckNull.CheckedValue(TempQuery.Fields[1].value) + CheckNull.CheckedValue
    (TempQuery.Fields[0].value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQBTheNumberOfWholeBlood.create выполнена');
end;

function TBQBTheNumberOfWholeBlood.GetValue: string;
begin
  result := NumberOfWB;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQBTheNumberOfWholeBlood.GetValue выполнена');
end;

end.
