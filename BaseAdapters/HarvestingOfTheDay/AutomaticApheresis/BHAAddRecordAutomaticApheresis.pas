unit BHAAddRecordAutomaticApheresis;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBHAAddRecordAutomaticApheresis = interface
    procedure AddRecordPlasma(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String);
    procedure AddRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure AddRecordPlasmaComponents(VolumePlazma: String;
      NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordPlasmaDefect(VolumeDefects: String;
      NumberDosesDefects: String; TypeOfDefect: String);
  end;

  TBHAAddRecordAutomaticApheresis = class(TInterfacedObject,
    IBHAAddRecordAutomaticApheresis)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure AddRecordPlasma(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String);
    procedure AddRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure AddRecordPlasmaComponents(VolumePlazma: String;
      NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordPlasmaDefect(VolumeDefects: String;
      NumberDosesDefects: String; TypeOfDefect: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBHAAddRecordAutomaticApheresis.AddRecordPlasma(Date: Extended;
  VolumeDonors: String; SentToPreserving: String; ForLaboratoryResearch: String;
  AllWholeBlood: String; AllStoredBlood: String);
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
      SQL.Add('INSERT INTO Plasma([�����], [���], [������], [����], [����], [����]) VALUES '
        + '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        VolumeDonors + ', ' + SentToPreserving + ', ' + ForLaboratoryResearch +
        ', ' + AllWholeBlood + ', ' + AllStoredBlood + ' )');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAAddRecordAutomaticApheresis.AddRecordPlasma ���������');
end;

procedure TBHAAddRecordAutomaticApheresis.AddRecordPlasmaDoza(Date: Extended;
  Volue600: String);
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
      SQL.Add('INSERT INTO PlazmaDoza([�����], [600]) VALUES ' + '(#' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        Volue600 + ' )');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAAddRecordAutomaticApheresis.AddRecordPlasmaDoza ���������');
end;

procedure TBHAAddRecordAutomaticApheresis.AddRecordPlasmaComponents
  (VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection;
      Close;
      SQL.Clear;
      SQL.Add('SELECT top 1 PlazmaDoza.[�����] FROM PlazmaDoza ORDER BY PlazmaDoza.[�����] DESC');
      Open;
      Recordset.MoveFirst;
      TempId := IntToStr(Fields[0].value);
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO PlasmaComponents([�����], [����], [����], [������]) VALUES '
        + '(' + TempId + ', ' + NumberDosesPlazma + ', ' + VolumePlazma + ', '''
        + TypeProduction + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAAddRecordAutomaticApheresis.AddRecordPlasmaComponents ���������');
end;

procedure TBHAAddRecordAutomaticApheresis.AddRecordPlasmaDefect
  (VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
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
      SQL.Add('INSERT INTO PlazmaBrak([�����], [����], [����], [������]) VALUES '
        + '(' + TempId + ', ' + NumberDosesDefects + ', ' + VolumeDefects +
        ', ''' + TypeOfDefect + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAAddRecordAutomaticApheresis.AddRecordPlasmaDefect ���������');
end;
end.
