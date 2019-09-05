
#include <string.h>
#include <iostream>
#include <cstdlib>
#include <bitset>
#include <cmath>

using namespace std;


void trivial(int eps, int del)
{
    //starts with the matrix
    //declare a matrix
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

    //val = 4.5
    //adds the values
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            if ((i != 3) && ((j == 0) || (j == 3)))
            {
                nlb[i][j] = 0.90/2;//(1+del)/4;
            }
            else if ((i==3) && ((j != 0) && (j != 3)))
            {
               nlb[i][j] = 0.90/2;//(1+eps)/4;
            }
            else if ((i==3) && ((j == 0) || (j == 3)))
            {

                nlb[i][j] = (1-0.90)/2;  //(1-eps)/4;
            }
            else if ((i != 3) && ((j != 0) && (j != 3)))
            {
                nlb[i][j] = (1-0.90)/2; //(1-del)/4;
            }
        }
    }




//
//    for (int l = 0; l < 4; l++)
//    {
//        for (int m = 0; m < 4; m++)
//            cout << l << m << nlb[l][m] << endl;
//    }

    //input 6-bits. loop of 2^6

    int i; /*,f1,f2,f3,g1,g2,g3,d1,d2,o;*/
    double prob;// i is the input
    int d1 = 0;
    int d2 = 0;
    i = 0;
    prob = 0.0;



   for (int k = 0; k < 64; k++)
   {
       p[i] = 0;
   }

        //Alice's inputs: f1 corresponds to the first box, f2 to the second, f3 to the final output; Same goes for Bob
   f1 = 105;
    g1 = 112;
    f2 = 51113;
    g2 = 35163;
    //g2 = 15420;
    f3 = 1718184345;
    g3 = 1718084345;
    //g3 = 1768331625;
  
    f1 = 195;
    g1 = 102;
    f2 = 50115;
    g2 = 4080;
    f3 = 1718184345;
   // f3 = 2523293289;
    g3 = 1768331625;

    

    // int f2 = 0;
    // int g2 = 0;
    // int h2 = 0;
    // int f3 = 0;
    // int g3 = 0;
    // int h3 = 0;
    //g3 = 1721133414;



       for (f1 = 0; f1 < pow(2,8); f1++)
       {
           for(f2 = 0; f2 < pow(2,16); f2++)
           {
               for (f3=0; f3 < pow(2,32); f3++)

               {
        o           for (g1=0; g1 < pow(2,8); g1++)
                   {
                       for (g2 = 0; g2 < pow(2,16); g2++)

                       {
                           for (g3 = 0; g3 < pow(2,32); g3++)
                           {
                        //bitset for the input


                        //therefore alice and bob have index 'a_in' and 'b_in'

                        //f1 and g1 are the input function to the first box

                        //f2 and g2 are the functions to the second box
                        bitset<4> f2_b = f2;
                        //cout << "f2: " << f2_b << endl;
                        bitset<4> g2_b = g2;
                        //cout << "g2: " << g2_b << endl;
                        bitset<4> h2_b = h2;
                        //f3 and g3 are the functions of the final outputs
                        bitset<8> f3_b = f3;
                        //cout << "f3: " << f3_b << endl;
                        bitset<8> g3_b = g3;
                        //cout << "g3: " << g3_b << endl;
                        bitset<8> h3_b = h3;
                        //first box inputs xy

                        /*so we have the functions f,g,h*/
                        //setting for the input
               for (i = 0; i < 8; i++)
                {
                       // the input to the NLB will be 2^3

                        bitset<3> xyz = i; // input to the main box

                        //000

                        cout <<"INPUT: " << xyz << endl;

                        //alice = xyz[2] , bob = xyz[1], charlie = xyz[0]
                /* Alice, Bob, and Charlie's input */
                        //
                        //bitset<1> a_bit; //first box's alice's input bit.



                        input bit of alice

                       cout << "a bit: " << a_bits << endl;

                       int a_in; //alice index

                       a_in = (int)(a_bits.to_ulong());// alice index

                       //cout << "alice: " << a_bits << endl;
                       //cout << "a index: " << a_in << endl;

                       bitset<3> b_bits; //input bits of bob
                       b_bits[2] = xy[2];
                       b_bits[1] = xy[1];
                       b_bits[0] = xy[0];

                       cout << "b bits: " << b_bits << endl;

                       int b_in; //alice index

                       b_in = (int)(b_bits.to_ulong());// alice index

                        cout << "bob: " << b_bits << endl;
                        cout << "b index: " << b_in << endl;
                        a_bit[0]

                       bitset<2> fb_xyz; // input
                       fb_xy[1] = f1_b[7-a_in];
                       fb_xy[0] = g1_b[7-b_in];
                       cout << "function: " << g1_b << endl;
                       cout << "fb1: " << fb_xy << endl;

                       //cout << "alice: " << f1_b << endl;
                      // cout << "bob: " << g1_b << endl;

                       //fb_xy has the first box inputs stosred.
                      // cout << "alice: " << f1_b
                      // cout << ""

                        int in_1; //input to the first box

                        in_1 = (int)(xyz.to_ulong());// index of the input to the first box

                        cout << "index: " << in_1 << endl;


                        for (d1 = 0; d1 < 8; d1++) //the first box output loop 000 001 .... 111
                        {
                            //000
                            for (d2 = 0; d2 < 8; d2++) // the second box output loop 000 001 .... 111
                            {
                                //000
                                //cout << "input 1: " << fb_xy << endl;

                                bitset<3> o1_bit = d1; //bitset of first box output

                                cout << "output 1: " << o1_bit << endl;

                                bitset<3> o2_bit = d2; //bitset of the second box output


                                bitset<2> a2_bits; // alice's second box input stochastic map on the previous input


                                a2_bits[1] = xyz[2]; //the first bit of xy
                                //cout << "at 1: " << xy[3] << endl;
                                a2_bits[0] = o1_bit[2];
                                //cout << "at 0: " << o1_bit[1] << endl;

                                //cout << "bits: " << a2_bits << endl;

                                cout << "alice bits: " << a2_bits << endl;

                                int a2_in; // alice's second box index
                                a2_in = (int)(a2_bits.to_ulong());
                                //#######//


                                //cout << "alice bits: " << a2_bits << endl;
                                bitset<2> b2_bits; // alice's second box input


                                b2_bits[1] = xyz[1];
                                //bob's second box bits
                                b2_bits[0] = o1_bit[1];

                                cout << "bob bits: " << b2_bits << endl;

                                int b2_in; // alice's second box index
                                b2_in = (int)(b2_bits.to_ulong());


                                bitset<2> c2_bits; //charlie's inputs

                                c2_bits[1] = xyz[0];
                                //charlie's bits
                                c2_bits[0] = o1_bit[0];

                                //second box inputs
                                int c2_in; // alice's second box index
                                c2_in = (int)(c2_bits.to_ulong());

                                cout << "charlie bits: " << c2_bits << endl;

                                bitset<3> fb2_xyz;
                                fb2_xyz[2] = f2_b[3-a2_in];
                                fb2_xyz[1] = g2_b[3-b2_in];
                                fb2_xyz[0] = h2_b[3-c2_in];

                                cout << "f2: " << f2_b << endl;
                                cout << "g2: " << g2_b << endl;
                                cout << "h2: " << h2_b << endl;
                                cout << "input 2: " << fb2_xyz << endl;
                                cout << "output 2: " << o2_bit << endl;


                                int in_2; //input box 2 inputs

                                in_2 = (int)(fb2_xyz.to_ulong());//

                                //output is in the bitset ab

                                bitset<3> oa_in; //output index for alice -- the final output

                                oa_in[2] = xyz[2];
                                oa_in[1] = o1_bit[2];
                                oa_in[0] = o2_bit[2];

                                bitset<3> ob_in; //output index for bob

                                ob_in[2] = xyz[1];
                                ob_in[1] = o1_bit[1];
                                ob_in[0] = o2_bit[1];


                                bitset<3> oc_in; //output index for bob

                                oc_in[2] = xyz[0];
                                oc_in[1] = o1_bit[0];
                                oc_in[0] = o2_bit[0];



                                int a3_in; //alice output index

                                a3_in = (int)(oa_in.to_ulong());//

                                int b3_in; //bob output index

                                b3_in = (int)(ob_in.to_ulong());

                                int c3_in; //charlie output index

                                c3_in = (int)(oc_in.to_ulong());

                                bitset<3> output; //a ^ b
                                output[2] = f3_b[7-a3_in];
                                output[1] = g3_b[7-b3_in];
                                output[0] = h3_b[7-c3_in];


                                cout << "f3: " << f3_b << endl;
                                cout << "g3: " << g3_b << endl;
                                cout << "h3: " << h3_b << endl;

                                cout << "alice out3 " << oa_in << endl;
                                cout << "bob out3 " << ob_in << endl;
                                cout << "charlie out3 " << oc_in << endl;
//                                cout << "f3_b " << f3_b << endl;
//                                cout << "g3_b " << g3_b << endl;


                                //if the output is this this and this, then we will add the probabilities or we will multiply

                                int ab,out;

                                //ab = output[1] ^ output[0];

                                cout << "ouput: " << output << endl;

                              //  cout << "parity output: " <<  ab << endl;
                                out = (int)(output.to_ulong());



                                //output indices

                                //so we have now in_1, in_2, ab
                                cout << "output: " << out << endl;


                                if (in_1 == 0 || in_1 == 1 || in_1 == 2 || in_1 == 3 || in_1 == 4 )
                                {
                                    if (out == 1 || out == 2 || out == 4 || out == 7)
                                    {
                                        prob = prob + ((nlb[in_1][d1]) * (nlb[in_2][d2]));

                                        cout << "prob " << prob << endl;
                                    }
                                    else
                                    {
                                        prob = prob - ((nlb[in_1][d1]) * (nlb[in_2][d2]));

                                        cout << "prob " << prob << endl;
                                    }

                                }

                                else if (in_1 == 5)
                                {
                                    if (out == 0 || out == 1 || out == 3 || out == 5 || out == 6)
                                    {
                                        prob = prob + ((nlb[in_1][d1]) * (nlb[in_2][d2]));

                                        cout << "prob " << prob << endl;
                                    }
                                    else
                                    {
                                        prob = prob - ((nlb[in_1][d1]) * (nlb[in_2][d2]));

                                        cout << "prob " << prob << endl;
                                    }

                                }

                                else if (in_1 == 6)
                                {
                                    if (out == 0 || out == 2 || out == 3 || out == 5 || out == 6)
                                    {
                                        prob = prob + ((nlb[in_1][d1]) * (nlb[in_2][d2]));

                                        cout << "prob " << prob << endl;
                                    }
                                    else
                                    {
                                        prob = prob - ((nlb[in_1][d1]) * (nlb[in_2][d2]));

                                        cout << "prob " << prob << endl;
                                    }

                                }
                                else if (in_1 == 7)
                                {

                                    if (out == 1 || out == 2 || out == 3 || out == 4 || out == 5 || out == 6)
                                    {
                                        prob = prob + ((nlb[in_1][d1]) * (nlb[in_2][d2]));

                                        cout << "prob calc " << nlb[in_1][d1] << "  " << nlb[in_2][d2];

                                        cout << "prob " << prob << endl;
                                    }
                                    else
                                    {

                                        prob = prob - ((nlb[in_1][d1]) * (nlb[in_2][d2]));

                                        cout << "prob calc " << nlb[in_1][d1] << "  " << nlb[in_2][d2];

                                        cout << "prob " << prob << endl;
                                    }

                                }
                                //final probability calculation




                            }


                        }

//
//                     cout << "PROB ADD" << prob << endl;
//
//                      cout << "PROB SUB: " << prob2 << endl;
//
                      cout << "final correlation: " << abs(prob) << endl;
//


              }


//
//              for (int m = 0; m < 64; m++)
//              {
//
//                  cout << "prob" << m << ": " << p[m] << endl;
//              }

                        //prob = abs(prob);
                       // cout << "PROB" << ": " << prob2 << "\n \n";

                        //cout << "prob final: " << prob << endl;


                          //  }
                       // }
                   // }
               // }
           // }
       // }





}



int main()
{
    double p = 0.90;
    double q = 0;
    double v = 0;

    q = pow(p,2) + pow((1 - p),2);



    v = 64*(q - (1-q));



   /* for (int i = 0; i<64; i++)
    {
        bitset<6> a = i;
        cout << "bits: " << a << endl;
        cout << "nlm: " << nlm(i) << endl;
    }*/

    trivial(3,4);
    //cout << "measured value: " << v << endl;

}

