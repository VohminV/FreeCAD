object fMain: TfMain
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'fMain'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 385
    Top = 0
    Height = 390
    ExplicitLeft = 456
    ExplicitTop = 208
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 407
    Width = 628
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object MemoGCode: TMemo
    Left = 0
    Top = 0
    Width = 385
    Height = 390
    Align = alLeft
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitHeight = 401
  end
  object Panel2: TPanel
    Left = 388
    Top = 0
    Width = 240
    Height = 390
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 512
    ExplicitTop = 176
    ExplicitWidth = 185
    ExplicitHeight = 41
    object LoadGCode: TButton
      Left = 24
      Top = 32
      Width = 185
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1092#1072#1081#1083' *.gcode | *.nc'
      TabOrder = 0
      OnClick = LoadGCodeClick
    end
    object SaveGCode: TButton
      Left = 24
      Top = 80
      Width = 185
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083' *.gcode | *.nc'
      TabOrder = 1
      OnClick = SaveGCodeClick
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 390
    Width = 628
    Height = 17
    Align = alBottom
    TabOrder = 3
    ExplicitLeft = 424
    ExplicitTop = 8
    ExplicitWidth = 150
  end
  object OpenDialogGCode: TOpenDialog
    Left = 340
    Top = 184
  end
end
