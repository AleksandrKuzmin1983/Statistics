unit MIECAddRecordCancellation;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIECAddRecordCancellation = interface
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String; NumOfDoses: String; NumOfPackets: String);
  end;

  TMIECAddRecordCancellation = class(TInterfacedObject,
    IMIECAddRecordCancellation)
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

procedure TMIECAddRecordCancellation.AddRecord(Date: Extended; ProdList: String; Volume: String; NumOfDoses: String; NumOfPackets: String);
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
        ProdList + ''', "Êðàé (ñïèñàíèå)", ' +
        Volume + ', ' + NumOfDoses + ', ' + NumOfPackets + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
