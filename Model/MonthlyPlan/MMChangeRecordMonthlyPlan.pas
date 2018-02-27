unit MMChangeRecordMonthlyPlan;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  GetAdoQuery;

type
  IMMChangeRecordMonthlyPlan = interface
    procedure ChangeRecordPlasma(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String);
    procedure ChangeRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure GetTempId(Date: String);
  end;

  TMMChangeRecordMonthlyPlan = class(TInterfacedObject,
    IMMChangeRecordMonthlyPlan)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure ChangeRecordPlasma(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String);
    procedure ChangeRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure GetTempId(Date: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMMChangeRecordMonthlyPlan.ChangeRecordPlasma(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('UPDATE Plasma SET ' +
        'Plasma.КДП=' + VolumeDonors + ', ' +
        'Plasma.НаКонП=' + SentToPreserving + ', ' +
        'Plasma.ЛабП=' + ForLaboratoryResearch + ', ' +
        'Plasma.ЦелП=' + AllWholeBlood + ', ' +
        'Plasma.КонП=' + AllStoredBlood + ' ' +
        'WHERE Plasma.ДатаП=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMMChangeRecordMonthlyPlan.ChangeRecordPlasmaDoza(Date: Extended; Volue600: String);
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
      SQL.Add('UPDATE PlazmaDoza SET ' +
        'PlazmaDoza.600=' + Volue600 + ' ' +
        'WHERE PlazmaDoza.ДатаП=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMMChangeRecordMonthlyPlan.GetTempId(Date: String);
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
      SQL.Add('SELECT PlazmaDoza.КодПл ' +
      'FROM PlazmaDoza ' +
      'WHERE (PlazmaDoza.ДатаП = #' + Date + '#)');
      Open;
      if not TempQuery.IsEmpty then
      begin
        Recordset.MoveFirst;
        TempId:=IntToStr(Fields[0].value);
      end
      else
        ShowMessage('Id изменяемой строки не определен!');
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
