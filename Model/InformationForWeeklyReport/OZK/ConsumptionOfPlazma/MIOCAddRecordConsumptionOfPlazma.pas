unit MIOCAddRecordConsumptionOfPlazma;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOCAddRecordConsumptionOfPlazma = interface
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String; NumOfDoses: String; Reason: String);
  end;

  TMIOCAddRecordConsumptionOfPlazma = class(TInterfacedObject,
    IMIOCAddRecordConsumptionOfPlazma)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String; NumOfDoses: String; Reason: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOCAddRecordConsumptionOfPlazma.AddRecord(Date: Extended; ProdList: String; Volume: String; NumOfDoses: String; Reason: String);
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
      SQL.Add('INSERT INTO [���� ����������� � ������ ������] (�������, ������, ���, ���, ���, ���) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
        ProdList + ''', ' +
        Volume + ', ' + NumOfDoses + ', ''' +
        Reason + ''')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
