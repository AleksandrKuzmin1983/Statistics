unit MIOChangeRecord;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOChangeRecord = interface
    procedure ChangeRecord(Date: Extended; NameTap: String; Num: String; Id: String);
    procedure destroy;
  end;

  TMIOChangeRecord = class(TInterfacedObject,
    IMIOChangeRecord)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    procedure ChangeRecord(Date: Extended; NameTap: String; Num: String; Id: String);
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOChangeRecord.ChangeRecord(Date: Extended; NameTap: String; Num: String; Id: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    with TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE NewOKDK SET NewOKDK.DateTap = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'NewOKDK.Tap=''' + NameTap + ''', ' +
        'NewOKDK.Numb=' + Num + ' ' +
        'WHERE NewOKDK.Код=' + Id);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMIOChangeRecord.destroy;
begin
  if Assigned(TempQuery) then
    FreeAndNil(TempQuery);
  if Assigned(TempConnect) then
    TempConnect.destroy;
end;

end.
