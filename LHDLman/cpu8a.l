{ ======================================================= }
{    8桁プロセッサ  CPU8A                                 }
{                                           by LdLabo     }
{                                           2004.11.21    }
{ ======================================================= }
logicname sample

{ ------------------------------------------------------- }
{    実効譜                                               }
{ ------------------------------------------------------- }
entity main
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    端子                                                 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
input  RESET;         { 初期化 }
inout  MDATA[8];      { メモリデータ }
output ADDRESS[16];   { メモリ番地 }
output MRE;           { メモリ読み出し }
output MWE;           { メモリ書き込み }
output PRE;           { ポート読み出し }
output PWE;           { ポート書き込み }
input  INT[8];        { 割り込み要求   }
output PADDRESS[8];   { 頁番地 }

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    テスト端子                                           }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
output T0P[8];
output T1P[8];
output T2P[8];
output T3P[8];
output T4P[16];
output T5P[4];
output T6P;
output T7P[4];
output T8P[4];
output T9P[16];
output T10P[8];
output T11P[8];
output T12P[8];
output T13P[8];
output T14P[16];
output T15P[16];
output T16P[16];
output T17P;
output T18P;
output T19P;
output T20P[4];
output T21P[8];
output T22P;
output T23P[8];
output T24P[8];
output T25P[8];
output T26P[8];
output T27P[8];
output T28P[8];
output T29P[8];
output T30P[8];
output T31P[8];
output T32P[8];

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    内部信号                                             }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
bitr   ip[16];   { 命令ポインタ }
bitr   cp[4];    { 符順番   }
bitr   np[4];    { 使用符数 }
bitr   codea[8]; { 一番符   }
bitr   codeb[8]; { 二番符   }
bitr   codec[8]; { 三番符   }

bitr   r0p[16];  { RP0 }
bitr   r1p[16];  { RP1 }
bitr   ix[16];   { IX }
bitr   iy[16];   { IY }
bitr   jr[16];   { JR }
bitr   sp[16];   { SP }
bitr   cpr[8];   { CPR }
bitr   dpr[8];   { DPR }

bitr   codepage[8];  { コード頁 }
bitr   icodepage[8]; { 退避コード頁 }

bitn   rno[4];   { レジスタ選択 }
bitn   sw;       { スタック書き込み }
bitn   sr;       { スタック読み出し }
bitn   mw;       { メモリ書き込み }
bitn   mr;       { メモリ読み出し }
bitn   bn;       { バス無操作　　 }
bitn   pw;       { ポート書き込み }
bitn   pr;       { ポート読み出し }
bitn   cr;       { 符読み出し }
bitr   ie;       { 割り込み制御 }

bitr   cc[4];    { 命令行程 }
bitr   ipr[16];  { 命令ポインタ一時記憶 }

bitn   c15n;     { 命令未実行 }

bitn   ipi;      { 命令ポインタ増 }
bitn   iph;      { 命令ポインタ保持 }
bitn   spi;      { スタックポインタ増 }
bitn   spd;      { スタックポインタ減 }

bitn   cd_jmp ;  { 命令コード検出 }
bitn   cd_jmpc;
bitn   cd_jmpz;
bitn   cd_movj;
bitn   cd_call;
bitn   cd_ret;
bitn   cd_push;
bitn   cd_pop;
bitn   cd_inc;
bitn   cd_dec;
bitn   cd_movi;
bitn   cd_movmr;
bitn   cd_movrm;
bitn   cd_movpr;
bitn   cd_movrp;
bitn   cd_reti;
bitn   cd_movx;
bitn   cd_movy;
bitn   cd_movs;

bitn   aluout;   { 算術論理演算除外 }
bitn   aluop;    { 算術論理演算実行 }
bitn   aluo[9];  { 算術論理演算器出力 }
bitn   alu0i[9]; { 算術論理演算器入力1 }
bitn   alu1i[9]; { 算術論理演算器入力2 }
bitn   alu2i[9]; { 算術論理演算器入力3 }
bitr   sc;       { 桁上げ }
bitr   sz;       { 零 }

bitn   MDATAI[8];  { メモリデータ入力 }
bitn   MDATAO[8];  { メモリデータ出力 }
bitn   buscnt;     { メモリデータバス制御 }

bitr   int0p[2];   { 割り込み要求 0 起点 }
bitr   int1p[2];   { 割り込み要求 1 起点 }
bitr   int2p[2];   { 割り込み要求 2 起点 }
bitr   int3p[2];   { 割り込み要求 3 起点 }
bitr   int4p[2];   { 割り込み要求 4 起点 }
bitr   int5p[2];   { 割り込み要求 5 起点 }
bitr   int6p[2];   { 割り込み要求 6 起点 }
bitr   int7p[2];   { 割り込み要求 7 起点 }
bitr   intm[8];    { 割り込み無効指定 }
bitr   it;         { 割り込み処理待ち }
bitr   ic[4];      { 割り込み行程 }

bitr   rf0[8];     { レジスタファイル 0 }
bitr   rf1[8];     { レジスタファイル 1 }
bitr   rf2[8];     { レジスタファイル 2 }
bitr   rf3[8];     { レジスタファイル 3 }
bitr   rf4[8];     { レジスタファイル 4 }
bitr   rf5[8];     { レジスタファイル 5 }
bitr   rf6[8];     { レジスタファイル 6 }
bitr   rf7[8];     { レジスタファイル 7 }

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 割り込み要求 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ INT0 }
   if (RESET)
      int0p = 0;
   else
      if (intm.0)
         int0p = 0;
      else
         if (INT.0)
            switch(int0p)
               case 0: int0p = 1;
               case 1: int0p = 2;
               case 2: int0p = int0p;
            endswitch
         endif
      endif
   endif

{ INT1 }
   if (RESET)
      int1p = 0;
   else
      if (intm.1)
         int1p = 0;
      else
         if (INT.1)
            switch(int1p)
               case 0: int1p = 1;
               case 1: int1p = 2;
               case 2: int1p = int1p;
            endswitch
         endif
      endif
   endif

{ INT2 }
   if (RESET)
      int2p = 0;
   else
      if (intm.2)
         int2p = 0;
      else
         if (INT.2)
            switch(int2p)
               case 0: int2p = 1;
               case 1: int2p = 2;
               case 2: int2p = int2p;
            endswitch
         endif
      endif
   endif

{ INT3 }
   if (RESET)
      int3p = 0;
   else
      if (intm.3)
         int3p = 0;
      else
         if (INT.3)
            switch(int3p)
               case 0: int3p = 1;
               case 1: int3p = 2;
               case 2: int3p = int3p;
            endswitch
         endif
      endif
   endif

{ INT4 }
   if (RESET)
      int4p = 0;
   else
      if (intm.4)
         int4p = 0;
      else
         if (INT.4)
            switch(int4p)
               case 0: int4p = 1;
               case 1: int4p = 2;
               case 2: int4p = int4p;
            endswitch
         endif
      endif
   endif

{ INT5 }
   if (RESET)
      int5p = 0;
   else
      if (intm.5)
         int5p = 0;
      else
         if (INT.5)
            switch(int5p)
               case 0: int5p = 1;
               case 1: int5p = 2;
               case 2: int5p = int5p;
            endswitch
         endif
      endif
   endif

{ INT6 }
   if (RESET)
      int6p = 0;
   else
      if (intm.6)
         int6p = 0;
      else
         if (INT.6)
            switch(int6p)
               case 0: int6p = 1;
               case 1: int6p = 2;
               case 2: int6p = int6p;
            endswitch
         endif
      endif
   endif

{ INT7 }
   if (RESET)
      int7p = 0;
   else
         if (INT.7)
            switch(int7p)
               case 0: int7p = 1;
               case 1: int7p = 2;
               case 2: int7p = int7p;
            endswitch
         endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 割り込み認識 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      it = 0;
   else
      if ( int0p.0 | int1p.0 | int2p.0 | int3p.0
         | int4p.0 | int5p.0 | int6p.0 | int7p.0)
         it = 1;
      else
         if (ic==0)
            it = 0;
         else
            it = it;
         endif
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 割り込み行程 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      ic = 15;
   else
      if (c15n)
         if (ic==15)
            if (it)
               if (ie)
                  ic = 8;
               else
                  ic = ic;
               endif
            else
               ic = ic;
            endif
         else
            ic = ic - 1;
         endif
      else
         ic = 15;
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ メモリデータ }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   enable(MDATA,MDATAI,MDATAO,buscnt)

   if (mw | sw | pw)
      buscnt = 1;
   endif

   MDATAI.8 = 1;   { MDATAI を有効にする }
 
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 命令ポインタ }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      ip = 0;                        { 初期後の命令ポインタ }
   else
      if (ipi) ip = ip + 1; endif    { 1増やす }
      if (iph) ip = ip; endif        { 保持 }
   endif

   switch(codea)
      case 0x9f:                     { RETI }
         switch(cc)
            case 2: ip.0:7 = MDATAI;
            case 1: ip.8:15 = MDATAI; ip.0:7 = ip.0:7;
            case 0: iph = 1;
         endswitch

      case 0xf0:                     { JMP }
         switch(cc)
            case 15: ipi = 1;
            case  1: ipi = 1;
            case  0:
               ip.0:7  = codeb;
               ip.8:15 = MDATAI;
         endswitch

      case 0xf1:                     { JMPC }
         switch(cc)
            case 15: ipi = 1;
            case  1: ipi = 1;
            case  0:
               if (sc)
                  ip.0:7  = codeb;
                  ip.8:15 = MDATAI;
               else
                  ipi = 1;
               endif
         endswitch

      case 0xf2:                     { JMPZ }
         switch(cc)
            case 15: ipi = 1;
            case  1: ipi = 1;
            case  0:
               if (sz)
                  ip.0:7  = codeb;
                  ip.8:15 = MDATAI;
               else
                  ipi = 1;
               endif
         endswitch

      case 0x45:                     { MOVX }
         switch(cc)
            case 15: ipi = 1;
            case  1: ipi = 1;
            case  0: ipi = 1;
         endswitch

      case 0x4a:                     { MOVY }
         switch(cc)
            case 15: ipi = 1;
            case  1: ipi = 1;
            case  0: ipi = 1;
         endswitch

      case 0x4f:                     { MOVS }
         switch(cc)
            case 15: ipi = 1;
            case  1: ipi = 1;
            case  0: ipi = 1;
         endswitch

      case 0xf6:                     { MOVJ }
         switch(cc)
            case 15: ipi = 1;
            case  1: ipi = 1;
            case  0: ipi = 1;
            
         endswitch

      case 0xf7:                     { CALL }
         switch(cc)
            case 15: ipi = 1;
            case  7:
               ipi = 1;
            case  6:
               ipi = 1;
            case  0:
               ip.0:7  = codeb;
               ip.8:15 = codec;
            default:
               iph = 1;
         endswitch
      case 0xf8:                     { RET }
         switch(cc)
            case 15: ipi = 1;
            case  1: ip.8:15 = MDATAI;
            case  0: ip.0:7  = MDATAI; ip.8:15 = ip.8:15;
         endswitch
       case 0xf9:                    { PUSH }
         switch(cc)
            case 15: ipi = 1;
            case  6:
               ipi = 1;
            default:
               iph = 1;
         endswitch
       case 0xfa:                    { POP }
         switch(cc)
            case 15: ipi = 1;
            case  2: ipi = 1;
            case  1: iph = 1;
            case  0: iph = 1;
         endswitch
       case 0xfd: ipi = 1;           { INC }
       case 0xfe: ipi = 1;           { DEC }

      default:
         if (c15n)
            switch(MDATAI)
               case 0xf3: ip = jr;   { JMPR }
               case 0xf4:            { JMPRC }
                  if (sc)
                     ip = jr;
                  else
                     ipi = 1;
                  endif
               case 0xf5:            { JMPRZ }
                  if (sz)
                     ip = jr;
                  else
                     ipi = 1;
                  endif
               default:
                  switch(ic)         { 割り込み呼び出し分岐 80h }
                     case 15: ipi = 1;
                     case  0: ip = 0x80;
                     default: iph = 1;
                  endswitch
            endswitch
         else
            if (codea.4:7==0xa)
               ipi = 1;
            else
               iph = 1;
            endif
         endif
   endswitch

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    スタックポインタ }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      sp = 0xfff0;   { 初期後のスタックポインタ }
   else
      if (rno==12)   { MOVS }
         sp.0:7  = codeb;
         sp.8:15 = MDATAI;
      else
         if (spi)  sp = sp + 1; endif
         if (spd)  sp = sp - 1; endif
         if (!spi & !spd)  sp = sp; endif
      endif
   endif

   switch(codea)
      case 0x9f:   { RETI }
         if (cc!=0)
            spi = 1;
         endif

      case 0xf7:   { CALL }
         if (cc==3)
            spd = 1;
         else
            if (cc==0) spd = 1; endif
         endif

      case 0xf8:   { RET }
         if (cc==1)
            spi = 1;
         endif

      case 0xf9:   { PUSH }
         switch(cc)
            case 3: spd = 1;
            case 0: spd = 1;
         endswitch

      case 0xfa:   { POP }
         switch(cc)
            case 2: spi = 1;
            case 1: spi = 1;
         endswitch

      default:
         if (c15n)
            if (MDATAI==0xf8)   { RET }
               spi = 1;
            endif

            if (MDATAI==0x9f)   { RETI }
               spi = 1;
            else
               switch(ic)       { 割り込み行程 }
                  case 6: spd = 1;
                  case 3: spd = 1;
                  case 0: spd = 1;
               endswitch
            endif
         endif
   endswitch

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 符読み出し順番 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      cp = 1;
      np = 0;
   else
      if (cc!=0)
         if (cp==1)
            switch(codea.4:7)
               case 4:
                  switch(codea.0:3)
                     case 5:  cp = 2; np = 3;   { MOVX }
                     case 10: cp = 2; np = 3;   { MOVY }
                     case 15: cp = 2; np = 3;   { MOVS }
                     default: cp = 1; np = 1;
                  endswitch
               case 10:                         { MOVI }
                  cp = 2; np = 2;
               case 15:
                  switch(codea.0:3)
                     case 0  : cp = 2; np = 3;  { JMP  }
                     case 1  : cp = 2; np = 3;  { JMPC }
                     case 2  : cp = 2; np = 3;  { JMPZ }
                     case 6  : cp = 2; np = 3;  { MOVJ }
                     case 7  : cp = 2; np = 3;  { CALL }
                     case 9  : cp = 2; np = 3;  { PUSH }
                     case 10 : cp = 2; np = 3;  { POP  }
                     default:  cp = 1; np = 1;
                  endswitch
               default: cp = 1; np = 1;
            endswitch
         else
            switch(cp)
               case 0:
                  cp = 1;
                  np = 1;
               case 2:
                  switch(np)
                     case 1:
                       if (c15n)
                          cp = 1;
                       else
                          cp = cp;
                       endif
                     case 2: 
                        if (c15n)
                           cp = 1;
                        else
                           cp = cp;
                        endif
                     case 3: cp = 3;
                  endswitch
               case 3:
                  if (cc==0)
                     cp = 1;
                  else
                     cp = 4;
                  endif
               case 4:
                  if (cc==0)
                     cp = 1;
                  else
                     cp = cp;
                  endif
            endswitch
         endif
      else
         cp = 1;
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 符読み出し }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      codea = 0;
      codeb = 0;
      codec = 0;
   else
      if (c15n)
         codea = MDATAI;   { 1番目 }
      else
         if (cc!=0)
            switch(cp)
               case 1:
                  codea = codea;
                  codeb = MDATAI;   { 2番目 }
                  codec = codec;
               case 2:
                  codea = codea;
                  codeb = codeb;
                  codec = MDATAI;   { 3番目 }
               default:
                  codea = codea;
                  codeb = codeb;
                  codec = codec;
            endswitch
         endif
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 命令行程数設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      cc = 15;
   else
      if (cc==0)
         cc = 15;
      else
         if (c15n)
               switch(MDATAI)
                  case 0x45: cc = 1;      { MOVX }
                  case 0x4a: cc = 1;      { MOVY }
                  case 0x4f: cc = 1;      { MOVS }
                  case 0xf0: cc = 1;      { JMP }
                  case 0xf1: cc = 1;      { JMPC }
                  case 0xf2: cc = 1;      { JMPZ }
                  case 0xf3: cc = 15;     { JMPR }
                  case 0xf4: cc = 15;     { JMPRC }
                  case 0xf5: cc = 15;     { JMPRZ }
                  case 0xf6: cc = 1;      { MOVJ }
                  case 0xf7: cc = 7;      { CALL }
                  case 0xf8: cc = 1;      { RET }
                  case 0xf9: cc = 6;      { PUSH }
                  case 0xfa: cc = 2;      { POP }
                  case 0xfd: cc = 0;      { INC }
                  case 0xfe: cc = 0;      { DEC }
                  default:
                     switch(MDATAI.4:7)
                        case 0x9:
                           if (MDATAI.0:3==0xf)   { RETI }
                              cc = 2;
                           else
                              cc = cc;
                           endif
                        case 0xa: cc = 0;   { MOVR }
                        case 0xb: cc = 0;   { MOVMR }
                        case 0xc: cc = 2;   { MOVRM }
                        case 0xd: cc = 0;   { MOVPR }
                        case 0xe: cc = 2;   { MOVRP }
                        default: cc = cc;
                     endswitch
               endswitch
         else
            switch(cc)
               case 4:
                  if (cd_push)
                     switch(codeb)
                        case 1:  cc = 0;   { R0 }
                        case 2:  cc = 0;   { R1 }
                        case 3:  cc = 0;   { R2 }
                        case 4:  cc = 0;   { R3 }
                        case 10: cc = 0;   { CF ZF IF }
                        default: cc = cc - 1;
                     endswitch
                  else
                     cc = cc - 1;
                  endif

               case 2:
                  if (cd_pop)
                     switch(MDATAI)
                        case 1:  cc = 0;   { R0 }
                        case 2:  cc = 0;   { R1 }
                        case 3:  cc = 0;   { R2 }
                        case 4:  cc = 0;   { R3}
                        case 10: cc = 0;   { CF ZF IF }
                        default: cc = cc - 1;
                     endswitch
                  else
                     cc = cc - 1;
                  endif

               default: cc = cc - 1;
            endswitch

         endif
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 命令未実行 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (cc==15) c15n = 1; endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ レジスタ選択 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (c15n)   { 早期に選択}
      if (aluop)   { 算術論理演算}
         switch(MDATAI)   { 算術論理演算 除外 }
            case 0x10: rno = 1;  { LDCPR }
            case 0x15: rno = 1;  { LDDPR }
            case 0x1a: rno = 13; { STCPR }
            case 0x1f: rno = 14; { STDPR }

            case 0x20: rno = 1;  { MOVFR }
            case 0x25: rno = 15; { MOVRF }
            case 0x2a: rno = 3;  { INC R2 }
            case 0x2f: rno = 3;  { DEC R2 }

            case 0x30: rno = 1; { ADDC R0,R1 }
            case 0x35: rno = 1; { SUBC R0,R1 }
            case 0x3a: rno = 1; { ROU  R0,R0 }
            case 0x3f: rno = 1; { ROD  R0,R0 }
            case 0x40: rno = 0; { CMP  R0,R1 }
            case 0x45: rno = 0; { MOVX imm16 }
            case 0x4a: rno = 0; { MOVY imm16 }
            case 0x4f: rno = 0; { MOVS imm16 }
            default:   { 算術論理演算}
               switch(MDATAI.2:3)
                  case 0: rno = 1;   { R0 }
                  case 1: rno = 2;   { R1 }
                  case 2: rno = 3;   { R2 }
                  case 3: rno = 4;   { R3 }
               endswitch
         endswitch
      endif

      switch(MDATAI.4:7)   { レジスタ転送}
         case 9:                  { MOVR }
            switch(MDATAI.2:3)
               case 0: rno = 1;   { R0 }
               case 1:
                  if (MDATAI.0:1==1)
                     rno = 1;     { LDIR }
                  else
                     rno = 2;     { R1 }
                  endif
               case 2:
                  if (MDATAI.0:1==2)
                     rno = 11;    { STMR }
                  else
                     rno = 3;     { R2 }
                  endif
               case 3:
                  if (MDATAI.0:1==3)
                  else
                     rno = 4;     { R3 }
                  endif
            endswitch
         case 0:    { 16桁レジスタ転送 }
            switch(MDATAI.0:1)
               case 0: rno = 7;  { MOVRX }
               case 1: rno = 8;  { MOVRY}
               case 2:           { MOVXR }
                  switch(MDATAI.2:3)
                     case 0: rno = 5; { RP0 = IX }
                     case 1: rno = 6; { RP1 = IX }
                  endswitch
               case 3:           { MOVYR }
                  switch(MDATAI.2:3)
                     case 0: rno = 5; { RP0 = IY }
                     case 1: rno = 6; { RP1 = IY }
                  endswitch
            endswitch
      endswitch
   endif

   if (!c15n)                        { 通常の選択}
      switch(codea.4:7)
         case 4:
            switch(codea.0:3)
               case 5:  rno = 7;     { IX }
               case 10: rno = 8;     { IY }
               case 15: rno =12;     { SP }
            endswitch
         case 10:                    { MOVI }
            if (codea.2:3==0)
               switch(codea.0:1)
                  case 0: rno = 1;   { R0 = imm }
                  case 1: rno = 2;   { R1 = imm }
                  case 2: rno = 3;   { R2 = imm }
                  case 3: rno = 4;   { R3 = imm }
               endswitch
            endif

         case 11:                 { MOVMR }
            switch(codea.2:3)
               case 0: rno = 1;   { R0 = m[ir] }
               case 1: rno = 2;   { R1 = m[ir] }
               case 2: rno = 3;   { R2 = m[ir] }
               case 3: rno = 4;   { R3 = m[ir] }
            endswitch

         case 13:                 { MOVPR }
            switch(codea.2:3)
               case 0: rno = 1;   { R0 = p[ir] }
               case 1: rno = 2;   { R1 = p[ir] }
               case 2: rno = 3;   { R2 = p[ir] }
               case 3: rno = 4;   { R3 = p[ir] }
            endswitch

         case 15:
            switch(codea.0:3)
               case 6: rno = 9;   { MOVJ}
               case 10:           { POP }
                  rno = codeb.0:3;
               case 13:           { INC }
                  rno = MDATAI.0:3;
               case 14:           { DEC }
                  rno = MDATAI.0:3;
            endswitch
      endswitch
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 割り込み許可 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (!RESET)
      switch(codea)
         case 0x9f:           { RETI }
            if (cc==0)
               ie = MDATAI.3;
            else
               ie = ie;
            endif
         case 0xfb: ie = 1;   { EI }
         case 0xfc: ie = 0;   { DI }
         default
            if (rno==10)
               ie = MDATAI.3; { POP SR }
            else
               if (it)        { 割り込み呼び出し後割り込み無効 }
                  if (ic==0)
                     ie = 0;
                  else
                     ie = ie;
                  endif
               else
                  ie = ie;
               endif
            endif
      endswitch
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ スタック操作 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   switch(ic)   { 割り込み戻り番地と指標書き込み }
      case 8: bn = 1;
      case 7: sw = 1;
      case 6: bn = 1;
      case 5: bn = 1;
      case 4: sw = 1;
      case 3: bn = 1;
      case 2: bn = 1;
      case 1: sw = 1;
      case 0: bn = 1;
   endswitch

   if (!c15n)
      switch(codea)
         case 0xf7:         { CALL }
            switch(cc)
               case 5: bn = 1; 
               case 4: sw = 1;
               case 3: bn = 1;
               case 2: bn = 1;
               case 1: sw = 1;
               case 0: bn = 1;
            endswitch
         case 0xf8: sr = 1; { RET }
         case 0xf9:         { PUSH }
            switch(cc)
               case 5: bn = 1;
               case 4: sw = 1;
               case 3: bn = 1;
               case 2: bn = 1;
               case 1: sw = 1;
               case 0: bn = 1;
            endswitch
         case 0xfa:         { POP }
            switch(cc)
               case 1: sr = 1;
               case 0: sr = 1;
            endswitch

      endswitch
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ メモリ操作 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (!c15n)
      switch(codea.4:7)
         case 11: mr = 1; { MOVMR }
         case 12:         { MOVRM }
            switch(cc)
               case 0: bn = 1;
               case 1: mw = 1;
               case 2: bn = 1;
            endswitch
      endswitch 
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ ポート操作 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (!c15n)
      switch(codea.4:7)
         case 13: pr = 1; { MOVPR }
         case 14:         { MOVRP }
            switch(cc)
               case 0: bn = 1;
               case 1: pw = 1;
               case 2: bn = 1;
            endswitch
      endswitch 
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    符読み取り                                           }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      cr = 0;
   else
      if (sw | sr | mr | mw | pr | pw | bn)
         cr = 0;
      else
         cr = 1;
      endif
   endif


{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 算術論理演算 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   switch(MDATAI)
      case 0x30:                           { ADDC }
         alu0i.0:7 = r0p.0:7;
         alu1i.0:7 = r0p.8:15;
      case 0x35:                           { SUBC }
         alu0i.0:7 = r0p.0:7;
         alu1i.0:7 = r0p.8:15;
      case 0x3a:                           { ROU }
         alu0i.0:7 = r0p.0:7;
         alu1i.0:7 = r0p.0:7;
      case 0x3f:                           { ROD }
         alu0i.0:7 = r0p.0:7;
         alu1i.0:7 = r0p.0:7;
      case 0x40:                           { CMP }
         alu0i.0:7 = r0p.0:7;
         alu1i.0:7 = r0p.8:15;

      default:
         switch(MDATAI.2:3)                { 第一引数と代入先 }
            case 0: alu0i.0:7 = r0p.0:7;   { R0 }
            case 1: alu0i.0:7 = r0p.8:15;  { R1 }
            case 2: alu0i.0:7 = r1p.0:7;   { R2 }
            case 3: alu0i.0:7 = r1p.8:15;  { R3 }
         endswitch

         switch(MDATAI.0:1)                { 第二引数 }
            case 0: alu1i.0:7 = r0p.0:7;   { R0 }
            case 1: alu1i.0:7 = r0p.8:15;  { R1 }
            case 2: alu1i.0:7 = r1p.0:7;   { R2 }
            case 3: alu1i.0:7 = r1p.8:15;  { R3 }
         endswitch
   endswitch

   if (sc) alu2i.0 = 1; endif

   switch(MDATAI.4:7)                { 演算 }
      case 1:                        { 加算 }
         switch(MDATAI.0:3)
            case 0:  aluout=1;       { LDCPR }
            case 5:  aluout=1;       { LDDPR }
            case 10: aluout=1;       { STCPR }
            case 15: aluout=1;       { STDPR }
            default:
                aluo = alu0i + alu1i;
         endswitch
      case 2:                       { 減算 }
         switch(MDATAI.0:3)
            case 0:  aluout=1;      { MOVFR }
            case 5:  aluout=1;      { MOVRF }
            case 10: aluout=1;      { INC R2 }
            case 15: aluout=1;      { DEC R2 }
            default:
               aluo = alu0i - alu1i;
         endswitch
      case 3:
         switch(MDATAI.0:3)
            case 0:                  { 桁上げ加算 }
               aluo = alu0i + alu1i + alu2i;
            case 5:                  { 桁上げ減算 }
               aluo = alu0i - alu1i - alu2i;
            case 10:                 { 桁上げ上回転 }
               aluo.1:8 = alu1i.0:7;
               aluo.0   = sc;
            case 15:                 { 桁上げ下回転 }
               aluo.0:6 = alu1i.1:7;
               aluo.7   = sc;
               aluo.8   = alu1i.0;
            default:                 { 論理積 }
                aluo = alu0i & alu1i;
         endswitch
      case 4:
         switch(MDATAI.0:3)
            case 0:  aluo = alu0i - alu1i; { CMP }
            case 5:  aluout=1;             { MOVIX }
            case 10: aluout=1;             { MOVIY }
            case 15: aluout=1;             { MOVIS }
            default: aluout=1;             { 論理和 }
               aluo = alu0i | alu1i;
         endswitch

      case 5: aluo = alu0i ^ alu1i;  { 排他的論理和 }
      case 6: aluo = !alu1i;         { 論理否定 }
      case 7: aluo.1:8 = alu1i.0:7;  { 上位桁移動 }
      case 8: aluo.0:6 = alu1i.1:7;  { 下位桁移動 }
              aluo.8 = aluo.0;
      from:                          { 演算実行指標 }
         if (c15n&!it) aluop = 1; endif
   endswitch

   if (!RESET)               { 演算指標 }
      if (c15n)
         if (aluop&!aluout)
            sc = aluo.8;
         else
            sc = sc;
         endif
      else
         if (codea==0x9f)   { RETI }
            if (cc==0)
               sc = MDATAI.7;
            else
               sc = sc;
            endif
         endif

         if (rno==10)        { POP SR }
            sc = MDATAI.7;
         else
            sc = sc;
         endif
      endif
   endif

   if (!RESET)               { 零指標 }
      if (c15n)
         if (aluop&!aluout)
            if (aluo.0:7==0)
               sz = 1;
            else
               sz = 0;
            endif
         else
            sz = sz;
         endif
      else
         if (codea==0x9f)   { RETI }
            if (cc==0)
               sz = MDATAI.6;
            else
               sz = sz;
            endif
         endif

         if (rno==10)        { POP SR }
            sz = MDATAI.6;
         else
            sz = sz;
         endif
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ R0 レジスタ設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (!RESET)
   if (rno==1)
      if (aluop)                         { 算術論理演算 }
         switch(MDATAI)
            case 0x10: r0p.0:7=cpr;
            case 0x15: r0p.0:7=dpr;
            case 0x20:
               switch(r1p.0:7)
                  case 0: r0p.0:7=rf0;
                  case 1: r0p.0:7=rf1;
                  case 2: r0p.0:7=rf2;
                  case 3: r0p.0:7=rf3;
                  case 4: r0p.0:7=rf4;
                  case 5: r0p.0:7=rf5;
                  case 6: r0p.0:7=rf6;
                  case 7: r0p.0:7=rf7;
               endswitch
            case 0x40: r0p.0:7=r0p.0:7;
            default:   r0p.0:7=aluo.0:7;
         endswitch
      endif

      switch(MDATAI.4:7)
         case 9:                         { MOVR }
            switch(MDATAI.0:1)
               case 0:                   { LDSR }
                  r0p.3 = ie;
                  r0p.6 = sz;
                  r0p.7 = sc;
               case 1:
                  if (MDATAI.2:3==1)
                     r0p.0:7 = INT;      { LDIR }
                  else
                     r0p.0:7 = r0p.8:15;
                  endif
               case 2: r0p.0:7 = r1p.0:7;
               case 3: r0p.0:7 = r1p.8:15;
            endswitch
         case 13:                        { MOVPR }
            r0p.0:7 = MDATAI;
     endswitch

      switch(codea.4:7)
         case 10:                        { MOVI }
            r0p.0:7 = MDATAI;
         case 11:                        { MOVMR }
            r0p.0:7 = MDATAI;
         case 13:                        { MOVPR }
            r0p.0:7 = MDATAI;
         case 15:
            switch(codea.0:3)
               case 0xa:
                  r0p.0:7 = MDATAI;      { POP }
               case 0xd:
                  r0p.0:7 = r0p.0:7 + 1; { INC }
               case 0xe:
                  r0p.0:7 = r0p.0:7 - 1; { DEC }
            endswitch
       endswitch
   else
      if (rno==5)
         switch(MDATAI.4:7)
            case 0:
               switch(MDATAI.0:1)
                  case 2: r0p.0:7 = ix.0:7;    { MOVXR }
                  case 3: r0p.0:7 = iy.0:7;    { MOVYR }
               endswitch
            case 15:                           { INC/DEC/POP RP0 }
               { RP0 レジスタ設定 }
         endswitch
      else
         r0p.0:7 = r0p.0:7;
      endif
   endif
endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ R1 レジスタ設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (!RESET)
   if (rno==2)
      if (aluop)   { 算術論理演算 }
         if (MDATAI==0x40)
            r0p.8:15=r0p.8:15;
         else
            r0p.8:15 = aluo.0:7;
         endif
      endif

      switch(MDATAI.4:7)
         case 9:                          { MOVR }
            switch(MDATAI.0:1)
               case 0: r0p.8:15 = r0p.0:7;
               case 1: r0p.8:15 = r0p.8:15;
               case 2: r0p.8:15 = r1p.0:7;
               case 3: r0p.8:15 = r1p.8:15;
            endswitch
         case 13:                         { MOVPR}
            r0p.8:15 = MDATAI;
      endswitch

      switch(codea.4:7)
         case 10:                         { MOVI }
            r0p.8:15 = MDATAI;
         case 11:                         { MOVMR}
            r0p.8:15 = MDATAI;
         case 13:                         { MOVPR }
            r0p.8:15 = MDATAI;
         case 15:
            switch(codea.0:3)
               case 0xa:
                  r0p.8:15 = MDATAI;       { POP }
               case 0xd:
                  r0p.8:15 = r0p.8:15 + 1; { INC }
               case 0xe:
                  r0p.8:15 = r0p.8:15 - 1; { DEC }
            endswitch
      endswitch
   else
      if (rno==5)
         switch(MDATAI.4:7)
            case 0:
               switch(MDATAI.0:1)
                  case 2: r0p.8:15 = ix.8:15;   { MOVXR }
                  case 3: r0p.8:15 = iy.8:15;   { MOVYR }
               endswitch
            case 15:                            { INC/DEC/POP RP0 }
               { RP0 レジスタ設定 }
         endswitch
      else
         r0p.8:15 = r0p.8:15;
      endif
   endif
endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ R2 レジスタ設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (!RESET)
   if (rno==3)
      if (aluop)   { 算術論理演算 }
         switch(MDATAI)
            case 0x20: r1p.0:7=r1p.0:7;
            case 0x25: r1p.0:7=r1p.0:7;
            case 0x2a: r1p.0:7=r1p.0:7+1;
            case 0x2f: r1p.0:7=r1p.0:7-1;
            case 0x40: r1p.0:7=r1p.0:7;
            default:   r1p.0:7 = aluo.0:7;
         endswitch
      endif

      switch(MDATAI.4:7)
         case 9:                         { MOVR }
            switch(MDATAI.0:1)
               case 0: r1p.0:7 = r0p.0:7;
               case 1: r1p.0:7 = r0p.8:15;
               case 2:                   { STMR }
               case 3: r1p.0:7 = r1p.8:15;
            endswitch
         case 13:                        { MOVPR }
            r1p.0:7 = MDATAI;
      endswitch

      switch(codea.4:7)
         case 10:                        { MOVI }
            r1p.0:7 = MDATAI;
         case 11:                        { MOVMR }
            r1p.0:7 = MDATAI;
         case 13:                        { MOVPR }
            r1p.0:7 = MDATAI;
         case 15:
            switch(codea.0:3)
               case 0xa:
                  r1p.0:7 = MDATAI;      { POP }
               case 0xd:
                  r1p.0:7 = r1p.0:7 + 1; { INC }
               case 0xe:
                  r1p.0:7 = r1p.0:7 - 1; { DEC }
            endswitch
      endswitch
   else
      if (rno==6)
         switch(MDATAI.4:7)
            case 0:
               switch(MDATAI.0:1)
                  case 2: r1p.0:7 = ix.0:7;    { MOVXR }
                  case 3: r1p.0:7 = iy.0:7;    { MOVYR }
               endswitch
            case 15:                           { INC/DEC/POP RP1 }
               { RP1 レジスタ設定 }
         endswitch
      else
         r1p.0:7 = r1p.0:7;
      endif
   endif
endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ R3 レジスタ設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (!RESET)
   if (rno==4)
      if (aluop)   { 算術論理演算 }
         if (MDATAI==0x40)
            r1p.0:7=r1p.0:7;
         else
            r1p.0:7 = aluo.0:7;
         endif
      endif

      switch(MDATAI.4:7)
         case 9:                          { MOVR }
            switch(MDATAI.0:1)
               case 0: r1p.8:15 = r0p.0:7;
               case 1: r1p.8:15 = r0p.8:15;
               case 2: r1p.8:15 = r1p.0:7;
               case 3:                    { RETI }
            endswitch
         case 13:                         { MOVPR}
            r1p.8:15 = MDATAI;
      endswitch

      switch(codea.4:7)
         case 10:                         { MOVI}
            r1p.8:15 = MDATAI;
         case 11:                         { MOVMR }
            r1p.8:15 = MDATAI;
         case 13:                         { MOVPR }
            r1p.8:15 = MDATAI;
         case 15:
            switch(codea.0:3)
               case 0xa:
                  r1p.8:15 = MDATAI;       { POP }
               case 0xd:
                  r1p.8:15 = r1p.8:15 + 1; { INC }
               case 0xe:
                  r1p.8:15 = r1p.8:15 - 1; { DEC }
            endswitch
      endswitch
   else
      if (rno==6)
         switch(MDATAI.4:7)
            case 0:
               switch(MDATAI.0:1)
                  case 2: r1p.8:15 = ix.8:15;   { MOVXR }
                  case 3: r1p.8:15 = iy.8:15;   { MOVYR }
               endswitch
            case 15:                            { INC/DEC/POP RP1 }
               { RP1 レジスタ設定 }
         endswitch
      else
         r1p.8:15 = r1p.8:15;
      endif
   endif
endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ RP0 レジスタ設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (!RESET)
   if (rno==5)
      switch(codea)
         case 0xfa:   { POP }
            if (cc==1)
               r0p.8:15 = MDATAI;
            else
               r0p.8:15 = r0p.8:15;
            endif

            if (cc==0)
               r0p.0:7 = MDATAI;
            else
               r0p.0:7 = r0p.0:7;
            endif
         case 0xfd:   { INC }
            r0p = r0p + 1;
         case 0xfe:   { DEC }
            r0p = r0p - 1;
      endswitch
   endif
endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ RP1 レジスタ設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (!RESET)
   if (rno==6)
      switch(codea)
         case 0xfa:   { POP }
            if (cc==1)
               r1p.8:15 = MDATAI;
            else
               r1p.8:15 = r1p.8:15;
            endif

            if (cc==0)
               r1p.0:7 = MDATAI;
            else
               r1p.0:7 = r1p.0:7;
            endif
         case 0xfd:   { INC }
            r1p = r1p + 1;
         case 0xfe:   { DEC }
            r1p = r1p - 1;
      endswitch
   endif
endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ IX レジスタ設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (!RESET)
   if (rno==7)                { MOVRX }

      if (codea==0x45)        { MOVX }
         ix.0:7  = codeb;
         ix.8:15 = MDATAI;
      endif

      if (codea.4:7==0)
         switch(codea.2:3)
            case 0: ix = r0p;
            case 1: ix = r1p;
         endswitch
      endif

      if (codea.4:7==15)
         switch(codea.0:3)
            case 0xa:                 { POP }
               if (cc==1)
                  ix.8:15 = MDATAI;
               else
                  ix.8:15 = ix.8:15;
               endif

               if (cc==0)
                  ix.0:7 = MDATAI;
               else
                  ix.0:7 = ix.0:7;
               endif
            case 0xd:
               ix = ix + 1;           { INC }
            case 0xe:
               ix = ix - 1;           { DEC }
         endswitch
      endif
   else
      ix = ix;
   endif
endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ IY レジスタ設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (!RESET)
   if (rno==8)                { MOVRY }

      if (codea==0x4a)        { MOVY }
         iy.0:7  = codeb;
         iy.8:15 = MDATAI;
      endif

      if (codea.4:7==0)
         switch(codea.2:3)
            case 0: iy = r0p;
            case 1: iy = r1p;
         endswitch
      endif

      if (codea.4:7==15)
         switch(codea.0:3)
            case 0xa:                 { POP }
               if (cc==1)
                  iy.8:15 = MDATAI;
               else
                  iy.8:15 = iy.8:15;
               endif

               if (cc==0)
                  iy.0:7 = MDATAI;
               else
                  iy.0:7 = iy.0:7;
               endif
            case 0xd:
               iy = iy + 1;           { INC }
            case 0xe:
               iy = iy - 1;           { DEC }
         endswitch
      endif
   else
      iy = iy;
   endif
endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ JR レジスタ設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
if (!RESET)
   if (rno==9)
      switch(codea)
         case 0xf6:               { MOVJ }
            jr.0:7  = codeb;
            jr.8:15 = MDATAI;
         case 0xfa:               { POP }
            if (cc==1)
               jr.8:15 = MDATAI;
            else
               jr.8:15 = jr.8:15;
            endif

            if (cc==0)
               jr.0:7 = MDATAI;
            else
               jr.0:7 = jr.0:7;
            endif

         case 0xfd:               { INC }
            jr = jr + 1;
         case 0xfe:               { DEC }
            jr = jr - 1;
      endswitch
   else
      jr = jr;
   endif
endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ MR 割り込み無効レジスタ 設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      intm = 0x7f;
   else
      if (rno==11)
         intm = r0p.0:7;
      else
         intm = intm;
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ CPR コード頁レジスタ 設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      cpr = 0;
   else
      if (rno==13)
         cpr = r0p.0:7;
      else
         cpr = cpr;
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ DPR データ頁レジスタ 設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      dpr = 0;
   else
      if (rno==14)
         dpr = r0p.0:7;
      else
         dpr = dpr;
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ RF0～RF7 レジスタファイル 設定 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (RESET)
      rf0=0; rf1=0; rf2=0; rf3=0;
      rf4=0; rf5=0; rf6=0; rf7=0;
   else
      if (rno==15)
         if (r1p.0:7==0) rf0=r0p.0:7; else rf0=rf0; endif
         if (r1p.0:7==1) rf1=r0p.0:7; else rf1=rf1; endif
         if (r1p.0:7==2) rf2=r0p.0:7; else rf2=rf2; endif
         if (r1p.0:7==3) rf3=r0p.0:7; else rf3=rf3; endif
         if (r1p.0:7==4) rf4=r0p.0:7; else rf4=rf4; endif
         if (r1p.0:7==5) rf5=r0p.0:7; else rf5=rf5; endif
         if (r1p.0:7==6) rf6=r0p.0:7; else rf6=rf6; endif
         if (r1p.0:7==7) rf7=r0p.0:7; else rf7=rf7; endif
      else
         rf0=rf0; rf1=rf1; rf2=rf2; rf3=rf3;
         rf4=rf4; rf5=rf5; rf6=rf6; rf7=rf7;
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ メモリ制御 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (sw) MWE = 1; endif
   if (mw) MWE = 1; endif

   if (sr) MRE = 1; endif
   if (mr) MRE = 1; endif

   if (cr) MRE = 1; endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ ポート制御 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   PWE = pw;
   PRE = pr;

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 命令類別 }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   switch(codea)
      case 0x45: cd_movx = 1; { MOVX }
      case 0x4a: cd_movy = 1; { MOVY }
      case 0x4f: cd_movs = 1; { MOVS }
      case 0x9f: cd_reti = 1; { RETI }
      case 0xf0: cd_jmp =1;   { JMP }
      case 0xf1: cd_jmpc=1;   { JMPC }
      case 0xf2: cd_jmpz=1;   { JMPZ }
      case 0xf6: cd_movj=1;   { MOVJ }
      case 0xf7: cd_call=1;   { CALL }
      case 0xf8: cd_ret=1;
      case 0xf9: cd_push=1;   { PUSH }
      case 0xfa: cd_pop =1;   { POP }
      case 0xfd: cd_inc =1;   { INC }
      case 0xfe: cd_dec =1;   { DEC }
   endswitch

   switch(codea.4:7)
      case 0xa: cd_movi  = 1;   { MOVI }
      case 0xb: cd_movmr = 1;   { MOVMR }
      case 0xc: cd_movrm = 1;   { MOVRM }
      case 0xd: cd_movpr = 1;   { MOVPR }
      case 0xe: cd_movrp = 1;   { MOVRP }
   endswitch

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 番地   }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (c15n)
      if (ic==15)
         ADDRESS = ip;
      else
         ADDRESS = sp;
      endif
   else
      if (cd_reti)                  { RETI }
         ADDRESS = sp;
      endif

      if (cd_movi)                  { MOVI }
         if (cc==0) ADDRESS = ip; endif
      endif

      { MOVMR }
      { MOVRM }
      { MOVPR }
      { MOVRP }
      if (cd_movmr | cd_movrm | cd_movpr | cd_movrp)
         switch(codea.0)
            case 0: ADDRESS = ix;   { IX }
            case 1: ADDRESS = iy;   { IY }
         endswitch
      endif

      if (cd_call)                  { CALL }
         switch(cc)
            case 7: ADDRESS = ip;
            case 6: ADDRESS = ip;
            case 5: ADDRESS = sp;
            case 4: ADDRESS = sp;
            case 3: ADDRESS = sp;
            case 2: ADDRESS = sp;
            case 1: ADDRESS = sp;
            case 0: ADDRESS = sp;
         endswitch
      endif

      if (cd_ret)
         switch(cc)
            case 1: ADDRESS = sp;
            case 0: ADDRESS = sp;
         endswitch
      endif

      { JMP }
      { JMPC }
      { JMPZ }
      { MOVJ }
      { MOVX MOVY MOVS }
      if (cd_jmp|cd_jmpc|cd_jmpz|cd_movj|cd_movx|cd_movy|cd_movs)
         switch(cc)
            case 1: ADDRESS = ip;
            case 0: ADDRESS = ip;
         endswitch
      endif

      if (cd_push)                  { PUSH }
         switch(cc)
            case 6: ADDRESS = ip;
            case 5: ADDRESS = sp;
            case 4: ADDRESS = sp;
            case 3: ADDRESS = sp;
            case 2: ADDRESS = sp;
            case 1: ADDRESS = sp;
            case 0: ADDRESS = sp;
         endswitch
      endif

      if (cd_pop)                  { POP }
         switch(cc)
            case 2: ADDRESS = ip;
            case 1: ADDRESS = sp;
            case 0: ADDRESS = sp;
         endswitch
      endif

      if (cd_inc) ADDRESS = ip; endif   { INC }
      if (cd_dec) ADDRESS = ip; endif   { DEC }

   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 頁番地   }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (c15n)
      PADDRESS=codepage;
   else
      { MOVMR }
      { MOVRM }
      if (cd_movmr | cd_movrm)
         PADDRESS=dpr;
      endif
   endif

   if (RESET)
      codepage=0;
   else
      if (it)
         icodepage=codepage;
         codepage=0;
      else
         if (cd_reti)
            codepage=icodepage;
         else
            if (cd_jmp|cd_jmpc|cd_jmpz|cd_ret)
               codepage=cpr;
            else
               codepage=codepage;
            endif
         endif
      endif
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{ 出力データ }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (cd_call)   { 命令ポインタ一時記憶 }
      if (cc==5)
         ipr = ip;
      else
         ipr = ipr;
      endif
   else
      ipr = ipr;
   endif

   switch(ic)   { 割り込み戻り番地、指標 書き込み }
      case 8: MDATAO = ip.0:7;
      case 7: MDATAO = ip.0:7;
      case 6: MDATAO = ip.0:7;
      case 5: MDATAO = ip.8:15;
      case 4: MDATAO = ip.8:15;
      case 3: MDATAO = ip.8:15;
      case 2: MDATAO.7 = sc;
              MDATAO.6 = sz;
              MDATAO.3 = ie;
      case 1: MDATAO.7 = sc;
              MDATAO.6 = sz;
              MDATAO.3 = ie;
      case 0: MDATAO.7 = sc;
              MDATAO.6 = sz;
              MDATAO.3 = ie;
   endswitch 

   switch(codea.4:7)
      case 0xc:   { MOVRM }
         switch(codea.2:3)
            case 0: MDATAO = r0p.0:7;   { R0 }
            case 1: MDATAO = r0p.8:15;  { R1 }
            case 2: MDATAO = r1p.0:7;   { R2 }
            case 3: MDATAO = r1p.8:15;  { R3 }
         endswitch

      case 0xe:   { MOVRP }
         switch(codea.2:3)
            case 0: MDATAO = r0p.0:7;   { R0 }
            case 1: MDATAO = r0p.8:15;  { R1 }
            case 2: MDATAO = r1p.0:7;   { R2 }
            case 3: MDATAO = r1p.8:15;  { R3 }
         endswitch
   endswitch

   switch(codea)
      case 0xf7:   { CALL }
         switch(cc)
            case 5: MDATAO = ipr.0:7;   { 戻り命令ポインタ 下8桁 }
            case 4: MDATAO = ipr.0:7;
            case 3: MDATAO = ipr.0:7;
            case 2: MDATAO = ipr.8:15;  { 戻り命令ポインタ 上8桁 }
            case 1: MDATAO = ipr.8:15;
            case 0: MDATAO = ipr.8:15;
         endswitch

      case 0xf9:   { PUSH }
         switch(codeb)
            case 1:             { R0 }
               switch(cc)
                  case 5: MDATAO = r0p.0:7;
                  case 4: MDATAO = r0p.0:7;
                  case 0: MDATAO = r0p.0:7;
               endswitch
            case 2:             { R1 }
               switch(cc)
                  case 5: MDATAO = r0p.8:15;
                  case 4: MDATAO = r0p.8:15;
                  case 0: MDATAO = r0p.8:15;
               endswitch
            case 3:             { R2 }
               switch(cc)
                  case 5: MDATAO = r1p.0:7;
                  case 4: MDATAO = r1p.0:7;
                  case 0: MDATAO = r1p.0:7;
               endswitch
            case 4:             { R3 }
               switch(cc)
                  case 5: MDATAO = r1p.8:15;
                  case 4: MDATAO = r1p.8:15;
                  case 0: MDATAO = r1p.8:15;
               endswitch
            case 5:             { RP0 }
               switch(cc)
                  case 5: MDATAO = r0p.0:7;
                  case 4: MDATAO = r0p.0:7;
                  case 3: MDATAO = r0p.0:7;
                  case 2: MDATAO = r0p.8:15;
                  case 1: MDATAO = r0p.8:15;
                  case 0: MDATAO = r0p.8:15;
               endswitch
            case 6:             { RP1 }
               switch(cc)
                  case 5: MDATAO = r1p.0:7;
                  case 4: MDATAO = r1p.0:7;
                  case 3: MDATAO = r1p.0:7;
                  case 2: MDATAO = r1p.8:15;
                  case 1: MDATAO = r1p.8:15;
                  case 0: MDATAO = r1p.8:15;
               endswitch
            case 7:             { IX }
               switch(cc)
                  case 5: MDATAO = ix.0:7;
                  case 4: MDATAO = ix.0:7;
                  case 3: MDATAO = ix.0:7;
                  case 2: MDATAO = ix.8:15;
                  case 1: MDATAO = ix.8:15;
                  case 0: MDATAO = ix.8:15;
               endswitch
            case 8:             { IY }
               switch(cc)
                  case 5: MDATAO = iy.0:7;
                  case 4: MDATAO = iy.0:7;
                  case 3: MDATAO = iy.0:7;
                  case 2: MDATAO = iy.8:15;
                  case 1: MDATAO = iy.8:15;
                  case 0: MDATAO = iy.8:15;
               endswitch
            case 9:             { JR }
               switch(cc)
                  case 5: MDATAO = jr.0:7;
                  case 4: MDATAO = jr.0:7;
                  case 3: MDATAO = jr.0:7;
                  case 2: MDATAO = jr.8:15;
                  case 1: MDATAO = jr.8:15;
                  case 0: MDATAO = jr.8:15;
               endswitch
            case 10:
               MDATAO.7 = sc;   { CF }
               MDATAO.6 = sz;   { ZF }
               MDATAO.3 = ie;   { IF }
         endswitch
   endswitch

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{                                                         }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   T0P = MDATAO;      { メモリデータ出力 }
   T1P = codea;       { 1番目符 }
   T2P = codeb;       { 2番目符 }
   T3P = codec;       { 3番目符 }
   T4P = sp;          { SP }
   T5P = rno;         { レジスタ選択 }
   T6P = it;
   T7P = cc;          { 命令行程数 }
   T8P = cp;          { 符順番 }
   T9P = ip;          { IP }
   T10P = r0p.0:7;    { R0 }
   T11P = r0p.8:15;   { R1 }
   T12P = r1p.0:7;    { R2 }
   T13P = r1p.8:15;   { R3 }
   T14P = ix;         { IX }
   T15P = iy;         { IY }
   T16P = jr;         { JR }
   T17P = sc;         { SR C }
   T18P = sz;         { SR Z }
   T19P = ie;         { SR I }
   T20P = ic;         { 割り込み行程 }
   T21P = intm;       { 割り込み無効指定 }
   T22P = buscnt;     { データバス方向制御 }
   T23P = cpr;        { コード頁レジスタ }
   T24P = dpr;        { データ頁レジスタ }
   T25P = rf0;        { レジスタファイル 0 }
   T26P = rf1;        { レジスタファイル 1 }
   T27P = rf2;        { レジスタファイル 2 }
   T28P = rf3;        { レジスタファイル 3 }
   T29P = rf4;        { レジスタファイル 4 }
   T30P = rf5;        { レジスタファイル 5 }
   T31P = rf6;        { レジスタファイル 6 }
   T32P = rf7;        { レジスタファイル 7 }
ende

{ ------------------------------------------------------- }
{    機能実行譜                                           }
{ ------------------------------------------------------- }
entity sim
output RESET;
output MDATA[8];
output ADDRESS[16];
output MRE;
output MWE;
output PRE;
output PWE;
output INT[8];
output PADDRESS[8];

output T0P[8];
output T1P[8];
output T2P[8];
output T3P[8];
output T4P[16];
output T5P[4];
output T6P;
output T7P[4];
output T8P[4];
output T9P[16];
output T10P[8];
output T11P[8];
output T12P[8];
output T13P[8];
output T14P[16];
output T15P[16];
output T16P[16];
output T17P;
output T18P;
output T19P;
output T20P[4];
output T21P[8];
output T22P;
output T23P[8];
output T24P[8];
output T25P[8];
output T26P[8];
output T27P[8];
output T28P[8];
output T29P[8];
output T30P[8];
output T31P[8];
output T32P[8];
input  simres;

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    内部信号  }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
bitr   tc[16];
bitn   address[16];   { ① アドレスバス }
bitn   data[8];       { ② データバス }
bitn   mwe;
bitn   mre;
bitn   paddress[8];   { 頁番地 }
bitr   stack00[8];
bitr   stack01[8];
bitr   stack02[8];
bitr   stack03[8];
bitr   dmem10[8];  { BR0 }
bitr   dmem11[8];  { BR1 }
bitr   dmem12[8];  { BR2 }
bitr   dmem13[8];  { BR3 }
bitr   dmem14[8];  { BR4 }
bitr   dmem15[8];  { BR5 }
bitr   dmem16[8];  { BR6 }
bitr   dmem17[8];  { BR7 }
bitr   dmem18[8];  { BR8 }
bitr   dmem19[8];  { BR9 }
bitr   dmem1a[8];  { BR10 }
bitr   dmem1b[8];  { BR11 }
bitr   dmem1c[8];  { BR12 }
bitr   dmem1d[8];  { BR13 }
bitr   dmem1e[8];  { BR14 }
bitr   dmem1f[8];  { BR15 }
bitr   dmem20[8];  { DR0L }
bitr   dmem21[8];  { DR0H }
bitr   dmem22[8];  { DR1L }
bitr   dmem23[8];  { DR1H }
bitr   dmem24[8];  { DR2L }
bitr   dmem25[8];  { DR2H }
bitr   dmem26[8];  { DR3L }
bitr   dmem27[8];  { DR3H }
bitr   dmem28[8];  { DR4L }
bitr   dmem29[8];  { DR4H }
bitr   dmem2a[8];  { DR5L }
bitr   dmem2b[8];  { DR5H }
bitr   dmem2c[8];  { DR6L }
bitr   dmem2d[8];  { DR6H }
bitr   dmem2e[8];  { DR7L }
bitr   dmem2f[8];  { DR7H }

bitn   t0p[8];

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    実行譜導入  }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   part main(RESET,MDATA,address,mre,mwe,PRE,PWE,INT,paddress,
             t0p,T1P,T2P,T3P,T4P,T5P,T6P,T7P,T8P,T9P,
             T10P,T11P,T12P,T13P,T14P,T15P,T16P,T17P,T18P,T19P
             T20P,T21P,T22P,T23P,T24P,
             T25P,T26P,T27P,T28P,T29P,T30P,T31P,T32P)

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    プログラム導入  }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   { プログラムを配置します。 }
   { ↓ }              {①      ② }
   preparation codegen(address,data,sample)
                                   { ↑ }
                                   { sample.hex }
                                   { プログラム }

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   {simres = 0;}   { LSIM 以外の検証では注釈にします。 }

   if (!simres) tc=tc+1; endif

   if (tc<10) RESET=1; endif

   PADDRESS=paddress;
   ADDRESS=address;
   MDATA=data;
   MWE=mwe;
   MRE=mre;
   T0P=t0p;

   { if (tc==10) INT.0 = 1; endif } { 割り込み要求 }
   { if (tc==25) INT.0 = 1; endif }

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    メモリ読み出し   }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (mre)
      switch(address)
         case 0x10  : MDATA=dmem10;
         case 0x11  : MDATA=dmem11;
         case 0x12  : MDATA=dmem12;
         case 0x13  : MDATA=dmem13;
         case 0x14  : MDATA=dmem14;
         case 0x15  : MDATA=dmem15;
         case 0x16  : MDATA=dmem16;
         case 0x17  : MDATA=dmem17;
         case 0x18  : MDATA=dmem18;
         case 0x19  : MDATA=dmem19;
         case 0x1a  : MDATA=dmem1a;
         case 0x1b  : MDATA=dmem1b;
         case 0x1c  : MDATA=dmem1c;
         case 0x1d  : MDATA=dmem1d;
         case 0x1e  : MDATA=dmem1e;
         case 0x1f  : MDATA=dmem1f;
         case 0x20  : MDATA=dmem20;
         case 0x21  : MDATA=dmem21;
         case 0x22  : MDATA=dmem22;
         case 0x23  : MDATA=dmem23;
         case 0x24  : MDATA=dmem24;
         case 0x25  : MDATA=dmem25;
         case 0x26  : MDATA=dmem26;
         case 0x27  : MDATA=dmem27;
         case 0x28  : MDATA=dmem28;
         case 0x29  : MDATA=dmem29;
         case 0x2a  : MDATA=dmem2a;
         case 0x2b  : MDATA=dmem2b;
         case 0x2c  : MDATA=dmem2c;
         case 0x2d  : MDATA=dmem2d;
         case 0x2e  : MDATA=dmem2e;
         case 0x2f  : MDATA=dmem2f;

         case 0xfff0: MDATA=stack00;
         case 0xffef: MDATA=stack01;
         case 0xffee: MDATA=stack02;
         case 0xffed: MDATA=stack03;
         default:     MDATA=data;
      endswitch
   else
      MDATA=data;
   endif

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{    メモリ書き込み   }
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   if (mwe)
      if (address==0x10) dmem10=t0p; else dmem10=dmem10; endif
      if (address==0x11) dmem11=t0p; else dmem11=dmem11; endif
      if (address==0x12) dmem12=t0p; else dmem12=dmem12; endif
      if (address==0x13) dmem13=t0p; else dmem13=dmem13; endif
      if (address==0x14) dmem14=t0p; else dmem14=dmem14; endif
      if (address==0x15) dmem15=t0p; else dmem15=dmem15; endif
      if (address==0x16) dmem16=t0p; else dmem16=dmem16; endif
      if (address==0x17) dmem17=t0p; else dmem17=dmem17; endif
      if (address==0x18) dmem18=t0p; else dmem18=dmem18; endif
      if (address==0x19) dmem19=t0p; else dmem19=dmem19; endif
      if (address==0x1a) dmem1a=t0p; else dmem1a=dmem1a; endif
      if (address==0x1b) dmem1b=t0p; else dmem1b=dmem1b; endif
      if (address==0x1c) dmem1c=t0p; else dmem1c=dmem1c; endif
      if (address==0x1d) dmem1d=t0p; else dmem1d=dmem1d; endif
      if (address==0x1e) dmem1e=t0p; else dmem1e=dmem1e; endif
      if (address==0x1f) dmem1f=t0p; else dmem1f=dmem1f; endif
      if (address==0x20) dmem20=t0p; else dmem20=dmem20; endif
      if (address==0x21) dmem21=t0p; else dmem21=dmem21; endif
      if (address==0x22) dmem22=t0p; else dmem22=dmem22; endif
      if (address==0x23) dmem23=t0p; else dmem23=dmem23; endif
      if (address==0x24) dmem24=t0p; else dmem24=dmem24; endif
      if (address==0x25) dmem25=t0p; else dmem25=dmem25; endif
      if (address==0x26) dmem26=t0p; else dmem26=dmem26; endif
      if (address==0x27) dmem25=t0p; else dmem27=dmem27; endif
      if (address==0x28) dmem28=t0p; else dmem28=dmem28; endif
      if (address==0x29) dmem29=t0p; else dmem29=dmem29; endif
      if (address==0x2a) dmem2a=t0p; else dmem2a=dmem2a; endif
      if (address==0x2b) dmem2b=t0p; else dmem2b=dmem2b; endif
      if (address==0x2c) dmem2c=t0p; else dmem2c=dmem2c; endif
      if (address==0x2d) dmem2d=t0p; else dmem2d=dmem2d; endif
      if (address==0x2e) dmem2e=t0p; else dmem2e=dmem2e; endif
      if (address==0x2f) dmem2f=t0p; else dmem2f=dmem2f; endif

      if (address==0xfff0) stack00=t0p; else stack00=stack00; endif
      if (address==0xffef) stack01=t0p; else stack01=stack01; endif
      if (address==0xffee) stack02=t0p; else stack02=stack02; endif
      if (address==0xffed) stack03=t0p; else stack03=stack03; endif
   else
      dmem10=dmem10;
      dmem11=dmem11;
      dmem12=dmem12;
      dmem13=dmem13;
      dmem14=dmem14;
      dmem15=dmem15;
      dmem16=dmem16;
      dmem17=dmem17;
      dmem18=dmem18;
      dmem19=dmem19;
      dmem1a=dmem1a;
      dmem1b=dmem1b;
      dmem1c=dmem1c;
      dmem1d=dmem1d;
      dmem1e=dmem1e;
      dmem1f=dmem1f;
      dmem20=dmem20;
      dmem21=dmem21;
      dmem22=dmem22;
      dmem23=dmem23;
      dmem24=dmem24;
      dmem25=dmem25;
      dmem26=dmem26;
      dmem27=dmem27;
      dmem28=dmem28;
      dmem29=dmem29;
      dmem2a=dmem2a;
      dmem2b=dmem2b;
      dmem2c=dmem2c;
      dmem2d=dmem2d;
      dmem2e=dmem2e;
      dmem2f=dmem2f;

      stack00=stack00;
      stack01=stack01;
      stack02=stack02;
      stack03=stack03;
   endif
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }

ende

endlogic
