unit MIOFAddRecordFlowRateOfWholeBlood;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOFAddRecordFlowRateOfWholeBlood = interface
    procedure AddRecord(Date: Extended; Volume: String; NumOfDoses: String; Reason: String);
  end;

  TMIOFAddRecordFlowRateOfWholeBlood = class(TInterfacedObject,
    IMIOFAddRecordFlowRateOfWholeBlood)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure AddRecord(Date: Extended; Volume: String; NumOfDoses: String; Reason: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOFAddRecordFlowRateOfWholeBlood.AddRecord(Date: Extended; Volume: String; NumOfDoses: String; Reason: String);
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
      SQL.Add('INSERT INTO [Брак компонентов и другой расход] (ДАТАЗАГ, ДАТАБР, БЦКО, БЦКД, БКЦП) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
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
