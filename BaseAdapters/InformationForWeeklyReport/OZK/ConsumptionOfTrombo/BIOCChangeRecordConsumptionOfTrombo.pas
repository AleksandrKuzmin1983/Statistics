unit BIOCChangeRecordConsumptionOfTrombo;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMIOCChangeRecordConsumptionOfTrombo = interface
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; NumOfPackets: String; Reason: String; Id: String);
  end;

  TMIOCChangeRecordConsumptionOfTrombo = class(TInterfacedObject,
    IMIOCChangeRecordConsumptionOfTrombo)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; NumOfPackets: String; Reason: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOCChangeRecordConsumptionOfTrombo.ChangeRecord(Date: Extended; ProdList: String; Volume: String;
  NumOfDoses: String; NumOfPackets: String; Reason: String; Id: String);
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
      SQL.Add('UPDATE [���� ����������� � ������ ������] SET ' +
        '[���� ����������� � ������ ������].������� = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[���� ����������� � ������ ������].������ = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[���� ����������� � ������ ������].��� =''' + ProdList + ''', ' +
        '[���� ����������� � ������ ������].���=' + Volume + ', ' +
        '[���� ����������� � ������ ������].���=' + NumOfDoses + ', ' +
        '[���� ����������� � ������ ������].�����=' + NumOfPackets + ', ' +
        '[���� ����������� � ������ ������].���=''' + Reason + ''' ' +
        'WHERE [���� ����������� � ������ ������].���=' + Id);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
