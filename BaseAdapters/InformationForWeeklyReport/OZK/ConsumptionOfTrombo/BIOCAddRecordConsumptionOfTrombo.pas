unit BIOCAddRecordConsumptionOfTrombo;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOCAddRecordConsumptionOfTrombo = interface
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; NumOfPackets: String; Reason: String);
  end;

  TBIOCAddRecordConsumptionOfTrombo = class(TInterfacedObject,
    IBIOCAddRecordConsumptionOfTrombo)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; NumOfPackets: String; Reason: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOCAddRecordConsumptionOfTrombo.AddRecord(Date: Extended;
  ProdList: String; Volume: String; NumOfDoses: String; NumOfPackets: String;
  Reason: String);
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
      SQL.Add('INSERT INTO [Брак компонентов и другой расход] (ДАТАЗАГ, ДАТАБР, БТВ, БТО, БТД, БТПАК, БТП) VALUES '
        + '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
        ProdList + ''', ' + Volume + ', ' + NumOfDoses + ', ' + NumOfPackets +
        ', ''' + Reason + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOCAddRecordConsumptionOfTrombo.AddRecord выполнена');
end;

end.
