unit Query1Unit1;

interface
uses
  SysUtils, Classes, Controls, StdCtrls, Buttons, GetDataSoursUnit1,
  Vcl.ComCtrls, DateUtils;

type
  FormQuery1 = class (TObject)
  private
    StartDate: TLabel;
    EndDate: TLabel;
    StartDateCal: TDateTimePicker;
    EndDateCal: TDateTimePicker;
    ButtonBack: TBitBtn;
    ButtonAction: TBitBtn;
    NameStat1: Tlabel;
    NameStat2: Tlabel;
    NameStat3: Tlabel;
    ResultEdit1: TEdit;
    ResultEdit2: TEdit;
    ResultEdit3: TEdit;
  public
    function GetLabelStartDate(NameForm: TwinControl): TLabel;
    function GetLabelEndDate(NameForm: TwinControl): TLabel;
    function GetCalendarStartDate(NameForm: TwinControl): TDateTimePicker;
    function GetCalendarEndDate(NameForm: TwinControl): TDateTimePicker;
    function GetButtonBack(NameForm: TwinControl): TBitBtn;
    function GetLabelNameStat1(NameForm: TwinControl): Tlabel;
    function GenEdit1(NameForm: TwinControl): TEdit;
    function GetLabelNameStat2(NameForm: TwinControl): Tlabel;
    function GenEdit2(NameForm: TwinControl): TEdit;
    function GetLabelNameStat3(NameForm: TwinControl): Tlabel;
    function GenEdit3(NameForm: TwinControl): TEdit;
//  procedure ButtonBackClick(Sender: TObject);
    function GetButtonAction(NameForm: TwinControl): TBitBtn;
  end;

implementation

{ FormQuery1 }



{ FormQuery1 }

{procedure FormQuery1.ButtonBackClick(Sender: TObject);
begin
  ShowMessage('Я нажата!');
end;}

function FormQuery1.GenEdit1(NameForm: TwinControl): TEdit;
begin
  if not Assigned(ResultEdit1) then
    ResultEdit1:=TEdit.create(NameForm);
  ResultEdit1.parent:=NameForm;
  with ResultEdit1 do
  begin
    left:=400;
    top:=180;
    Width:=100;
    Font.name:='Times New Roman';
    Font.Size:=12;
    Alignment:=taRightJustify;
    ReadOnly:=true;
    Text:='';
  end;
  result:=ResultEdit1;
end;

function FormQuery1.GenEdit2(NameForm: TwinControl): TEdit;
begin
  if not Assigned(ResultEdit2) then
    ResultEdit2:=TEdit.create(NameForm);
  ResultEdit2.parent:=NameForm;
  with ResultEdit2 do
  begin
    left:=400;
    top:=220;
    Width:=100;
    Font.name:='Times New Roman';
    Font.Size:=12;
    Alignment:=taRightJustify;
    ReadOnly:=true;
    Text:='';
  end;
  result:=ResultEdit2;
end;

function FormQuery1.GenEdit3(NameForm: TwinControl): TEdit;
begin
  if not Assigned(ResultEdit3) then
    ResultEdit3:=TEdit.create(NameForm);
  ResultEdit3.parent:=NameForm;
  with ResultEdit3 do
  begin
    left:=400;
    top:=260;
    Width:=100;
    Font.name:='Times New Roman';
    Font.Size:=12;
    Alignment:=taRightJustify;
    ReadOnly:=true;
    Text:='';
  end;
  result:=ResultEdit3;
end;

function FormQuery1.GetButtonAction(NameForm: TwinControl): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction:=TBitBtn.create(NameForm);
  ButtonAction.parent:=NameForm;
  with ButtonAction do
  begin
    left:=385;
    top:=350;
    Font.name:='Times New Roman';
    Font.Size:=12;
    Caption:='Сформировать';
    Width:=130;
  end;
  result:=ButtonAction;
end;

function FormQuery1.GetButtonBack(NameForm: TwinControl): TBitBtn;
begin
  if not Assigned(ButtonBack) then
    ButtonBack:=TBitBtn.create(NameForm);
  ButtonBack.parent:=NameForm;
  with ButtonBack do
  begin
    left:=780;
    top:=350;
    Font.name:='Times New Roman';
    Font.Size:=12;
    Caption:='Назад';
  end;
  result:=ButtonBack;
end;

function FormQuery1.GetCalendarEndDate(NameForm: TwinControl): TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal:=TDateTimePicker.create(NameForm);
  EndDateCal.parent:=NameForm;
  with EndDateCal do
  begin
    left:=250;
    top:=120;
    Font.Size:=12;
    Date:=EncodeDate(YearOf(Now),MonthOf(Now),1)-1;
  end;
  result:=EndDateCal;
end;

function FormQuery1.GetCalendarStartDate(NameForm: TwinControl): TDateTimePicker;
begin
  if not Assigned(StartDateCal) then
    StartDateCal:=TDateTimePicker.create(NameForm);
  StartDateCal.parent:=NameForm;
  with StartDateCal do
  begin
    left:=250;
    top:=80;
    Font.Size:=12;
    date:=EncodeDate(YearOf(Now),MonthOf(Now)-1,1);
  end;
  result:=StartDateCal;
end;

function FormQuery1.GetLabelEndDate(NameForm: TwinControl): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate:=Tlabel.create(NameForm);
  EndDate.parent:=NameForm;
  with EndDate do
  begin
    left:=50;
    top:=120;
    Font.name:='Times New Roman';
    Font.Size:=20;
    Caption:='Конечная дата:';
  end;
  result:=EndDate;
end;

function FormQuery1.GetLabelNameStat1(NameForm: TwinControl): Tlabel;
begin
  if not Assigned(NameStat1) then
    NameStat1:=Tlabel.create(NameForm);
  NameStat1.parent:=NameForm;
  with NameStat1 do
  begin
    left:=50;
    top:=180;
    Font.name:='Times New Roman';
    Font.Size:=20;
    Caption:='Количество донаций крови:';
  end;
  result:=NameStat1;
end;

function FormQuery1.GetLabelNameStat2(NameForm: TwinControl): Tlabel;
begin
  if not Assigned(NameStat2) then
    NameStat2:=Tlabel.create(NameForm);
  NameStat2.parent:=NameForm;
  with NameStat2 do
  begin
    left:=50;
    top:=220;
    Font.name:='Times New Roman';
    Font.Size:=20;
    Caption:='Количество донаций крови:';
  end;
  result:=NameStat2;
end;

function FormQuery1.GetLabelNameStat3(NameForm: TwinControl): Tlabel;
begin
  if not Assigned(NameStat3) then
    NameStat3:=Tlabel.create(NameForm);
  NameStat3.parent:=NameForm;
  with NameStat3 do
  begin
    left:=50;
    top:=260;
    Font.name:='Times New Roman';
    Font.Size:=20;
    Caption:='Количество донаций крови:';
  end;
  result:=NameStat3;
end;

function FormQuery1.GetLabelStartDate(NameForm: TwinControl): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate:=Tlabel.create(NameForm);
  StartDate.parent:=NameForm;
  with StartDate do
  begin
    left:=50;
    top:=80;
    Font.name:='Times New Roman';
    Font.Size:=20;
    Caption:='Начальная дата:';
  end;
  result:=StartDate;
end;

end.
