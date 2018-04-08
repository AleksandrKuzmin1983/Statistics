unit BIOOKDK;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBIOOKDK = interface
    function GetKod(i: integer): string;
    function GetReportDate(i: integer): string;
    function GetTheNameOfTap(i: integer): string;
    function GetVolume(i: integer): string;
    function GetOuting(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
    procedure destroy;
  end;

  TResultRecord = Record
  private
    Kod: string;
    ReportDate: String;
    TheNameOfTap: String;
    Volume: String;
    Outing: String;
  end;

  TBIOOKDK = class(TInterfacedObject, IBIOOKDK)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetReportDate(i: integer): string;
    function GetTheNameOfTap(i: integer): string;
    function GetVolume(i: integer): string;
    function GetOuting(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

function TBIOOKDK.GetReportDate(i: integer): string;
begin
  result := ResultMass[i].ReportDate;
end;

function TBIOOKDK.GetOuting(i: integer): string;
begin
  result := ResultMass[i].Outing;
end;

function TBIOOKDK.GetRowCount: integer;
begin
  result := Length(ResultMass);

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOOKDK.GetRowCount выполнена', result);
end;

function TBIOOKDK.GetTheNameOfTap(i: integer): string;
begin
  result := ResultMass[i].TheNameOfTap;
end;

function TBIOOKDK.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

procedure TBIOOKDK.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;
  CheckNull := nil;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOOKDK.destroy выполнена');
end;

procedure TBIOOKDK.GetContent;
var
  i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  SQL := 'SELECT NewOKDK.Код, NewOKDK.DateTap, NewOKDK.Tap, NewOKDK.Numb, NewOKDK.Outing '
    + 'FROM NewOKDK ' + 'ORDER BY NewOKDK.DateTap DESC;';
  Try
    TempQuery.SQL.Add(SQL);
  Except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  try
    TempQuery.Open;
  Except
    ShowMessage('Нет подключения к базе данных!' + chr(13) +
      'Обратитесь к администратору!');
  end;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i := 0 to TempQuery.RecordCount - 1 do
    begin
      ResultMass[i].Kod :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].ReportDate :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].TheNameOfTap :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].Volume :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      if VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value)) = 'True'
      then
        ResultMass[i].Outing := 'Да'
      else
        ResultMass[i].Outing := 'Нет';
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOOKDK.GetContent выполнена');
end;

function TBIOOKDK.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;
end.
