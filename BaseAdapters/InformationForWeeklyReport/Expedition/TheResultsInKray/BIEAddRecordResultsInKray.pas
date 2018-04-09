unit BIEAddRecordResultsInKray;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, CodeSiteLogging, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIEAddRecordResultsInKray = interface
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; NumOfPackets: String);
  end;

  TBIEAddRecordResultsInKray = class(TInterfacedObject,
    IBIEAddRecordResultsInKray)
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

procedure TBIEAddRecordResultsInKray.AddRecord(Date: Extended; ProdList: String;
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
      SQL.Add('INSERT INTO Exped (ƒ¿“¿À«, Õ—, ¬À«, À«Œ, À«ƒ, À«œ¿ ) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
        ProdList + ''', " ‡È", ' + Volume + ', ' + NumOfDoses + ', ' +
        NumOfPackets + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIEAddRecordResultsInKray.AddRecord ‚˚ÔÓÎÌÂÌ‡');
end;
end.
