unit BIOAddRecord;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOAddRecord = interface
    procedure AddRecord(Date: Extended; CTap: String; Num: String;
      Outing: String);
    procedure destroy;
  end;

  TBIOAddRecord = class(TInterfacedObject, IBIOAddRecord)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    procedure AddRecord(Date: Extended; CTap: String; Num: String;
      Outing: String);
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOAddRecord.AddRecord(Date: Extended; CTap: String; Num: String;
  Outing: string);
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
      SQL.Add('INSERT INTO NewOKDK (DateTap, Tap, Numb, Outing) VALUES ' + '(#'
        + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' + CTap +
        ''', ' + Num + ', ' + Outing + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOAddRecord.AddRecord выполнена');
end;

procedure TBIOAddRecord.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOAddRecord.destroy выполнена');
end;

end.
