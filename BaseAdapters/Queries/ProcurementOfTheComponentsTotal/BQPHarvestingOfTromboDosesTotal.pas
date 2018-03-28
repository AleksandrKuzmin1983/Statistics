unit BQPHarvestingOfTromboDosesTotal;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  GetAdoConnect,
  USCheckNull;

type
  IBQPHarvestingOfTromboDosesTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfTromboDosesTotal = class(TInterfacedObject,
    IBQPHarvestingOfTromboDosesTotal)
  private
    TromboDosesTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfTromboDosesTotal.create(DateStart, DateEnd: TDate);
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
  TempQuery.SQL.Add('SELECT Sum(TrombComponents.ДПЛТ) ' +
    'FROM Tromb INNER JOIN (TrombDoza INNER JOIN TrombComponents ' +
    'ON TrombDoza.КодТ = TrombComponents.КодДТ) ON Tromb.ДатаТ = TrombDoza.ДатаТ '
    + 'WHERE (Tromb.ДатаТ) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  TromboDosesTotal :=
    VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function TBQPHarvestingOfTromboDosesTotal.GetValue: string;
begin
  result := TromboDosesTotal;
end;

end.
