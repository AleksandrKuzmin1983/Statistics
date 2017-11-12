unit ConnectingUnit1;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, Contnrs, Data.DB, Data.Win.ADODB,
  Generics.Collections;

type
  Connecting = class  //—оздаем запрос, содержащий некоторую таблицу
  private
//    Connect: TADOConnection;
//    DataSource: TDataSource;
    Query: TADOQuery;
  public
//    function GetConnect: TADOConnection;
//    function GetQuery: TDataSource;
{    procedure GetDataQuery(SQL: string);     }
    constructor create;
  end;

  BloodTable = class
  private
//    DateK: Tlistbox;
    KolDon: Tlistbox;
//    OnConservation: Tlistbox;
//    nLaborIssled: Tlistbox;
//    CellBlood: Tlistbox;
//    ConservationBloob: Tlistbox;
  public
    procedure GetData;
//    function AddNew(KD: integer):BloodTable;

  end;

{   TMyList=class(TObjectList<BloodTable>)
     //fConnecting: Connecting;
    // function AddNew(KD: integer):BloodTable;
     //procedure GetTableBlood;
   end;         }

implementation

{ Connecting }

constructor Connecting.create;
begin
//  Connect:=TADOConnection.Create(nil);
//  Connect.ConnectionString:='Provider=Microsoft.ACE.OLEDB.12.0;' +
//  'Data Source=..\AccesBase\Stat_rab_ver.accdb;Persist Security Info=False';
//  Connect.LoginPrompt:=False;
//  Connect.Connected:=true;
  if not Assigned(Query) then
    Query := TADOQuery.create(nil);
  Query.ConnectionString:='Provider=Microsoft.ACE.OLEDB.12.0;' +
  'Data Source=..\AccesBase\Stat_rab_ver.accdb;Persist Security Info=False';
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add('SELECT * FROM Blood');
end;

{function Connecting.GetConnect: TADOConnection;
begin
  result:=connect;
end;        }

{procedure Connecting.GetDataQuery(SQL: string);
begin
  if not Assigned(Query) then
    Query := TADOQuery.create(nil);
  Query.Connection := Connect;
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add(sql);
  Query.Open;
  Query.Active := true;
  if not Assigned(DataSource) then
    DataSource := TDataSource.create(nil);
  DataSource.DataSet := Query;


end;   }

{function Connecting.GetQuery: TDataSource;
begin
  result := DataSource;
end;           }

{ TMyList }

{function TMyList.AddNew(KD: integer): BloodTable;
begin
  MyList:=BloodTable.Create;
  //result := BloodTable.Create;
  MyList.KolDon:=KD;
  //result.KolDon:=KD;
  add(result);
end;       }

{ BloodTable }

procedure BloodTable.GetData;
begin

end;

end.
