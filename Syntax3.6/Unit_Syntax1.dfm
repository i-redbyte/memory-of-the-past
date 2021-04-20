object Form1: TForm1
  Left = 192
  Top = 109
  Width = 406
  Height = 285
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 201
    Height = 241
    Lines.Strings = (
      'program Test;'
      'uses WinCrt, Strings;'
      'begin'
      '  begin'
      '    begin'
      '      ; ; ;'
      '      '
      '    end;'
      '  end;'
      'end.')
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 216
    Top = 8
    Width = 177
    Height = 185
    TabOrder = 1
  end
  object Button2: TButton
    Left = 248
    Top = 208
    Width = 121
    Height = 33
    Caption = 'Check'
    TabOrder = 2
    OnClick = Button2Click
  end
end
