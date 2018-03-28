unit BIOChangeRecord;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOChangeRecord = interface
    procedure ChangeRecord(Date: Extended; NameTap: String; Num: String;
      Id: String; Outing: String);
    procedure destroy;
  end;

  TBIOChangeRecord = class(TInterfacedObject, IBIOChangeRecord)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    procedure ChangeRecord(Date: Extended; NameTap: String; Num: String;
      Id: String; Outing: String);
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOChangeRecord.ChangeRecord(Date: Extended; NameTap: String;
  Num: String; Id: String; Outing: String);
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
      SQL.Add('UPDATE NewOKDK SET NewOKDK.DateTap = #' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'NewOKDK.Tap=''' + NameTap + ''', ' + 'NewOKDK.Numb=' + Num + ', ' +
        'NewOKDK.Outing=' + Outing + ' ' + 'WHERE NewOKDK.Код=' + Id);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

procedure TBIOChangeRecord.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;
end;

end.
