#include <string.h>
#include <iostream>
#include <cstdlib>
#include <bitset>
#include <cmath>


using namespace std;
int generateRule()
{


    int c = 0;

//    int i = 0;
//    int j = 0;
    int q = 0;
    int r = 0;
    int m = 0;
    int n = 0;


    double nlb[8][8] =
    {
        {0 , 1 , 1, 0, 1, 0, 0 , 1},
        {0 , 1 , 1, 0, 1, 0, 0 , 1},
        {0 , 1 , 1, 0, 1, 0, 0 , 1},
        {0 , 1 , 1, 0, 1, 0, 0 , 1},
        {0 , 1 , 1, 0, 1, 0, 0 , 1},
        {1, 1 , 0, 1, 0, 1, 1 , 0},
        {1 , 0 , 1, 1, 0, 1, 1 , 0},
        {0 , 1 , 1, 1, 1, 1, 1 , 0}
    };
    //adds the values
//    for (int i = 0; i < 4; i++)
//    {
//        for (int j = 0; j < 4; j++)
//        {
//            if ((i != 3) && ((j == 0) || (j == 3)))
//            {
//                nlb[i][j] = 1;//(1+del)/4;
//
//                cout << nlb[i][j] << " ";
//            }
//            else if ((i==3) && ((j != 0) && (j != 3)))
//            {
//               nlb[i][j] = 1;//(1+eps)/4;
//               cout << nlb[i][j] << " ";
//            }
//            else if ((i==3) && ((j == 0) || (j == 3)))
//            {
//
//                nlb[i][j] = 0;  //(1-eps)/4;
//                cout << nlb[i][j] << " ";
//            }
//            else if ((i != 3) && ((j != 0) && (j != 3)))
//            {
//                nlb[i][j] = 0; //(1-del)/4;
//                cout << nlb[i][j] << " ";
//            }
//
//        }
//        cout << endl;
//    }


    for(r = 0; r < 64; r++)
    {
        for (q = 0; q < 64; q++)
        {
//             r = 6;
//             q = 1;
             bitset<8> f = q; // function f(x,y)
             bitset<8> g = r; // function g(a,b)



             for (m=0; m<8; m++)
             {
                 for (n=0; n<8; n++)
                 {

                     if ( ((f[7-m] == g[7-n]) &&  nlb[m][n] == 1) || ((f[7-m] != g[7-n]) &&  nlb[m][n] == 0)) // where both functions are equal and the matrix has the correct value
                     {
                        // cout << "there is a rule, which is: f(x,y):  " << i << " g(a,b): " << j << endl;

                         cout << "f(x,y): " << f << endl;
                         cout << "g(x,y): " << g << endl;

                         cout << "f[" << 7-m << "]"  << f[7-m] << endl;
                         cout << "g[" << 7-n << "]"  << g[7-n] << endl;
                         cout << "matrix: [" << m << "][" << n << "]" << ": " << nlb[m][n] << endl;

                         c++;

                         cout << "c: " << c << endl;

                     }



                     else
                     {

                        cout << "f: " << f << endl;
                        cout << "g: " << g << endl;
                        cout << "f[" << 7-m << "]"  << f[7-m] << endl;
                        cout << "g[" << 7-n << "]"  << g[7-n] << endl;
                        cout << "m: [" << m << "][" << n << "]" << ": " << nlb[m][n] << endl;



                         c--;
                         cout << "c: " << c << endl;
                     }

                 }

             }

            // cout << "c: " << c << endl;

             if (c == 16)
             {
                cout << "there is a rule, which is: f(x,y,z):  " << q << " g(a,b,c): " << r << endl;
                return 0;
             }

             c = 0;




        }


    }

return 0;

}


int main ()
{
    //generateRule

    generateRule();
}
