unit BQHBloodComponentsPlasma;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBQHBloodComponentsPlasma = interface
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumber(i: integer): string;
    function GetRowCount: integer;
  end;

  TResultRecord = Record
  private
    Name: String;
    Volume: String;
    Number: String;
  end;

  TBQHBloodComponentsPlasma = class(TInterfacedObject,
    IBQHBloodComponentsPlasma)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumber(i: integer): string;
    function GetRowCount: integer;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQHBloodComponentsPlasma.create(DateStart, DateEnd: TDate);
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
  Try
    TempQuery.SQL.Add
      ('SELECT BloodPlasma.ВидПЛ, Sum(BloodPlasma.КПЛ), Sum(BloodPlasma.ДПЛ) ' +
      'FROM (BloodDoza INNER JOIN BloodErSusp ON BloodDoza.КодД = BloodErSusp.Код) '
      + 'INNER JOIN BloodPlasma ON BloodErSusp.Код = BloodPlasma.КодЭ ' +
      'WHERE (((BloodDoza.ДатаК) Between #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateEnd) +
      '#)) GROUP BY BloodPlasma.ВидПЛ;');

    TempQuery.Open;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i := 0 to TempQuery.RecordCount - 1 do
    begin
      ResultMass[i].Name :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Volume :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Number :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHBloodComponentsPlasma.create выполнена');
end;

function TBQHBloodComponentsPlasma.GetRowCount: integer;
begin
  result := Length(ResultMass);

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHBloodComponentsPlasma.GetRowCount выполнена');
end;

function TBQHBloodComponentsPlasma.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHBloodComponentsPlasma.GetVolume выполнена');
end;

function TBQHBloodComponentsPlasma.GetName(i: integer): string;
begin
  result := ResultMass[i].Name;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHBloodComponentsPlasma.GetName выполнена');
end;

function TBQHBloodComponentsPlasma.GetNumber(i: integer): string;
begin
  result := ResultMass[i].Number;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHBloodComponentsPlasma.GetNumber выполнена');
end;

end.
