unit Unit1;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DXInput, DXClass, DXSprite, DXDraws, ExtCtrls, DXSounds, MPlayer,
  ComCtrls, StdCtrls, Menus,shellapi;

type
  TForm1 = class(TForm)
    DXDraw1: TDXDraw;
    DXImageList1: TDXImageList;
    DXSpriteEngine1: TDXSpriteEngine;
    DXTimer1: TDXTimer;
    DXInput1: TDXInput;
    Timer1: TTimer;
    Timer3: TTimer;
    Timer5: TTimer;
    DXSound1: TDXSound;
    DXWaveList1: TDXWaveList;
    MediaPlayer1: TMediaPlayer;
    Timer4: TTimer;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    N12: TMenuItem;
    N13: TMenuItem;
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure N6Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Form1: TForm1;
  xxx,x_bos,x_play,x_fon1,x_fon2,x_fon3,x_fon4,x_bonus,y_bonus,y_pat_play,
  y_pat_bos,x_pat_bos,x_pat_play:real;
   n,nn1,np,nv,np1,nv1,pop,life,pot,g,g1,nn2,bonus,
   payse,speed_fon,npp,npb,musik,zag,ust_n,cuc,bonus_f:Integer;
   ok,smert_bossa,smert_igroka,nnn,smert_objecta,new,
   www,pris,flag,flag1,pause,open:boolean;
implementation

uses Unit2, Unit3, Unit4;
{~~~~~~~~~~~~~~~~~~~~~~Классы объектов~~~~~~~~~~~~~~~~~~~~~~~}
{****************************Босс****************************}
type
  TplayerSprite=class(TImageSprite)
  protected
  procedure Domove(movecount:integer); override;
  procedure DoCollision(Sprite:Tsprite; var Done :Boolean);override;
end;
{****************************Игрок***************************}
  TplayerSprite1=class(TImageSprite)
  protected
  procedure DoMove(MoveCount:integer); override;
    procedure DoCollision(Sprite:Tsprite; var Done :Boolean);override;
end;
{*************************Бонус******************************}
  TplayerSprite5=class(TImageSprite)
  protected
 procedure DoMove(MoveCount:integer); override;
  procedure DoCollision(Sprite:Tsprite; var Done :Boolean);override;
end;

{***********************Пуля Игрока**************************}
  TplayerSprite2=class(TImageSprite)
  protected
  procedure DoMove(MoveCount:integer); override;
  procedure DoCollision(Sprite:Tsprite; var Done :Boolean);override;
  public
  constructor create(aparent:TSprite); override;
end;
{***********************Пуля Босса**************************}
  TplayerSprite3=class(TImageSprite)
  protected
  procedure DoMove(MoveCount:integer); override;
  procedure DoCollision(Sprite:Tsprite; var Done :Boolean);override;

  public
  constructor create(aparent:TSprite); override;
end;
{***********************####ФОН####**************************}
  TplayerSprite4=class(Tbackgroundsprite)
  public
procedure domove(movecount:integer);override;
end;
{***********************####ФОН####**************************}
  TplayerSprite4_1=class(Tbackgroundsprite)
  public
procedure domove(movecount:integer);override;
end;

{***********************####ФОН####**************************}
  TplayerSprite6=class(Tbackgroundsprite)
  public
procedure domove(movecount:integer);override;
end;
  TplayerSprite6_1=class(Tbackgroundsprite)
  public
procedure domove(movecount:integer);override;
end;


{$R *.dfm}
procedure pauza;
begin
IF Payse = 1 Then
  Begin
  pris:=True;
  nn2 :=3;
     cuc := bonus_f;
     Form1.MediaPlayer1.Stop;
     nn1 := 0;
       n := 0;
    pause := true;
    speed_fon := 0;
    nn2 := 0;
  bonus_f := 0;
  end;
IF Payse = 2 Then
  Begin
   pris:=True;
  nn2 :=3;
   
  bonus_f := cuc;
     nn2 := 5;
     speed_fon := 1;
     Payse := 0;
IF mmm = False Then
    Form1.MediaPlayer1.Play;
     nn1 := 4;
       n := 3;
    pause := False;
  end;
end;

Procedure Muzika;
begin
//540289
//323568
{*******************************Музыка***********************}
IF Musik = 3 Then
  begin
    musik := 0;
    Form1.MediaPlayer1.FileName := '#3_05_Voyna.mp3';
    Form1.MediaPlayer1.Open;
    Form1.MediaPlayer1.Play;
  end else
IF (Form1.MediaPlayer1.Position >=540000)and(musik=0) Then
  begin
    Form1.MediaPlayer1.FileName := '01 Hells Bells.mp3';
    Form1.MediaPlayer1.Open;
    Form1.MediaPlayer1.Play;
    musik := musik + 1;
  end else
IF (Form1.MediaPlayer1.Position >= 313550)and(musik = 1) Then
 begin
   Form1.MediaPlayer1.FileName := '01 Thunderstruck.mp3';
   Form1.MediaPlayer1.Open;
   Form1.MediaPlayer1.Play;
    musik := musik + 1;
 end else
IF (musik=2)and(Form1.MediaPlayer1.Position >= 293120) Then musik := 3;
{************************************************************}
end;
Procedure bye;
begin
{ IF (IsButton2 in Form1.DXInput1.States)and(pop>=15) then
    begin}
      pot := pot + 5;
      pop := pop - 15;
      Form1.Timer5.Enabled:=False;
//    EnD;
Form1.Timer5.Enabled:=True;

end;

Procedure neww;
begin
IF MessageBox(0,'Вы уверены, что хотите начать новую игру?','Новая игра.',4) = IDYES Then
 begin
  ShellExecute(Form1.Handle,nil,'Waroftheworlds.exe',nil,'',sw_restore);
  Form1.Close;
end;
 end;


Procedure save;
var t:textfile;
s:string;
begin
getdir(255,s);
Form1.SaveDialog1.Execute;
    AssignFile(t,Form1.SaveDialog1.FileName+'.sav');
        Rewrite(t);
IF Form1.SaveDialog1.FileName <>'' Then
  Begin
        writeln(t,'Assembler,Delphi,C++,Fortran,Java,Pl/1');
        writeln(t,pop);
        writeln(t,life);
        writeln(t,pot);
        writeln(t,x_bos:0:0);
        writeln(t,x_play:0:0);
{        writeln(t,y_pat_bos:0:0);
        writeln(t,y_pat_play:0:0);
        writeln(t,x_pat_bos:0:0);
        writeln(t,x_pat_play:0:0);}
        writeln(t,x_fon1:0:0);
        writeln(t,x_fon2:0:0);
        writeln(t,x_fon3:0:0);
        writeln(t,x_fon4:0:0);
        writeln(t,x_bonus:0:0);
        writeln(t,y_bonus:0:0);
  End;
        CloseFile(t);
ChDir(s);
end;

Procedure opens;
var t:textfile;
s,s1:string;
begin
getdir(255,s1);
Form1.OpenDialog1.Execute;
AssignFile(t,Form1.OpenDialog1.FileName);
      reset(t);
IF Form1.OpenDialog1.FileName <>'' Then
  Begin
        Readln(t,s);
        IF s ='Assembler,Delphi,C++,Fortran,Java,Pl/1' Then
          begin
            open := true;
            Readln(t,pop);
            Readln(t,life);
            Readln(t,pot);
            Readln(t,x_bos);
            Readln(t,x_play);
{            Readln(t,y_pat_bos);
            Readln(t,y_pat_play);
            Readln(t,x_pat_bos);
            Readln(t,x_pat_play); }
            Readln(t,x_fon1);
            Readln(t,x_fon2);
            Readln(t,x_fon3);
            Readln(t,x_fon4);
            Readln(t,x_bonus);
            Readln(t,y_bonus);
        end
          Else ShowMessage('Недоступный файл!');
  End;
  CloseFile(t);
  ChDir(s1);
end;
//TABLICA

Procedure tabla;
begin
form2.Visible := True;
IF payse = 1 Then Payse := 0;
Payse := Payse + 1;
Pauza;
end;

Procedure options;
begin
form4.Visible := True;
Form1.Timer1.Enabled:=false;
Form1.Timer3.Enabled:=false;
Form1.Timer5.Enabled:=false;
Form1.DXTimer1.Enabled := false;
end;

{ TplayerSprite }
//Смерть Босса.
procedure TplayerSprite.DoCollision(Sprite: Tsprite; var Done: Boolean);
var r:byte;
begin
Randomize;
IF (sprite is TplayerSprite2) Then
  begin
    Dead;
    xxx := x;
r := random(100);
IF r mod 2 = 0 Then
begin
pris := True;
 bonus := random(6)+0;

 Form1.timer4.Enabled:=True;
 cuc := 0;
end
else
  pris := false;
IF flag = False Then Flag := true;
    form1.DXWaveList1.Items.Find('smert_b').Play(false);
    pop := pop + 5;
    smert_bossa  := True;
    Form1.Timer1.Enabled := True;
  end;
end;
// Смерть игрока
procedure TplayerSprite1.DoCollision(Sprite: Tsprite; var Done: Boolean);
begin
  IF (sprite is TplayerSprite3) Then
   begin
     Dead;
    life := life - 1;
    form1.DXWaveList1.Items.Find('smert_g').Play(false);
    smert_igroka := true;
    Form1.Timer3.Enabled:=True;
   end;
   //---------------------------------
IF (sprite is TplayerSprite5) Then
begin
    cuc := 90;

IF bonus_f = 1 Then pot := pot + 15;
IF bonus_f = 2 Then life := life + 1;
IF bonus_f = 3 Then pop := pop - 30;
IF bonus_f = 5 Then pop := pop + 30;
IF bonus_f = 4  Then
   begin
     Dead;
     flag1 := false;
    life := life - 1;
    form1.DXWaveList1.Items.Find('smert_g').Play(false);
    smert_igroka := true;
    Form1.Timer3.Enabled:=True;
   end;
end
Else      bonus_f := 0;


       

end;


//БОСС
procedure TplayerSprite.Domove(movecount: integer);
begin

  inherited DoMove(MoveCount);
  randomize;
 IF open Then x := x_bos;
 IF new Then x := x_bos;

  x_bos := x;
  IF (x > 600) then n := -ust_n;
  IF (x < 5) then n := ust_n;
  x := x + n;
Np1 := Np1 +1;
      IF ((x=x_play)or((x-x_play>=15)and(x-x_play<=30))or((x-x_play<=-15)and(x-x_play>=-30)))and(np1-nv1 >= 25)and(pause=false)Then
      begin
        With  TPlayerSprite3.Create(Engine) do
          Begin
            Image := Form1.DXImageList1.Items.Find('Pula2');
            form1.DXWaveList1.Items.Find('vis2').Play(false);
            X := Self.X + Self.Width-50;
            Y := Self.Y + Self.Height-30;
            Width := Image.Width;
            Height := Image.Height;
          end;
          nv1 := np1;
      end;
Collision;
end;
{ TplayerSprite1 }
{IGROK=player!!!!!!!!!!!!!!!!!!!!!}

procedure TplayerSprite1.DoMove(MoveCount: integer);
begin
  inherited DoMove(MoveCount);
  IF open Then x := x_play;
  IF new Then x := x_play;
  x_play := x;
  IF (IsLeft in Form1.DXInput1.States) or(x>600) then x := x - nn1;
  IF (IsRight in Form1.DXInput1.States)or(x < 5) then x := x + nn1;
Np := Np +1;

  IF ((IsUp in Form1.DXInput1.States)or(IsButton1 in Form1.DXInput1.States))and(pot>0) Then
    Begin
      IF (np-nv > 100)and(pause=false) Then
      begin
        With  TPlayerSprite2.Create(Engine) do
          Begin
            PixelCheck := True;
            Image := Form1.DXImageList1.Items.Find('Pula1');
            form1.DXWaveList1.Items.Find('vis1').Play(false);
            X := Self.X + Self.Width-60;
            Y := Self.Y + Self.Height-110;
            Width := Image.Width;
            Height := Image.Height;
            pot := pot - 1;
          end;
          nv := np;
      end;
    end;
Collision;


end;

{Таймер DelphiX'a}
procedure TForm1.DXTimer1Timer(Sender: TObject; LagCount: Integer);
begin
//randomize;
IF not DxDraw1.CanDraw Then exit;

DxInput1.Update;
DxSpriteEngine1.Move(lagCount);
dxdraw1.Surface.Fill(0);
DXSpriteEngine1.Dead;
DxSpriteEngine1.Draw;

//dxdraw1.Surface.Canvas.Rectangle(100,100,200,200);
with dxdraw1.Surface.Canvas do
begin
  brush.Style := BsClear;
  Font.Size := 14;
      Font.Color := clYellow;
  TextOut(720,30,'Очки :'+IntToStr(pop));
      Font.Color := clWhite;
  TextOut(720,510,'Жизней :'+IntToStr(life));
      Font.Color := cllime;
  TextOut(700,210,'Выстрелов :'+IntToStr(pot));
IF Payse = 1 Then
  Begin
    Font.Color := ClWhite;
    Font.Size := 25;
    TextOut(400,150,'ПАУЗА.');

  end;
IF pot = 0 Then
Begin
//Fuchsia
  Font.Color := ClLime;
  Font.Size := 10;
  TextOut(650,570,'Уваc закончились патроны');
  Form1.Caption := 'Чтобы купить патроны нажмите b';
end
Else Form1.Caption := 'Война миров I';

IF life = 0 Then
Begin
  Font.Color := ClAqua;
  Font.Size := 25;
  TextOut(300,150,'Увы! Вы проиграли...?');
  nnn := true;
  Timer3.Enabled:=True;
end;
IF pop >= 300 Then
Begin
  Font.Color := ClRed;
  Font.Size := 25;
  TextOut(250,150,'Поздравляю вы выйграли!');
  nnn := true;
  Timer3.Enabled:=True;
end;

  release;
end;


DxDraw1.Flip;


end;

{Криат Формы}
procedure TForm1.FormCreate(Sender: TObject);
var s:string;

begin
bonus_f := 0;
cuc := 0;
ust_n := 3;
zag := 0;
musik := 0;
open := false;
npp := 3;
npb := 5;
new := False;
speed_fon := 1;
bonus := 0;
Payse := 0;
Pause := False;
Flag:=false;
Flag1:=false;
Form1.MediaPlayer1.Play;
pris := false;
 Randomize;
 g := 0;
 g1 := 80;
  pot := 30;
  ok := false;
  life := 3;
  nnn := False;
  www := true;
  n := ust_n;
  pop := 0;
  smert_bossa := False;
  smert_igroka := False;
  nn1 := 4;
  np := 0;
  nv := 0;
  np1 := 0;
  nv1 := 0;

//***********************************************************
  With TPlayerSprite6.Create(DxSpriteEngine1.Engine) do
     Begin
        image:=DxImagelist1.Items.Find('fon2');
        x := 1;
        y := 231;
        Image.Transparent:=false;
        setmapsize(1,1);
        z := - 10;
     end;

  With TPlayerSprite6.Create(DxSpriteEngine1.Engine) do
     Begin
        image:=DxImagelist1.Items.Find('fon3');
        x := 962;
        y := 231;
        Image.Transparent:=false;
        setmapsize(1,1);
        z := - 10;
     end;
//***********************************************************
//***********************************************************
  With TPlayerSprite4.Create(DxSpriteEngine1.Engine) do
     Begin
        image:=DxImagelist1.Items.Find('fon');
        x := 1 ;
        y := 1;
        Image.Transparent:=false;
        setmapsize(1,1);
        z := - 10;
     end;

  With TPlayerSprite4_1.Create(DxSpriteEngine1.Engine) do
     Begin

        image:=DxImagelist1.Items.Find('fon1');
        x := 960;
        y := 1;
        Image.Transparent:=false;
        setmapsize(1,1);
            z := - 10;
     end;
//***********************************************************
  With TPlayerSprite.Create(DxSpriteEngine1.Engine) do
     Begin
       PixelCheck := True;
       Image := Form1.DXImageList1.Items.Find('boss');
       x := 1; y := 1;
       Width := Image.Width;
       Height := Image.Height;
     end;

  With TPlayerSprite1.Create(DxSpriteEngine1.Engine) do
     Begin
       PixelCheck := True;
       Image := Form1.DXImageList1.Items.Find('Igrok');
       x := 300; y := 490;
       Width := Image.Width;
       Height := Image.Height;
     end;
{  With TPlayerSprite5.Create(DxSpriteEngine1.Engine) do
     Begin
       PixelCheck := True;
       Image := Form1.DXImageList1.Items.Find('smile');
       x := Random(600); y := Random(400);
       Width := Image.Width;
       Height := Image.Height;
     end;}

end;


{ TplayerSprite2 }

constructor TplayerSprite2.create(aparent:TSprite);
begin
  inherited Create(Aparent);
  Image := Form1.DXImageList1.Items.Find('Pula1');
  Width := Image.Width;
  Height := Image.Height;
  Collision;
end;

// пуля игрока исчезает при попадании в Босса
procedure TplayerSprite2.DoCollision(Sprite: Tsprite; var Done: Boolean);
begin
  IF(sprite is TplayerSprite5)or((sprite is TplayerSprite)and(smert_bossa)) Then
     Dead;
end;

procedure TplayerSprite2.DoMove(MoveCount: integer);
begin
  inherited DoMove(MoveCount);
 IF open then y := y_pat_play;
  if (pause = false) then y := y - 5;
   y_pat_play := y;
  Collision;
end;

{ TplayerSprite3 }
{Пуля Босса}
constructor TplayerSprite3.create(aparent: TSprite);
begin
  inherited Create(Aparent);
  Image := Form1.DXImageList1.Items.Find('Pula2');
  Width := Image.Width;
  Height := Image.Height;
  Collision;

end;

procedure TplayerSprite3.DoCollision(Sprite: Tsprite; var Done: Boolean);
begin
IF y > 630 Then dead; 
end;

procedure TplayerSprite3.DoMove(MoveCount: integer);
begin
  inherited DoMove(MoveCount);
   IF open then y := y_pat_bos;
  if (pause = false)then y := y + 10;
  y_pat_bos:=y;

 Collision;
end;
//Таймер смерти Босса.
procedure TForm1.Timer1Timer(Sender: TObject);
begin
Randomize;
IF smert_bossa Then
begin
  With TPlayerSprite.Create(DxSpriteEngine1.Engine) do
     Begin
       PixelCheck := True;
       Image := Form1.DXImageList1.Items.Find('boss');
       x := Random(600)+random(50); y := 1;
       Width := Image.Width;
       Height := Image.Height;
       smert_bossa := False;
     end;
end;
Form1.Timer1.Enabled := False;
end;

{ TplayerSprite4 }


procedure TForm1.Timer3Timer(Sender: TObject);
begin
randomize;
IF nnn Then
begin
//sleep(100);
Form2.Visible:=True;
Form1.DXWaveList1.DXSound.Finalize;
Form1.Timer1.Enabled:=false;
Form1.Timer3.Enabled:=false;
Form1.Timer5.Enabled:=false;
Form1.DXTimer1.Enabled:=false;
end;
IF smert_igroka Then
begin
  With TPlayerSprite1.Create(DxSpriteEngine1.Engine) do
     Begin
       PixelCheck := True;
       Image := Form1.DXImageList1.Items.Find('igrok');
       x := Random(600)+random(50); y := 490;
       Width := Image.Width;
       Height := Image.Height;
       smert_igroka := False;
     end;
end;
 IF  smert_objecta Then  www := True;
 Timer3.Enabled:=False;
end;


procedure TForm1.Timer5Timer(Sender: TObject);
begin
Muzika;
IF (IsButton2 in Form1.DXInput1.States)and(pop>=15) then bye;
IF open Then open := false;
end;

{ TplayerSprite4 }

procedure TplayerSprite4.domove(movecount: integer);
begin
IF open Then x := x_fon1;

x := x - speed_fon;
x_fon1 := x;
IF x =-959 then x := 959;
end;

procedure TplayerSprite4_1.domove(movecount: integer);
begin
IF open Then  x := x_fon2;

x := x - speed_fon;
x_fon2 := x;
IF x =-959 then x :=959;
end;

procedure priz;
begin
With TPlayerSprite5.Create(Form1.DxSpriteEngine1.Engine) do
  Begin
visible := false;
PixelCheck := True;
     Flag:=false;
    IF bonus = 1 Then
     begin
       Image := Form1.DXImageList1.Items.Find('bonus1');
       bonus_f := 1;
     cuc := bonus_f;
     end
    Else
      IF bonus = 2 Then
       begin
        Image := Form1.DXImageList1.Items.Find('bonus2');
       bonus_f := 2;
     cuc := bonus_f;
       end
        Else
          IF bonus = 3 Then
           begin
             Image := Form1.DXImageList1.Items.Find('bonus3');
              bonus_f := 3; //Then
                cuc := bonus_f;
           end
        else
//******************bonus = 4 смерть игрока!*****************
          IF bonus = 4 Then
           begin
            Image := Form1.DXImageList1.Items.Find('bonus4');
              bonus_f := 4;
             cuc := bonus_f;
//            flag1 := true;
           end
        else
          IF bonus = 5 Then
           begin
             Image := Form1.DXImageList1.Items.Find('bonus5');
             bonus_f := 5;
     cuc := bonus_f;
           end
        Else  Image := Form1.DXImageList1.Items.Find('bonus0');
      bonus := 0;
Width := Image.Width;
Height := Image.Height;
end;
End;


procedure TForm1.Timer4Timer(Sender: TObject);
var r:byte;
begin
randomize;
IF smert_igroka = false then
  begin
  IF r <> 78 then begin
   nn2 := 5;
   pris := false;
   priz;
   r := 78;
   end;
  end;
 timer4.Enabled:=False;
end;

{ TplayerSprite5 }

procedure TplayerSprite5.DoCollision(Sprite: Tsprite; var Done: Boolean);
begin
  IF (sprite is TplayerSprite1)and(cuc = 90) Then Dead;
  IF (sprite is TplayerSprite2) Then
   begin
     pop := pop + 1;
     Dead;
     
   end;
end;

procedure TplayerSprite5.DoMove(MoveCount: integer);
begin
  inherited DoMove(MoveCount);
IF open Then
 begin
   x := x_bonus;
   y := y_bonus;
 end;
  x := xxx;
  x_bonus := x;
  y_bonus := y;
 IF nn2 = 5 then   visible := True
 Else visible := false;
  y := y + nn2;
IF y > 600 Then
begin
  visible := false;
  y := 1;
  nn2:=0;
  Flag := False;
end;
Collision;
end;

{ TplayerSprite4_1 }


{ TplayerSprite6 }

procedure TplayerSprite6.domove(movecount: integer);
begin
IF open Then x := x + x_fon4;

x := x - speed_fon;
x_fon3 := x;

IF x = - 962 Then x := 961;
end;

{ TplayerSprite6_1 }

procedure TplayerSprite6_1.domove(movecount: integer);
begin

IF open Then   x := x + x_fon3;
  x := x - speed_fon;
  x_fon4 := x;
IF x = - 962 Then x := 962;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
Form1.Close;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  if payse > 2 Then payse := 0;
  payse := payse + 1;
pauza;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
IF(key ='n')or(key='N')or(key ='Т')or(key='т') Then neww;
IF key = #27 Then Form1.Close;
IF (key = 'p')or(key = 'P')or(key = 'з')or(key = 'З') Then
begin
  if payse >2 Then payse := 0;
  payse := payse + 1;
  pauza;
enD;
IF(key ='ы')or(key='Ы')or(key ='S')or(key='s') Then save;
IF(key ='Z')or(key='z')or(key ='Я')or(key='я') Then opens;
IF(key ='Е')or(key='е')or(key ='T')or(key='t') Then tabla;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  neww;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
Form1.Timer1.Enabled:=false;
Form1.Timer3.Enabled:=false;
Form1.Timer5.Enabled:=false;
Form3.Timer19.Enabled := True;
Form1.DXTimer1.Enabled := false;
Form3.visible:=true;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
save;
end;

procedure TForm1.N12Click(Sender: TObject);
begin
tabla;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
opens;
end;

procedure TForm1.N13Click(Sender: TObject);
begin
options;
end;


end.
