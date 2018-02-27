object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Form3'
  ClientHeight = 490
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxPreview1: TfrxPreview
    Left = 0
    Top = 0
    Width = 657
    Height = 490
    Align = alClient
    OutlineVisible = False
    OutlineWidth = 120
    ThumbnailVisible = False
    UseReportHints = True
  end
  object frxReport1: TfrxReport
    Version = '4.12.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    Preview = frxPreview1
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43126.540306412000000000
    ReportOptions.LastChange = 43140.626570949080000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Function MonthStartF: string;'
      'begin'
      
        '  Result:='#39'01.'#39' + FormatDateTime('#39'mm'#39', date()) + '#39'.'#39' + FormatDat' +
        'eTime('#39'yyyy'#39', date()) + '#39#1075'.'#39';'
      'end;  '
      ''
      
        'Function CurrentDateF: string;                                  ' +
        '                                              '
      'begin'
      
        '  Result:=FormatDateTime('#39'dd'#39', date()) + '#39'.'#39' + FormatDateTime('#39'm' +
        'm'#39', date()) + '#39'.'#39' + FormatDateTime('#39'yyyy'#39', date()) + '#39#1075'.'#39';'
      'end;    '
      ''
      'Function WeekStartF: string;'
      'begin'
      '  Result:=DateToStr(date()-DayOfWeek(Date())-5) + '#39#1075'.'#39';'
      'end;  '
      ''
      'Function WeekEndF: string;'
      'begin'
      '  Result:=DateToStr(date()-DayOfWeek(Date())-1) + '#39#1075'.'#39';'
      'end;'
      ''
      'Function WeekEndForExpedF: string;'
      'begin'
      '  Result:=DateToStr(date()-DayOfWeek(Date())+1) + '#39#1075'.'#39';'
      'end;'
      '    '
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  set('#39'MonthStart'#39', '#39#39#39#39' + MonthStartF + '#39#39#39#39');                 ' +
        '    '
      '  set('#39'CurrentDate'#39', '#39#39#39#39' + CurrentDateF + '#39#39#39#39');'
      '  set('#39'WeekStart'#39', '#39#39#39#39' + WeekStartF + '#39#39#39#39');'
      '  set('#39'WeekEnd'#39', '#39#39#39#39' + WeekEndF + '#39#39#39#39');'
      '  set('#39'WeekEndForExped'#39', '#39#39#39#39' + WeekEndForExpedF + '#39#39#39#39');'
      '  if get('#39'VolumeTrombo'#39')='#39'0,000'#39' then'
      '  begin            '
      '    memo21.visible:=false;'
      '    memo22.text:='#39' '#39';                                         '
      
        '  //  memo22.visible:=false;                                    ' +
        '              '
      '  end'
      '  else'
      '  begin'
      
        '   memo22.text:=<NumberDosesTromb> + '#39'/'#39' + <NumberPacketsTromb> ' +
        '+ '#39'sdfsdfsfd'#39';                                               '
      '  end;'
      'end;'
      ''
      'begin'
      '                        '
      'end.')
    OnGetValue = frxReport1GetValue
    Left = 40
    Top = 40
    Datasets = <>
    Variables = <
      item
        Name = ' DonorsAndProcedures'
        Value = ''
      end
      item
        Name = 'AddressedJust'
        Value = ''
      end
      item
        Name = 'ExceptionTotal'
        Value = ''
      end
      item
        Name = 'PreliminaryAnalysis'
        Value = ''
      end
      item
        Name = 'AdmittedToDonation'
        Value = ''
      end
      item
        Name = 'ProceduresTotal'
        Value = ''
      end
      item
        Name = 'BloodProcedures'
        Value = ''
      end
      item
        Name = 'PlasmaProceduresTotal'
        Value = ''
      end
      item
        Name = 'APAProcedures'
        Value = ''
      end
      item
        Name = 'TromboProcedures'
        Value = ''
      end
      item
        Name = 'NotTaken'
        Value = ''
      end
      item
        Name = 'AddressedJustOuting'
        Value = ''
      end
      item
        Name = 'ExceptionTotalOuting'
        Value = ''
      end
      item
        Name = 'PreliminaryAnalysisOuting'
        Value = ''
      end
      item
        Name = 'AdmittedToDonationOuting'
        Value = ''
      end
      item
        Name = 'ProceduresTotalOuting'
        Value = ''
      end
      item
        Name = 'BloodProceduresOuting'
        Value = ''
      end
      item
        Name = 'NotTakenOuting'
        Value = ''
      end
      item
        Name = ' TheResultsOfTheProducts'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastFiltrVolumeCity'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastFiltrDosesCity'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastFiltrVolumeArea'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastFiltrDosesArea'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastFiltrPercentCity'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastFiltrPercentArea'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastVolumeCity'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastDosesCity'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastVolumeArea'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastDosesArea'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastPercentCity'
        Value = ''
      end
      item
        Name = 'ErSuspWithResuspRastPercentArea'
        Value = ''
      end
      item
        Name = 'ErSuspWithFisioRastVolumeCity'
        Value = ''
      end
      item
        Name = 'ErSuspWithFisioRastDosesCity'
        Value = ''
      end
      item
        Name = 'ErSuspWithFisioRastVolumeArea'
        Value = ''
      end
      item
        Name = 'ErSuspWithFisioRastDosesArea'
        Value = ''
      end
      item
        Name = 'ErSuspWithFisioRastPercentCity'
        Value = ''
      end
      item
        Name = 'ErSuspWithFisioRastPercentArea'
        Value = ''
      end
      item
        Name = 'SZPKarantVolumeCity'
        Value = ''
      end
      item
        Name = 'SZPKarantDosesCity'
        Value = ''
      end
      item
        Name = 'SZPKarantVolumeArea'
        Value = ''
      end
      item
        Name = 'SZPKarantDosesArea'
        Value = ''
      end
      item
        Name = 'SZPKarantPercentCity'
        Value = ''
      end
      item
        Name = 'SZPKarantPercentArea'
        Value = ''
      end
      item
        Name = 'SZPVirusInaktVolumeCity'
        Value = ''
      end
      item
        Name = 'SZPVirusInaktDosesCity'
        Value = ''
      end
      item
        Name = 'SZPVirusInaktVolumeArea'
        Value = ''
      end
      item
        Name = 'SZPVirusInaktDosesArea'
        Value = ''
      end
      item
        Name = 'SZPVirusInaktPercentCity'
        Value = ''
      end
      item
        Name = 'SZPVirusInaktPercentArea'
        Value = ''
      end
      item
        Name = 'KriopresipitatVolumeCity'
        Value = ''
      end
      item
        Name = 'KriopresipitatDosesCity'
        Value = ''
      end
      item
        Name = 'KriopresipitatVolumeArea'
        Value = ''
      end
      item
        Name = 'KriopresipitatDosesArea'
        Value = ''
      end
      item
        Name = 'KriopresipitatPercentCity'
        Value = ''
      end
      item
        Name = 'KriopresipitatPercentArea'
        Value = ''
      end
      item
        Name = 'TromboVolumeCity'
        Value = ''
      end
      item
        Name = 'TromboDosesCity'
        Value = ''
      end
      item
        Name = 'TromboVolumeArea'
        Value = ''
      end
      item
        Name = 'TromboDosesArea'
        Value = ''
      end
      item
        Name = 'TromboPercentCity'
        Value = ''
      end
      item
        Name = 'TromboPercentArea'
        Value = ''
      end
      item
        Name = 'PerftoranVolumeCity'
        Value = ''
      end
      item
        Name = 'PerftoranDosesCity'
        Value = ''
      end
      item
        Name = 'PerftoranVolumeArea'
        Value = ''
      end
      item
        Name = 'PerftoranDosesArea'
        Value = ''
      end
      item
        Name = 'PerftoranPercentCity'
        Value = ''
      end
      item
        Name = 'PerftoranPercentArea'
        Value = ''
      end
      item
        Name = ' SecondTable'
        Value = Null
      end
      item
        Name = 'ProductWholeBlood'
        Value = Null
      end
      item
        Name = 'VolumeReinfusion'
        Value = Null
      end
      item
        Name = 'PreparedFitProductionErSuspFiltr'
        Value = Null
      end
      item
        Name = 'PreparedFitProductionErSusp'
        Value = Null
      end
      item
        Name = 'PreparedFitProductionSZP'
        Value = Null
      end
      item
        Name = 'OutingProductWholeBlood'
        Value = ''
      end
      item
        Name = 'OutingPreparedFitProductionErSuspFiltr'
        Value = ''
      end
      item
        Name = 'OutingPreparedFitProductionErSusp'
        Value = ''
      end
      item
        Name = 'OutingPreparedFitProductionSZP'
        Value = ''
      end
      item
        Name = ' Production'
        Value = Null
      end
      item
        Name = 'PlanVolumeWholeBlood'
        Value = Null
      end
      item
        Name = 'VolumeWholeBlood'
        Value = Null
      end
      item
        Name = 'PercentWholeBlood'
        Value = Null
      end
      item
        Name = 'PlanVolumeConsBlood'
        Value = Null
      end
      item
        Name = 'VolumeConsBlood'
        Value = Null
      end
      item
        Name = 'PercentConsBlood'
        Value = Null
      end
      item
        Name = 'PlanVolumePlasmaTotal'
        Value = Null
      end
      item
        Name = 'VolumePlasmaTotal'
        Value = Null
      end
      item
        Name = 'PercentPlasmaTotal'
        Value = Null
      end
      item
        Name = 'PlanVolumePlasmaAPA'
        Value = Null
      end
      item
        Name = 'VolumePlasmaAPA'
        Value = Null
      end
      item
        Name = 'PercentPlasmaAPA'
        Value = Null
      end
      item
        Name = 'PlanVolumeErSusp'
        Value = Null
      end
      item
        Name = 'VolumeErSusp'
        Value = Null
      end
      item
        Name = 'PercentErSusp'
        Value = Null
      end
      item
        Name = 'VolumeTrombo'
        Value = Null
      end
      item
        Name = 'NumberDosesTromb'
        Value = Null
      end
      item
        Name = 'NumberPacketsTromb'
        Value = Null
      end
      item
        Name = ' DateVariables'
        Value = Null
      end
      item
        Name = 'MonthStart'
        Value = Null
      end
      item
        Name = 'CurrentDate'
        Value = Null
      end
      item
        Name = 'WeekStart'
        Value = Null
      end
      item
        Name = 'WeekEnd'
        Value = Null
      end
      item
        Name = 'WeekEndForExped'
        Value = Null
      end
      item
        Name = ' ProcurementForTheMonth'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'Page1OnBeforePrint'
      object Memo1: TfrxMemoView
        Width = 718.110700000000000000
        Height = 22.677180000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1087#1083#1072#1085#1086#1074#1099#1093' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1077#1081)
        ParentFont = False
      end
      object Memo2: TfrxMemoView
        Left = 37.795300000000000000
        Top = 52.913420000000000000
        Width = 226.771653540000000000
        Height = 26.456692913385800000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        Memo.UTF8W = (
          #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo3: TfrxMemoView
        Left = 359.055350000000000000
        Top = 52.913420000000000000
        Width = 94.488250000000000000
        Height = 26.456692913385800000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1060#1072#1082#1090)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo4: TfrxMemoView
        Left = 453.543600000000000000
        Top = 52.913420000000000000
        Width = 94.488188980000000000
        Height = 26.456692913385800000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '%')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo5: TfrxMemoView
        Left = 37.795300000000000000
        Top = 79.370130000000000000
        Width = 226.771653540000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        Memo.UTF8W = (
          #1047#1072#1075#1086#1090#1086#1074#1082#1072' '#1094#1077#1083#1100#1085#1086#1081' '#1082#1088#1086#1074#1080)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo6: TfrxMemoView
        Left = 37.795300000000000000
        Top = 109.606370000000000000
        Width = 226.771653540000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        Memo.UTF8W = (
          #1055#1077#1088#1077#1088#1072#1073#1086#1090#1082#1072' '#1082#1088#1086#1074#1080' '#1085#1072' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1099' '#1080' '#1087#1088#1077#1087#1072#1088#1072#1090#1099)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo11: TfrxMemoView
        Left = 453.543600000000000000
        Top = 79.370130000000000000
        Width = 94.488188980000000000
        Height = 30.236220470000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.2f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PercentWholeBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo16: TfrxMemoView
        Left = 359.055350000000000000
        Top = 79.370130000000000000
        Width = 94.488188980000000000
        Height = 30.236220470000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[VolumeWholeBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo17: TfrxMemoView
        Left = 359.055350000000000000
        Top = 109.606370000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[VolumeConsBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo7: TfrxMemoView
        Left = 37.795300000000000000
        Top = 147.401670000000000000
        Width = 226.771653540000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        Memo.UTF8W = (
          #1055#1088#1086#1080#1079#1074#1077#1076#1089#1090#1074#1086' '#1087#1083#1072#1079#1084#1099)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo8: TfrxMemoView
        Left = 37.795300000000000000
        Top = 177.637910000000000000
        Width = 226.771653540000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        Memo.UTF8W = (
          #1074' '#1090'.'#1095'. '#1084#1077#1090#1086#1076#1086#1084' '#1040#1055#1040)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo9: TfrxMemoView
        Left = 37.795300000000000000
        Top = 207.874150000000000000
        Width = 226.771653540000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        Memo.UTF8W = (
          #1055#1088#1086#1080#1079#1074#1077#1076#1089#1090#1074#1086' '#1101#1088'. '#1089#1088#1077#1076)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo10: TfrxMemoView
        Left = 37.795300000000000000
        Top = 238.110390000000000000
        Width = 226.771653540000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        Memo.UTF8W = (
          #1055#1088#1086#1080#1079#1074#1077#1076#1089#1090#1074#1086
          #1090#1088#1086#1084#1073#1086#1082#1086#1085#1094#1077#1085#1090#1088#1072#1090#1072)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo13: TfrxMemoView
        Left = 453.543600000000000000
        Top = 147.401670000000000000
        Width = 94.488188980000000000
        Height = 30.236220470000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PercentPlasmaTotal]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo14: TfrxMemoView
        Left = 453.543600000000000000
        Top = 177.637910000000000000
        Width = 94.488188980000000000
        Height = 30.236220470000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PercentPlasmaAPA]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo15: TfrxMemoView
        Left = 453.543600000000000000
        Top = 207.874150000000000000
        Width = 94.488188980000000000
        Height = 30.236220470000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PercentErSusp]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo18: TfrxMemoView
        Left = 359.055350000000000000
        Top = 147.401670000000000000
        Width = 94.488188980000000000
        Height = 30.236220470000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[VolumePlasmaTotal]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo19: TfrxMemoView
        Left = 359.055350000000000000
        Top = 177.637910000000000000
        Width = 94.488188980000000000
        Height = 30.236220470000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[VolumePlasmaAPA]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo20: TfrxMemoView
        Left = 359.055350000000000000
        Top = 207.874150000000000000
        Width = 94.488188980000000000
        Height = 30.236220470000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[VolumeErSusp]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo21: TfrxMemoView
        Left = 264.567100000000000000
        Top = 238.110390000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft]
        HAlign = haRight
        Memo.UTF8W = (
          '[VolumeTrombo]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo22: TfrxMemoView
        Left = 359.055350000000000000
        Top = 238.110390000000000000
        Width = 188.976438980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo12: TfrxMemoView
        Left = 453.543600000000000000
        Top = 109.606370000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PercentConsBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo24: TfrxMemoView
        Top = 52.913420000000000000
        Width = 37.795275590000000000
        Height = 26.456692913385800000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #8470)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo25: TfrxMemoView
        Top = 79.370130000000000000
        Width = 37.795275590000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '1')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo27: TfrxMemoView
        Top = 109.606370000000000000
        Width = 37.795275590000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '2')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo28: TfrxMemoView
        Top = 147.401670000000000000
        Width = 37.795275590000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '3')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo29: TfrxMemoView
        Top = 177.637910000000000000
        Width = 37.795275590000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '4')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo30: TfrxMemoView
        Top = 207.874150000000000000
        Width = 37.795275590000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '5')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo31: TfrxMemoView
        Top = 238.110390000000000000
        Width = 37.795275590000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          '6')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo32: TfrxMemoView
        Left = 264.567100000000000000
        Top = 52.913420000000000000
        Width = 94.488250000000000000
        Height = 26.456692913385800000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1055#1083#1072#1085)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo33: TfrxMemoView
        Left = 264.567100000000000000
        Top = 79.370130000000000000
        Width = 94.488250000000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PlanVolumeWholeBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo34: TfrxMemoView
        Left = 264.567100000000000000
        Top = 109.606370000000000000
        Width = 94.488250000000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PlanVolumeConsBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo35: TfrxMemoView
        Left = 264.567100000000000000
        Top = 147.401670000000000000
        Width = 94.488250000000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PlanVolumePlasmaTotal]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo36: TfrxMemoView
        Left = 264.567100000000000000
        Top = 177.637910000000000000
        Width = 94.488250000000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PlanVolumePlasmaAPA]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo37: TfrxMemoView
        Left = 264.567100000000000000
        Top = 207.874150000000000000
        Width = 94.488250000000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          '[PlanVolumeErSusp]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo23: TfrxMemoView
        Top = 283.464750000000000000
        Width = 718.110700000000000000
        Height = 22.677180000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          #1047#1072#1075#1086#1090#1086#1074#1083#1077#1085#1086' '#1080' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1086' '#1076#1086#1085#1086#1088#1089#1082#1086#1081' '#1082#1088#1086#1074#1080)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo38: TfrxMemoView
        Top = 306.141930000000000000
        Width = 718.110700000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          #1057' [WeekStart] '#1087#1086' [WeekEnd]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo39: TfrxMemoView
        Top = 325.039580000000000000
        Width = 725.669760000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '('#1079#1072' '#1085#1077#1076#1077#1083#1102' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1084#1077#1089#1103#1094#1072')')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo40: TfrxMemoView
        Top = 351.496290000000000000
        Width = 75.590600000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
      end
      object Memo41: TfrxMemoView
        Left = 75.590600000000000000
        Top = 351.496290000000000000
        Width = 113.385900000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1047#1072#1075#1086#1090#1086#1074#1083#1077#1085#1086
          #1094#1077#1083#1100#1085#1086#1081
          #1082#1088#1086#1074#1080', '#1083'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo42: TfrxMemoView
        Left = 188.976500000000000000
        Top = 351.496290000000000000
        Width = 113.385900000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1056#1077#1080#1085#1092#1091#1079#1080#1103', '#1083'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo43: TfrxMemoView
        Left = 302.362400000000000000
        Top = 351.496290000000000000
        Width = 302.362400000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1047#1072#1073#1088#1072#1082#1086#1074#1072#1085#1086', '#1083'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo44: TfrxMemoView
        Left = 302.362400000000000000
        Top = 389.291590000000000000
        Width = 188.976500000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1087#1088#1080#1095#1080#1085#1072)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo45: TfrxMemoView
        Left = 491.338900000000000000
        Top = 389.291590000000000000
        Width = 113.385900000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1082#1086#1083#1080#1095#1077#1089#1090#1074#1086)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo46: TfrxMemoView
        Left = 604.724800000000000000
        Top = 351.496290000000000000
        Width = 113.385900000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1055#1088#1086#1080#1079#1074#1077#1076#1077#1085#1086
          #1075#1086#1076#1085#1086#1081' '#1076#1083#1103
          #1083#1077#1095#1077#1073#1085#1099#1093
          #1094#1077#1083#1077#1081', '#1083'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo47: TfrxMemoView
        Top = 427.086890000000000000
        Width = 75.590600000000000000
        Height = 185.196872362205000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1042#1089#1077#1075#1086)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo48: TfrxMemoView
        Top = 612.283860000000000000
        Width = 75.590600000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1042' '#1090'.'#1095'. '#1074
          #1074#1099#1077#1079#1076#1085#1099#1093
          #1091#1089#1083#1086#1074#1080#1103#1093)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo49: TfrxMemoView
        Left = 75.590600000000000000
        Top = 427.086890000000000000
        Width = 113.385900000000000000
        Height = 185.196872360000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ProductWholeBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo50: TfrxMemoView
        Left = 188.976500000000000000
        Top = 427.086890000000000000
        Width = 113.385900000000000000
        Height = 185.196872360000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[VolumeReinfusion]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo52: TfrxMemoView
        Left = 75.590600000000000000
        Top = 612.283860000000000000
        Width = 113.385900000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[OutingProductWholeBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo53: TfrxMemoView
        Left = 188.976500000000000000
        Top = 612.283860000000000000
        Width = 113.385900000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo55: TfrxMemoView
        Left = 302.362400000000000000
        Top = 612.283860000000000000
        Width = 302.362400000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo26: TfrxMemoView
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Height = 30.236240000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          'C [MonthStart] '#1087#1086' [WeekEnd]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo56: TfrxMemoView
        Top = 699.213050000000000000
        Width = 718.110700000000000000
        Height = 22.677180000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          
            #1042#1099#1076#1072#1095#1072' '#1090#1088#1072#1085#1089#1092#1091#1079#1080#1086#1085#1085#1099#1093' '#1089#1088#1077#1076' '#1074' '#1091#1095#1088#1077#1078#1076#1077#1085#1080#1103' '#1079#1076#1088#1072#1074#1086#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1050#1088#1072#1089#1085#1086#1103#1088 +
            #1089#1082#1086#1075#1086' '#1082#1088#1072#1103)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo57: TfrxMemoView
        Top = 767.244590000000000000
        Width = 37.795300000000000000
        Height = 56.692950000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #8470)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo58: TfrxMemoView
        Left = 37.795300000000000000
        Top = 767.244590000000000000
        Width = 226.771800000000000000
        Height = 56.692950000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1088#1077#1076#1099)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo59: TfrxMemoView
        Left = 264.567100000000000000
        Top = 767.244590000000000000
        Width = 302.362400000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1047#1072#1103#1074#1082#1080' '#1091#1095#1088#1077#1078#1076#1077#1085#1080#1081' '#1079#1076#1088#1072#1074#1086#1086#1093#1088#1072#1085#1077#1085#1080#1103)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo61: TfrxMemoView
        Left = 566.929500000000000000
        Top = 767.244590000000000000
        Width = 151.181200000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '% '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo62: TfrxMemoView
        Top = 721.890230000000000000
        Width = 718.110700000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          #1057' [WeekStart] '#1087#1086' [WeekEndForExped]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo63: TfrxMemoView
        Left = -3.779530000000000000
        Top = 740.787880000000000000
        Width = 725.669760000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '('#1079#1072' '#1085#1077#1076#1077#1083#1102' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1084#1077#1089#1103#1094#1072')')
        ParentFont = False
      end
      object Memo60: TfrxMemoView
        Left = 566.929500000000000000
        Top = 786.142240000000000000
        Width = 75.590600000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1075#1086#1088#1086#1076#1089#1082#1080#1077)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo64: TfrxMemoView
        Left = 642.520100000000000000
        Top = 786.142240000000000000
        Width = 75.590600000000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1088#1072#1081#1086#1085#1085#1099#1077)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo65: TfrxMemoView
        Left = 264.567100000000000000
        Top = 786.142240000000000000
        Width = 151.181200000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1075#1086#1088#1086#1076#1089#1082#1080#1077)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo66: TfrxMemoView
        Left = 415.748300000000000000
        Top = 786.142240000000000000
        Width = 151.181200000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1088#1072#1081#1086#1085#1085#1099#1077)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo67: TfrxMemoView
        Left = 264.567100000000000000
        Top = 805.039890000000000000
        Width = 75.590551180000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1083)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo68: TfrxMemoView
        Left = 415.748300000000000000
        Top = 805.039890000000000000
        Width = 75.590551180000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1083)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo69: TfrxMemoView
        Left = 340.157700000000000000
        Top = 805.039890000000000000
        Width = 75.590551180000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1076)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo70: TfrxMemoView
        Left = 491.338900000000000000
        Top = 805.039890000000000000
        Width = 75.590551180000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1076)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo71: TfrxMemoView
        Top = 823.937540000000000000
        Width = 37.795300000000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '1')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo72: TfrxMemoView
        Top = 861.732840000000000000
        Width = 37.795300000000000000
        Height = 22.677165354330700000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '2')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo73: TfrxMemoView
        Top = 884.410020000000000000
        Width = 37.795300000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '3')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo74: TfrxMemoView
        Top = 929.764380000000000000
        Width = 37.795300000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '5')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo75: TfrxMemoView
        Top = 975.118740000000000000
        Width = 37.795300000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '7')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo76: TfrxMemoView
        Top = 997.795920000000000000
        Width = 37.795300000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '8')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo77: TfrxMemoView
        Top = 952.441560000000000000
        Width = 37.795300000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '6')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo78: TfrxMemoView
        Top = 907.087200000000000000
        Width = 37.795300000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '4')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo79: TfrxMemoView
        Left = 37.795300000000000000
        Top = 823.937540000000000000
        Width = 226.771800000000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1069#1088'. '#1074#1079#1074#1077#1089#1100' '#1089' '#1088#1077#1089#1091#1089#1087'. '#1088#1072#1089#1090#1088'., '#1092#1080#1083#1100#1090#1088'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo80: TfrxMemoView
        Left = 37.795300000000000000
        Top = 861.732840000000000000
        Width = 226.771800000000000000
        Height = 22.677165354330700000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1069#1088'. '#1074#1079#1074#1077#1089#1100' '#1089' '#1088#1077#1089#1091#1089#1087'. '#1088#1072#1089#1090#1088'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo81: TfrxMemoView
        Left = 37.795300000000000000
        Top = 884.410020000000000000
        Width = 226.771800000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1069#1088'. '#1074#1079#1074#1077#1089#1100' '#1089' '#1092#1080#1079#1080#1086' '#1088#1072#1089#1090#1088'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo82: TfrxMemoView
        Left = 37.795300000000000000
        Top = 907.087200000000000000
        Width = 226.771800000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1057#1047#1055' '#1082#1072#1088'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo83: TfrxMemoView
        Left = 37.795300000000000000
        Top = 929.764380000000000000
        Width = 226.771800000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1057#1047#1055' '#1074#1080#1088#1091#1089#1080#1085#1072#1082#1090#1080#1074#1080#1088#1086#1074#1072#1085#1085#1072#1103)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo84: TfrxMemoView
        Left = 37.795300000000000000
        Top = 952.441560000000000000
        Width = 226.771800000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1050#1088#1080#1086#1087#1088#1077#1094#1080#1087#1080#1090#1072#1090' '#1079#1072#1084'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo85: TfrxMemoView
        Left = 37.795300000000000000
        Top = 975.118740000000000000
        Width = 226.771800000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1050#1086#1085#1094#1077#1085#1090#1088#1072#1090' '#1090#1088#1086#1084#1073#1086#1094#1080#1090#1086#1074)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo86: TfrxMemoView
        Left = 37.795300000000000000
        Top = 997.795920000000000000
        Width = 226.771800000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1055#1077#1088#1092#1090#1086#1088#1072#1085)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo87: TfrxMemoView
        Left = 264.567100000000000000
        Top = 823.937540000000000000
        Width = 75.590600000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastFiltrVolumeCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo88: TfrxMemoView
        Left = 264.567100000000000000
        Top = 861.732840000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastVolumeCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo89: TfrxMemoView
        Left = 264.567100000000000000
        Top = 884.410020000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithFisioRastVolumeCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo90: TfrxMemoView
        Left = 264.567100000000000000
        Top = 907.087200000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPKarantVolumeCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo91: TfrxMemoView
        Left = 264.567100000000000000
        Top = 929.764380000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPVirusInaktVolumeCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo92: TfrxMemoView
        Left = 264.567100000000000000
        Top = 952.441560000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[KriopresipitatVolumeCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo93: TfrxMemoView
        Left = 264.567100000000000000
        Top = 975.118740000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboVolumeCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo94: TfrxMemoView
        Left = 264.567100000000000000
        Top = 997.795920000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PerftoranVolumeCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo95: TfrxMemoView
        Left = 340.157700000000000000
        Top = 861.732840000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastDosesCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo96: TfrxMemoView
        Left = 340.157700000000000000
        Top = 884.410020000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithFisioRastDosesCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo97: TfrxMemoView
        Left = 340.157700000000000000
        Top = 907.087200000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPKarantDosesCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo98: TfrxMemoView
        Left = 340.157700000000000000
        Top = 929.764380000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPVirusInaktDosesCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo99: TfrxMemoView
        Left = 340.157700000000000000
        Top = 952.441560000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[KriopresipitatDosesCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo100: TfrxMemoView
        Left = 340.157700000000000000
        Top = 975.118740000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboDosesCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo101: TfrxMemoView
        Left = 340.157700000000000000
        Top = 997.795920000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PerftoranDosesCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo102: TfrxMemoView
        Left = 415.748300000000000000
        Top = 861.732840000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastVolumeArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo103: TfrxMemoView
        Left = 415.748300000000000000
        Top = 884.410020000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithFisioRastVolumeArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo104: TfrxMemoView
        Left = 415.748300000000000000
        Top = 907.087200000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPKarantVolumeArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo105: TfrxMemoView
        Left = 415.748300000000000000
        Top = 929.764380000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPVirusInaktVolumeArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo106: TfrxMemoView
        Left = 415.748300000000000000
        Top = 952.441560000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[KriopresipitatVolumeArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo107: TfrxMemoView
        Left = 415.748300000000000000
        Top = 975.118740000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboVolumeArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo108: TfrxMemoView
        Left = 415.748300000000000000
        Top = 997.795920000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PerftoranVolumeArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo109: TfrxMemoView
        Left = 491.338900000000000000
        Top = 861.732840000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastDosesArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo110: TfrxMemoView
        Left = 491.338900000000000000
        Top = 884.410020000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithFisioRastDosesArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo111: TfrxMemoView
        Left = 491.338900000000000000
        Top = 907.087200000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPKarantDosesArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo112: TfrxMemoView
        Left = 491.338900000000000000
        Top = 929.764380000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPVirusInaktDosesArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo113: TfrxMemoView
        Left = 491.338900000000000000
        Top = 952.441560000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[KriopresipitatDosesArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo114: TfrxMemoView
        Left = 491.338900000000000000
        Top = 975.118740000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboDosesArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo115: TfrxMemoView
        Left = 491.338900000000000000
        Top = 997.795920000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PerftoranDosesArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo116: TfrxMemoView
        Left = 566.929500000000000000
        Top = 861.732840000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastPercentCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo117: TfrxMemoView
        Left = 566.929500000000000000
        Top = 884.410020000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithFisioRastPercentCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo118: TfrxMemoView
        Left = 566.929500000000000000
        Top = 907.087200000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPKarantPercentCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo119: TfrxMemoView
        Left = 566.929500000000000000
        Top = 929.764380000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPVirusInaktPercentCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo120: TfrxMemoView
        Left = 566.929500000000000000
        Top = 952.441560000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[KriopresipitatPercentCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo121: TfrxMemoView
        Left = 566.929500000000000000
        Top = 975.118740000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboPercentCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo122: TfrxMemoView
        Left = 566.929500000000000000
        Top = 997.795920000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PerftoranPercentCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo123: TfrxMemoView
        Left = 642.520100000000000000
        Top = 861.732840000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastPercentArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo124: TfrxMemoView
        Left = 642.520100000000000000
        Top = 884.410020000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithFisioRastPercentArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo125: TfrxMemoView
        Left = 642.520100000000000000
        Top = 907.087200000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPKarantPercentArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo126: TfrxMemoView
        Left = 642.520100000000000000
        Top = 929.764380000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[SZPVirusInaktPercentArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo127: TfrxMemoView
        Left = 642.520100000000000000
        Top = 952.441560000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[KriopresipitatPercentArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo128: TfrxMemoView
        Left = 642.520100000000000000
        Top = 975.118740000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboPercentArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo129: TfrxMemoView
        Left = 642.520100000000000000
        Top = 997.795920000000000000
        Width = 75.590600000000000000
        Height = 22.677165350000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PerftoranPercentArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo130: TfrxMemoView
        Left = 340.157700000000000000
        Top = 823.937540000000000000
        Width = 75.590600000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastFiltrDosesCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo131: TfrxMemoView
        Left = 415.748300000000000000
        Top = 823.937540000000000000
        Width = 75.590600000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastFiltrVolumeArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo132: TfrxMemoView
        Left = 491.338900000000000000
        Top = 823.937540000000000000
        Width = 75.590600000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastFiltrDosesArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo133: TfrxMemoView
        Left = 566.929500000000000000
        Top = 823.937540000000000000
        Width = 75.590600000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastFiltrPercentCity]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo134: TfrxMemoView
        Left = 642.520100000000000000
        Top = 823.937540000000000000
        Width = 75.590600000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ErSuspWithResuspRastFiltrPercentArea]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo359: TfrxMemoView
        Left = 623.622450000000000000
        Top = 1028.032160000000000000
        Width = 94.488250000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haRight
        Memo.UTF8W = (
          #1057#1090#1088'. 1 '#1080#1079' 3')
        ParentFont = False
        VAlign = vaCenter
      end
      object Subreport1: TfrxSubreport
        Left = 302.362400000000000000
        Top = 427.086890000000000000
        Width = 302.362400000000000000
        Height = 185.196970000000000000
        ShowHint = False
        Page = frxReport1.Page4
      end
      object Memo51: TfrxMemoView
        Left = 604.724800000000000000
        Top = 427.086890000000000000
        Width = 3.779527560000000000
        Height = 185.196970000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftBottom]
        ParentFont = False
      end
      object Memo363: TfrxMemoView
        Left = 714.331170000000000000
        Top = 427.086890000000000000
        Width = 3.779530000000000000
        Height = 185.196970000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftRight, ftBottom]
        ParentFont = False
      end
      object Memo364: TfrxMemoView
        Left = 608.504330000000000000
        Top = 427.086890000000000000
        Width = 105.826840000000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        Memo.UTF8W = (
          '[PreparedFitProductionSZP]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo365: TfrxMemoView
        Left = 608.504330000000000000
        Top = 457.323130000000000000
        Width = 105.826840000000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        Memo.UTF8W = (
          '[PreparedFitProductionErSuspFiltr]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo366: TfrxMemoView
        Left = 608.504330000000000000
        Top = 487.559370000000000000
        Width = 105.826840000000000000
        Height = 30.236220470000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        Memo.UTF8W = (
          '[PreparedFitProductionErSusp]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo367: TfrxMemoView
        Left = 604.724800000000000000
        Top = 612.283860000000000000
        Width = 3.779530000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftLeft, ftBottom]
        ParentFont = False
      end
      object Memo54: TfrxMemoView
        Left = 608.504330000000000000
        Top = 684.094930000000000000
        Width = 105.826840000000000000
        Height = 3.779530000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
        ParentFont = False
      end
      object Memo368: TfrxMemoView
        Left = 608.504330000000000000
        Top = 608.504330000000000000
        Width = 105.826840000000000000
        Height = 3.779530000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
        ParentFont = False
      end
      object Memo369: TfrxMemoView
        Left = 714.331170000000000000
        Top = 612.283860000000000000
        Width = 3.779530000000000000
        Height = 75.590600000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftRight, ftBottom]
        ParentFont = False
      end
      object Memo370: TfrxMemoView
        Left = 608.504330000000000000
        Top = 612.283860000000000000
        Width = 105.826840000000000000
        Height = 23.937006520000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        Memo.UTF8W = (
          '[OutingPreparedFitProductionSZP]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo371: TfrxMemoView
        Left = 608.504330000000000000
        Top = 636.220881980000000000
        Width = 105.826840000000000000
        Height = 23.937006520000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        Memo.UTF8W = (
          '[OutingPreparedFitProductionErSuspFiltr]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo372: TfrxMemoView
        Left = 608.504330000000000000
        Top = 660.157903950000000000
        Width = 105.826840000000000000
        Height = 23.937006520000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        Memo.UTF8W = (
          '[OutingPreparedFitProductionErSusp]')
        ParentFont = False
        VAlign = vaCenter
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Memo135: TfrxMemoView
        Width = 721.890230000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          #1044#1086#1085#1086#1088#1099' '#1080' '#1087#1088#1086#1094#1077#1076#1091#1088#1099)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo136: TfrxMemoView
        Top = 26.456710000000000000
        Width = 718.110700000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          #1057' [WeekStart] '#1087#1086' [WeekEnd]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo137: TfrxMemoView
        Top = 41.574830000000000000
        Width = 718.110700000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '('#1079#1072' '#1085#1077#1076#1077#1083#1102' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1084#1077#1089#1103#1094#1072')')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo138: TfrxMemoView
        Top = 75.590600000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #8470)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo139: TfrxMemoView
        Top = 102.047310000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '1')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo140: TfrxMemoView
        Top = 128.504020000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '2')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo141: TfrxMemoView
        Top = 154.960730000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo142: TfrxMemoView
        Top = 181.417440000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '3')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo143: TfrxMemoView
        Top = 207.874150000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '4')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo144: TfrxMemoView
        Top = 234.330860000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo145: TfrxMemoView
        Top = 260.787570000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo146: TfrxMemoView
        Top = 287.244280000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo147: TfrxMemoView
        Top = 313.700990000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo148: TfrxMemoView
        Top = 340.157700000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '5')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo149: TfrxMemoView
        Left = 37.795300000000000000
        Top = 75.590600000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1055#1086#1082#1072#1079#1072#1090#1077#1083#1080)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo150: TfrxMemoView
        Left = 453.543600000000000000
        Top = 75.590600000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1042' '#1054#1050#1044#1050' '#1080' '#1054#1047#1050)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo151: TfrxMemoView
        Left = 604.724800000000000000
        Top = 75.590600000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1053#1072' '#1074#1099#1077#1079#1076#1077)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo152: TfrxMemoView
        Left = 37.795300000000000000
        Top = 102.047310000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1054#1073#1088#1072#1090#1080#1083#1086#1089#1100' '#1095#1077#1083#1086#1074#1077#1082' '#1076#1083#1103' '#1076#1072#1095#1080' '#1082#1088#1086#1074#1080' ('#1087#1083#1072#1079#1084#1099'):')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo153: TfrxMemoView
        Left = 37.795300000000000000
        Top = 128.504020000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1054#1090#1074#1077#1076#1077#1085#1086' '#1095#1077#1083#1086#1074#1077#1082' '#1086#1090' '#1076#1086#1085#1086#1088#1089#1090#1074#1072':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo154: TfrxMemoView
        Left = 37.795300000000000000
        Top = 154.960730000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          '     '#1074' '#1090'.'#1095'. '#1087#1086' '#1087#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1084' '#1072#1085#1072#1083#1080#1079#1072#1084':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo155: TfrxMemoView
        Left = 37.795300000000000000
        Top = 181.417440000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1044#1086#1087#1091#1097#1077#1085#1086' '#1095#1077#1083#1086#1074#1077#1082' '#1082' '#1076#1086#1085#1072#1094#1080#1080':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo156: TfrxMemoView
        Left = 37.795300000000000000
        Top = 207.874150000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1055#1088#1086#1094#1077#1076#1091#1088' '#1074#1089#1077#1075#1086':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo157: TfrxMemoView
        Left = 37.795300000000000000
        Top = 234.330860000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          '     '#1082#1088#1086#1074#1086#1076#1072#1095':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo158: TfrxMemoView
        Left = 37.795300000000000000
        Top = 260.787570000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          '     '#1087#1083#1072#1079#1084#1086#1076#1072#1095' '#1074#1089#1077#1075#1086':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo159: TfrxMemoView
        Left = 37.795300000000000000
        Top = 287.244280000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          '          '#1074' '#1090'.'#1095'. '#1072#1087#1087#1072#1088#1072#1090#1085#1099#1081' '#1087#1083#1072#1079#1084#1086#1092#1077#1088#1077#1079':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo160: TfrxMemoView
        Left = 37.795300000000000000
        Top = 313.700990000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          '          '#1074' '#1090'.'#1095'. '#1094#1080#1090#1086#1092#1077#1088#1077#1079':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo161: TfrxMemoView
        Left = 37.795300000000000000
        Top = 340.157700000000000000
        Width = 415.748300000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1053#1077' '#1074#1079#1103#1090#1086':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo163: TfrxMemoView
        Left = 1031.811690000000000000
        Top = 136.063080000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          #1042' '#1054#1050#1044#1050' '#1080' '#1054#1047#1050)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo164: TfrxMemoView
        Left = 1145.197590000000000000
        Top = 136.063080000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          #1053#1072' '#1074#1099#1077#1079#1076#1077)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo162: TfrxMemoView
        Left = 453.543600000000000000
        Top = 102.047310000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[AddressedJust]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo165: TfrxMemoView
        Left = 604.724800000000000000
        Top = 102.047310000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[AddressedJustOuting]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo166: TfrxMemoView
        Left = 453.543600000000000000
        Top = 128.504020000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ExceptionTotal]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo167: TfrxMemoView
        Left = 604.724800000000000000
        Top = 128.504020000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ExceptionTotalOuting]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo168: TfrxMemoView
        Left = 453.543600000000000000
        Top = 154.960730000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PreliminaryAnalysis]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo169: TfrxMemoView
        Left = 604.724800000000000000
        Top = 154.960730000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PreliminaryAnalysisOuting]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo170: TfrxMemoView
        Left = 453.543600000000000000
        Top = 181.417440000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[AdmittedToDonation]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo171: TfrxMemoView
        Left = 604.724800000000000000
        Top = 181.417440000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[AdmittedToDonationOuting]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo172: TfrxMemoView
        Left = 453.543600000000000000
        Top = 207.874150000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ProceduresTotal]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo173: TfrxMemoView
        Left = 604.724800000000000000
        Top = 207.874150000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[ProceduresTotalOuting]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo174: TfrxMemoView
        Left = 453.543600000000000000
        Top = 234.330860000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[BloodProcedures]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo175: TfrxMemoView
        Left = 604.724800000000000000
        Top = 234.330860000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[BloodProceduresOuting]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo176: TfrxMemoView
        Left = 453.543600000000000000
        Top = 260.787570000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlasmaProceduresTotal]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo177: TfrxMemoView
        Left = 604.724800000000000000
        Top = 260.787570000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo178: TfrxMemoView
        Left = 453.543600000000000000
        Top = 287.244280000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[APAProcedures]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo179: TfrxMemoView
        Left = 604.724800000000000000
        Top = 287.244280000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo180: TfrxMemoView
        Left = 453.543600000000000000
        Top = 313.700990000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboProcedures]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo181: TfrxMemoView
        Left = 604.724800000000000000
        Top = 313.700990000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo182: TfrxMemoView
        Left = 453.543600000000000000
        Top = 340.157700000000000000
        Width = 151.181200000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[NotTaken]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo183: TfrxMemoView
        Left = 604.724800000000000000
        Top = 340.157700000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[NotTakenOuting]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo184: TfrxMemoView
        Top = 393.071120000000000000
        Width = 718.110700000000000000
        Height = 22.677180000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          #1055#1088#1080#1095#1080#1085#1099' '#1084#1077#1076#1086#1090#1074#1086#1076#1086#1074' '#1086#1090' '#1076#1086#1085#1086#1088#1089#1090#1074#1072':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo185: TfrxMemoView
        Top = 427.086890000000000000
        Width = 37.795275590000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '1')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo186: TfrxMemoView
        Left = 37.795300000000000000
        Top = 427.086890000000000000
        Width = 415.748275590000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1055#1086' '#1087#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1084' '#1072#1085#1072#1083#1080#1079#1072#1084)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo187: TfrxMemoView
        Left = 453.543600000000000000
        Top = 427.086890000000000000
        Width = 151.181175590000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1042' '#1054#1050#1044#1050' '#1080' '#1054#1047#1050)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo188: TfrxMemoView
        Left = 604.724800000000000000
        Top = 427.086890000000000000
        Width = 113.385875590000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1053#1072' '#1074#1099#1077#1079#1076#1077)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo189: TfrxMemoView
        Top = 453.543600000000000000
        Width = 37.795275590000000000
        Height = 18.897637795275600000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo190: TfrxMemoView
        Left = 37.795300000000000000
        Top = 453.543600000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1043#1077#1084#1086#1075#1083#1086#1073#1080#1085':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo191: TfrxMemoView
        Left = 464.882190000000000000
        Top = 453.543600000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo192: TfrxMemoView
        Left = 604.724800000000000000
        Top = 453.543600000000000000
        Width = 113.385875590000000000
        Height = 18.897637795275600000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo193: TfrxMemoView
        Left = 442.205010000000000000
        Top = 453.543600000000000000
        Width = 11.338590000000000000
        Height = 18.897637795275600000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo194: TfrxMemoView
        Top = 472.441250000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo195: TfrxMemoView
        Left = 37.795300000000000000
        Top = 472.441250000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1040#1051#1058':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo196: TfrxMemoView
        Left = 464.882190000000000000
        Top = 472.441250000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo197: TfrxMemoView
        Left = 604.724800000000000000
        Top = 472.441250000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo198: TfrxMemoView
        Left = 442.205010000000000000
        Top = 472.441250000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo199: TfrxMemoView
        Top = 491.338900000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo200: TfrxMemoView
        Left = 37.795300000000000000
        Top = 491.338900000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1061#1080#1083#1077#1079':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo201: TfrxMemoView
        Left = 464.882190000000000000
        Top = 491.338900000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo202: TfrxMemoView
        Left = 604.724800000000000000
        Top = 491.338900000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo203: TfrxMemoView
        Left = 442.205010000000000000
        Top = 491.338900000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo204: TfrxMemoView
        Top = 510.236550000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo205: TfrxMemoView
        Left = 37.795300000000000000
        Top = 510.236550000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1053#1080#1079#1082#1080#1077' '#1090#1088#1086#1084#1073#1086#1094#1080#1090#1099':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo206: TfrxMemoView
        Left = 464.882190000000000000
        Top = 510.236550000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo207: TfrxMemoView
        Left = 604.724800000000000000
        Top = 510.236550000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo208: TfrxMemoView
        Left = 442.205010000000000000
        Top = 510.236550000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo209: TfrxMemoView
        Top = 529.134200000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo210: TfrxMemoView
        Left = 37.795300000000000000
        Top = 529.134200000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1042#1099#1089#1086#1082#1080#1077' '#1090#1088#1086#1084#1073#1086#1094#1080#1090#1099':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo211: TfrxMemoView
        Left = 464.882190000000000000
        Top = 529.134200000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo212: TfrxMemoView
        Left = 604.724800000000000000
        Top = 529.134200000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo213: TfrxMemoView
        Left = 442.205010000000000000
        Top = 529.134200000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo214: TfrxMemoView
        Top = 548.031850000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo215: TfrxMemoView
        Left = 37.795300000000000000
        Top = 548.031850000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1041#1080#1083#1080#1088#1091#1073#1080#1085':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo216: TfrxMemoView
        Left = 464.882190000000000000
        Top = 548.031850000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo217: TfrxMemoView
        Left = 604.724800000000000000
        Top = 548.031850000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo218: TfrxMemoView
        Left = 442.205010000000000000
        Top = 548.031850000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo219: TfrxMemoView
        Top = 566.929500000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo220: TfrxMemoView
        Left = 37.795300000000000000
        Top = 566.929500000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1042#1099#1089#1086#1082#1086#1077' '#1057#1054#1069':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo221: TfrxMemoView
        Left = 464.882190000000000000
        Top = 566.929500000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo222: TfrxMemoView
        Left = 604.724800000000000000
        Top = 566.929500000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo223: TfrxMemoView
        Left = 442.205010000000000000
        Top = 566.929500000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo224: TfrxMemoView
        Top = 585.827150000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo225: TfrxMemoView
        Left = 37.795300000000000000
        Top = 585.827150000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1053#1080#1079#1082#1080#1077' '#1083#1077#1081#1082#1086#1094#1080#1090#1099':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo226: TfrxMemoView
        Left = 464.882190000000000000
        Top = 585.827150000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo227: TfrxMemoView
        Left = 604.724800000000000000
        Top = 585.827150000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo228: TfrxMemoView
        Left = 442.205010000000000000
        Top = 585.827150000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo229: TfrxMemoView
        Top = 604.724800000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo230: TfrxMemoView
        Left = 37.795300000000000000
        Top = 604.724800000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1042#1099#1089#1086#1082#1080#1077' '#1083#1077#1081#1082#1086#1094#1080#1090#1099':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo231: TfrxMemoView
        Left = 464.882190000000000000
        Top = 604.724800000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo232: TfrxMemoView
        Left = 604.724800000000000000
        Top = 604.724800000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo233: TfrxMemoView
        Left = 442.205010000000000000
        Top = 604.724800000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo234: TfrxMemoView
        Top = 623.622450000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo235: TfrxMemoView
        Left = 37.795300000000000000
        Top = 623.622450000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1041#1077#1083#1086#1082':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo236: TfrxMemoView
        Left = 464.882190000000000000
        Top = 623.622450000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo237: TfrxMemoView
        Left = 604.724800000000000000
        Top = 623.622450000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo238: TfrxMemoView
        Left = 442.205010000000000000
        Top = 623.622450000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo239: TfrxMemoView
        Top = 642.520100000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo240: TfrxMemoView
        Left = 37.795300000000000000
        Top = 642.520100000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1062#1074#1077#1090#1085#1086#1081':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo241: TfrxMemoView
        Left = 464.882190000000000000
        Top = 642.520100000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo242: TfrxMemoView
        Left = 604.724800000000000000
        Top = 642.520100000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo243: TfrxMemoView
        Left = 442.205010000000000000
        Top = 642.520100000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo244: TfrxMemoView
        Top = 661.417750000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo245: TfrxMemoView
        Left = 37.795300000000000000
        Top = 661.417750000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1043#1077#1084#1072#1090#1086#1082#1088#1080#1090':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo246: TfrxMemoView
        Left = 464.882190000000000000
        Top = 661.417750000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo247: TfrxMemoView
        Left = 604.724800000000000000
        Top = 661.417750000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo248: TfrxMemoView
        Left = 442.205010000000000000
        Top = 661.417750000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo249: TfrxMemoView
        Top = 680.315400000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo250: TfrxMemoView
        Left = 37.795300000000000000
        Top = 680.315400000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1069#1088#1080#1090#1088#1086#1094#1080#1090#1099':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo251: TfrxMemoView
        Left = 464.882190000000000000
        Top = 680.315400000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo252: TfrxMemoView
        Left = 604.724800000000000000
        Top = 680.315400000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo253: TfrxMemoView
        Left = 442.205010000000000000
        Top = 680.315400000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo254: TfrxMemoView
        Top = 699.213050000000000000
        Width = 37.795275590000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '2')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo255: TfrxMemoView
        Left = 37.795300000000000000
        Top = 699.213050000000000000
        Width = 415.748275590000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1055#1086' '#1076#1088#1091#1075#1080#1084' '#1087#1088#1080#1095#1080#1085#1072#1084)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo256: TfrxMemoView
        Left = 453.543600000000000000
        Top = 699.213050000000000000
        Width = 151.181175590000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo257: TfrxMemoView
        Left = 604.724800000000000000
        Top = 699.213050000000000000
        Width = 113.385875590000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo258: TfrxMemoView
        Top = 725.669760000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo259: TfrxMemoView
        Left = 37.795300000000000000
        Top = 725.669760000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1042#1099#1089#1086#1082#1086#1077' '#1076#1072#1074#1083#1077#1085#1080#1077':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo260: TfrxMemoView
        Left = 464.882190000000000000
        Top = 725.669760000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo261: TfrxMemoView
        Left = 604.724800000000000000
        Top = 725.669760000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo262: TfrxMemoView
        Left = 442.205010000000000000
        Top = 725.669760000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo263: TfrxMemoView
        Top = 744.567410000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo264: TfrxMemoView
        Left = 37.795300000000000000
        Top = 744.567410000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1055#1083#1086#1093#1080#1077' '#1074#1077#1085#1099':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo265: TfrxMemoView
        Left = 464.882190000000000000
        Top = 744.567410000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo266: TfrxMemoView
        Left = 604.724800000000000000
        Top = 744.567410000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo267: TfrxMemoView
        Left = 442.205010000000000000
        Top = 744.567410000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo268: TfrxMemoView
        Top = 763.465060000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo269: TfrxMemoView
        Left = 37.795300000000000000
        Top = 763.465060000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1054#1090#1089#1077#1074' '#1091' '#1090#1077#1088#1072#1087#1077#1074#1090#1072':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo270: TfrxMemoView
        Left = 464.882190000000000000
        Top = 763.465060000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo271: TfrxMemoView
        Left = 604.724800000000000000
        Top = 763.465060000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo272: TfrxMemoView
        Left = 442.205010000000000000
        Top = 763.465060000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo273: TfrxMemoView
        Top = 782.362710000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo274: TfrxMemoView
        Left = 37.795300000000000000
        Top = 782.362710000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1053#1077#1076#1086#1073#1086#1088' '#1074#1077#1089#1072':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo275: TfrxMemoView
        Left = 464.882190000000000000
        Top = 782.362710000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo276: TfrxMemoView
        Left = 604.724800000000000000
        Top = 782.362710000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo277: TfrxMemoView
        Left = 442.205010000000000000
        Top = 782.362710000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo278: TfrxMemoView
        Top = 801.260360000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo279: TfrxMemoView
        Left = 37.795300000000000000
        Top = 801.260360000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1058#1072#1090#1091':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo280: TfrxMemoView
        Left = 464.882190000000000000
        Top = 801.260360000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo281: TfrxMemoView
        Left = 604.724800000000000000
        Top = 801.260360000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo282: TfrxMemoView
        Left = 442.205010000000000000
        Top = 801.260360000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo283: TfrxMemoView
        Top = 820.158010000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo284: TfrxMemoView
        Left = 37.795300000000000000
        Top = 820.158010000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haRight
        Memo.UTF8W = (
          #1054#1090#1089#1077#1074' '#1087#1086' '#1041#1044':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo285: TfrxMemoView
        Left = 464.882190000000000000
        Top = 820.158010000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo286: TfrxMemoView
        Left = 604.724800000000000000
        Top = 820.158010000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo287: TfrxMemoView
        Left = 442.205010000000000000
        Top = 820.158010000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo288: TfrxMemoView
        Top = 839.055660000000000000
        Width = 37.795275590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo289: TfrxMemoView
        Left = 37.795300000000000000
        Top = 839.055660000000000000
        Width = 404.409685590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haRight
        Memo.UTF8W = (
          #1057#1076#1072#1083#1080' '#1090#1086#1083#1100#1082#1086' '#1072#1085#1072#1083#1080#1079#1099':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo290: TfrxMemoView
        Left = 464.882190000000000000
        Top = 839.055660000000000000
        Width = 139.842585590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo291: TfrxMemoView
        Left = 604.724800000000000000
        Top = 839.055660000000000000
        Width = 113.385875590000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo292: TfrxMemoView
        Left = 442.205010000000000000
        Top = 839.055660000000000000
        Width = 11.338590000000000000
        Height = 18.897637800000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight, ftBottom]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo293: TfrxMemoView
        Left = 453.543600000000000000
        Top = 839.055660000000000000
        Width = 11.338590000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haRight
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo358: TfrxMemoView
        Left = 623.622450000000000000
        Top = 1028.032160000000000000
        Width = 94.488250000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haRight
        Memo.UTF8W = (
          #1057#1090#1088'. 2 '#1080#1079' 3')
        ParentFont = False
        VAlign = vaCenter
      end
    end
    object Page3: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Memo294: TfrxMemoView
        Width = 718.110700000000000000
        Height = 30.236240000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          #1050#1086#1085#1089#1091#1083#1100#1090#1072#1094#1080' '#1051#1055#1059' '#1087#1086' '#1074#1086#1087#1088#1086#1089#1072#1084' '#1090#1088#1072#1085#1089#1092#1091#1079#1080#1086#1085#1085#1086#1081' '#1090#1077#1088#1072#1087#1080)
        ParentFont = False
      end
      object Memo295: TfrxMemoView
        Top = 26.456710000000000000
        Width = 718.110700000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '('#1079#1072' '#1085#1077#1076#1077#1083#1102' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1084#1077#1089#1103#1094#1072')')
        ParentFont = False
      end
      object Memo296: TfrxMemoView
        Top = 75.590600000000000000
        Width = 37.795300000000000000
        Height = 26.456692913385800000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #8470)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo297: TfrxMemoView
        Left = 37.795300000000000000
        Top = 75.590600000000000000
        Width = 453.543600000000000000
        Height = 26.456692913385800000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1082#1077#1084)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo298: TfrxMemoView
        Left = 491.338900000000000000
        Top = 75.590600000000000000
        Width = 109.606370000000000000
        Height = 26.456692913385800000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1082#1086#1083#1080#1095#1077#1089#1090#1074#1086)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo299: TfrxMemoView
        Top = 102.047310000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '1')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo300: TfrxMemoView
        Left = 37.795300000000000000
        Top = 102.047310000000000000
        Width = 453.543600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1042#1088#1072#1095#1077#1084'-'#1090#1088#1072#1085#1089#1092#1091#1079#1080#1086#1083#1086#1075#1086#1084':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo301: TfrxMemoView
        Left = 491.338900000000000000
        Top = 102.047310000000000000
        Width = 109.606370000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo302: TfrxMemoView
        Top = 128.504020000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '2')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo303: TfrxMemoView
        Left = 37.795300000000000000
        Top = 128.504020000000000000
        Width = 453.543600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1042#1088#1072#1095#1077#1084'-'#1083#1072#1073#1086#1088#1072#1085#1090#1086#1084' ('#1087#1086' '#1087#1086#1076#1073#1086#1088#1091'):')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo304: TfrxMemoView
        Left = 491.338900000000000000
        Top = 128.504020000000000000
        Width = 109.606370000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo305: TfrxMemoView
        Top = 154.960730000000000000
        Width = 37.795300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '3')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo306: TfrxMemoView
        Left = 37.795300000000000000
        Top = 154.960730000000000000
        Width = 453.543600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1055#1088#1086#1074#1077#1088#1082#1072' '#1051#1055#1059':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo307: TfrxMemoView
        Left = 491.338900000000000000
        Top = 154.960730000000000000
        Width = 109.606370000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo308: TfrxMemoView
        Top = 211.653680000000000000
        Width = 718.110700000000000000
        Height = 30.236240000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          
            #1044#1086#1089#1090#1072#1074#1083#1077#1085#1086' '#1074' '#1054#1044#1061#1050#1050' '#1080' '#1042#1058#1057' '#1050#1050#1062#1050' '#8470'1, '#1089#1087#1080#1089#1072#1085#1086' '#1087#1086' '#1080#1089#1090#1077#1095#1077#1085#1080#1102' '#1089#1088#1086#1082#1072' '#1075#1086#1076 +
            #1085#1086#1089#1090#1080)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo309: TfrxMemoView
        Top = 264.567100000000000000
        Width = 415.748300000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1072)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo310: TfrxMemoView
        Left = 415.748300000000000000
        Top = 264.567100000000000000
        Width = 151.181200000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1044#1086#1089#1090#1072#1074#1083#1077#1085#1086)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo311: TfrxMemoView
        Left = 566.929500000000000000
        Top = 264.567100000000000000
        Width = 151.181200000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1057#1087#1080#1089#1072#1085#1086)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo312: TfrxMemoView
        Left = 415.748300000000000000
        Top = 283.464750000000000000
        Width = 75.590600000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1083)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo313: TfrxMemoView
        Left = 566.929500000000000000
        Top = 283.464750000000000000
        Width = 75.590600000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1083)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo314: TfrxMemoView
        Left = 491.338900000000000000
        Top = 283.464750000000000000
        Width = 75.590600000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1076)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo315: TfrxMemoView
        Left = 642.520100000000000000
        Top = 283.464750000000000000
        Width = 75.590600000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          #1076)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo316: TfrxMemoView
        Top = 302.362400000000000000
        Width = 415.748300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1069#1088'. '#1074#1079#1074#1077#1089#1100' '#1089' '#1088#1077#1089#1091#1089#1087'. '#1088'-'#1088#1086#1084', '#1092#1080#1083#1100#1090#1088#1086#1074#1072#1085#1085#1072#1103)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo317: TfrxMemoView
        Left = 415.748300000000000000
        Top = 302.362400000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo318: TfrxMemoView
        Left = 566.929500000000000000
        Top = 302.362400000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo319: TfrxMemoView
        Left = 491.338900000000000000
        Top = 302.362400000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo320: TfrxMemoView
        Left = 642.520100000000000000
        Top = 302.362400000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo321: TfrxMemoView
        Top = 328.819110000000000000
        Width = 415.748300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1069#1088'. '#1074#1079#1074#1077#1089#1100' '#1089' '#1088#1077#1089#1091#1089#1087'. '#1088'-'#1088#1086#1084)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo322: TfrxMemoView
        Left = 415.748300000000000000
        Top = 328.819110000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo323: TfrxMemoView
        Left = 566.929500000000000000
        Top = 328.819110000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo324: TfrxMemoView
        Left = 491.338900000000000000
        Top = 328.819110000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo325: TfrxMemoView
        Left = 642.520100000000000000
        Top = 328.819110000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo326: TfrxMemoView
        Top = 355.275820000000000000
        Width = 415.748300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1069#1088'. '#1074#1079#1074#1077#1089#1100' '#1089' '#1092#1080#1079#1080#1086' '#1088'-'#1088#1086#1084)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo327: TfrxMemoView
        Left = 415.748300000000000000
        Top = 355.275820000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo328: TfrxMemoView
        Left = 566.929500000000000000
        Top = 355.275820000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo329: TfrxMemoView
        Left = 491.338900000000000000
        Top = 355.275820000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo330: TfrxMemoView
        Left = 642.520100000000000000
        Top = 355.275820000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo331: TfrxMemoView
        Top = 381.732530000000000000
        Width = 415.748300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1057#1047#1055' '#1082#1072#1088'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo332: TfrxMemoView
        Left = 415.748300000000000000
        Top = 381.732530000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo333: TfrxMemoView
        Left = 566.929500000000000000
        Top = 381.732530000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo334: TfrxMemoView
        Left = 491.338900000000000000
        Top = 381.732530000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo335: TfrxMemoView
        Left = 642.520100000000000000
        Top = 381.732530000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo336: TfrxMemoView
        Top = 408.189240000000000000
        Width = 415.748300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1057#1047#1055' '#1074#1080#1088#1091#1089#1080#1085#1072#1082#1090#1080#1074#1080#1088#1086#1074#1072#1085#1085#1072#1103)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo337: TfrxMemoView
        Left = 415.748300000000000000
        Top = 408.189240000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo338: TfrxMemoView
        Left = 566.929500000000000000
        Top = 408.189240000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo339: TfrxMemoView
        Left = 491.338900000000000000
        Top = 408.189240000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo340: TfrxMemoView
        Left = 642.520100000000000000
        Top = 408.189240000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo341: TfrxMemoView
        Top = 434.645950000000000000
        Width = 415.748300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1050#1088#1080#1086#1087#1088#1077#1094#1080#1087#1080#1090#1072#1090' '#1079#1072#1084'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo342: TfrxMemoView
        Left = 415.748300000000000000
        Top = 434.645950000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo343: TfrxMemoView
        Left = 566.929500000000000000
        Top = 434.645950000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo344: TfrxMemoView
        Left = 491.338900000000000000
        Top = 434.645950000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo345: TfrxMemoView
        Left = 642.520100000000000000
        Top = 434.645950000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo346: TfrxMemoView
        Top = 461.102660000000000000
        Width = 415.748300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1050#1086#1085#1094#1077#1085#1090#1088#1072#1090' '#1090#1088#1086#1084#1073#1086#1094#1080#1090#1086#1074)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo347: TfrxMemoView
        Left = 415.748300000000000000
        Top = 461.102660000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo348: TfrxMemoView
        Left = 566.929500000000000000
        Top = 461.102660000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo349: TfrxMemoView
        Left = 491.338900000000000000
        Top = 461.102660000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo350: TfrxMemoView
        Left = 642.520100000000000000
        Top = 461.102660000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo351: TfrxMemoView
        Top = 487.559370000000000000
        Width = 415.748300000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Memo.UTF8W = (
          #1055#1077#1088#1092#1090#1086#1088#1072#1085)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo352: TfrxMemoView
        Left = 415.748300000000000000
        Top = 487.559370000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo353: TfrxMemoView
        Left = 566.929500000000000000
        Top = 487.559370000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo354: TfrxMemoView
        Left = 491.338900000000000000
        Top = 487.559370000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo355: TfrxMemoView
        Left = 642.520100000000000000
        Top = 487.559370000000000000
        Width = 75.590600000000000000
        Height = 26.456692910000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        HAlign = haCenter
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo356: TfrxMemoView
        Left = 623.622450000000000000
        Top = 1028.032160000000000000
        Width = 94.488250000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haRight
        Memo.UTF8W = (
          #1057#1090#1088'. 3 '#1080#1079' 3')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo357: TfrxMemoView
        Top = 238.110390000000000000
        Width = 718.110700000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '('#1079#1072' '#1085#1077#1076#1077#1083#1102' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1084#1077#1089#1103#1094#1072')')
        ParentFont = False
      end
    end
    object Page4: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        Height = 15.118110240000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = frxUserDataSet1
        DataSetName = 'frxUserDataSet1'
        RowCount = 0
        object Memo360: TfrxMemoView
          Left = 3.779530000000000000
          Width = 173.858380000000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Name]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo361: TfrxMemoView
          Left = 200.315090000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8W = (
            '[Volume]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo362: TfrxMemoView
          Left = 177.637910000000000000
          Width = 22.677180000000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            #8211)
          ParentFont = False
          VAlign = vaBottom
        end
      end
    end
  end
  object frxUserDataSet1: TfrxUserDataSet
    UserName = 'frxUserDataSet1'
    Left = 40
    Top = 160
  end
end
