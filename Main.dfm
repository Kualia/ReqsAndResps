object MainForm: TMainForm
  Left = 490
  Top = 166
  Caption = 'MainForm'
  ClientHeight = 768
  ClientWidth = 1191
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Calibri'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 544
    Height = 768
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitLeft = -1
    ExplicitHeight = 769
    DesignSize = (
      544
      768)
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 39
      Height = 19
      Caption = 'Query'
    end
    object btnExecute: TButton
      Left = 440
      Top = 568
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Execute'
      TabOrder = 0
      OnClick = btnExecuteClick
      ExplicitLeft = 326
    end
    object ComboBox1: TComboBox
      Left = 289
      Top = 566
      Width = 145
      Height = 27
      Anchors = [akTop, akRight]
      TabOrder = 1
      Text = 'ComboBox1'
      ExplicitLeft = 175
    end
    object MemoQueryText: TMemo
      AlignWithMargins = True
      Left = 8
      Top = 38
      Width = 501
      Height = 524
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      ExplicitWidth = 387
    end
  end
  object Panel2: TPanel
    Left = 544
    Top = 0
    Width = 647
    Height = 768
    Align = alClient
    AutoSize = True
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitLeft = 550
    ExplicitWidth = 640
    ExplicitHeight = 769
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 645
      Height = 766
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 6
      ExplicitTop = 13
      ExplicitWidth = 638
      ExplicitHeight = 641
      object TabSheet1: TTabSheet
        Caption = 'TabSheet1'
        object DBGrid: TDBGrid
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 637
          Height = 530
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clWhite
          DataSource = MSDataSource
          FixedColor = clTeal
          GradientStartColor = clBackground
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = TURKISH_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Calibri'
          TitleFont.Style = []
          OnDblClick = DBGridDblClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'TabSheet2'
        ImageIndex = 1
      end
    end
  end
  object MSConnection: TMSConnection
    Left = 8
    Top = 736
  end
  object MSQuery: TMSQuery
    Connection = MSConnection
    Left = 40
    Top = 736
  end
  object MSDataSource: TMSDataSource
    DataSet = MSQuery
    Left = 72
    Top = 736
  end
end
