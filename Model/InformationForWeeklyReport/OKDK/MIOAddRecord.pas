unit MIOAddRecord;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOAddRecord = interface
    procedure AddRecord(Date: Extended; CTap: String; Num: String; Outing: String);
    procedure destroy;
  end;

  TMIOAddRecord = class(TInterfacedObject,
    IMIOAddRecord)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    procedure AddRecord(Date: Extended; CTap: String; Num: String; Outing: String);
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOAddRecord.AddRecord(Date: Extended; CTap: String; Num: String; Outing: string);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO NewOKDK (DateTap, Tap, Numb, Outing) VALUES ' +
      '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
      CTap + ''', ' +
      Num + ', ' +
      Outing + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
procedure TMIOAddRecord.destroy;
begin
  TempConnect.destroy;
  TempConnect:=nil;
  if Assigned(TempQuery) then
    TempQuery.Free;
end;

end.
