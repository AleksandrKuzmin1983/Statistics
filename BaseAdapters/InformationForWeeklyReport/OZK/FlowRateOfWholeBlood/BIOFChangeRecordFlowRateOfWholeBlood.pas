unit BIOFChangeRecordFlowRateOfWholeBlood;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMIOFChangeRecordFlowRateOfWholeBlood = interface
    procedure ChangeRecord(Date: Extended; Volume: String;
  NumOfDoses: String; Reason: String; Id: String);
  end;

  TMIOFChangeRecordFlowRateOfWholeBlood = class(TInterfacedObject,
    IMIOFChangeRecordFlowRateOfWholeBlood)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure ChangeRecord(Date: Extended; Volume: String;
  NumOfDoses: String; Reason: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOFChangeRecordFlowRateOfWholeBlood.ChangeRecord(Date: Extended; Volume: String;
  NumOfDoses: String; Reason: String; Id: String);
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
      SQL.Add('UPDATE [Брак компонентов и другой расход] SET ' +
        '[Брак компонентов и другой расход].ДАТАЗАГ = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[Брак компонентов и другой расход].ДАТАБР = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[Брак компонентов и другой расход].БЦКО=' + Volume + ', ' +
        '[Брак компонентов и другой расход].БЦКД=' + NumOfDoses + ', ' +
        '[Брак компонентов и другой расход].БКЦП=''' + Reason + ''' ' +
        'WHERE [Брак компонентов и другой расход].Код=' + Id);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.
