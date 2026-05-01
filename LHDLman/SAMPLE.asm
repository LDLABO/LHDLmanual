         org       0

         movi      r0,data
         movi      r1,data>>8
         movrx     rp0

         movj      x0
         xor       r0,r0
         movi      r2,10
x0:      movmr     r1,ix
         add       r0,r1

         inc       ix
         dec       r2
         xor       r3,r3
         sub       r3,r2
         shu       r3,r3
         jmprc

         nop
         nop
         nop
         nop

data:    db        01,02,03,04,05,06,07,08,09
         db        10



