unit MQBTheAmountOfBloodOnPreserving;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;

type
  ITheAmountOfBloodOnPreserving = interface
    function GetValue: string;
  end;

  TTheAmountOfBloodOnPreserving = class(TInterfacedObject, ITheAmountOfBloodOnPreserving)
  private
    AmountOfBP: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TTheAmountOfBloodOnPreserving.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
  TempQuery.SQL.Add
    ('SELECT Sum(Blood.������) AS [Sum-������], Sum(Plasma.������) AS [Sum-������], '
    + 'Sum(Tromb.������) AS [Sum-������] ' +
    'FROM ((FactoryCal LEFT JOIN Blood ON FactoryCal.���� = Blood.�����) ' +
    'LEFT JOIN Plasma ON FactoryCal.���� = Plasma.�����) ' +
    'LEFT JOIN Tromb ON FactoryCal.���� = Tromb.����� ' +
    'WHERE (Blood.�����) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#');
    TempQuery.Open;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  AmountOfBP := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value) +
    CheckNull.CheckedValue(TempQuery.Fields[1].value) + CheckNull.CheckedValue
    (TempQuery.Fields[0].value));
  TempQuery.Close;
end;

function TTheAmountOfBloodOnPreserving.GetValue: string;
begin
  result := AmountOfBP;
end;

end.
