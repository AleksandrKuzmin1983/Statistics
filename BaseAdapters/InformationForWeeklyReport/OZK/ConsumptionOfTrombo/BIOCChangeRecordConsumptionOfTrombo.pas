unit BIOCChangeRecordConsumptionOfTrombo;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOCChangeRecordConsumptionOfTrombo = interface
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; NumOfPackets: String; Reason: String; Id: String);
  end;

  TBIOCChangeRecordConsumptionOfTrombo = class(TInterfacedObject,
    IBIOCChangeRecordConsumptionOfTrombo)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; NumOfPackets: String; Reason: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOCChangeRecordConsumptionOfTrombo.ChangeRecord(Date: Extended;
  ProdList: String; Volume: String; NumOfDoses: String; NumOfPackets: String;
  Reason: String; Id: String);
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
      SQL.Add('UPDATE [���� ����������� � ������ ������] SET ' +
        '[���� ����������� � ������ ������].������� = #' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[���� ����������� � ������ ������].������ = #' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[���� ����������� � ������ ������].��� =''' + ProdList + ''', ' +
        '[���� ����������� � ������ ������].���=' + Volume + ', ' +
        '[���� ����������� � ������ ������].���=' + NumOfDoses + ', ' +
        '[���� ����������� � ������ ������].�����=' + NumOfPackets + ', ' +
        '[���� ����������� � ������ ������].���=''' + Reason + ''' ' +
        'WHERE [���� ����������� � ������ ������].���=' + Id);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOCChangeRecordConsumptionOfTrombo.ChangeRecord ���������');
end;

end.
