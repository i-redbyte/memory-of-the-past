//=============================================================================
//................................. � ��������� ...............................
//.............................................................................
//....... ��������� ������������� ��� ������������ ������ � COM-������ ........
//....... � ������� ������� � �������������� ����������� �������� .............
//.............................................................................
//.. ������������ ������ WINAPI � ��������� ResumeThread() � SuspendThread() ..
//.............................................................................
//=============================================================================

//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include <io.h>         //��� ������ � �������
#include <fcntl.h>      //��� ������ � �������
#include <sys\stat.h>   //��� ������ � �������

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;


//=============================================================================
//..................... ���������� ���������� ���������� ......................
//=============================================================================

#define BUFSIZE 255     //������� ������

unsigned char bufrd[BUFSIZE], bufwr[BUFSIZE],pak[BUFSIZE],tim_pak[BUFSIZE]; //������� � ���������� ������
unsigned char CRC8[]={0x00, 0x31, 0x62, 0x53, 0x44, 0x75, 0x26, 0x17,
0x39, 0x08, 0x5b, 0x6a, 0x7d, 0x4c, 0x1f, 0x2e,
0x43, 0x72, 0x21, 0x10, 0x07, 0x36, 0x65, 0x54,
0x7a, 0x4b, 0x18, 0x29, 0x3e, 0x0f, 0x5c, 0x6d,
0x06, 0x37, 0x64, 0x55, 0x42, 0x73, 0x20, 0x11,
0x3f, 0x0e, 0x5d, 0x6c, 0x7b, 0x4a, 0x19, 0x28,
0x45, 0x74, 0x27, 0x16, 0x01, 0x30, 0x63, 0x52,
0x7c, 0x4d, 0x1e, 0x2f, 0x38, 0x09, 0x5a, 0x6b,
0x3d, 0x0c, 0x5f, 0x6e, 0x79, 0x48, 0x1b, 0x2a,
0x04, 0x35, 0x66, 0x57, 0x40, 0x71, 0x22, 0x13,
0x7e, 0x4f, 0x1c, 0x2d, 0x3a, 0x0b, 0x58, 0x69,
0x47, 0x76, 0x25, 0x14, 0x03, 0x32, 0x61, 0x50,
0x3b, 0x0a, 0x59, 0x68, 0x7f, 0x4e, 0x1d, 0x2c,
0x02, 0x33, 0x60, 0x51, 0x46, 0x77, 0x24, 0x15,
0x78, 0x49, 0x1a, 0x2b, 0x3c, 0x0d, 0x5e, 0x6f,
0x41, 0x70, 0x23, 0x12, 0x05, 0x34, 0x67, 0x56,
0x7a, 0x4b, 0x18, 0x29, 0x3e, 0x0f, 0x5c, 0x6d,
0x43, 0x72, 0x21, 0x10, 0x07, 0x36, 0x65, 0x54,
0x39, 0x08, 0x5b, 0x6a, 0x7d, 0x4c, 0x1f, 0x2e,
0x00, 0x31, 0x62, 0x53, 0x44, 0x75, 0x26, 0x17,
0x7c, 0x4d, 0x1e, 0x2f, 0x38, 0x09, 0x5a, 0x6b,
0x45, 0x74, 0x27, 0x16, 0x01, 0x30, 0x63, 0x52,
0x3f, 0x0e, 0x5d, 0x6c, 0x7b, 0x4a, 0x19, 0x28,
0x06, 0x37, 0x64, 0x55, 0x42, 0x73, 0x20, 0x11,
0x47, 0x76, 0x25, 0x14, 0x03, 0x32, 0x61, 0x50,
0x7e, 0x4f, 0x1c, 0x2d, 0x3a, 0x0b, 0x58, 0x69,
0x04, 0x35, 0x66, 0x57, 0x40, 0x71, 0x22, 0x13,
0x3d, 0x0c, 0x5f, 0x6e, 0x79, 0x48, 0x1b, 0x2a,
0x41, 0x70, 0x23, 0x12, 0x05, 0x34, 0x67, 0x56,
0x78, 0x49, 0x1a, 0x2b, 0x3c, 0x0d, 0x5e, 0x6f,
0x02, 0x33, 0x60, 0x51, 0x46, 0x77, 0x24, 0x15,
0x3b, 0x0a, 0x59, 0x68, 0x7f, 0x4e, 0x1d, 0x2c};

//---------------------------------------------------------------------------
unsigned char op_pol[]={0x00,0x01,0xE0,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x78};
//$01$E0$00$00$00$00$00$00$00$00$78;
bool op=true;
HANDLE COMport;		//���������� �����
//��������� OVERLAPPED ���������� ��� ����������� ��������, ��� ���� ��� �������� ������ � ������ ����� �������� ������ ���������
//��� ��������� ���������� �������� ���������, ����� ��������� �� ����� �������� ���������
OVERLAPPED overlapped;		//����� ������������ ��� �������� ������ (��. ����� ReadThread)
OVERLAPPED overlappedwr;       	//����� ������������ ��� �������� ������ (��. ����� WriteThread)

//---------------------------------------------------------------------------

int handle;             	//���������� ��� ������ � ������ � ������� ���������� <io.h>

//---------------------------------------------------------------------------

bool fl=0;	//����, ����������� �� ���������� �������� ������ (1 - �������, 0 - �� �������)

unsigned long counter;	//������� �������� ������, ���������� ��� ������ �������� �����


//=============================================================================
//.............................. ���������� ������� ...........................
//=============================================================================

void COMOpen(void);             //������� ����
void COMClose(void);            //������� ����


//=============================================================================
//.............................. ���������� ������� ...........................
//=============================================================================

HANDLE reader;	//���������� ������ ������ �� �����
HANDLE writer;	//���������� ������ ������ � ����

DWORD WINAPI ReadThread(LPVOID);
DWORD WINAPI WriteThread(LPVOID);


//=============================================================================
//.............................. ���������� ������� ...........................
//=============================================================================

//-----------------------------------------------------------------------------
//............................... ����� ReadThead .............................
//-----------------------------------------------------------------------------

void ReadPrinting(void);

//---------------------------------------------------------------------------

//������� ������� ������, ��������� ���� ������ �� COM-�����
DWORD WINAPI ReadThread(LPVOID)
{
 COMSTAT comstat;		//��������� �������� ��������� �����, � ������ ��������� ������������ ��� ����������� ���������� �������� � ���� ������
 DWORD btr, temp, mask, signal;	//���������� temp ������������ � �������� ��������

 overlapped.hEvent = CreateEvent(NULL, true, true, NULL);	//������� ���������� ������-������� ��� ����������� ��������
 SetCommMask(COMport, EV_RXCHAR);                   	        //���������� ����� �� ������������ �� ������� ����� ����� � ����
 while(1)						//���� ����� �� ����� �������, ��������� ����
  {
   WaitCommEvent(COMport, &mask, &overlapped);               	//������� ������� ����� ����� (��� � ���� ������������� ��������)
   signal = WaitForSingleObject(overlapped.hEvent, INFINITE);	//������������� ����� �� ������� �����
   if(signal == WAIT_OBJECT_0)				        //���� ������� ������� ����� ���������
    {
     if(GetOverlappedResult(COMport, &overlapped, &temp, true)) //���������, ������� �� ����������� ������������� �������� WaitCommEvent
      if((mask & EV_RXCHAR)!=0)					//���� ��������� ������ ������� ������� �����
       {
        ClearCommError(COMport, &temp, &comstat);		//����� ��������� ��������� COMSTAT
        btr = comstat.cbInQue;                          	//� �������� �� �� ���������� �������� ������
        if(btr==11)                         			//���� ������������� ���� ����� ��� ������
        {
         ReadFile(COMport, bufrd, btr, &temp, &overlapped);     //��������� ����� �� ����� � ����� ���������
         counter+=btr;                                          //����������� ������� ������
         ReadPrinting();                      		//�������� ������� ��� ������ ������ �� ����� � � ����
        }
       }
    }
  }
}

//---------------------------------------------------------------------------

//������� �������� ����� �� ����� � � ���� (���� ��������)
void ReadPrinting()
{
String s;
if ( (bufrd[10]!=0)){
Form1->Edit1->Text = "";
s="";
for (int k=0; k<11; k++){
tim_pak[k+1] = bufrd[k];
s = s +  IntToHex(tim_pak[k+1],2)+" ";
//Form1->Memo1->Lines->Text = Form1->Memo1->Lines->Text + IntToHex(tim_pak[k+1],2)+" ";
//Form1->Edit1->Text = Form1->Edit1->Text + IntToHex(tim_pak[k+1],2);

}
Form1->Memo1->Lines->Add(s);
//Form1->Memo1->Lines->Add();
} else Form1->Memo1->Lines->Add("������ ����");
Form1->StatusBar1->Panels->Items[2]->Text = "����� ������� " + IntToStr(counter) + " ����";	//������� ������� � ������ ���������

 if(Form1->CheckBox3->Checked == true)  //���� ������� ����� ������ � ����
  {
   write(handle, bufrd, strlen(bufrd)); //�������� � ���� ������ �� �������� ������
  }
 memset(bufrd, 0, BUFSIZE);	        //�������� ����� (����� ������ �� ������������� ���� �� �����)
}

//---------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//............................... ����� WriteThead ............................
//-----------------------------------------------------------------------------

//---------------------------------------------------------------------------

//������� ������� ������, ��������� �������� ������ �� ������ � COM-����
DWORD WINAPI WriteThread(LPVOID)
{
 DWORD temp, signal;	//temp - ����������-��������
 int i=0;
 overlappedwr.hEvent = CreateEvent(NULL, true, true, NULL);   	  //������� �������
 while(1)
  {WriteFile(COMport, bufwr, 11, &temp, &overlappedwr);  //�������� ����� � ����
   signal = WaitForSingleObject(overlappedwr.hEvent, INFINITE);	  //������������� �����, ���� �� ���������� ������������� �������� WriteFile
   if((signal == WAIT_OBJECT_0) && (GetOverlappedResult(COMport, &overlappedwr, &temp, true)))	//���� �������� ����������� �������
     {
      Form1->StatusBar1->Panels->Items[0]->Text  = "�������� ������ �������";    //������� ��������� �� ���� � ������ ���������
     }
   else {Form1->StatusBar1->Panels->Items[0]->Text  = "������ ��������";} 	//����� ������� � ������ ��������� ��������� �� ������

   SuspendThread(writer);
   }
}

//---------------------------------------------------------------------------


//=============================================================================
//............................. �������� ����� ................................
//=============================================================================

//---------------------------------------------------------------------------

//����������� �����, ������ � �� ����������� ������������� ��������� �����
__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner)
{
 //������������� ��������� ����� ��� ������� ���������
 Form1->Label5->Enabled = false;
 Form1->Label6->Enabled = false;
 Form1->Button1->Enabled = false;
 Form1->CheckBox1->Enabled = false;
 Form1->CheckBox2->Enabled = false;
}

//---------------------------------------------------------------------------

//���������� ������� �� ������ "������� ����"
void __fastcall TForm1::SpeedButton1Click(TObject *Sender)
{
 if(SpeedButton1->Down)
  {
   COMOpen();                   //���� ������ ������ - ������� ����

   //��������/�������� �������� �� �����
   Form1->ComboBox1->Enabled = false;
   Form1->ComboBox2->Enabled = false;
   Form1->Button1->Enabled = true;
   Form1->CheckBox1->Enabled = true;
   Form1->CheckBox2->Enabled = true;

   Form1->SpeedButton1->Caption = "������� ����";	//������� ������� �� ������

   counter = 0;	//���������� ������� ������

   //���� ���� �������� ������ DTR � RTS, ���������� ��� ����� � �������
   Form1->CheckBox1Click(Sender);
   Form1->CheckBox2Click(Sender);
  }

 else
  {
   COMClose();                  //���� ������ ������ - ������� ����

   Form1->SpeedButton1->Caption = "������� ����";	//������� ������� �� ������
   Form1->StatusBar1->Panels->Items[0]->Text = "";	//�������� ������ ������� ������ ���������

   //��������/�������� �������� �� �����
   Form1->ComboBox1->Enabled = true;
   Form1->ComboBox2->Enabled = true;
   Form1->Button1->Enabled = false;
   Form1->CheckBox1->Enabled = false;
   Form1->CheckBox2->Enabled = false;
  }
}

//---------------------------------------------------------------------------

//���������� �������� �����
void __fastcall TForm1::FormClose(TObject *Sender, TCloseAction &Action)
{
 COMClose();
}
//---------------------------------------------------------------------------

//������� "��������� � ����"
void __fastcall TForm1::CheckBox3Click(TObject *Sender)
{
 if(Form1->CheckBox3->Checked)		//���� ������� ��������
  {
   //������������ ��������������� �������� �� �����
   Form1->Label5->Enabled = true;
   Form1->Label6->Enabled = true;

   //������� ��������� ������ � ���� � ������ ���������
   Form1->StatusBar1->Panels->Items[1]->Text = "����� � ����!";
  }

 else   				//���� ������� ���������
  {
   //��������� ��������������� �������� �� �����
   Form1->Label5->Enabled = false;
   Form1->Label6->Enabled = false;

   //������ ��������� ������ � ���� �� ������ ���������
   Form1->StatusBar1->Panels->Items[1]->Text = "";
  }

}
//---------------------------------------------------------------------------
//�������� ������
void send_pak(unsigned char pak1[BUFSIZE])
{
int k=1;
 memset(bufwr,0,BUFSIZE);		                	//�������� ����������� ���������� �����, ����� ������ �� ������������� ���� �� �����
 PurgeComm(COMport, PURGE_TXCLEAR);                      //�������� ���������� ����� �����
 for (int i=0; i <11; i++)
{
 bufwr[i] = pak1[k];
  k++;
 }
ResumeThread(writer);               //������������ ����� ������ ������ � ����
}

//������ "��������"
void __fastcall TForm1::Button1Click(TObject *Sender)
{
/*int k=1;
 memset(bufwr,0,BUFSIZE);		                	//�������� ����������� ���������� �����, ����� ������ �� ������������� ���� �� �����
 PurgeComm(COMport, PURGE_TXCLEAR);                      //�������� ���������� ����� �����
 for (int i=0; i <11; i++)
{
 bufwr[i] = pak[k];
  k++;
 }
ResumeThread(writer);               //������������ ����� ������ ������ � ����
*/
send_pak(pak);
}

//���������� � �������
int step(int num,int _i)
{
    int t = num;
    if (_i > 0) for (int i=0;i<_i-1;i++) num *= t;
    else num = 1;
    return num;
}
//������� �������� ������� � ����������
int BinToDec(const char * hex)
{
        long Number = 0;
        int To = strlen(hex);//����� ��������� �����
        for (int i=0;i<To;i++)
        {
         Number += StrToInt(hex[i]) * step (2, (To-i-1));
        }
        return Number;
}

int HexToDec(char *st)
{
    int i,s,k,p;
    s=0;
    p=strlen(st)-1;
    for (i=0; st[i]!='\0'; i++)
    {
        switch (toupper(st[i]))
        {
        case 'A': k=10; break;
        case 'B': k=11; break;
        case 'C': k=12; break;
        case 'D': k=13; break;
        case 'E': k=14; break;
        case 'F': k=15; break;
        case '1': k=1; break;
        case '2': k=2; break;
        case '3': k=3; break;
        case '4': k=4; break;
        case '5': k=5; break;
        case '6': k=6; break;
        case '7': k=7; break;
        case '8': k=8; break;
        case '9': k=9; break;
        case '0': k=0; break;
        }
        s=s+k*step(16,p);
        p--;
    }
 return s;
}
//---------------------------------------------------------------------------

//������ "�������� ����"
void __fastcall TForm1::Button3Click(TObject *Sender)
{
 Form1->Memo1->Clear();	//�������� Memo1
}

//---------------------------------------------------------------------------

//������� "DTR"
void __fastcall TForm1::CheckBox1Click(TObject *Sender)
{
 //���� ����������� - ���������� ����� DTR � �������, ����� - � ����
 if(Form1->CheckBox1->Checked) EscapeCommFunction(COMport, SETDTR);
 else EscapeCommFunction(COMport, CLRDTR);
}

//---------------------------------------------------------------------------

//������� "RTS"
void __fastcall TForm1::CheckBox2Click(TObject *Sender)
{
 //���� ����������� - ���������� ����� RTS � �������, ����� - � ����
 if(Form1->CheckBox2->Checked) EscapeCommFunction(COMport, SETRTS);
 else EscapeCommFunction(COMport, CLRRTS);
}

//---------------------------------------------------------------------------

//=============================================================================
//........................... ���������� ������� ..............................
//=============================================================================

//---------------------------------------------------------------------------

//������� �������� � ������������� �����
void COMOpen()
{
 String portname;     	 //��� ����� (��������, "COM1", "COM2" � �.�.)
 DCB dcb;                //��������� ��� ����� ������������� ����� DCB
 COMMTIMEOUTS timeouts;  //��������� ��� ��������� ���������

 portname = Form1->ComboBox1->Text;	//�������� ��� ���������� �����

 //������� ����, ��� ����������� �������� ����������� ����� ������� ���� FILE_FLAG_OVERLAPPED
 COMport = CreateFile(portname.c_str(),GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, NULL);
 //�����:
 // - portname.c_str() - ��� ����� � �������� ����� �����, c_str() ����������� ������ ���� String � ������ � ���� ������� ���� char, ����� ������� �� ������
 // - GENERIC_READ | GENERIC_WRITE - ������ � ����� �� ������/�������
 // - 0 - ���� �� ����� ���� ������������� (shared)
 // - NULL - ���������� ����� �� �����������, ������������ ���������� ������������ �� ���������
 // - OPEN_EXISTING - ���� ������ ����������� ��� ��� ������������ ����
 // - FILE_FLAG_OVERLAPPED - ���� ���� ��������� �� ������������� ����������� ��������
 // - NULL - ��������� �� ���� ������� �� ������������ ��� ������ � �������

 if(COMport == INVALID_HANDLE_VALUE)            //���� ������ �������� �����
  {
   Form1->SpeedButton1->Down = false;           //������ ������
   Form1->StatusBar1->Panels->Items[0]->Text = "�� ������� ������� ����";       //������� ��������� � ������ ���������
   return;
  }

 //������������� �����

 dcb.DCBlength = sizeof(DCB); 	//� ������ ���� ��������� DCB ���������� ������� � �����, ��� ����� �������������� ��������� ��������� ����� ��� �������� ������������ ���������

 //������� ��������� DCB �� �����
 if(!GetCommState(COMport, &dcb))	//���� �� ������� - ������� ���� � ������� ��������� �� ������ � ������ ���������
  {
   COMClose();
   Form1->StatusBar1->Panels->Items[0]->Text  = "�� ������� ������� DCB";
   return;
  }

 //������������� ��������� DCB
 dcb.BaudRate = StrToInt(Form1->ComboBox2->Text);       //����� �������� �������� 9600 ���
 dcb.fBinary = TRUE;                                    //�������� �������� ����� ������
 dcb.fOutxCtsFlow = FALSE;                              //��������� ����� �������� �� �������� CTS
 dcb.fOutxDsrFlow = FALSE;                              //��������� ����� �������� �� �������� DSR
 dcb.fDtrControl = DTR_CONTROL_DISABLE;                 //��������� ������������� ����� DTR
 dcb.fDsrSensitivity = FALSE;                           //��������� ��������������� �������� � ��������� ����� DSR
 dcb.fNull = FALSE;                                     //��������� ���� ������� ������
 dcb.fRtsControl = RTS_CONTROL_DISABLE;                 //��������� ������������� ����� RTS
 dcb.fAbortOnError = FALSE;                             //��������� ��������� ���� �������� ������/������ ��� ������
 dcb.ByteSize = 8;                                      //����� 8 ��� � �����
 dcb.Parity = 0;                                        //��������� �������� ��������
 dcb.StopBits = 0;                                      //����� ���� ����-���

 //��������� ��������� DCB � ����
 if(!SetCommState(COMport, &dcb))	//���� �� ������� - ������� ���� � ������� ��������� �� ������ � ������ ���������
  {
   COMClose();
   Form1->StatusBar1->Panels->Items[0]->Text  = "�� ������� ���������� DCB";
   return;
  }

 //���������� ��������
 timeouts.ReadIntervalTimeout = 0;	 	//������� ����� ����� ���������
 timeouts.ReadTotalTimeoutMultiplier = 0;	//����� ������� �������� ������
 timeouts.ReadTotalTimeoutConstant = 0;         //��������� ��� ������ �������� �������� ������
 timeouts.WriteTotalTimeoutMultiplier = 0;      //����� ������� �������� ������
 timeouts.WriteTotalTimeoutConstant = 0;        //��������� ��� ������ �������� �������� ������

 //�������� ��������� ��������� � ����
 if(!SetCommTimeouts(COMport, &timeouts))	//���� �� ������� - ������� ���� � ������� ��������� �� ������ � ������ ���������
  {
   COMClose();
   Form1->StatusBar1->Panels->Items[0]->Text  = "�� ������� ���������� ����-����";
   return;
  }

 //���������� ������� �������� ����� � ��������
 SetupComm(COMport,2000,2000);

 //������� ��� ������� ������������ ���� ��� ������ ����������� ������
 handle = open("test.txt", O_CREAT | O_APPEND | O_BINARY | O_WRONLY, S_IREAD | S_IWRITE);

 if(handle==-1)		//���� ��������� ������ �������� �����
  {
   Form1->StatusBar1->Panels->Items[1]->Text = "������ �������� �����";	//������� ��������� �� ���� � ��������� ������
   Form1->Label6->Hide();                                               //�������� ������� � ������ �����
   Form1->CheckBox3->Checked = false;                                   //�������� � ��������� �������
   Form1->CheckBox3->Enabled = false;
  }
 else { Form1->StatusBar1->Panels->Items[0]->Text = "���� ������ �������"; } //����� ������� � ������ ��������� ��������� �� �������� �������� �����

 PurgeComm(COMport, PURGE_RXCLEAR);	//�������� ����������� ����� �����

 reader = CreateThread(NULL, 0, ReadThread, NULL, 0, NULL);			//������ ����� ������, ������� ����� ����� ����������� (������������� �������� = 0)
 writer = CreateThread(NULL, 0, WriteThread, NULL, CREATE_SUSPENDED, NULL);	//������ ����� ������ � ������������� ��������� (������������� �������� = CREATE_SUSPENDED)

}

//---------------------------------------------------------------------------

//������� �������� �����
void COMClose()
{
//����������: ��� ��� ��� ���������� �������, ��������� � ������� ������� WinAPI, �������� TerminateThread
//	      ����� ����� ���� ������� �����, � ����� ����� ������ ����������, �� ����������� ����������
//	      ����������� �������-�������, ������������ � ��������� ���� OVERLAPPED, ��������� � �������,
//	      ������� �� ������ ���� ������, � ��������, ����� ������ ������� TerminateThread.
//	      ����� ���� ����� ���������� � ��� ���������� ������.

 if(writer)		//���� ����� ������ ��������, ��������� ���; �������� if(writer) �����������, ����� ��������� ������
  {TerminateThread(writer,0);
   CloseHandle(overlappedwr.hEvent);	//����� ������� ������-�������
   CloseHandle(writer);
  }
 if(reader)		   //���� ����� ������ ��������, ��������� ���; �������� if(reader) �����������, ����� ��������� ������
  {TerminateThread(reader,0);
   CloseHandle(overlapped.hEvent);	//����� ������� ������-�������
   CloseHandle(reader);
  }

 CloseHandle(COMport);                  //������� ����
 COMport=0;				//�������� ���������� ��� ����������� �����
 close(handle);				//������� ����, � ������� ������ ������ ����������� ������
 handle=0;				//�������� ���������� ��� ����������� �����

}
//������� ������������ ������
void form_pak()
 {
unsigned char ks[10];
int n=1;
String s;
/*        adrABCD = "";
        adrABCD = adrABCD + Form1->Edit2->Text + Form1->Edit3->Text + Form1->Edit4->Text + Form1->Edit5->Text + Form1->Edit6->Text;
        Form1->Edit1->Text = adrABCD;
        */
for (int i=1; i <= Form1->Edit1->Text.Length(); i++)
  {
  s = s + Form1->Edit1->Text[i];
  if (i % 3 == 0)
   {
    pak[n] = StrToInt(s);
    s = "";
    n++;
    }
   }
//****************************
//* ������ ����������� ����� *
//****************************
ks[0] = 0;
        for (int k=0; k<=9; k++)
          {
           ks[k+1] = CRC8[ks[k] ^ pak[k+1]];
          }
        pak[n] = ks[10];

}
//---------------------------------------------------------------------------
//������ ������������
void __fastcall TForm1::Button2Click(TObject *Sender)
{
String adrABCD;
adrABCD = "";
        adrABCD = adrABCD + Form1->Edit2->Text + Form1->Edit3->Text + Form1->Edit4->Text + Form1->Edit5->Text + Form1->Edit6->Text;
        Form1->Edit1->Text = adrABCD;
form_pak();
        Edit1->Text = "";
        for (int k=1; k<=11; k++){
                Edit1->Text =Edit1->Text+"$"+IntToHex(pak[k],2);
        }
              Edit7->Text = "";
              Edit7->Text = Edit7->Text +"$"+IntToHex(pak[11],2);
//**************************
//**************************
//**************************

}
//---------------------------------------------------------------------------



//����� �������
void __fastcall TForm1::ComboBox3Change(TObject *Sender)
{
Edit1->Text = ComboBox3->Text;
form_pak();
}
//---------------------------------------------------------------------------






void __fastcall TForm1::Button4Click(TObject *Sender)
{
Edit3->Text="";
Edit3->Text="$"+IntToHex(BinToDec(Edit8->Text.c_str()),2)+"$"+IntToHex(BinToDec(Edit9->Text.c_str()),2);
Edit4->Text="";
Edit4->Text="$"+IntToHex(BinToDec(Edit10->Text.c_str()),2)+"$"+IntToHex(BinToDec(Edit11->Text.c_str()),2);
Edit5->Text="";
Edit5->Text="$"+IntToHex(BinToDec(Edit12->Text.c_str()),2)+"$"+IntToHex(BinToDec(Edit13->Text.c_str()),2);
Edit6->Text="";
Edit6->Text="$"+IntToHex(BinToDec(Edit14->Text.c_str()),2)+"$"+IntToHex(BinToDec(Edit15->Text.c_str()),2);
}
//---------------------------------------------------------------------------







void __fastcall TForm1::Button5Click(TObject *Sender)
{
//if (strlen(Edit8->Text.c_str())<8) ShowMessage("������ ���� 8 ���");
Edit3->Text="";
Edit3->Text="$"+IntToHex(BinToDec(Edit8->Text.c_str()),2)+"$"+IntToHex(BinToDec(Edit9->Text.c_str()),2);
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button6Click(TObject *Sender)
{
Edit4->Text="";
Edit4->Text="$"+IntToHex(BinToDec(Edit10->Text.c_str()),2)+"$"+IntToHex(BinToDec(Edit11->Text.c_str()),2);

}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button7Click(TObject *Sender)
{
Edit5->Text="";
Edit5->Text="$"+IntToHex(BinToDec(Edit12->Text.c_str()),2)+"$"+IntToHex(BinToDec(Edit13->Text.c_str()),2);

}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button8Click(TObject *Sender)
{
Edit6->Text="";
Edit6->Text="$"+IntToHex(BinToDec(Edit14->Text.c_str()),2)+"$"+IntToHex(BinToDec(Edit15->Text.c_str()),2);
        
}
//---------------------------------------------------------------------------



void __fastcall TForm1::Button9Click(TObject *Sender)
{
Edit2->Text ="";
Edit2->Text = Edit2->Text + ComboBox4->Text;
Edit2->Text = Edit2->Text +"$"+IntToHex(BinToDec(Edit16->Text.c_str()),2);
/*Edit2->Text = Edit2->Text +"$"+IntToHex(first,1);
Edit2->Text = Edit2->Text +IntToHex(upr,1);
*/
}
//---------------------------------------------------------------------------





void __fastcall TForm1::ComboBox4Change(TObject *Sender)
{
/*Edit2->Text ="";
Edit2->Text = Edit2->Text + ComboBox4->Text;*/
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button10Click(TObject *Sender)
{
String upr,otv,start;
if (ComboBox5->ItemIndex == 0) upr = "0000";
if (ComboBox5->ItemIndex == 1) upr = "0001";
if (ComboBox5->ItemIndex == 2) upr = "0010";
if (ComboBox5->ItemIndex == 3) upr = "0110";
if (ComboBox5->ItemIndex == 4) upr = "0111";
if (ComboBox5->ItemIndex == 5) upr = "1000";
if (ComboBox5->ItemIndex == 6) upr = "1001";
if (ComboBox5->ItemIndex == 7) upr = "1010";
if (ComboBox5->ItemIndex == 8) upr = "1111";
if (ComboBox6->ItemIndex == 0) otv = "000";
if (ComboBox6->ItemIndex == 1) otv = "100";
if (ComboBox6->ItemIndex == 2) otv = "101";
if (ComboBox6->ItemIndex == 3) otv = "110";
if (ComboBox6->ItemIndex == 4) otv = "111";
 if(Form1->CheckBox4->Checked==true)
 {
  start = "1";
 }
else   start = "0";
Edit16->Text =otv+start+upr;

}
//---------------------------------------------------------------------------


void __fastcall TForm1::Edit8KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != 8))  Key = 0;
// if (Key != '1')  Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit9KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != 8))  Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit10KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != 8))  Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit11KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != 8))  Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit12KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != 8))  Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit13KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != 8))  Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit14KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != 8))  Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit15KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != 8))  Key = 0;
}
//---------------------------------------------------------------------------



void __fastcall TForm1::Edit16KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != 8))  Key = 0;
}
//---------------------------------------------------------------------------



void __fastcall TForm1::Button12Click(TObject *Sender)
{
Timer1->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button11Click(TObject *Sender)
{
if ( Edit18->Text !=""){
Timer1->Interval = StrToInt(Edit18->Text);
Timer1->Enabled = true;
}
}
//---------------------------------------------------------------------------


//������ ������ � �������� �������
void __fastcall TForm1::Timer1Timer(TObject *Sender)
{
String s,sp;
int dv=0;
 unsigned char sen[12],ks[10],x;
 s = "";
  ks[0]=0;
  if (op){
  send_pak(op_pol);
  op = false;
}
  if(tim_pak[11]!=0){
  for(x=10;x >6; x--)
  s = s + IntToHex(tim_pak[x],2);
  dv = HexToDec(s.c_str());
   if(CheckBox5->Checked == false)
    dv = dv + StrToInt(Edit17->Text);
     else     dv = dv - StrToInt(Edit17->Text);
s = IntToHex(dv,8);
x = 8;
int q=0;
for (int z = 7; z<11; z++){
sp ="";
sp = sp+s[x-q-1]+s[x-q];
tim_pak[z] = HexToDec(sp.c_str());
x --;
q+=2;
}
  for (int l=0; l<=9; l++) ks[l+1] = CRC8[ks[l] ^ tim_pak[l+1]];
  tim_pak[11] = ks[10];
  send_pak(tim_pak);
}

else
 op = true;
// Form1->Caption = sp;
}

//---------------------------------------------------------------------------


void __fastcall TForm1::Edit18KeyPress(TObject *Sender, char &Key)
{
 if ((Key != '0')&&(Key != '1')&&(Key != '2')&&(Key != '3')&&(Key != '4')&&(Key != '5')&&(Key != '6')&&(Key != '7')&&(Key != '8')&&(Key != '9')&&(Key != 8))  Key = 0;
if (Edit18->Text!="") Timer1->Interval = StrToInt(Edit18->Text);
 else Edit18->Text = "0";

}
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------




void __fastcall TForm1::Button14Click(TObject *Sender)
{
Memo2->Lines->Clear();
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button13Click(TObject *Sender)
{
 unsigned char sen[12],ks[10],x=0;
 ks[0]=0;
 String ch="";
 int m=StrToInt(Edit17->Text);

 send_pak(op_pol);
 if(tim_pak[11]!=0){
    sen[1] = 0x01;  sen[2] = 0xF1; sen[3] = 0xC0;
    for (x = 4; x <7; x++) sen[x] = 0;
    for (x = 7; x <11; x++) sen[x] = tim_pak[x];

if (CheckBox5->Checked ==false)
{
 if (sen[7] + m <= 0xFF) sen[7]+=m;
  else if (sen[8] + m <= 0xFF) sen[8]+=m;
  else if (sen[9] + m <= 0xFF) sen[9]+=m;
  else {
  Timer1->Enabled = false;
  ShowMessage("Max");
  }
}
if (CheckBox5->Checked )
{
 if (sen[9] - m >= 0) sen[9]-=m;
  else if (sen[8] - m >= 0) sen[8]-=m;
  else if (sen[7] - m >= 0) sen[7]-=m;
  else {
  Timer1->Enabled = false;
  ShowMessage("Min");
  }
}
    for (int l=0; l<=9; l++) ks[l+1] = CRC8[ks[l] ^ sen[l+1]];
    sen[11] = ks[10];
 send_pak(sen);
for(x =1; x<=11; x++)
Memo2->Text = Memo2->Text+" "+IntToHex(sen[x],2);
Memo2->Lines->Add("");
    }

}
//---------------------------------------------------------------------------



