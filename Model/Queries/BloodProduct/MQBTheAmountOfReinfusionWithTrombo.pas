unit MQBTheAmountOfReinfusionWithTrombo;

interface

uses
  SysUtils, Variants,
  Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;

type
  ITheAmountOfReinfusionWithTrombo = interface
    function GetValue: string;
  end;

  TTheAmountOfReinfusionWithTrombo = class(TInterfacedObject, ITheAmountOfReinfusionWithTrombo)
  private
    AmountOfRWT: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TTheAmountOfReinfusionWithTrombo.create(DateStart, DateEnd: TDate);
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
    ('SELECT Sum(Tromb.����), Sum(TrombComponents.����), Sum(TrombBrak.����) ' +
    'FROM (Tromb INNER JOIN TrombDoza ON Tromb.�����=TrombDoza.�����) ' +
    'INNER JOIN (TrombComponents INNER JOIN TrombBrak ' +
    'ON TrombComponents.����� = TrombBrak.�����) ON ' +
    'TrombDoza.���� = TrombComponents.����� ' +
    'WHERE (Tromb.�����) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#');
    TempQuery.Open;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  AmountOfRWT := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value) -
    CheckNull.CheckedValue(TempQuery.Fields[1].value) - CheckNull.CheckedValue
    (TempQuery.Fields[2].value));
  TempQuery.Close;
end;

function TTheAmountOfReinfusionWithTrombo.GetValue: string;
begin
  result := AmountOfRWT;
end;

end.
