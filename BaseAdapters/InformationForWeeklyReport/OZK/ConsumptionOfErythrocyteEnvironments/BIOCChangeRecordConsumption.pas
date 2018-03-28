unit BIOCChangeRecordConsumption;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMIOCChangeRecordConsumption = interface
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; Reason: String; Id: String);
  end;

  TMIOCChangeRecordConsumption = class(TInterfacedObject,
    IMIOCChangeRecordConsumption)
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

procedure TMIOCChangeRecordConsumption.ChangeRecord(Date: Extended; ProdList: String; Volume: String;
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
        '[Брак компонентов и другой расход].БЭСВ =''' + ProdList + ''', ' +
        '[Брак компонентов и другой расход].БЭСО=' + Volume + ', ' +
        '[Брак компонентов и другой расход].БЭСД=' + NumOfDoses + ', ' +
        '[Брак компонентов и другой расход].БЭСП=''' + Reason + ''' ' +
        'WHERE [Брак компонентов и другой расход].Код=' + Id);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.
