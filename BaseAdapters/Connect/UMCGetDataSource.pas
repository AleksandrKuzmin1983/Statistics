unit UMCGetDataSource;

interface

uses
  SysUtils, Variants, Data.DB,
  Dialogs, Data.Win.ADODB,
  GetAdoConnect;

type
  IGetDataSource = interface
    function GetDataSource: TDataSource;
    procedure Insert;
    procedure Post;
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
    procedure Insert;
    procedure Post;
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
  try
    TempQuery.SQL.Add(CSQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
  TempDataSource.DataSet:=TempQuery;
end;

function TGetDataSource.GetDataSource: TDataSource;
begin
  result := TempDataSource;
end;

procedure TGetDataSource.Insert;
begin
  Try
    TempQuery.Insert;
  Except
    ShowMessage('Не могу добавить запись к базу данных (UMCGetDataSource)!' + chr(13) + 'Обратитесь к администратору!');
  End;
end;

procedure TGetDataSource.CloseConnect;
begin
  TempQuery.Close;
end;

procedure TGetDataSource.OpenConnect;
begin
  Try
    TempQuery.Open;
  Except
    ShowMessage('Не могу подключиться к базе данных (UMCGetDataSource)!' + chr(13) + 'Обратитесь к администратору!');
  End;
end;
procedure TGetDataSource.Post;
begin
  Try
    TempQuery.Post;
  Except
    ShowMessage('Не могу сохранить изменения в базе данных (UMCGetDataSource)!' + chr(13) + 'Обратитесь к администратору!');
  end;
end;
end.
