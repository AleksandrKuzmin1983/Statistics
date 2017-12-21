unit MIOAAdviceToDoctors;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  UCheckNull,
  GetAdoQuery;

type
  IAdviceTDoctors = interface
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetTransfuziolog(i: integer): string;
    function GetLaboratoryScientist(i: integer): string;
    function GetRowCount: integer;
    procedure OpenConnect;
    procedure Insert;
    procedure post;
    procedure CloseConnect;
    procedure ExecSQL;
    procedure Clear;
    procedure AddSQL(SQL: string);
    procedure WriteValue(NumberField: integer; Value: Variant);
    procedure GetContent;
  end;

  TResultRecord=Record
  private
    Kod: string;
    Date: String;
    Transfuziolog: String;
    LaboratoryScientist: String;
  end;

  TAdviceTDoctors = class(TInterfacedObject,
    IAdviceTDoctors)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetTransfuziolog(i: integer): string;
    function GetLaboratoryScientist(i: integer): string;
    function GetRowCount: integer;
    procedure OpenConnect;
    procedure Insert;
    procedure post;
    procedure CloseConnect;
    procedure ExecSQL;
    procedure Clear;
    procedure AddSQL(SQL: string);

    procedure WriteValue(NumberField: integer; Value: Variant);
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TAdviceTDoctors.AddSQL(SQL: string);
begin
  TempQuery.SQL.Add(SQL);
end;

procedure TAdviceTDoctors.Clear;
begin
  TempQuery.SQL.Clear;
end;

procedure TAdviceTDoctors.CloseConnect;
begin
  TempQuery.Close;
end;

procedure TAdviceTDoctors.GetContent;
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
  SQL:='SELECT Consultations.Код, Consultations.ДатаКон, Consultations.ВТ, Consultations.ВЛ ' +
  'FROM Consultations ' +
  'WHERE not ((Consultations.ВТ = 0) and (Consultations.ВЛ = 0)) ' +
  'ORDER BY Consultations.ДатаКон desc;';
  Try
    TempQuery.SQL.Add(SQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  Try
    TempQuery.Open;
  Except
    ShowMessage('Нет подключения в базе данных!' + chr(13) + 'Обратитесь к администратору!');
  End;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Kod:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Date:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Transfuziolog:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].LaboratoryScientist:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

procedure TAdviceTDoctors.ExecSQL;
begin
  TempQuery.ExecSQL;
end;

function TAdviceTDoctors.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TAdviceTDoctors.GetLaboratoryScientist(i: integer): string;
begin
  result := ResultMass[i].LaboratoryScientist;
end;

procedure TAdviceTDoctors.Insert;
begin
  Try
  TempQuery.Insert;
  Except
    ShowMessage('Не могу добавить запись к базу данных (AdviceTDoctors)!' + chr(13) + 'Обратитесь к администратору!');
  End;

end;

procedure TAdviceTDoctors.OpenConnect;
begin
  Try
  TempQuery.Open;
  Except
    ShowMessage('Не могу подключиться к базе данных (AdviceTDoctors)!' + chr(13) + 'Обратитесь к администратору!');
  End;
end;

procedure TAdviceTDoctors.post;
begin
  Try
  TempQuery.Post;
  Except
    ShowMessage('Не могу сохранить изменения в базе данных (AdviceTDoctors)!' + chr(13) + 'Обратитесь к администратору!');
  End;
end;

procedure TAdviceTDoctors.WriteValue(NumberField: integer;
  Value: Variant);
begin
  Try
  TempQuery.Fields[NumberField].Value:=Value;
  Except
    ShowMessage('Не могу записать значение поля (AdviceTDoctors)!' + chr(13) + 'Обратитесь к администратору!');
  End;
end;

function TAdviceTDoctors.GetTransfuziolog(i: integer): string ;
begin
  result := ResultMass[i].Transfuziolog;
end;

function TAdviceTDoctors.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TAdviceTDoctors.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
