object Form2: TForm2
  Left = 192
  Top = 125
  Width = 1305
  Height = 675
  Caption = 'p'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 88
    Top = 128
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 88
    Top = 168
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 216
    Top = 32
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 360
    Top = 280
    Width = 32
    Height = 13
    Caption = 'Label4'
  end
  object Button1: TButton
    Left = 1144
    Top = 616
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
    OnKeyDown = Button1KeyDown
  end
  object Button2: TButton
    Left = 1232
    Top = 600
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
    OnKeyDown = Button2KeyDown
  end
  object ComboBox1: TComboBox
    Left = 232
    Top = 72
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'ComboBox1'
    OnChange = ComboBox1Change
    OnClick = ComboBox1Click
    OnKeyDown = ComboBox1KeyDown
  end
  object ComboBox2: TComboBox
    Left = 232
    Top = 120
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    Text = 'ComboBox2'
    OnChange = ComboBox2Change
    OnClick = ComboBox2Click
    OnKeyDown = ComboBox2KeyDown
  end
  object Button3: TButton
    Left = 168
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    OnClick = Button3Click
    OnKeyDown = Button3KeyDown
  end
  object Button5: TButton
    Left = 456
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 5
    OnClick = Button5Click
    OnKeyDown = Button5KeyDown
  end
  object Edit1: TEdit
    Left = 400
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'Edit1'
    OnExit = Edit1Exit
    OnKeyDown = Edit1KeyDown
    OnKeyPress = Edit1KeyPress
  end
  object Memo1: TMemo
    Left = 216
    Top = 400
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 7
    OnKeyDown = Memo1KeyDown
  end
  object Button6: TButton
    Left = 536
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Button6'
    TabOrder = 8
    OnClick = Button6Click
    OnKeyDown = Button6KeyDown
  end
  object Button7: TButton
    Left = 664
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button7'
    TabOrder = 9
    OnClick = Button7Click
    OnKeyDown = Button7KeyDown
  end
  object Memo5: TMemo
    Left = 912
    Top = 312
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo5')
    TabOrder = 10
    OnKeyDown = Memo5KeyDown
  end
  object RichEdit1: TCustomRichMemo
    Left = 896
    Top = 152
    Width = 185
    Height = 89
    BorderStyle = bsNone
    Lines.Strings = (
      'RichEdit1')
    TabOrder = 11
    OnKeyDown = RichEdit1KeyDown
  end
  object Button8: TButton
    Left = 648
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button8'
    TabOrder = 12
    OnClick = Button8Click
    OnKeyDown = Button8KeyDown
  end
  object Button9: TButton
    Left = 656
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Button9'
    TabOrder = 13
    OnClick = Button9Click
    OnKeyDown = Button9KeyDown
  end
  object Button10: TButton
    Left = 616
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Button10'
    TabOrder = 14
    OnClick = Button10Click
    OnKeyDown = Button10KeyDown
  end
  object Button11: TButton
    Left = 624
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Button11'
    TabOrder = 15
    OnClick = Button11Click
    OnKeyDown = Button11KeyDown
  end
  object CheckBox1: TCheckBox
    Left = 888
    Top = 40
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 16
  end
  object CheckBox2: TCheckBox
    Left = 888
    Top = 88
    Width = 97
    Height = 17
    Caption = 'CheckBox2'
    TabOrder = 17
  end
  object Memo2: TMemo
    Left = 296
    Top = 176
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo2')
    TabOrder = 18
  end
  object OpenDialog1: TOpenDialog
    Left = 176
    Top = 88
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 720
    Top = 56
  end
  object OpenDialog2: TOpenDialog
    Left = 672
    Top = 376
  end
end
