unit MIEAddRecordResultsInLPU;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIEAddRecordResultsInLPU = interface
    procedure AddRecord(Date: Extended; ProdList: String; TypeLPU: String; Volume: String; NumOfDoses: String; Percentage: String; NumOfPackets: String);
  end;

  TMIEAddRecordResultsInLPU = class(TInterfacedObject,
    IMIEAddRecordResultsInLPU)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure AddRecord(Date: Extended; ProdList: String; TypeLPU: String; Volume: String; NumOfDoses: String; Percentage: String; NumOfPackets: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIEAddRecordResultsInLPU.AddRecord(Date: Extended; ProdList: String; TypeLPU: String; Volume: String; NumOfDoses: String; Percentage: String; NumOfPackets: String);
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
      SQL.Add('INSERT INTO Exped (������, ��, ���, ���, ���, ����, �����) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
        ProdList + ''', ''' +  TypeLPU + ''', ' +
        Volume + ', ' + NumOfDoses + ', ' + Percentage + ', ' + NumOfPackets + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.
