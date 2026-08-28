{\{ ===================================================================== \}}
{\{    \logicso{08D07A}{機能実行譜}                                       \}}
{\{ ===================================================================== \}}
entity sim
output RESET;
output RELOCK;
output RDATA;
output MFM;
output Q[2];

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07B}{検証論理端子}                                     \}}
{\{ --------------------------------------------------------------------- \}}
output T0BP[3];
output T1BP[16];
output T2BP[7];
output T3BP[7];
output T4BP;
output T5BP[3];
output T6BP[8];

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07C}{内部信号}                                         \}}
{\{ --------------------------------------------------------------------- \}}
bitr tc[16];         {\{ 検証計数 \}}
bitr sel[7];         {\{ ビットセル行程 \}}
bitr wide[7];        {\{ ビットセル幅 \}}
bitn pulsewide[7];   {\{ パルス幅 \}}
bitn datapulses[7];  {\{ データパルス開始位置 \}}
bitn datapulsee[7];  {\{ データパルス終了位置 \}}
bitn widecenter[7];  {\{ ビットセル中心 \}}
bitr bitcount[3];    {\{ ビット計数 \}}
bitr bytecount[16];  {\{ バイト計数 \}}
bitn datapulse;      {\{ データパルス \}}
bitn clockpulse;     {\{ クロックパルス \}}
bitr bitcount[3];    {\{ ビット計数 \}}
bitn selzero;        {\{ ビットセル開始位置 \}}
bitn bytedata[8];    {\{ バイトデータ \}}
bitn bitdata;        {\{ ビットデータ \}}
bitn byteclock[8];   {\{ MFMクロックデータ \}}
bitr lastbit;        {\{ MFMデータ生成用最終ビット \}}
bitn bitclock;       {\{ MFMクロックパルス \}}

bitn node_RESET;     {\{ 初期化 \}}
bitn node_RELOCK;    {\{ 再同期開始 \}}
bitn node_MFM;       {\{ 方式選択 \}}

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07D}{検証論理端子代入}                                 \}}
{\{ --------------------------------------------------------------------- \}}
   T0BP=bitcount;
   T1BP=bytecount;
   T2BP=datapulses;
   T3BP=datapulsee;
   T4BP=datapulse;
   T5BP=bitcount;
   T6BP=byteclock;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07Z}{方式選択}                                         \}}
{\{ --------------------------------------------------------------------- \}}
   node_MFM=0;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07E}{実効譜引用}                                       \}}
{\{ --------------------------------------------------------------------- \}}
   part main(node_RESET,RELOCK,RDATA,MFM,Q)

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07F}{検証計数}                                         \}}
{\{ --------------------------------------------------------------------- \}}
   tc=tc+1;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07G}{初期化}                                           \}}
{\{ --------------------------------------------------------------------- \}}
   if (tc<5) node_RESET=1; endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07H}{ビットセル行程}                                   \}}
{\{ --------------------------------------------------------------------- \}}
   if (node_RESET)
      sel=0;
   else
      if (sel>=wide)
         sel=0;
      else
         sel=sel+1;
      endif
   endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07J}{クロックパルス}                                   \}}
{\{ --------------------------------------------------------------------- \}}
   if ((sel<pulsewide)&(sel>0))
      if (node_MFM)
         clockpulse=bitclock;
      else
         clockpulse=1;
      endif
   endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07K}{ビットセル開始位置}                               \}}
{\{ --------------------------------------------------------------------- \}}
   switch(sel)
      case 0: selzero=1;
   endswitch

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07L}{ビット計数}                                       \}}
{\{ --------------------------------------------------------------------- \}}
   if (node_RESET)
      bitcount=0;
   else
      if (selzero)
         switch(bitcount)
            case 7:  bitcount=0;
            default: bitcount=bitcount+1;
         endswitch
      else
         bitcount=bitcount;
      endif
   endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07M}{バイト計数}                                       \}}
{\{ --------------------------------------------------------------------- \}}
   if (node_RESET)
      bytecount=0;
   else
      switch(bitcount)
         case 7:
            switch(sel)
               case 0:  bytecount=bytecount+1;
               default: bytecount=bytecount;
            endswitch
         default: bytecount=bytecount;
      endswitch
   endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07N}{MFMデータ生成用最終ビット}                        \}}
{\{ --------------------------------------------------------------------- \}}
   if (node_RESET)
      lastbit=0;
   else
      switch(bitcount)
         case 7:
            switch(sel)
               case 0:  lastbit=bitdata;
               default: lastbit=lastbit;
            endswitch
         default: lastbit=lastbit;
      endswitch
   endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07P}{パルス幅}                                         \}}
{\{ --------------------------------------------------------------------- \}}
   pulsewide.0:3=wide.3:6;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07Q}{データパルス開始位置}                             \}}
{\{ --------------------------------------------------------------------- \}}
   datapulses=widecenter;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07R}{データパルス終了位置}                             \}}
{\{ --------------------------------------------------------------------- \}}
   datapulsee=widecenter+pulsewide;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07S}{ビットセル中心}                                   \}}
{\{ --------------------------------------------------------------------- \}}
   widecenter.0:5=wide.1:6;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07T}{ビットセル幅}                                     \}}
{\{ --------------------------------------------------------------------- \}}
   if (node_MFM)
      switch(bytecount)
         case 5:
            switch(bitcount)
               case 0: wide=30;
               case 1: wide=29;
               case 2: wide=28;
               case 3: wide=26;
               case 4: wide=27;
               case 5: wide=28;
               case 6: wide=29;
               case 7: wide=30;
            endswitch
        default: wide=31;
      endswitch
   else
      switch(bytecount)
         case 5:
            switch(bitcount)
               case 0: wide=61;
               case 1: wide=59;
               case 2: wide=57;
               case 3: wide=55;
               case 4: wide=57;
               case 5: wide=59;
               case 6: wide=61;
               case 7: wide=63;
            endswitch
        default: wide=63;
      endswitch
   endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07U}{データパルス}                                     \}}
{\{ --------------------------------------------------------------------- \}}
   if ((datapulses<=sel)&(datapulsee>=sel))
      if (bitdata)
         datapulse=1;
      endif
   endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07V}{バイトデータ}                                     \}}
{\{ --------------------------------------------------------------------- \}}
   if (node_MFM)
      switch(bytecount)
         case 0:  bytedata=0x4e;   {\{ GAP \}}
         case 1:  bytedata=0x4e;   {\{ GAP \}}
         case 2:  bytedata=0;      {\{ SYNC \}}
         case 3:  bytedata=0;      {\{ SYNC \}}
         case 4:  bytedata=0;      {\{ SYNC \}}
         case 5:  bytedata=0;      {\{ SYNC \}}
         case 6:  bytedata=0;      {\{ SYNC \}}
         case 7:  bytedata=0;      {\{ SYNC \}}
         default: bytedata=0x55;
      endswitch
   else
      switch(bytecount)
         case 0:  bytedata=0xff;   {\{ GAP \}}
         case 1:  bytedata=0xff;   {\{ GAP \}}
         case 2:  bytedata=0;      {\{ SYNC \}}
         case 3:  bytedata=0;      {\{ SYNC \}}
         case 4:  bytedata=0;      {\{ SYNC \}}
         case 5:  bytedata=0;      {\{ SYNC \}}
         case 6:  bytedata=0;      {\{ SYNC \}}
         case 7:  bytedata=0;      {\{ SYNC \}}
         default: bytedata=0x55;
      endswitch
   endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07W}{ビットデータ}                                     \}}
{\{ --------------------------------------------------------------------- \}}
   switch(bitcount)
      case 0: bitdata=bytedata.0;
      case 1: bitdata=bytedata.1;
      case 2: bitdata=bytedata.2;
      case 3: bitdata=bytedata.3;
      case 4: bitdata=bytedata.4;
      case 5: bitdata=bytedata.5;
      case 6: bitdata=bytedata.6;
      case 7: bitdata=bytedata.7;
   endswitch

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07X}{MFMクロックデータ}                                \}}
{\{ --------------------------------------------------------------------- \}}
   if (lastbit|bytedata.0) else byteclock.0=1; endif
   if (bytedata.0|bytedata.1) else byteclock.1=1; endif
   if (bytedata.1|bytedata.2) else byteclock.2=1; endif
   if (bytedata.2|bytedata.3) else byteclock.3=1; endif
   if (bytedata.3|bytedata.4) else byteclock.4=1; endif
   if (bytedata.4|bytedata.5) else byteclock.5=1; endif
   if (bytedata.5|bytedata.6) else byteclock.6=1; endif
   if (bytedata.6|bytedata.7) else byteclock.7=1; endif

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07Y}{MFMクロックパルス}                                \}}
{\{ --------------------------------------------------------------------- \}}
   switch(bitcount)
      case 0: bitclock=byteclock.0;
      case 1: bitclock=byteclock.1;
      case 2: bitclock=byteclock.2;
      case 3: bitclock=byteclock.3;
      case 4: bitclock=byteclock.4;
      case 5: bitclock=byteclock.5;
      case 6: bitclock=byteclock.6;
      case 7: bitclock=byteclock.7;
   endswitch

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07AA}{Disk 読み出しデータ}                             \}}
{\{ --------------------------------------------------------------------- \}}
   RDATA=clockpulse|datapulse;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07AB}{初期化}                                          \}}
{\{ --------------------------------------------------------------------- \}}
   RESET=node_RESET;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07AC}{再同期開始}                                      \}}
{\{ --------------------------------------------------------------------- \}}
   RELOCK=node_RELOCK;

{\{ --------------------------------------------------------------------- \}}
{\{    \logicso{08D07AD}{単密/倍密切り換え}                               \}}
{\{ --------------------------------------------------------------------- \}}
   MFM=node_MFM;

ende
