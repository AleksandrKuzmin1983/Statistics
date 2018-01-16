unit MIODeleteRecord;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIODeleteRecord = interface
    procedure DeleteRecord(NumRecord: String);
    procedure destroy;
  end;

  TMIODeleteRecord = class(TInterfacedObject,
    IMIODeleteRecord)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    procedure DeleteRecord(NumRecord: String);
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIODeleteRecord.DeleteRecord(NumRecord: String);
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
      SQL.Add('DELETE FROM NewOKDK WHERE NewOKDK.Код=' + NumRecord);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
procedure TMIODeleteRecord.destroy;
begin
  TempConnect.destroy;
  TempConnect:=nil;
  if Assigned(TempQuery) then
    TempQuery.Free;
end;

end.
