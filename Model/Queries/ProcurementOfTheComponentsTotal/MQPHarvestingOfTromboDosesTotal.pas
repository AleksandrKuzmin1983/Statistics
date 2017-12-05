unit MQPHarvestingOfTromboDosesTotal;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  GetDataSoursUnit1,
  UCheckNull;

type
  IHarvestingOfTromboDosesTotal = interface
    function GetValue: string;
  end;

  THarvestingOfTromboDosesTotal = class(TInterfacedObject,
    IHarvestingOfTromboDosesTotal)
  private
    TromboDosesTotal: string;
    TempConnect: IDataBaseTables;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor THarvestingOfTromboDosesTotal.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TDataBaseTables.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add('SELECT Sum(TrombComponents.ДПЛТ) ' +
    'FROM Tromb INNER JOIN (TrombDoza INNER JOIN TrombComponents ' +
    'ON TrombDoza.КодТ = TrombComponents.КодДТ) ON Tromb.ДатаТ = TrombDoza.ДатаТ ' +
    'WHERE (Tromb.ДатаТ) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#;');
  TempQuery.Open;
  TromboDosesTotal :=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function THarvestingOfTromboDosesTotal.GetValue: string;
begin
  result := TromboDosesTotal;
end;

end.
