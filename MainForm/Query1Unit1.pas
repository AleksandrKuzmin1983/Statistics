unit Query1Unit1;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus,  Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, ConnectivgUnit1_ver2, Generics.Collections, Contnrs, Bde.DBTables, Vcl.ComCtrls ;

type
  FormQuery1 = class (TObject)
  private
    StartDate: TLabel;
    EndDate: TLabel;
    StartDateCal: TDateTimePicker;
    EndDateCal: TDateTimePicker;
    ButtonBack: TBitBtn;
  public
    function GetLabelStartDate(NameForm: TwinControl): TLabel;
    function GetLabelEndDate(NameForm: TwinControl): TLabel;
    function GetCalendarStartDate(NameForm: TwinControl): TDateTimePicker;
    function GetCalendarEndDate(NameForm: TwinControl): TDateTimePicker;
    function GetButtonBack(NameForm: TwinControl): TBitBtn;
    procedure ButtonBackClick(Sender: TObject); //не работает
  end;

implementation

{ FormQuery1 }



{ FormQuery1 }

procedure FormQuery1.ButtonBackClick(Sender: TObject); //не работает
begin
  ShowMessage('Я нажата!');
end;

function FormQuery1.GetButtonBack(NameForm: TwinControl): TBitBtn;
begin
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
end;

function FormQuery1.GetCalendarEndDate(NameForm: TwinControl): TDateTimePicker;
begin
  EndDateCal:=TDateTimePicker.create(NameForm);
  EndDateCal.parent:=NameForm;
  with EndDateCal do
  begin
    left:=250;
    top:=120;
    Font.Size:=12;
  end;
end;

function FormQuery1.GetCalendarStartDate(NameForm: TwinControl): TDateTimePicker;
begin
  StartDateCal:=TDateTimePicker.create(NameForm);
  StartDateCal.parent:=NameForm;
  with StartDateCal do
  begin
    left:=250;
    top:=80;
    Font.Size:=12;
  end;
end;

function FormQuery1.GetLabelEndDate(NameForm: TwinControl): TLabel;
begin
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
end;

function FormQuery1.GetLabelStartDate(NameForm: TwinControl): TLabel;
begin
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
end;

end.
