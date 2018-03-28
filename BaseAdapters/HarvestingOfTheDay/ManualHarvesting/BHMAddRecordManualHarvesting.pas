unit BHMAddRecordManualHarvesting;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMHMAddRecordManualHarvesting = interface
    procedure AddRecordBlood(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String; Outing: String);
    procedure AddRecordBloodDoze(Date: Extended; Volue300: String; Volue350: String;
      Volue400: String; Volue450: String; Volue500: String);
    procedure AddRecordBloodErSusp(VolumeErSusp: String; NumberDosesErSusp: String; TypeProduction: String);
    procedure AddRecordBloodPlazma(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordBloodFiltrat(VolumeFiltrat: String; NumberDosesFiltrat: String);
    procedure AddRecordBloodDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
  end;

  TMHMAddRecordManualHarvesting = class(TInterfacedObject,
    IMHMAddRecordManualHarvesting)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure AddRecordBlood(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String; Outing: String);
    procedure AddRecordBloodDoze(Date: Extended; Volue300: String; Volue350: String;
      Volue400: String; Volue450: String; Volue500: String);
    procedure AddRecordBloodErSusp(VolumeErSusp: String; NumberDosesErSusp: String; TypeProduction: String);
    procedure AddRecordBloodPlazma(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordBloodFiltrat(VolumeFiltrat: String; NumberDosesFiltrat: String);
    procedure AddRecordBloodDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMHMAddRecordManualHarvesting.AddRecordBlood(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String; Outing: String);
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
      SQL.Add('INSERT INTO Blood([ƒ‡Ú‡ ], [ ƒ ], [Õ‡ ÓÌ ], [À‡· ], [÷ÂÎ ], [ ÓÌ ], [¬˚ÂÁ‰]) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        VolumeDonors + ', ' +
        SentToPreserving + ', ' +
        ForLaboratoryResearch + ', ' +
        AllWholeBlood + ', ' +
        AllStoredBlood + ', ' +
        Outing + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHMAddRecordManualHarvesting.AddRecordBloodDoze(Date: Extended; Volue300: String; Volue350: String;
  Volue400: String; Volue450: String; Volue500: String);
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
      SQL.Add('INSERT INTO BloodDoza([ƒ‡Ú‡ ], [300], [350], [400], [450], [500]) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        Volue300 + ', ' +
        Volue350 + ', ' +
        Volue400 + ', ' +
        Volue450 + ', ' +
        Volue500 + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;



procedure TMHMAddRecordManualHarvesting.AddRecordBloodErSusp(VolumeErSusp: String; NumberDosesErSusp: String; TypeProduction: String);
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
      SQL.Add('SELECT top 1 BloodDoza.[ Ó‰ƒ] FROM BloodDoza order by BloodDoza.[ Ó‰ƒ] DESC');
      Open;
      Recordset.MoveFirst;
      TempId:=IntToStr(Fields[0].value);
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO BloodErSusp([ Ó‰], [ƒ›¬], [ ›¬], [¬Ë‰›¬]) VALUES ' +
        '(' + TempId + ', ' +
        NumberDosesErSusp + ', ' +
        VolumeErSusp + ', ''' +
        TypeProduction + ''')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHMAddRecordManualHarvesting.AddRecordBloodPlazma(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
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
      SQL.Add('INSERT INTO BloodPlasma([ Ó‰›], [ƒœÀ], [ œÀ], [¬Ë‰œÀ]) VALUES ' +
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

procedure TMHMAddRecordManualHarvesting.AddRecordBloodFiltrat(VolumeFiltrat: String; NumberDosesFiltrat: String);
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
      SQL.Add('INSERT INTO Filtrat([ Ó‰œ], [ƒ‘], [ ‘]) VALUES ' +
        '(' + TempId + ', ' +
        NumberDosesFiltrat + ', ' +
        VolumeFiltrat + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHMAddRecordManualHarvesting.AddRecordBloodDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
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
      SQL.Add('INSERT INTO BloodBrak([ Ó‰‘], [ƒ¡–], [ ¡–], [¬Ë‰¡–]) VALUES ' +
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
