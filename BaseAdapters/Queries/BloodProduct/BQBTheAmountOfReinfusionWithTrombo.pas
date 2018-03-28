unit BQBTheAmountOfReinfusionWithTrombo;

interface

uses
  SysUtils, Variants,
  Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBQBTheAmountOfReinfusionWithTrombo = interface
    function GetValue: string;
  end;

  TBQBTheAmountOfReinfusionWithTrombo = class(TInterfacedObject,
    IBQBTheAmountOfReinfusionWithTrombo)
  private
    AmountOfRWT: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBQBTheAmountOfReinfusionWithTrombo.create(DateStart,
  DateEnd: TDate);
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
      ('SELECT Sum(Tromb. ÓÌ“), Sum(TrombComponents. œÀ“), Sum(TrombBrak. ¡–“) '
      + 'FROM (Tromb INNER JOIN TrombDoza ON Tromb.ƒ‡Ú‡“=TrombDoza.ƒ‡Ú‡“) ' +
      'INNER JOIN (TrombComponents INNER JOIN TrombBrak ' +
      'ON TrombComponents. Ó‰ƒ“ = TrombBrak. Ó‰ “) ON ' +
      'TrombDoza. Ó‰“ = TrombComponents. Ó‰ƒ“ ' +
      'WHERE (Tromb.ƒ‡Ú‡“) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
      DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
      DateEnd) + '#');
    TempQuery.Open;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  AmountOfRWT := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value) -
    CheckNull.CheckedValue(TempQuery.Fields[1].value) - CheckNull.CheckedValue
    (TempQuery.Fields[2].value));
  TempQuery.Close;
end;

function TBQBTheAmountOfReinfusionWithTrombo.GetValue: string;
begin
  result := AmountOfRWT;
end;

end.
