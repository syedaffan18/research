restart;

DecToBin := proc(n::nonnegint,bits::posint)

  local i,j,m,q;

   q := n;

   for i while q <> 0 do m[i] := irem(q,2,'q') od;

   if nargs = 1 then

    if n = 0 then [0]

    else [seq(m[i-j],j=1..i-1)] fi

   else [0$(1+bits-i),seq(m[i-j],j=1..i-1)]

   fi

 end:

 

 p:=Matrix([[.45,.05,.05,.45],

            [.45,.05,.05,.45],

            [.45,.05,.05,.45],

            [0,.5,.5,0]]);

 

 d1:=1;

 d2:=1;

 

 stra1 := [seq(0,i=1..6)];

 stra2 := [seq(0,i=1..6)];

 stra3 := [seq(0,i=1..6)];

 stra4 := [seq(0,i=1..6)];

 

 strb1 := [seq(0,i=1..6)];

 strb2 := [seq(0,i=1..6)];

 strb3 := [seq(0,i=1..6)];

 strb4 := [seq(0,i=1..6)];

 

 prob:=0;

 

 stra1[1] := 0;

 strb1[1] := 0;

 stra2[1] := 0;

 strb2[1] := 1;

 stra3[1] := 1;

 strb3[1] := 0;

 stra4[1] := 1;

 strb4[1] := 1;

 

 fd := fopen("eps7.txt",WRITE);

 

 stra1[4] := 0;

 strb1[4] := 0;

 stra2[4] := 0;

 strb2[4] := 1;

 stra3[4] := 1;

 strb3[4] := 0;

 stra4[4] := 1;

 strb4[4] := 1;

 

 for F2 from 12 by 1 while F2 < 14 do

 f2:=DecToBin(F2,4):

 for G2 from 0 by 1 while G2 < 16 do

 g2:=DecToBin(G2,4):

 

 for F3 from 0 by 1 while F3 < 256 do

 f3:=DecToBin(F3,8):

 for G3 from 0 by 1 while G3 < 256 do

 g3:=DecToBin(G3,8):

 

 for d1 from 1 by 1 while d1 < 5 do

      temp1:=DecToBin(d1-1,2):

 

      stra1[2] := temp1[1]:

      stra2[2] := temp1[1]:

      stra3[2] := temp1[1]:

      stra4[2] := temp1[1]:

 

      strb1[2] := temp1[2]:

      strb2[2] := temp1[2]:

      strb3[2] := temp1[2]:

      strb4[2] := temp1[2]:

 

 

 for d2 from 1 by 1 while d2 < 5 do

      temp2:=DecToBin(d2-1,2):

      stra1[3] := temp2[1]:

      stra2[3] := temp2[1]:

      stra3[3] := temp2[1]:

      stra4[3] := temp2[1]:

 

      strb1[3] := temp2[2]:

      strb2[3] := temp2[2]:

      strb3[3] := temp2[2]:

      strb4[3] := temp2[2]:

 

 

 stra1[5] := f2[1+convert(parse(cat(seq(stra1[i],i=1..2))),decimal, binary)]:

 strb1[5] := g2[1+convert(parse(cat(seq(strb1[i],i=1..2))),decimal, binary)]:

 stra2[5] := f2[1+convert(parse(cat(seq(stra2[i],i=1..2))),decimal, binary)]:

 strb2[5] := g2[1+convert(parse(cat(seq(strb2[i],i=1..2))),decimal, binary)]:

 stra3[5] := f2[1+convert(parse(cat(seq(stra3[i],i=1..2))),decimal, binary)]:

 strb3[5] := g2[1+convert(parse(cat(seq(strb3[i],i=1..2))),decimal, binary)]:

 stra4[5] := f2[1+convert(parse(cat(seq(stra4[i],i=1..2))),decimal, binary)]:

 strb4[5] := g2[1+convert(parse(cat(seq(strb4[i],i=1..2))),decimal, binary)]:

 

 stra1[6] := f3[1+convert(parse(cat(seq(stra1[i],i=1..3))),decimal, binary)]:

 strb1[6] := g3[1+convert(parse(cat(seq(strb1[i],i=1..3))),decimal, binary)]:

 stra2[6] := f3[1+convert(parse(cat(seq(stra2[i],i=1..3))),decimal, binary)]:

 strb2[6] := g3[1+convert(parse(cat(seq(strb2[i],i=1..3))),decimal, binary)]:

 stra3[6] := f3[1+convert(parse(cat(seq(stra3[i],i=1..3))),decimal, binary)]:

 strb3[6] := g3[1+convert(parse(cat(seq(strb3[i],i=1..3))),decimal, binary)]:

 stra4[6] := f3[1+convert(parse(cat(seq(stra4[i],i=1..3))),decimal, binary)]:

 strb4[6] := g3[1+convert(parse(cat(seq(strb4[i],i=1..3))),decimal, binary)]:

 

 output:=convert(parse(cat(stra1[6],strb1[6])),decimal,binary):

 input1:=1+convert(parse(cat(stra1[4],strb1[4])),decimal,binary):

 input2:=1+convert(parse(cat(stra1[5],strb1[5])),decimal,binary):

 if (output=0) or (output=3) then 

 prob:=prob+p[input1,d1]*p[input2,d2];

 else

 prob:=prob-p[input1,d1]*p[input2,d2];

 end if:

 

 output:=convert(parse(cat(stra2[6],strb2[6])),decimal,binary):

 input1:=1+convert(parse(cat(stra2[4],strb2[4])),decimal,binary):

 input2:=1+convert(parse(cat(stra2[5],strb2[5])),decimal,binary):

 if (output=0) or (output=3) then 

 prob:=prob+p[input1,d1]*p[input2,d2];

 else

 prob:=prob-p[input1,d1]*p[input2,d2];

 end if:

 

 output:=convert(parse(cat(stra3[6],strb3[6])),decimal,binary):

 input1:=1+convert(parse(cat(stra3[4],strb3[4])),decimal,binary):

 input2:=1+convert(parse(cat(stra3[5],strb3[5])),decimal,binary):

 if (output=0) or (output=3) then 

 prob:=prob+p[input1,d1]*p[input2,d2];

 else

 prob:=prob-p[input1,d1]*p[input2,d2];

 end if:

 

 output:=convert(parse(cat(stra4[6],strb4[6])),decimal,binary):

 input1:=1+convert(parse(cat(stra4[4],strb4[4])),decimal,binary):

 input2:=1+convert(parse(cat(stra4[5],strb4[5])),decimal,binary):

 if (output=0) or (output=3) then 

 prob:=prob-p[input1,d1]*p[input2,d2];

 else

 prob:=prob+p[input1,d1]*p[input2,d2];

 end if:

 

 end do:

 end do:

 

 printf("%d %d %d %d %1.4f;\n",F2,G2,F3,G3,prob);

 if abs(prob) >= 3.4 then fprintf(fd,"%d %d %d %d %1.4f;\n",F2,G2,F3,G3,prob): end if:

fflush(fd);

 prob:=0;

 

 end do:

 end do:

 end do:

 end do:

 

 fprintf(fd,"-5\n");

 fclose(fd);