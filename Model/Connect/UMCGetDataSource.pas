unit UMCGetDataSource;

interface

uses
  SysUtils, Variants, Data.DB,
  Dialogs, Data.Win.ADODB,
  GetAdoQuery;

type
  IGetDataSource = interface
    function GetDataSource: TDataSource;
    procedure Refresh;  //
    procedure Insert; //
    procedure Post; //
    procedure OpenConnect;
    procedure CloseConnect;
  end;

  TGetDataSource = class(TInterfacedObject, IGetDataSource)
  private
    TempDataSource: TDataSource;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    function GetDataSource: TDataSource;
    procedure Refresh;
    procedure Insert; //
    procedure Post; //
    procedure OpenConnect;
    procedure CloseConnect;
    constructor create(CSQL: string);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TGetDataSource.create(CSQL: string);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
   if not Assigned(TempDataSource) then
    TempDataSource := TDataSource.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add(CSQL);
  TempDataSource.DataSet:=TempQuery;
end;

function TGetDataSource.GetDataSource: TDataSource;
begin
  result := TempDataSource;
end;

procedure TGetDataSource.Insert;
begin
  TempQuery.Insert;
end;

procedure TGetDataSource.CloseConnect;
begin
  TempQuery.Close;
end;

procedure TGetDataSource.OpenConnect;
begin
  TempQuery.Open;
end;
procedure TGetDataSource.Post;
begin
  TempQuery.Post;
end;

procedure TGetDataSource.Refresh;
begin
  TempQuery.Refresh;
end;

end.
