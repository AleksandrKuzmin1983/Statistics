unit BHAAddRecordAutomaticApheresis;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMHAAddRecordAutomaticApheresis = interface
    procedure AddRecordPlasma(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String);
    procedure AddRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure AddRecordPlasmaComponents(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordPlasmaDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
  end;

  TMHAAddRecordAutomaticApheresis = class(TInterfacedObject,
    IMHAAddRecordAutomaticApheresis)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure AddRecordPlasma(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String);
    procedure AddRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure AddRecordPlasmaComponents(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordPlasmaDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMHAAddRecordAutomaticApheresis.AddRecordPlasma(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String);
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
      SQL.Add('INSERT INTO Plasma([ƒ‡Ú‡œ], [ ƒœ], [Õ‡ ÓÌœ], [À‡·œ], [÷ÂÎœ], [ ÓÌœ]) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        VolumeDonors + ', ' +
        SentToPreserving + ', ' +
        ForLaboratoryResearch + ', ' +
        AllWholeBlood + ', ' +
        AllStoredBlood + ' )');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHAAddRecordAutomaticApheresis.AddRecordPlasmaDoza(Date: Extended; Volue600: String);
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
      SQL.Add('INSERT INTO PlazmaDoza([ƒ‡Ú‡œ], [600]) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        Volue600 + ' )');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHAAddRecordAutomaticApheresis.AddRecordPlasmaComponents(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
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
      SQL.Add('SELECT top 1 PlazmaDoza.[ Ó‰œÎ] FROM PlazmaDoza ORDER BY PlazmaDoza.[ Ó‰œÎ] DESC');
      Open;
      Recordset.MoveFirst;
      TempId:=IntToStr(Fields[0].value);
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO PlasmaComponents([ Ó‰ƒœ], [ƒœÀœ], [ œÀœ], [¬Ë‰œÀœ]) VALUES ' +
        '(' + TempId + ', ' +
        NumberDosesPlazma + ', ' +
        VolumePlazma + ', ''' +
        TypeProduction + ''')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHAAddRecordAutomaticApheresis.AddRecordPlasmaDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
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
      SQL.Add('INSERT INTO PlazmaBrak([ Ó‰ œ], [ƒ¡–œ], [ ¡–œ], [¬Ë‰¡–œ]) VALUES ' +
        '(' + TempId + ', ' +
        NumberDosesDefects + ', ' +
        VolumeDefects + ', ''' +
        TypeOfDefect + ''')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
