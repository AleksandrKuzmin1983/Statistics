unit GetAdoConnect;

interface

uses
  SysUtils, CodeSiteLogging, Data.Win.ADODB;

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
  CurrentDir := ExtractFileDir(ExtractFileDir(ParamStr(0)));
  if not Assigned(Connect) then
    Connect := TADOConnection.create(nil);
  Connect.ConnectionString := 'FILE NAME=' + CurrentDir +
    '\BaseAdapters\Connect\ConnectingStringx64.udl';
  Connect.LoginPrompt := False;
  Connect.KeepConnection := False;

  CodeSite.Send(FormatDateTime('c', Now) + ' TTempAdoQuery.create выполнена');
end;

procedure TTempAdoQuery.destroy;
begin
  if Assigned(Connect) then
    Connect.Free;

  CodeSite.Send(FormatDateTime('c', Now) + ' TTempAdoQuery.destroy выполнена');
end;

function TTempAdoQuery.GetConnect: TADOConnection;
begin
  result := Connect;

  CodeSite.Send(FormatDateTime('c', Now) + ' TTempAdoQuery.GetConnect выполнена');
end;

end.
