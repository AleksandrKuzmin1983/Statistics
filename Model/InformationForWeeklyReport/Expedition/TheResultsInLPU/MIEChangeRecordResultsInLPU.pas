unit MIEChangeRecordResultsInLPU;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIEChangeRecordResultsInLPU = interface
    procedure ChangeRecord(Date: Extended; ProdList: String; TypeLPU: String; Volume: String;
      NumOfDoses: String; Percentage: String; NumOfPackets: String; Id: String);
  end;

  TMIEChangeRecordResultsInLPU = class(TInterfacedObject,
    IMIEChangeRecordResultsInLPU)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure ChangeRecord(Date: Extended; ProdList: String; TypeLPU: String; Volume: String;
      NumOfDoses: String; Percentage: String; NumOfPackets: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIEChangeRecordResultsInLPU.ChangeRecord(Date: Extended; ProdList: String; TypeLPU: String; Volume: String;
  NumOfDoses: String; Percentage: String; NumOfPackets: String; Id: String);
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
      SQL.Add('UPDATE Exped SET Exped.������ = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'Exped.�� =''' + ProdList + ''', ' +
        'Exped.��� =''' + TypeLPU + ''', ' +
        'Exped.���=' + Volume + ', ' +
        'Exped.���=' + NumOfDoses + ', ' +
        'Exped.����=' + Percentage + ', ' +
        'Exped.�����=' + NumOfPackets + ' ' +
        'WHERE Exped.���=' + Id);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
