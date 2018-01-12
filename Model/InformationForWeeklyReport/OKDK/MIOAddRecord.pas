unit MIOAddRecord;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOAddRecord = interface
    procedure AddRecord(Date: Extended; CTap: String; Num: String);
    procedure destroy;
  end;

  TMIOAddRecord = class(TInterfacedObject,
    IMIOAddRecord)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    procedure AddRecord(Date: Extended; CTap: String; Num: String);
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOAddRecord.AddRecord(Date: Extended; CTap: String; Num: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;   //
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);    //
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    with TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO NewOKDK (DateTap, Tap, Numb) VALUES ' +
      '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
      CTap + ''', ' +
      Num + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
procedure TMIOAddRecord.destroy;
begin
  if Assigned(TempQuery) then
    FreeAndNil(TempQuery);
  if Assigned(TempConnect) then
    TempConnect.destroy;
end;

end.
