unit MIOCChangeRecordConsumptionOfPlazma;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOCChangeRecordConsumptionOfPlazma = interface
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; Reason: String; Id: String);
  end;

  TMIOCChangeRecordConsumptionOfPlazma = class(TInterfacedObject,
    IMIOCChangeRecordConsumptionOfPlazma)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; Reason: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOCChangeRecordConsumptionOfPlazma.ChangeRecord(Date: Extended; ProdList: String; Volume: String;
  NumOfDoses: String; Reason: String; Id: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
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
      SQL.Add('UPDATE [���� ����������� � ������ ������] SET ' +
        '[���� ����������� � ������ ������].������� = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[���� ����������� � ������ ������].������ = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[���� ����������� � ������ ������].��� =''' + ProdList + ''', ' +
        '[���� ����������� � ������ ������].���=' + Volume + ', ' +
        '[���� ����������� � ������ ������].���=' + NumOfDoses + ', ' +
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
