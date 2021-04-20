VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Об автаре и тесте:)"
   ClientHeight    =   5655
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9015
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5655
   ScaleWidth      =   9015
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Все понял, буду мстить!"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   4200
      TabIndex        =   3
      Top             =   5040
      Width           =   2415
   End
   Begin VB.PictureBox Picture1 
      AutoSize        =   -1  'True
      Height          =   3285
      Left            =   6720
      Picture         =   "Form1.frx":0000
      ScaleHeight     =   3225
      ScaleWidth      =   2235
      TabIndex        =   2
      Top             =   0
      Width           =   2295
   End
   Begin VB.Label Label2 
      Caption         =   "Тест разработал студент группы ПВТ приверженец ультралевых взглядов, программист, футурист и просто хороший человек:) Илья"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00008000&
      Height          =   2535
      Left            =   6720
      TabIndex        =   1
      Top             =   3240
      Width           =   2295
   End
   Begin VB.Label Label1 
      Caption         =   $"Form1.frx":1E22
      BeginProperty Font 
         Name            =   "Comic Sans MS"
         Size            =   14.25
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5535
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   6495
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Form1.Visible = False
Form2.Visible = True

End Sub
