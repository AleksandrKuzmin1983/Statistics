unit GetDataSoursUnit1;

interface

uses
  Data.Win.ADODB;

type

  DataBaseTables = class(TADOQuery)
  // Создаем запрос, содержащий некоторую таблицу
  private
    Connect: TADOConnection;
    // Убрать
    Query: TADOQuery;
  public
    constructor create;
    function GetConnect: TADOConnection;
    // Убрать
    function GetBlood: TADOQuery;
    function GetPlasma: TADOQuery;
    function GetTrombo: TADOQuery;
    function GetSQL(SQL: string): TADOQuery;

  end;

implementation

{ Connecting }

constructor DataBaseTables.create;
begin
  if not Assigned(Connect) then
    Connect := TADOConnection.create(nil);
  Connect.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;' +
    'Data Source=..\AccesBase\Stat_rab_ver.accdb;Persist Security Info=False';
  Connect.LoginPrompt := False;
  Connect.KeepConnection := False;

  // Убрать
  if not Assigned(Query) then
    Query := TADOQuery.create(nil);
  Query.Connection := Connect;
  Query.Close;
end;

function DataBaseTables.GetBlood: TADOQuery;
begin
  Query.SQL.Clear;
  Query.SQL.Add('Select * From Blood');
  result := Query;
end;

function DataBaseTables.GetConnect: TADOConnection;
begin
  result := Connect;
end;

function DataBaseTables.GetPlasma: TADOQuery;
begin
  Query.SQL.Clear;
  Query.SQL.Add('Select * From Plasma');
  result := Query;
end;

function DataBaseTables.GetSQL(SQL: string): TADOQuery;
begin
  Query.SQL.Clear;
  Query.SQL.Add(SQL);
  result := Query;
end;

function DataBaseTables.GetTrombo: TADOQuery;
begin
  Query.SQL.Clear;
  Query.SQL.Add('Select * From Tromb');
  result := Query;
end;

end.
