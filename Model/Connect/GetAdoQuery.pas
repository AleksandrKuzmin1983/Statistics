unit GetAdoQuery;

interface

uses
  SysUtils, Data.Win.ADODB;

type
  ITempAdoQuery = interface
    function GetConnect: TADOConnection;
    procedure destroy;
  end;

  TTempAdoQuery = class(TInterfacedObject, ITempAdoQuery)
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
var
  CurrentDir: String;
begin
  CurrentDir:=ExtractFileDir(ExtractFileDir(ParamStr(0)));
  if not Assigned(Connect) then
    Connect := TADOConnection.create(nil);
  Connect.ConnectionString:='FILE NAME=' + CurrentDir + '\Model\Connect\ConnectingStringx64.udl';
//  Connect.ConnectionString:='FILE NAME=..\Model\Connect\ConnectingStringx64.udl';
  Connect.LoginPrompt := False;
  Connect.KeepConnection := False;
end;

procedure TTempAdoQuery.destroy;
begin
  if Assigned(Connect) then
    Connect.Free;
end;

function TTempAdoQuery.GetConnect: TADOConnection;
begin
  result := Connect;
end;

end.
