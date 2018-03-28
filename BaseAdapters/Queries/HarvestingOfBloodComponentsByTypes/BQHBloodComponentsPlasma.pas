unit BQHBloodComponentsPlasma;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBloodComponentsPlasma = interface
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumber(i: integer): string;
    function GetRowCount: integer;
  end;

  TResultRecord=Record
  private
    Name: String;
    Volume: String;
    Number: String;
  end;

  TBloodComponentsPlasma = class(TInterfacedObject,
    IBloodComponentsPlasma)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
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

constructor TBloodComponentsPlasma.create(DateStart, DateEnd: TDate);
var i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
  TempQuery.SQL.Add
    ('SELECT BloodPlasma.¬Ë‰œÀ, Sum(BloodPlasma. œÀ), Sum(BloodPlasma.ƒœÀ) ' +
     'FROM (BloodDoza INNER JOIN BloodErSusp ON BloodDoza. Ó‰ƒ = BloodErSusp. Ó‰) ' +
     'INNER JOIN BloodPlasma ON BloodErSusp. Ó‰ = BloodPlasma. Ó‰› ' +
     'WHERE (((BloodDoza.ƒ‡Ú‡ ) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#)) GROUP BY BloodPlasma.¬Ë‰œÀ;');

    TempQuery.Open;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Name:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Volume:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Number:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

function TBloodComponentsPlasma.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TBloodComponentsPlasma.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TBloodComponentsPlasma.GetName(i: integer): string ;
begin
  result := ResultMass[i].Name;
end;

function TBloodComponentsPlasma.GetNumber(i: integer): string;
begin
  result := ResultMass[i].Number;
end;

end.
