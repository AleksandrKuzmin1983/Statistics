unit BIECAddRecordCancellation;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, CodeSiteLogging, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIECAddRecordCancellation = interface
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; NumOfPackets: String);
  end;

  TBIECAddRecordCancellation = class(TInterfacedObject,
    IBIECAddRecordCancellation)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; NumOfPackets: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIECAddRecordCancellation.AddRecord(Date: Extended; ProdList: String;
  Volume: String; NumOfDoses: String; NumOfPackets: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO Exped (ДАТАЛЗ, НС, ВЛЗ, ЛЗО, ЛЗД, ЛЗПАК) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
        ProdList + ''', "Край (списание)", ' + Volume + ', ' + NumOfDoses + ', '
        + NumOfPackets + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIECAddRecordCancellation.AddRecord выполнена');
end;

end.
