object FormDBConnect: TFormDBConnect
  Left = 735
  Top = 374
  BorderStyle = bsSingle
  Caption = 'DBConnect'
  ClientHeight = 302
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 32
    Height = 15
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 223
    Top = 14
    Width = 22
    Height = 15
    Caption = 'Port'
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 23
    Height = 15
    Caption = 'User'
  end
  object Label4: TLabel
    Left = 223
    Top = 62
    Width = 50
    Height = 15
    Caption = 'Password'
  end
  object Label5: TLabel
    Left = 8
    Top = 245
    Width = 37
    Height = 15
    Caption = 'Servers'
  end
  object Label6: TLabel
    Left = 8
    Top = 112
    Width = 48
    Height = 15
    Caption = 'Database'
    Enabled = False
  end
  object Label7: TLabel
    Left = 8
    Top = 174
    Width = 67
    Height = 15
    Caption = 'Server Name'
  end
  object EdServer: TEdit
    Left = 8
    Top = 35
    Width = 185
    Height = 23
    ImeName = 'Turkish Q'
    TabOrder = 0
    Text = 'localhost'
  end
  object EdPort: TEdit
    Left = 223
    Top = 35
    Width = 121
    Height = 23
    ImeName = 'Turkish Q'
    TabOrder = 1
    Text = '1433'
  end
  object EdUser: TEdit
    Left = 8
    Top = 85
    Width = 185
    Height = 23
    TabOrder = 2
    Text = 'Sa'
  end
  object EdPassword: TEdit
    Left = 223
    Top = 83
    Width = 121
    Height = 23
    Hint = 'Password'
    PasswordChar = #8226
    TabOrder = 3
  end
  object CBoxServers: TComboBox
    Left = 8
    Top = 266
    Width = 213
    Height = 23
    Style = csDropDownList
    TabOrder = 4
    OnChange = CBoxServersChange
  end
  object BtnConnect: TButton
    Left = 269
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 5
    OnClick = BtnConnectClick
  end
  object CbDatabase: TComboBox
    Left = 8
    Top = 133
    Width = 185
    Height = 23
    Enabled = False
    TabOrder = 6
    Text = 'master'
  end
  object CBSave: TCheckBox
    Left = 135
    Top = 195
    Width = 97
    Height = 17
    Caption = 'Save server'
    TabOrder = 7
  end
  object EdSaveName: TEdit
    Left = 8
    Top = 195
    Width = 121
    Height = 23
    TabOrder = 8
    TextHint = 'ServerName'
  end
  object BtnDeleteServer: TButton
    Left = 227
    Top = 266
    Width = 22
    Height = 23
    Caption = #55357#56785
    TabOrder = 9
    OnClick = BtnDeleteServerClick
  end
end
