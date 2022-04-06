object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Horse - IPGeoLocation'
  ClientHeight = 176
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblPort: TLabel
    Left = 8
    Top = 19
    Width = 24
    Height = 13
    Caption = 'Port:'
  end
  object btnStop: TBitBtn
    Left = 104
    Top = 50
    Width = 90
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 0
    OnClick = btnStopClick
  end
  object btnStart: TBitBtn
    Left = 8
    Top = 50
    Width = 90
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object edtPort: TEdit
    Left = 38
    Top = 16
    Width = 156
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Text = '9000'
  end
  object lblLinkJson: TLinkLabel
    Left = 8
    Top = 93
    Width = 16
    Height = 17
    Caption = '...'
    TabOrder = 3
    OnLinkClick = LinkClick
  end
  object lblLinkGoogleMaps: TLinkLabel
    Left = 8
    Top = 120
    Width = 16
    Height = 17
    Caption = '...'
    TabOrder = 4
    OnLinkClick = LinkClick
  end
  object lblLinkWazeMaps: TLinkLabel
    Left = 8
    Top = 148
    Width = 16
    Height = 17
    Caption = '...'
    TabOrder = 5
    OnLinkClick = LinkClick
  end
end
