unit MQBTheAmountOfReinfusionWithAPA;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;

type
  ITheAmountOfReinfusionWithAPA = interface
    function GetValue: string;
  end;

  TTheAmountOfReinfusionWithAPA = class(TInterfacedObject, ITheAmountOfReinfusionWithAPA)
  private
    AmountOfRWAPA: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TTheAmountOfReinfusionWithAPA.create(DateStart, DateEnd: TDate);
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
    ('SELECT Sum(Plasma. ÓÌœ), Sum(PlasmaComponents. œÀœ), Sum(PlazmaBrak. ¡–œ) ' +
    'FROM (Plasma INNER JOIN PlazmaDoza ON Plasma.ƒ‡Ú‡œ=PlazmaDoza.ƒ‡Ú‡œ) ' +
    'INNER JOIN (PlasmaComponents INNER JOIN PlazmaBrak ' +
    'ON PlasmaComponents. Ó‰ƒœ = PlazmaBrak. Ó‰ œ) ON ' +
    'PlazmaDoza. Ó‰œÎ = PlasmaComponents. Ó‰ƒœ ' +
    'WHERE (Plasma.ƒ‡Ú‡œ) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#');
    TempQuery.Open;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  AmountOfRWAPA := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value) -
    CheckNull.CheckedValue(TempQuery.Fields[1].value) - CheckNull.CheckedValue
    (TempQuery.Fields[2].value));
  TempQuery.Close;
end;

function TTheAmountOfReinfusionWithAPA.GetValue: string;
begin
  result := AmountOfRWAPA;
end;

end.
