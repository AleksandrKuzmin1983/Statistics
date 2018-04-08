unit BIOAAddRecordResultsAmountOfUsableErSusp;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, CodeSiteLogging, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOAAddRecordResultsAmountOfUsableErSusp = interface
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String);
  end;

  TBIOAAddRecordResultsAmountOfUsableErSusp = class(TInterfacedObject,
    IBIOAAddRecordResultsAmountOfUsableErSusp)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOAAddRecordResultsAmountOfUsableErSusp.AddRecord(Date: Extended;
  ProdList: String; Volume: String);
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
      SQL.Add('INSERT INTO Exped (ƒ¿“¿À«, Õ—, œ√›—) VALUES ' + '(#' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' + ProdList
        + ''', ' + Volume + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOAAddRecordResultsAmountOfUsableErSusp.AddRecord ‚˚ÔÓÎÌÂÌ‡');
end;

end.
