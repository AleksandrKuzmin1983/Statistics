unit BIEAddRecordResultsInKray;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMIEAddRecordResultsInKray = interface
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String; NumOfDoses: String; NumOfPackets: String);
  end;

  TMIEAddRecordResultsInKray = class(TInterfacedObject,
    IMIEAddRecordResultsInKray)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String; NumOfDoses: String; NumOfPackets: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIEAddRecordResultsInKray.AddRecord(Date: Extended; ProdList: String; Volume: String; NumOfDoses: String; NumOfPackets: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO Exped (ÄÀÒÀËÇ, ÍÑ, ÂËÇ, ËÇÎ, ËÇÄ, ËÇÏÀÊ) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
        ProdList + ''', "Êðàé", ' +
        Volume + ', ' + NumOfDoses + ', ' + NumOfPackets + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
