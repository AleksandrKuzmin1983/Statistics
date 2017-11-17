unit ConnectingUnit1;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, Data.DB, Data.Win.ADODB, Contnrs,
  Generics.Collections;
type
  Connecting = class
  private
    Connect: TADOConnection;
    Query: TADOQuery;
    DataSource: TDataSource;
  public
    function GetConnect: TADOConnection;
    procedure GetDataQuery(SQL: string);
    function GetQuery: TDataSource;
    constructor create;
  end;

  BloodTable = class
  private
    //DateK: Tdate;
    KolDon: integer;
    //OnConservation: real;
    //OnLaborIssled: real;
    //CellBlood: real;
    //ConservationBloob: real;

  end;

   TMyList=class(TObjectList<BloodTable>)
     //fConnecting: Connecting;
     function AddNew(KolDon: integer):BloodTable;

     //procedure GetTableBlood;
   end;

implementation

{ Connecting }

constructor Connecting.create;
begin
  Connect:=TADOConnection.Create(nil);
  Connect.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;' +
  'Data Source=C:\Users\ñòóä.k201-09\Documents\77-5\Statistics\MainForm\db\Stat_rab_ver.mdb;' +
  'Persist Security Info=False';
  Connect.LoginPrompt:=False;
  Connect.Connected:=true;

end;

function Connecting.GetConnect: TADOConnection;
begin
  result:=connect;
end;

procedure Connecting.GetDataQuery(SQL: string);
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
  //result := Query;
end;

function Connecting.GetQuery: TDataSource;
begin
  result := DataSource;
end;

{ TMyList }
      {
procedure TMyList.GetTableBlood;
var
  i: integer;
  DataSource1: TDataSource;
begin
  fConnecting := Connecting.create;
  fConnecting.GetDataQuery('select top 1 551 from Blood;');

  DataSource1:=fConnecting;
while not DataSource1.DataSet.Eof do
begin
  AddNew(DataSet.fieldByName('[ÊÄÊ]').AsInteger);
  dataset.next;
end;

end;  }

{ TMyList }

function TMyList.AddNew(KolDon: integer): BloodTable;
begin
  result := BloodTable.Create;
  result.KolDon:=KolDon;
  add(result);
end;

end.
