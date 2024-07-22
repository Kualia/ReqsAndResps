object MainForm: TMainForm
  Left = 490
  Top = 166
  Caption = 'MainForm'
  ClientHeight = 662
  ClientWidth = 1100
  Color = clBtnFace
  Constraints.MinHeight = 700
  Constraints.MinWidth = 1100
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
    Height = 662
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitHeight = 667
    DesignSize = (
      544
      662)
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 39
      Height = 19
      Caption = 'Query'
    end
    object LblDBStatus: TLabel
      Left = 8
      Top = 635
      Width = 104
      Height = 19
      Anchors = [akLeft, akBottom]
      Caption = 'Database: None'
      ExplicitTop = 640
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
      Top = 604
      Width = 81
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Connection'
      TabOrder = 3
      OnClick = Button1Click
      ExplicitTop = 609
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
    Width = 556
    Height = 662
    Align = alClient
    AutoSize = True
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitLeft = 550
    ExplicitWidth = 587
    ExplicitHeight = 682
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 554
      Height = 660
      Align = alClient
      TabOrder = 0
      OnMouseDown = PageControlMouseDown
    end
  end
end
