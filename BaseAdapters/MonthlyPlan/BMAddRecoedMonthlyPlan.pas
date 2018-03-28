unit BMAddRecoedMonthlyPlan;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMMAddRecoedMonthlyPlan = interface
    procedure AddRecordPlasma(Date: Extended; VolumeWholeBlood: String; VolumeStoredBlood: String;
      VolumePlasmaTotal: String; ProceduresBlood: String; ProceduresPlasmaAPA: String; ProceduresTrombo: String;
      VolumePlasmaAPA: String; VolumeErSusp: String; VolumeTrombo: String; NumberWorkDays: String);
    procedure AddRecordDays(Days: Extended);
  end;

  TMMAddRecoedMonthlyPlan = class(TInterfacedObject,
    IMMAddRecoedMonthlyPlan)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: TDate;
  public
    procedure AddRecordPlasma(Date: Extended; VolumeWholeBlood: String; VolumeStoredBlood: String;
      VolumePlasmaTotal: String; ProceduresBlood: String; ProceduresPlasmaAPA: String; ProceduresTrombo: String;
      VolumePlasmaAPA: String; VolumeErSusp: String; VolumeTrombo: String; NumberWorkDays: String);
    procedure AddRecordDays(Days: Extended);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMMAddRecoedMonthlyPlan.AddRecordPlasma(Date: Extended; VolumeWholeBlood: String; VolumeStoredBlood: String;
      VolumePlasmaTotal: String; ProceduresBlood: String; ProceduresPlasmaAPA: String; ProceduresTrombo: String;
      VolumePlasmaAPA: String; VolumeErSusp: String; VolumeTrombo: String; NumberWorkDays: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
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
      SQL.Add('INSERT INTO Plans([ƒ‡Ú‡œÎ‡Ì], [Œ÷ ], [Œ  ], [Œœ], [ œ ], [ œœ], [ œ“], [Œ¿œ¿], [Œ›¬], [ ≈ƒ“], [ –ƒ]) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        VolumeWholeBlood + ', ' +
        VolumeStoredBlood + ', ' +
        VolumePlasmaTotal + ', ' +
        ProceduresBlood + ', ' +
        ProceduresPlasmaAPA + ', ' +
        ProceduresTrombo + ', ' +
        VolumePlasmaAPA + ', ' +
        VolumeErSusp + ', ' +
        VolumeTrombo + ', ' +
        NumberWorkDays + ' )');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMMAddRecoedMonthlyPlan.AddRecordDays(Days: Extended);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection:= TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('SELECT top 1 Plans.[ƒ‡Ú‡œÎ‡Ì] FROM Plans ORDER BY Plans.[ƒ‡Ú‡œÎ‡Ì] DESC');
      Open;
      Recordset.MoveFirst;
      TempId:=Fields[0].value;
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO FactoryCal([ƒ‡Ú‡œÎ‡Ì], [ƒÂÌ¸]) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(TempId)) + '#, ' +
        '#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Days)) + '#) ');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
