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
    object LblDBStatus: TLabel
      Left = 8
      Top = 744
      Width = 104
      Height = 19
      Caption = 'Database: None'
    end
    object btnExecute: TButton
      Left = 434
      Top = 577
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Execute'
      TabOrder = 0
      OnClick = btnExecuteClick
    end
    object CBoxDatabases: TComboBox
      Left = 283
      Top = 576
      Width = 145
      Height = 27
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 1
      TextHint = 'Database'
    end
    object MemoQueryText: TMemo
      AlignWithMargins = True
      Left = 8
      Top = 38
      Width = 521
      Height = 524
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object Button1: TButton
      Left = 8
      Top = 632
      Width = 81
      Height = 25
      Caption = 'Connection'
      TabOrder = 3
      OnClick = Button1Click
    end
    object EdQueryName: TEdit
      Left = 307
      Top = 608
      Width = 121
      Height = 27
      TabOrder = 4
      TextHint = 'Name'
    end
    object BtnSaveSQL: TButton
      Left = 434
      Top = 609
      Width = 75
      Height = 25
      Caption = 'Save SQL'
      TabOrder = 5
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
    ExplicitWidth = 643
    ExplicitHeight = 767
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 645
      Height = 766
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      OnMouseDown = PageControlMouseDown
      ExplicitLeft = 6
      ExplicitTop = 0
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
          FixedColor = clTeal
          GradientStartColor = clBackground
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = TURKISH_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Calibri'
          TitleFont.Style = []
        end
      end
    end
  end
end
