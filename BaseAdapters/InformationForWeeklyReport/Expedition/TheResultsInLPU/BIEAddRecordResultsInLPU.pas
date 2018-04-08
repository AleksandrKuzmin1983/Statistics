unit BIEAddRecordResultsInLPU;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIEAddRecordResultsInLPU = interface
    procedure AddRecord(Date: Extended; ProdList: String; TypeLPU: String;
      Volume: String; NumOfDoses: String; Percentage: String;
      NumOfPackets: String);
  end;

  TBIEAddRecordResultsInLPU = class(TInterfacedObject,
    IBIEAddRecordResultsInLPU)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure AddRecord(Date: Extended; ProdList: String; TypeLPU: String;
      Volume: String; NumOfDoses: String; Percentage: String;
      NumOfPackets: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIEAddRecordResultsInLPU.AddRecord(Date: Extended; ProdList: String;
  TypeLPU: String; Volume: String; NumOfDoses: String; Percentage: String;
  NumOfPackets: String);
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
      SQL.Add('INSERT INTO Exped (ƒ¿“¿À«, Õ—, ¬À«, À«Œ, À«ƒ, À«œ–, À«œ¿ ) VALUES '
        + '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
        ProdList + ''', ''' + TypeLPU + ''', ' + Volume + ', ' + NumOfDoses +
        ', ' + Percentage + ', ' + NumOfPackets + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIEAddRecordResultsInLPU.AddRecord ‚˚ÔÓÎÌÂÌ‡');
end;

end.
