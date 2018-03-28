unit BHAChangeRecordAutomaticApheresis;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  GetAdoConnect;

type
  IMHAChangeRecordAutomaticApheresis = interface
    procedure ChangeRecordPlasma(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String);
    procedure ChangeRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure ChangeRecordPlasmaComponents(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
    procedure ChangeRecordPlasmaDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
    procedure GetTempId(Date: String);
  end;

  TMHAChangeRecordAutomaticApheresis = class(TInterfacedObject,
    IMHAChangeRecordAutomaticApheresis)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure ChangeRecordPlasma(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String);
    procedure ChangeRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure ChangeRecordPlasmaComponents(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
    procedure ChangeRecordPlasmaDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
    procedure GetTempId(Date: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMHAChangeRecordAutomaticApheresis.ChangeRecordPlasma(Date: Extended; VolumeDonors: String; SentToPreserving: String;
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
        'Plasma.���=' + VolumeDonors + ', ' +
        'Plasma.������=' + SentToPreserving + ', ' +
        'Plasma.����=' + ForLaboratoryResearch + ', ' +
        'Plasma.����=' + AllWholeBlood + ', ' +
        'Plasma.����=' + AllStoredBlood + ' ' +
        'WHERE Plasma.�����=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHAChangeRecordAutomaticApheresis.ChangeRecordPlasmaDoza(Date: Extended; Volue600: String);
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
        'WHERE PlazmaDoza.�����=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHAChangeRecordAutomaticApheresis.GetTempId(Date: String);
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
      SQL.Add('SELECT PlazmaDoza.����� ' +
      'FROM PlazmaDoza ' +
      'WHERE (PlazmaDoza.����� = #' + Date + '#)');
      Open;
      if not TempQuery.IsEmpty then
      begin
        Recordset.MoveFirst;
        TempId:=IntToStr(Fields[0].value);
      end
      else
        ShowMessage('Id ���������� ������ �� ���������!');
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHAChangeRecordAutomaticApheresis.ChangeRecordPlasmaComponents(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
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
      SQL.Add('UPDATE PlasmaComponents SET ' +
        'PlasmaComponents.����=' + NumberDosesPlazma + ', ' +
        'PlasmaComponents.����=' + VolumePlazma + ', ' +
        'PlasmaComponents.������=''' + TypeProduction + ''' ' +
        'WHERE PlasmaComponents.�����=' + TempId);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHAChangeRecordAutomaticApheresis.ChangeRecordPlasmaDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
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
      SQL.Add('UPDATE PlazmaBrak SET ' +
        'PlazmaBrak.����=' + NumberDosesDefects  + ', ' +
        'PlazmaBrak.����=' + VolumeDefects + ', ' +
        'PlazmaBrak.������=''' + TypeOfDefect + ''' ' +
        'WHERE PlazmaBrak.�����=' + TempId);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.
