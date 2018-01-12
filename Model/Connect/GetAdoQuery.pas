unit GetAdoQuery;

interface

uses
  SysUtils, Data.Win.ADODB;

type
  ITempAdoQuery = interface
    function GetConnect: TADOConnection;
    procedure destroy;
  end;

  TTempAdoQuery = class(TADOQuery, ITempAdoQuery)
  private
    Connect: TADOConnection;
  public
    constructor create;
    function GetConnect: TADOConnection;
    procedure destroy;
  end;

implementation

{ Connecting }

constructor TTempAdoQuery.create;
begin
  if not Assigned(Connect) then
    Connect := TADOConnection.create(nil);
  Connect.ConnectionString:='FILE NAME=..\Model\Connect\ConnectingStringx64.udl';
{  Connect.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;' +
    'Data Source=..\AccesBase\Stat_rab_ver.accdb;Persist Security Info=False';  }
  Connect.LoginPrompt := False;
  Connect.KeepConnection := False;
end;

procedure TTempAdoQuery.destroy;
begin
  if Assigned(Connect) then
    FreeAndNil(Connect);
end;

function TTempAdoQuery.GetConnect: TADOConnection;
begin
  result := Connect;
end;

end.
