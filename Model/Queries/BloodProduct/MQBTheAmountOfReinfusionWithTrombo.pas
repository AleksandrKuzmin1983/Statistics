unit MQBTheAmountOfReinfusionWithTrombo;

interface

uses
  SysUtils, Variants,
  Dialogs, Data.Win.ADODB,
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
  TempQuery.SQL.Add
    ('SELECT Sum(Tromb. ÓÌ“), Sum(TrombComponents. œÀ“), Sum(TrombBrak. ¡–“) ' +
    'FROM (Tromb INNER JOIN TrombDoza ON Tromb.ƒ‡Ú‡“=TrombDoza.ƒ‡Ú‡“) ' +
    'INNER JOIN (TrombComponents INNER JOIN TrombBrak ' +
    'ON TrombComponents. Ó‰ƒ“ = TrombBrak. Ó‰ “) ON ' +
    'TrombDoza. Ó‰“ = TrombComponents. Ó‰ƒ“ ' +
    'WHERE (Tromb.ƒ‡Ú‡“) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#');
  TempQuery.Open;
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
