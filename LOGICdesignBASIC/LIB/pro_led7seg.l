logicname led7dspdyd

procedure led7dspdyd
input  RESET;      { 初期化 }
input  SCLK;       { 桁駆動CLK }
input  BCD0P[4];   { BCD 第1桁 }
input  BCD1P[4];   { BCD 第2桁 }
input  BCD2P[4];   { BCD 第3桁 }
input  WE;         { BCD書き込み }

output Q[10];

bitr   dgh0p[4];   { BCD 第1桁記憶 }
bitr   dgh1p[4];   { BCD 第2桁記憶 }
bitr   dgh2p[4];   { BCD 第3桁記憶 }
bitn   keta[3];    { 桁 }
bitr   sst[3];     { 主行程 }
bitr   ledct[3];   { 桁計数 }
bitn   ledoff;     { 消灯 }
bitn   leddata[4]; { 現桁表示データ }
bitn   led7seg[7]; { 現桁セグメントデータ }

   Q.0:6=led7seg;
   Q.7:9=keta;

   if (RESET)
      sst=0;
   else
      switch(sst)
         case 0: if (SCLK) sst=1; endif
         case 1: sst=2;
         case 2: sst=3;
         case 3: sst=4;
         case 4: sst=5;
         case 5: if (SCLK)
                    sst=sst;
                 else
                    sst=0;
                 endif
      endswitch
   endif

   if (RESET)
      ledct=0;
   else
      switch(sst)
         case 3:
            switch(ledct)
               case 0: ledct=1; { 消灯 }
               case 1: ledct=2; { 第1桁 }
               case 2: ledct=4; { 第2桁 }
               case 4: ledct=1; { 第3桁 }
            endswitch
         default: ledct=ledct;
      endswitch
   endif

   switch(sst)
      case 1: ledoff=1;
      case 2: ledoff=1;
      case 3: ledoff=1;
      case 4: ledoff=1;
   endswitch

   if (ledoff)
      keta=0;
   else
      keta=ledct;
   endif

   if (WE)
      dgh0p=BCD0P;
      dgh1p=BCD1P;
      dgh2p=BCD2P;
   else
      dgh0p=dgh0p;
      dgh1p=dgh1p;
      dgh2p=dgh2p;
   endif

   switch(ledct)
      case 1: leddata=dgh0p.0:3;
      case 2: leddata=dgh1p.0:3;
      case 4: leddata=dgh2p.0:3;
   endswitch

   switch(leddata)
      case 0: led7seg=0b1111110;  { 7e }
      case 1: led7seg=0b0110000;  { 30 }
      case 2: led7seg=0b1101101;  { 6d }
      case 3: led7seg=0b1111100;  { 7c }
      case 4: led7seg=0b0110011;  { 33 }
      case 5: led7seg=0b1011011;  { 5b }
      case 6: led7seg=0b1011111;  { 5f }
      case 7: led7seg=0b1110000;  { 70 }
      case 8: led7seg=0b1111111;  { 7f }
      case 9: led7seg=0b1110011;  { 73 }
   endswitch

endp

endlogic
