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
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 661
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
    object LblFolderPath: TLabel
      Left = 8
      Top = 468
      Width = 19
      Height = 19
      Caption = 'C:\'
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
      Height = 419
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
      ExplicitTop = 603
    end
    object EdQueryName: TEdit
      Left = 264
      Top = 608
      Width = 164
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
      OnClick = BtnSaveSQLClick
    end
    object ListBoxQueryFiles: TListBox
      Left = 8
      Top = 493
      Width = 233
      Height = 97
      ItemHeight = 19
      TabOrder = 6
      OnClick = ListBoxQueryFilesClick
    end
  end
  object Panel2: TPanel
    Left = 544
    Top = 0
    Width = 556
    Height = 662
    Align = alClient
    AutoSize = True
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 552
    ExplicitHeight = 661
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 554
      Height = 660
      Align = alClient
      TabOrder = 0
      OnMouseDown = PageControlMouseDown
      ExplicitWidth = 550
      ExplicitHeight = 659
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 144
    Top = 608
  end
  object SaveDialogCsv: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'Csv|.Csv'
    FilterIndex = 0
    Left = 216
    Top = 608
  end
end
