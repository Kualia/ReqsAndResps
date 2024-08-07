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
  Menu = MainMenu1
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
    ExplicitLeft = -5
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
      Action = Execute
      Anchors = [akTop, akRight]
      TabOrder = 0
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
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object Button1: TButton
      Left = 8
      Top = 604
      Width = 81
      Height = 25
      Action = Connection
      Anchors = [akLeft, akBottom]
      TabOrder = 3
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
      Top = 608
      Width = 75
      Height = 25
      Action = Save
      TabOrder = 5
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
    object BtnDeleteSql: TButton
      Left = 247
      Top = 493
      Width = 26
      Height = 28
      Action = Delete
      Cancel = True
      Caption = #55357#56785
      TabOrder = 7
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
  object SaveDialogCsv: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'Csv|.Csv'
    FilterIndex = 0
    Left = 216
    Top = 608
  end
  object MainMenu1: TMainMenu
    Left = 128
    object OpenFolder1: TMenuItem
      Caption = 'File'
      object MenuItemChangeDirectory: TMenuItem
        Action = ChangeWorkingDirectory
        Caption = 'Change Directory'
      end
      object MenuItemSave: TMenuItem
        Action = Save
      end
    end
  end
  object ActionManager1: TActionManager
    Left = 168
    StyleName = 'Platform Default'
    object ChangeWorkingDirectory: TAction
      Caption = 'ChangeWorkingDirectory'
      ShortCut = 16463
      OnExecute = ChangeWorkingDirectoryExecute
    end
    object Save: TAction
      Caption = 'Save'
      ShortCut = 16467
      OnExecute = SaveExecute
    end
    object Delete: TAction
      Caption = 'Delete'
      OnExecute = DeleteExecute
    end
    object Execute: TAction
      Caption = 'Execute'
      ShortCut = 116
      OnExecute = ExecuteExecute
    end
    object Connection: TAction
      Caption = 'Connection'
      OnExecute = ConnectionExecute
    end
    object LoadFile: TAction
      Caption = 'LoadFile'
      OnExecute = LoadFileExecute
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 144
    Top = 608
  end
end
