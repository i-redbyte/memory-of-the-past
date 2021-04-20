VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form Form2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Кто ты?"
   ClientHeight    =   7905
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   10620
   FillColor       =   &H00800080&
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7905
   ScaleWidth      =   10620
   StartUpPosition =   3  'Windows Default
   Visible         =   0   'False
   Begin RichTextLib.RichTextBox RichTextBox1 
      Height          =   4095
      Left            =   6120
      TabIndex        =   8
      Top             =   0
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   7223
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"Form2.frx":0000
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.PictureBox Picture1 
      AutoSize        =   -1  'True
      Height          =   4170
      Left            =   0
      Picture         =   "Form2.frx":0086
      ScaleHeight     =   4110
      ScaleWidth      =   3000
      TabIndex        =   7
      Top             =   0
      Width           =   3060
   End
   Begin VB.CommandButton Command2 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   0
      TabIndex        =   4
      Top             =   6840
      Width           =   5775
   End
   Begin VB.CommandButton Command1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   0
      TabIndex        =   3
      Top             =   5880
      Width           =   5775
   End
   Begin VB.CommandButton Command4 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   5880
      TabIndex        =   2
      Top             =   6840
      Width           =   4815
   End
   Begin VB.CommandButton Command3 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   5880
      TabIndex        =   1
      Top             =   5880
      Width           =   4695
   End
   Begin VB.Label Label4 
      Caption         =   "Связь с аффтором можно держать через  E-mail: Lenin2917@ya.ru или через ICQ 284087344"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   2415
      Left            =   3120
      TabIndex        =   9
      Top             =   0
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.Label Label3 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C000C0&
      Height          =   255
      Left            =   3120
      TabIndex        =   6
      Top             =   0
      Width           =   2055
   End
   Begin VB.Label Label2 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3615
      Left            =   120
      TabIndex        =   5
      Top             =   4200
      Visible         =   0   'False
      Width           =   10335
   End
   Begin VB.Label Label1 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   240
      TabIndex        =   0
      Top             =   4680
      Width           =   9975
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim a(3) As String
Dim otv As Integer
Dim levo As Integer
Dim pravo As Integer
Dim countV As String



Private Sub FSB(x As Integer)

Dim s As String

Open "vop.txt" For Input As #1
Line Input #1, s
For i = 1 To x
For j = 1 To 9
Line Input #1, s
Next j
Next i

Line Input #1, s
Form2.Label1.Caption = s
Line Input #1, s
Command1.Caption = s
Line Input #1, s
Command2.Caption = s
Line Input #1, s
Command3.Caption = s
Line Input #1, s
Command4.Caption = s
Line Input #1, a(0)
Line Input #1, a(1)
Line Input #1, a(2)
Line Input #1, a(3)
Close #1
s = (otv + 1)
Label3.Caption = "Вопрос: " + s + "/" + countV
RichTextBox1.LoadFile (s + ".txt")
End Sub
'*********************************************
'*********************************************
'*********************************************

Function TheEnd() As Boolean
TheEnd = True

If otv = countV Then
   Command1.Visible = False
   Command2.Visible = False
   Command3.Visible = False
   Command4.Visible = False
   Label1.Visible = False
   Label3.Visible = False
   Label2.Visible = True
   Label4.Visible = True
   TheEnd = False
levo = levo * (-1)
   If levo > pravo Then
     If (levo >= 18) Then
        Label2.Caption = "Ваш результат: Вы коммунист! Вас не устраивает текущий порядок вещей.В разговорах Вы часто поминаете недобрым словом эту проклятую буржуйскую власть, которая уничтожает наш народ по миллиону в год. Вы ненавидите гос-во,классы и частную собственность! Так держать товарищ!Мы построим еще свой город солнца с домами из бетона и стекла,покарим весь космос и "
     End If
     
     If (levo >= 14) And (levo < 18) Then
        Label2.Caption = "Ваш результат: Вы склоняетесь к коммунизму, многое в этом обществе вам не нравится но с 'классической' коммунистической доктриной вы не согласны либо еще не созрели до нее"
     End If
     
     If (levo >= 10) And (levo < 14) Then
        Label2.Caption = "Вы социал-демократ,скорей всего выступаете за Евро-коммунизму и социализм эволюционным путем "
     End If
     
     If (levo < 10) Then
        Label2.Caption = "Ваш результат:Вы еще толком не определились с политическими взглядами,но склоняетесь влево "
     End If
     End If
   
    If levo < pravo Then
     If (pravo >= 18) Then
        Label2.Caption = "Ваш результат: Вы ультраправый националист,являетесь 'патриотом'своего гос-ва, оправдываете любые действия во имя демократии "
     End If
     If (pravo >= 14) And (pravo < 18) Then
        Label2.Caption = "Ваш результат: по своим взглядам вы скорей всего либерал, выступаете за рыночную экономику,конкуренцию и частную собственность"
     End If
     If (pravo >= 10) And (pravo < 14) Then
        Label2.Caption = "Ваш результат: вы умеренный либерал, выступаете за Европейскую модель развития"
     End If
     If (pravo < 10) Then
        Label2.Caption = "Ваш результат:Вы еще толком не определились с политическими взглядами,но склоняетесь вправо "
     End If
   End If
   
If levo = pravo Then
Label2.Caption = "Ваш результат: золотая середины!Вы центрист у вас нет уклонов ни в право ни в лево"
End If
End If

End Function
'*********************************************
'*********************************************
'*********************************************
'*********************************************


Private Sub Command1_Click()
If a(0) > 0 Then
pravo = pravo + a(0)
Else
  levo = levo + a(0)
End If
otv = otv + 1
If TheEnd Then
FSB (otv)
End If

End Sub

Private Sub Command2_Click()
If a(1) > 0 Then
pravo = pravo + a(1)
Else
  levo = levo + a(1)
End If
otv = otv + 1
If TheEnd Then
FSB (otv)
End If

End Sub

Private Sub Command3_Click()
If a(2) > 0 Then
pravo = pravo + a(2)
Else
  levo = levo + a(2)
End If
otv = otv + 1
If TheEnd Then
FSB (otv)
End If
End Sub

Private Sub Command4_Click()
If a(3) > 0 Then
pravo = pravo + a(3)
Else
  levo = levo + a(3)
End If
otv = otv + 1
If TheEnd Then
FSB (otv)
End If
End Sub

Private Sub Form_Activate()
FSB (0)
pravo = 0
levo = 0
Open "vop.txt" For Input As #1
Line Input #1, countV

Close #1
otv = 0
Dim s As String
s = (otv + 1)
Label3.Caption = "Вопрос: " + s + "/" + countV
RichTextBox1.LoadFile (s + ".txt")

End Sub

Private Sub Form_Unload(Cancel As Integer)
End

End Sub

