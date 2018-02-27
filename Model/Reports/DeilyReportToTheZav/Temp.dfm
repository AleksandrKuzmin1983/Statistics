object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 350
  ClientWidth = 749
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxPreview1: TfrxPreview
    Left = 0
    Top = 0
    Width = 749
    Height = 350
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
    ReportOptions.LastChange = 43130.478531851860000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      
        'Function StringDate: string;                                    ' +
        '                                            '
      'var'
      '  CYear, CMonth, CDay: word;'
      '  RedYear, RedMonth, RedDay: String;'
      'begin'
      '  DecodeDate(date(), CYear, CMonth, CDay);'
      '  case CMonth of'
      '    1: RedMonth:='#39#1103#1085#1074#1072#1088#1103#39';'
      '    2: RedMonth:='#39#1092#1077#1074#1088#1072#1083#1103#39';'
      '    3: RedMonth:='#39#1084#1072#1088#1090#1072#39';'
      '    4: RedMonth:='#39#1072#1087#1088#1077#1083#1103#39';'
      '    5: RedMonth:='#39#1084#1072#1103#39';'
      '    6: RedMonth:='#39#1080#1102#1085#1103#39';'
      '    7: RedMonth:='#39#1080#1102#1083#1103#39';'
      '    8: RedMonth:='#39#1072#1074#1075#1091#1089#1090#1072#39';'
      '    9: RedMonth:='#39#1089#1077#1085#1090#1103#1073#1088#1103#39';'
      '    10: RedMonth:='#39#1086#1082#1090#1103#1073#1088#1103#39';'
      '    11: RedMonth:='#39#1085#1086#1103#1073#1088#1103#39';'
      '    12: RedMonth:='#39#1076#1077#1082#1072#1073#1088#1103#39';'
      '  end;'
      
        '  if CDay<10 then RedDay:='#39'0'#39' + IntToStr(CDay) else RedDay:=IntT' +
        'oStr(CDay);'
      '  RedYear:=IntToStr(CYear);'
      '  Result:=RedDay + '#39' '#39' + RedMonth + '#39' '#39' + RedYear + '#39' '#1075'.'#39';'
      'end;  '
      '  '
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (get('#39'VolumeTrombo'#39')='#39'0,000'#39') or (get('#39'VolumeTrombo'#39')=null)' +
        ' then'
      '  begin            '
      '    memo21.visible:=false;'
      
        '    memo22.visible:=false;                                      ' +
        '            '
      '  end;'
      '  Set('#39'DateStr'#39', '#39#39#39#39' + StringDate + '#39#39#39#39');'
      '{    Set('#39'VolumeTrombo'#39', 9999);'
      '      Set('#39'NumberDosesTromb'#39', '#39#39#39' 99 '#1076'. '#39#39#39');'
      
        '        Set('#39'NumberPacketsTromb'#39', '#39#39#39' 50 '#1087'. '#39#39#39');     }         ' +
        '   '
      'end;'
      ''
      'begin'
      '                          '
      'end.')
    Left = 24
    Top = 16
    Datasets = <>
    Variables = <
      item
        Name = 'DateStr'
        Value = Null
      end
      item
        Name = ' Volume'
        Value = Null
      end
      item
        Name = 'VolumeWholeBlood'
        Value = Null
      end
      item
        Name = 'VolumeConsBlood'
        Value = Null
      end
      item
        Name = 'VolumePlasmaTotal'
        Value = Null
      end
      item
        Name = 'VolumePlasmaAPA'
        Value = Null
      end
      item
        Name = 'VolumeErSusp'
        Value = Null
      end
      item
        Name = 'VolumeTrombo'
        Value = Null
      end
      item
        Name = ' Percent'
        Value = Null
      end
      item
        Name = 'PercentWholeBlood'
        Value = Null
      end
      item
        Name = 'PercentConsBlood'
        Value = Null
      end
      item
        Name = 'PercentPlasmaTotal'
        Value = Null
      end
      item
        Name = 'PercentPlasmaAPA'
        Value = Null
      end
      item
        Name = 'PercentErSusp'
        Value = Null
      end
      item
        Name = ' PlanVolume'
        Value = Null
      end
      item
        Name = 'PlanVolumeWholeBlood'
        Value = Null
      end
      item
        Name = 'PlanVolumeConsBlood'
        Value = Null
      end
      item
        Name = 'PlanVolumePlasmaTotal'
        Value = Null
      end
      item
        Name = 'PlanVolumePlasmaAPA'
        Value = Null
      end
      item
        Name = 'PlanVolumeErSusp'
        Value = Null
      end
      item
        Name = ' NumberTrombo'
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
        Name = ' Procedures'
        Value = Null
      end
      item
        Name = 'PlanBloodProcedures'
        Value = Null
      end
      item
        Name = 'PlanAPAProcedures'
        Value = Null
      end
      item
        Name = 'PlanTromboProcedures'
        Value = Null
      end
      item
        Name = 'WorksDay'
        Value = Null
      end
      item
        Name = ' StatInformation'
        Value = Null
      end
      item
        Name = 'BloodNumberProceduresDone'
        Value = Null
      end
      item
        Name = 'BloodRestImplementationOfThePlan'
        Value = Null
      end
      item
        Name = 'BloodPercentageOfPlanProcedures'
        Value = Null
      end
      item
        Name = 'BloodTheNumberOfTreatmentsPerDay'
        Value = Null
      end
      item
        Name = 'BloodTheNumberOfTreatmentsPerDayWholeBlood'
        Value = Null
      end
      item
        Name = 'BloodNumberWholeBloodAtTheMomentToMatchThePlan'
        Value = Null
      end
      item
        Name = 'PlasmaNumberProceduresDone'
        Value = Null
      end
      item
        Name = 'PlasmaRestImplementationOfThePlan'
        Value = Null
      end
      item
        Name = 'PlasmaPercentageOfPlanProcedures'
        Value = Null
      end
      item
        Name = 'PlasmaTheNumberOfTreatmentsPerDay'
        Value = Null
      end
      item
        Name = 'TromboNumberProceduresDone'
        Value = Null
      end
      item
        Name = 'TromboRestImplementationOfThePlan'
        Value = Null
      end
      item
        Name = 'TromboPercentageOfPlanProcedures'
        Value = Null
      end
      item
        Name = 'TromboTheNumberOfTreatmentsPerDay'
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
        Width = 529.134200000000000000
        Height = 30.236240000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -32
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Memo.UTF8W = (
          #1045#1078#1077#1076#1085#1077#1074#1085#1099#1081' '#1086#1090#1095#1077#1090' '#1087#1086' '#1079#1072#1075#1086#1090#1086#1074#1082#1077' '#1082#1088#1086#1074#1080)
        ParentFont = False
      end
      object Memo2: TfrxMemoView
        Top = 113.385900000000000000
        Width = 226.771653540000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight, ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo3: TfrxMemoView
        Left = 226.771800000000000000
        Top = 113.385900000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          #1050#1086#1083'-'#1074#1086', '#1083)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo4: TfrxMemoView
        Left = 340.157700000000000000
        Top = 113.385900000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '% '#1086#1090' '#1087#1083#1072#1085#1072)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo5: TfrxMemoView
        Top = 151.181200000000000000
        Width = 226.771653540000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        Memo.UTF8W = (
          #1062#1077#1083#1100#1085#1072#1103' '#1082#1088#1086#1074#1100)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo6: TfrxMemoView
        Top = 188.976500000000000000
        Width = 226.771653540000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        Memo.UTF8W = (
          #1050#1086#1085#1089#1077#1088#1074#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1082#1088#1086#1074#1100)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo11: TfrxMemoView
        Left = 340.157700000000000000
        Top = 151.181200000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.2f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PercentWholeBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo16: TfrxMemoView
        Left = 226.771800000000000000
        Top = 151.181200000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          '[VolumeWholeBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo17: TfrxMemoView
        Left = 226.771800000000000000
        Top = 188.976500000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[VolumeConsBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo7: TfrxMemoView
        Top = 226.771800000000000000
        Width = 226.771653540000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        Memo.UTF8W = (
          #1055#1083#1072#1079#1084#1072' '#1074#1089#1077#1075#1086)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo8: TfrxMemoView
        Top = 264.567100000000000000
        Width = 226.771653540000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        Memo.UTF8W = (
          #1055#1083#1072#1079#1084#1072' '#1040#1055#1040)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo9: TfrxMemoView
        Top = 302.362400000000000000
        Width = 226.771653540000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        Memo.UTF8W = (
          #1069#1088'. '#1089#1088#1077#1076#1099)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo10: TfrxMemoView
        Top = 340.157700000000000000
        Width = 226.771653540000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        Memo.UTF8W = (
          #1058#1088#1086#1084#1073#1086#1082#1086#1085#1094#1077#1085#1090#1088#1072#1090)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo13: TfrxMemoView
        Left = 340.157700000000000000
        Top = 226.771800000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PercentPlasmaTotal]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo14: TfrxMemoView
        Left = 340.157700000000000000
        Top = 264.567100000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PercentPlasmaAPA]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo15: TfrxMemoView
        Left = 340.157700000000000000
        Top = 302.362400000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PercentErSusp]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo18: TfrxMemoView
        Left = 226.771800000000000000
        Top = 226.771800000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          '[VolumePlasmaTotal]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo19: TfrxMemoView
        Left = 226.771800000000000000
        Top = 264.567100000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[VolumePlasmaAPA]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo20: TfrxMemoView
        Left = 226.771800000000000000
        Top = 302.362400000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          '[VolumeErSusp]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo21: TfrxMemoView
        Left = 226.771800000000000000
        Top = 340.157700000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftTop]
        HAlign = haCenter
        Memo.UTF8W = (
          '[VolumeTrombo]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo22: TfrxMemoView
        Left = 340.157700000000000000
        Top = 340.157700000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftTop]
        Memo.UTF8W = (
          '[NumberPacketsTromb]/[NumberDosesTromb]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo12: TfrxMemoView
        Left = 340.157700000000000000
        Top = 188.976500000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        DisplayFormat.Kind = fkNumeric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftTop, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PercentConsBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object DateStr: TfrxMemoView
        Left = 11.338590000000000000
        Top = 37.795300000000000000
        Width = 302.362400000000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Times New Roman'
        Font.Style = []
        Memo.UTF8W = (
          '[DateStr]')
        ParentFont = False
      end
      object Memo23: TfrxMemoView
        Left = 476.220780000000000000
        Top = 92.598425196850400000
        Width = 241.889920000000000000
        Height = 32.881889760000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          #1055#1083#1072#1085#1086#1074#1099#1077' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1080':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo24: TfrxMemoView
        Left = 476.220780000000000000
        Top = 124.724490000000000000
        Width = 128.504020000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          #1054#1073#1098#1077#1084', '#1083'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo25: TfrxMemoView
        Left = 604.724800000000000000
        Top = 124.724490000000000000
        Width = 113.385900000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          #1055#1088#1086#1094'-'#1088#1099)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo26: TfrxMemoView
        Left = 476.220780000000000000
        Top = 151.181200000000000000
        Width = 128.503937010000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlanVolumeWholeBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo27: TfrxMemoView
        Left = 476.220780000000000000
        Top = 188.976500000000000000
        Width = 128.503937010000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlanVolumeConsBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo28: TfrxMemoView
        Left = 476.220780000000000000
        Top = 226.771800000000000000
        Width = 128.503937010000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlanVolumePlasmaTotal]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo29: TfrxMemoView
        Left = 476.220780000000000000
        Top = 264.567100000000000000
        Width = 128.503937010000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlanVolumePlasmaAPA]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo30: TfrxMemoView
        Left = 476.220780000000000000
        Top = 302.362400000000000000
        Width = 128.503937010000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlanVolumeErSusp]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo31: TfrxMemoView
        Left = 604.724800000000000000
        Top = 151.181200000000000000
        Width = 56.692913390000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlanBloodProcedures]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo32: TfrxMemoView
        Left = 604.724800000000000000
        Top = 188.976500000000000000
        Width = 56.692913390000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlanAPAProcedures]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo33: TfrxMemoView
        Left = 604.724800000000000000
        Top = 226.771800000000000000
        Width = 56.692913390000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlanTromboProcedures]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo36: TfrxMemoView
        Left = 476.220780000000000000
        Top = 340.157700000000000000
        Width = 128.503937010000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Width = 1.500000000000000000
        HAlign = haRight
        Memo.UTF8W = (
          #1082#1086#1083'-'#1074#1086' '#1088#1072#1073#1086#1095#1080#1093' '#1076#1085#1077#1081' '#1074' '#1084#1077#1089#1103#1094#1077':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo37: TfrxMemoView
        Left = 604.724800000000000000
        Top = 340.157700000000000000
        Width = 56.692913390000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[WorksDay]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo34: TfrxMemoView
        Left = 661.417750000000000000
        Top = 151.181200000000000000
        Width = 56.692913390000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Width = 1.500000000000000000
        Memo.UTF8W = (
          #1082#1088'.')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo35: TfrxMemoView
        Left = 661.417750000000000000
        Top = 188.976500000000000000
        Width = 56.692913390000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Width = 1.500000000000000000
        Memo.UTF8W = (
          #1040#1055#1040)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo38: TfrxMemoView
        Left = 661.417750000000000000
        Top = 226.771800000000000000
        Width = 56.692913390000000000
        Height = 37.795300000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Width = 1.500000000000000000
        Memo.UTF8W = (
          #1090#1088#1086#1084#1073#1086)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo39: TfrxMemoView
        Top = 491.338900000000000000
        Width = 415.748031500000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight, ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haRight
        Memo.UTF8W = (
          ' ')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo40: TfrxMemoView
        Left = 415.748300000000000000
        Top = 491.338900000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          #1050#1088#1086#1074#1100)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo41: TfrxMemoView
        Left = 529.134200000000000000
        Top = 491.338900000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          #1040#1055#1040)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo42: TfrxMemoView
        Top = 529.134200000000000000
        Width = 415.748031500000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haRight
        Memo.UTF8W = (
          #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1087#1088#1086#1094#1077#1076#1091#1088':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo43: TfrxMemoView
        Top = 566.929500000000000000
        Width = 415.748031500000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haRight
        Memo.UTF8W = (
          #1054#1089#1090#1072#1083#1086#1089#1100' '#1087#1088#1086#1094#1077#1076#1091#1088' '#1076#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1087#1083#1072#1085#1072':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo44: TfrxMemoView
        Left = 529.134200000000000000
        Top = 529.134200000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.2f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlasmaNumberProceduresDone]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo45: TfrxMemoView
        Left = 415.748300000000000000
        Top = 529.134200000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[BloodNumberProceduresDone]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo46: TfrxMemoView
        Left = 415.748300000000000000
        Top = 566.929500000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[BloodRestImplementationOfThePlan]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo47: TfrxMemoView
        Top = 604.724800000000000000
        Width = 415.748031500000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haRight
        Memo.UTF8W = (
          '% '#1086#1090' '#1087#1083#1072#1085#1072' '#1087#1086' '#1087#1088#1086#1094#1077#1076#1091#1088#1072#1084':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo48: TfrxMemoView
        Top = 642.520100000000000000
        Width = 415.748031496063000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haRight
        Memo.UTF8W = (
          #1055#1088#1080#1084#1077#1088#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1099#1093' '#1087#1088#1086#1094#1077#1076#1091#1088' '#1074' '#1076#1077#1085#1100':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo49: TfrxMemoView
        Top = 718.110700000000000000
        Width = 415.748031500000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haRight
        Memo.UTF8W = (
          #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1094#1077#1083#1100#1085#1086#1081' '#1082#1088#1086#1074#1080' '#1085#1072' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1077#1085#1100' '#1076#1083#1103' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1103' '#1087#1083#1072#1085#1091':')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo50: TfrxMemoView
        Top = 680.315400000000000000
        Width = 415.748031500000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftRight]
        Frame.Width = 1.500000000000000000
        HAlign = haRight
        Memo.UTF8W = (
          
            #1055#1088#1080#1084#1077#1088#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1099#1093' '#1087#1088#1086#1094#1077#1076#1091#1088' '#1074' '#1076#1077#1085#1100' ('#1076#1083#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103 +
            ' '#1087#1083#1072#1085#1072' '#1086#1073#1098#1077#1084#1072' '#1094#1077#1083#1100#1085#1086#1081' '#1082#1088#1086#1074#1080'):')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo51: TfrxMemoView
        Left = 529.134200000000000000
        Top = 604.724800000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlasmaPercentageOfPlanProcedures]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo52: TfrxMemoView
        Left = 529.134200000000000000
        Top = 642.520100000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlasmaTheNumberOfTreatmentsPerDay]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo54: TfrxMemoView
        Left = 415.748300000000000000
        Top = 604.724800000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[BloodPercentageOfPlanProcedures]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo55: TfrxMemoView
        Left = 415.748300000000000000
        Top = 642.520100000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[BloodTheNumberOfTreatmentsPerDay]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo56: TfrxMemoView
        Left = 415.748300000000000000
        Top = 680.315400000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.3f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[BloodTheNumberOfTreatmentsPerDayWholeBlood]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo57: TfrxMemoView
        Left = 415.748300000000000000
        Top = 718.110700000000000000
        Width = 113.385826770000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          '[BloodNumberWholeBloodAtTheMomentToMatchThePlan]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo59: TfrxMemoView
        Left = 529.134200000000000000
        Top = 566.929500000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftLeft, ftRight, ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[PlasmaRestImplementationOfThePlan]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo60: TfrxMemoView
        Left = 623.622450000000000000
        Top = 491.338900000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        Frame.Width = 1.500000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          #1058#1088#1086#1084#1073#1086)
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo61: TfrxMemoView
        Left = 623.622450000000000000
        Top = 529.134200000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%2.2f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboNumberProceduresDone]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo62: TfrxMemoView
        Left = 623.622450000000000000
        Top = 604.724800000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboPercentageOfPlanProcedures]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo63: TfrxMemoView
        Left = 623.622450000000000000
        Top = 642.520100000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboTheNumberOfTreatmentsPerDay]')
        ParentFont = False
        VAlign = vaCenter
      end
      object Memo66: TfrxMemoView
        Left = 623.622450000000000000
        Top = 566.929500000000000000
        Width = 94.488188980000000000
        Height = 37.795275590000000000
        ShowHint = False
        DataSetName = 'frxDBDataset1'
        DisplayFormat.FormatStr = '%0.0f'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Frame.Typ = [ftBottom]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TromboRestImplementationOfThePlan]')
        ParentFont = False
        VAlign = vaCenter
      end
    end
  end
end
