object Form3: TForm3
  Left = 192
  Top = 125
  Width = 1305
  Height = 675
  Caption = 'Form3'
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 224
    Top = 120
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 160
    Top = 40
  end
end
