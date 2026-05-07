logicname bcdconv

procedure bcdconv
input  RESET;
input  REQ;
input  ADATA[8];

output Q[13];

bitn   adata[8];
bitn   p[8];
bitn   q[8];
bitn   r[8];
bitn   s[8];
bitn   t[8];

   Q.0:3=r.0:3;
   Q.4:7=t.0:3;
   Q.8:11=p.0:3;
   Q.12=q.8;

   adata=ADATA;

   if (!RESET&!REQ)
      p=adata/100;
   endif

   if (!RESET&!REQ)
      q=adata/10;
   endif

   if (!RESET&!REQ)
      r=adata%10;
   endif

   s=p>>3+p>>1;

   t=q-s.0:7;

endp

endlogic
