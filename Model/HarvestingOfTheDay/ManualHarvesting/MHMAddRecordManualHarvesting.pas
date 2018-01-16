unit MHMAddRecordManualHarvesting;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

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
    CheckNull: TCheckNull;
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
      SQL.Add('INSERT INTO Blood([�����], [���], [������], [����], [����], [����], [�����]) VALUES ' +
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
      SQL.Add('INSERT INTO BloodDoza([�����], [300], [350], [400], [450], [500]) VALUES ' +
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
      SQL.Add('SELECT top 1 BloodDoza.[����] FROM BloodDoza order by BloodDoza.[����] DESC');
      Open;
      Recordset.MoveFirst;
      TempId:=IntToStr(Fields[0].value);
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO BloodErSusp([���], [���], [���], [�����]) VALUES ' +
        '(' + TempId + ', ' +
        VolumeErSusp + ', ' +
        NumberDosesErSusp + ', ''' +
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
      SQL.Add('INSERT INTO BloodPlasma([����], [���], [���], [�����]) VALUES ' +
        '(' + TempId + ', ' +
        VolumePlazma + ', ' +
        NumberDosesPlazma + ', ''' +
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
      SQL.Add('INSERT INTO Filtrat([����], [��], [��]) VALUES ' +
        '(' + TempId + ', ' +
        VolumeFiltrat + ', ' +
        NumberDosesFiltrat + ')');
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
      SQL.Add('INSERT INTO BloodBrak([����], [���], [���], [�����]) VALUES ' +
        '(' + TempId + ', ' +
        VolumeDefects + ', ' +
        NumberDosesDefects + ', ''' +
        TypeOfDefect + ''')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.


{
  '�������� ������������� ������
  Set mdb = CurrentDb
  sSQL = "Select top 2 BloodDoza.[�����] FROM BloodDoza order by BloodDoza.[�����] DESC"
  Set rst = mdb.OpenRecordset(sSQL)

  rst.MoveFirst
  FirstRec = CStr(rst.Fields("�����").Value)
  rst.MoveLast
  SecondRec = CStr(rst.Fields("�����").Value)

  rst.Close: Set rst = Nothing
  mdb.Close: Set mdb = Nothing

  If FirstRec = SecondRec Then
    MsgBox "������ ��� ���������!"
    Exit Function
  End If

  Set mdb = CurrentDb


  CurrentDb.Execute "INSERT INTO BloodDoza([�����], [450], [350]) values" _
  & "('" & Forms.MoreThenOneType.�����.Value & "','" _
  & Forms.MoreThenOneType.����55.Value & "', '" _
  & Forms.MoreThenOneType.����57.Value & "'); "

  rst.Close: Set rst = Nothing
  mdb.Close: Set mdb = Nothing

  Set mdb = CurrentDb
  sSQL = "SELECT top 1 BloodDoza.[����] FROM BloodDoza order by BloodDoza.[����] DESC"
  Set rst = mdb.OpenRecordset(sSQL)
  rst.MoveLast

  CurrentDb.Execute "INSERT INTO BloodErSusp([���], [���], [���], [�����]) values" _
  & "('" & Forms.MoreThenOneType.����61.Value & "','" _
  & Forms.MoreThenOneType.����59.Value & "', '" _
  & rst.Fields("����").Value & "', '" _
  & Forms.MoreThenOneType.�������������83.Value & "'); "

  CurrentDb.Execute "INSERT INTO BloodPlasma([���], [���], [����], [�����]) values" _
  & "('" & Forms.MoreThenOneType.����67.Value & "','" _
  & Forms.MoreThenOneType.����65.Value & "', '" _
  & rst.Fields("����").Value & "', '" _
  & Forms.MoreThenOneType.�������������85.Value & "'); "

  CurrentDb.Execute "INSERT INTO Filtrat([��], [����], [��]) values" _
  & "('" & Forms.MoreThenOneType.����73.Value & "','" _
  & rst.Fields("����").Value & "', '" _
  & Forms.MoreThenOneType.����71.Value & "'); "

  CurrentDb.Execute "INSERT INTO BloodBrak([���], [���], [����], [�����]) values" _
  & "('" & Forms.MoreThenOneType.����77.Value & "','" _
  & Forms.MoreThenOneType.����75.Value & "', '" _
  & rst.Fields("����").Value & "', '" _
  & Forms.MoreThenOneType.�������������87.Value & "'); "

  rst.Close: Set rst = Nothing
  mdb.Close: Set mdb = Nothing

  MsgBox "������ ���������!"





'�������� ���-�� �������
  If (Forms.MoreThenOneType.[450].Value + Forms.MoreThenOneType.[350].Value + Forms.MoreThenOneType.����55.Value + Forms.MoreThenOneType.����57.Value) <> Forms.MoreThenOneType.[���].Value Then
    MsgBox "��������� ���������� ������� (���� ""���-�� ��� ������� 450 � 350"") �� ��������� � ����������� �������!" & Chr(13) & "��������� � ��������� ��� ���!"
    Exit Function
  End If

  '�������� ���-�� ����� �� ��� ������-�
  If Forms.MoreThenOneType.[����].Value <> (20 * Forms.MoreThenOneType.[���].Value) Then
    MsgBox "���������� ����� �� ������������ ������������ �� ������������� ���������� �������!" & Chr(13) & "��������� � ��������� ��� ���!"
    Exit Function
  End If

  '�������� ���-�� ���� ����� �����
  If ((Forms.MoreThenOneType.[���].Value + Forms.MoreThenOneType.����59.Value) - 100 * (Forms.MoreThenOneType.[���].Value + Forms.MoreThenOneType.����61.Value) + (Forms.MoreThenOneType.[��].Value + Forms.MoreThenOneType.����71.Value) + (Forms.MoreThenOneType.[���].Value + Forms.MoreThenOneType.����65.Value) + (Forms.MoreThenOneType.[���].Value + Forms.MoreThenOneType.����75.Value)) <> Forms.MoreThenOneType.[����].Value Then
    MsgBox "���������� ���������������� ����� �� ��������� � ������ �� ����������� (������ ����� ����������� ������ �������� ��� ���� ������� �����)!" & Chr(13) & "��������� � ��������� ��� ���!"
    Exit Function
  End If

  '�������� ���-�� ������� �����
  If (Forms.MoreThenOneType.[����].Value + Forms.MoreThenOneType.[������].Value) <> Forms.MoreThenOneType.[����].Value Then
    MsgBox "���������� ������� ����� �� ��������� � ������ ""���������� �� ���������������"" � ""�� ������������ �����������""!" & Chr(13) & "��������� � ��������� ��� ���!"
    Exit Function
  End If

  '�������� ���-�� ��� �� ������
  If (Forms.MoreThenOneType.[450].Value + Forms.MoreThenOneType.[350].Value + Forms.MoreThenOneType.����55.Value + Forms.MoreThenOneType.����57.Value) <> (Forms.MoreThenOneType.[���].Value + Forms.MoreThenOneType.����61.Value) Then
    MsgBox "��������� ���������� ������� (���� ""���-�� ��� ������� 450 � 350"") �� ��������� � ����������� �������!" & Chr(13) & "��������� � ��������� ��� ���!"
    Exit Function
  End If

  '�������� ���-�� ��� ������
  If (Forms.MoreThenOneType.[450].Value + Forms.MoreThenOneType.[350].Value + Forms.MoreThenOneType.����55.Value + Forms.MoreThenOneType.����57.Value) <> (Forms.MoreThenOneType.[���].Value + Forms.MoreThenOneType.����67.Value) Then
    MsgBox "��������� ���������� ������� (���� ""���-�� ��� ������� 450 � 350"") �� ��������� � ����������� �������!" & Chr(13) & "��������� � ��������� ��� ���!"
    Exit Function
  End If

}
