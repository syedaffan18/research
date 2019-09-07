#include <cstring>
#include <stdio.h>
#include <stdlib.h>

#ifndef max
#define max( a, b ) ( ((a) > (b)) ? (a) : (b) )
#endif

int main(int argc, char*argv)
{

  int f1, f2, f3;
  int g1, g2, g3;

  int nlb[2][2];
  memset (nlb, 0, 2 * 2 * sizeof(int));
  /* nlb [the AND of the input] [the XOR of the output] = 10 * probability */
  nlb[0][0] =  10; nlb[0][1] = 0;
  nlb[1][0] =   3; nlb[1][1] = 7;

  int parityvalue  = (200 + nlb[1][1] * (30 - nlb[1][1])) * 4;
  int trivialvalue = (200) * 4;

  int p = 0;
  int pmax = max(parityvalue, trivialvalue);

  /* Alice's strategies */
  for (int f1=0; f1<4; f1++) {
    for (int f2=0; f2<16; f2++) {
      for (int f3=0; f3<256; f3++) {
      
        /* Bob's strategies */
/*      for (int g1=0; g1<4; g1++) {  */
/*        for (int g2=0; g2<16; g2++) {  */
/*          for (int g3=0; g3<256; g3++) {  */

              /* use the following line instead of the three g loops if Alice and Bob use same strategy */
               int g1 = f1; int g2 = f2; int g3 = f3; {{{  

              /* The input is (x1,y1) to the first NLB; the output is (x2,y2) */
              /* The input is (x2,y2) to the second NLB; the output is (x3,y3) *
/
              /* x = x3 x2 x1; y = y3 y2 y1, where xi is a bit */ 
     
              for (int x=0; x<8; x++) {
                for (int y=0; y<8; y++) {
                
                  if ( (((f3 >> (x % 8)) % 2) != ((g3 >> (y % 8)) % 2)) == ((x % 2) && (y % 2)) ) {
                    p += ( nlb[ ((f1 >> (x % 2)) % 2) && ((g1 >> (y % 2)) % 2) ]
[ ((x >> 1) % 2) != ((y >> 1) % 2) ]
                         * nlb[ ((f2 >> (x % 4)) % 2) && ((g2 >> (y % 4)) % 2) ]
[ ((x >> 2) % 2) != ((y >> 2) % 2) ] );
                  } else {
                    p -= ( nlb[ ((f1 >> (x % 2)) % 2) && ((g1 >> (y % 2)) % 2) ]
[ ((x >> 1) % 2) != ((y >> 1) % 2) ] 
                         * nlb[ ((f2 >> (x % 4)) % 2) && ((g2 >> (y % 4)) % 2) ]
[ ((x >> 2) % 2) != ((y >> 2) % 2) ] );
                  }
                }
              }
              p = abs(p);

              if (p>=pmax) {
                printf("For NLB (%d,%d,%d,%d) the value is %d", nlb[0][0], nlb[0][1], nlb[1][0], nlb[1][1], p);
                printf(" at strategies (%d,%d,%d,%d,%d,%d)\n", f1, f2, f3, g1, g2, g3);
                pmax = p;
              }
              p = 0;
            }
          }
        }
      }
      /* run time help -- keeps track of how long the program will take to execute */
      if ((f2 % 4) == 0) { printf ("out of f3 loops, %d \n", f1*16+f2); } 
    }
  }

  printf ("Trivial value of game = %2.2f (%d)\n",  (float) trivialvalue / 400, trivialvalue);
  printf ("Parity  value of game = %2.2f (%d)\n",  (float) parityvalue / 400, parityvalue);
  printf ("Max     value of game = %2.2f (%d)\n",  (float) pmax / 400, pmax);
  printf("\n");
}
