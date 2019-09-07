//
//  main.cpp
//  nprotocol
//
//  Created by talmac on 8/28/15.
//  Copyright (c) 2015 talmac. All rights reserved.
//

#include <bitset>
#include <iostream>
#include <utility>
#include <map>
#include <unordered_map>

#include "CBox.h"







inline bool NLB(const std::bitset<3> xyz,const std::bitset<3> abc)
{
    return (xyz[0] | xyz[1] | xyz[2])==(abc[0] ^ abc[1] ^ abc[2]);
}




inline bool tt_2_input(bool input1,bool input2,unsigned functionNo)
{
    
    std::map<std::pair<bool,bool>,bool> tt;
    std::bitset<4> bFunction(functionNo);
    for(int i=0;i<4;i++)
    {
        std::bitset<2> b(i);
        
        std::pair<bool,bool> p;
        p.first=b[0];
        p.second=b[1];
        
        tt[p]=bFunction[3-i];
    }
    return tt[std::make_pair(input2,input1)];
}


inline bool tt_3_input(bool input1,bool input2,bool input3,unsigned functionNo)
{
    std::map<std::tuple<bool,bool,bool>,bool> tt;
    std::bitset<8> bFunction(functionNo);
    for(int i=0;i<8;i++)
    {
        std::bitset<3> b(i);
        
        std::tuple<bool,bool,bool> p;
        std::get<0>(p)=b[0];
        std::get<1>(p)=b[1];
        std::get<2>(p)=b[2];
        
        tt[p]=bFunction[7-i];
    }
    return tt[std::make_tuple(input3,input2,input1)];
}



double nprotocol(unsigned f2,unsigned g2,unsigned h2,unsigned f3,unsigned g3,unsigned h3,CBox &Cb)
{
    
    
    double prob000=0.0;
    double prob011=0.0;
    double prob101=0.0;
    double prob110=0.0;
    double prob=0.0;

    
    int input[]={0,3,5,6};
    for (unsigned int i=0;i<4;i++)
    {
        std::bitset<3> x1_y1_z1(input[i]);
        for (unsigned int oNLB1=0;oNLB1<8;oNLB1++)
        {
            std::bitset<3> outputBox1(oNLB1);
            if (NLB(x1_y1_z1,outputBox1))
            {
                
            }
            else
            {
                
            }
            std::bitset<3> x2_y2_z2;
            
            
            x2_y2_z2[0]=tt_2_input(x1_y1_z1[0],outputBox1[0],f2);
            x2_y2_z2[1]=tt_2_input(x1_y1_z1[1],outputBox1[1],g2);
            x2_y2_z2[2]=tt_2_input(x1_y1_z1[2],outputBox1[2],h2);
            
            
            for (unsigned int oNLB2=0;oNLB2<8;oNLB2++)
            {
                std::bitset<3> outputBox2(oNLB2);
                if (NLB(x2_y2_z2,outputBox2))
                {
                    
                }
                else
                {
                    
                }
                std::bitset<3> abc;
                abc[0]=tt_3_input(x2_y2_z2[0],outputBox1[0],outputBox2[0],f3);
                abc[1]=tt_3_input(x2_y2_z2[1],outputBox1[1],outputBox2[1],g3);
                abc[2]=tt_3_input(x2_y2_z2[2],outputBox1[2],outputBox2[2],h3);
                if (NLB(x1_y1_z1,abc))
                {
                    if (x1_y1_z1.to_ulong()==0)
                    {
                        prob000+=(Cb.m_fConditionalProbMatrix[x1_y1_z1.to_ulong()][outputBox1.to_ulong()]*Cb.m_fConditionalProbMatrix[x2_y2_z2.to_ulong()][outputBox2.to_ulong()]);
                    }
                    else if (x1_y1_z1.to_ulong()==3)
                    {
                        prob011+=Cb.m_fConditionalProbMatrix[x1_y1_z1.to_ulong()][outputBox1.to_ulong()]*Cb.m_fConditionalProbMatrix[x2_y2_z2.to_ulong()][outputBox2.to_ulong()];
                    }
                    else if (x1_y1_z1.to_ulong()==5)
                    {
                        prob101+=Cb.m_fConditionalProbMatrix[x1_y1_z1.to_ulong()][outputBox1.to_ulong()]*Cb.m_fConditionalProbMatrix[x2_y2_z2.to_ulong()][outputBox2.to_ulong()];
                    }
                    else if (x1_y1_z1.to_ulong()==6)
                    {
                        prob110+=Cb.m_fConditionalProbMatrix[x1_y1_z1.to_ulong()][outputBox1.to_ulong()]*Cb.m_fConditionalProbMatrix[x2_y2_z2.to_ulong()][outputBox2.to_ulong()];
                    }
                }
                else
                {
                    
                    
                    if (x1_y1_z1.to_ulong()==0)
                    {
                        prob000-=(Cb.m_fConditionalProbMatrix[x1_y1_z1.to_ulong()][outputBox1.to_ulong()]*Cb.m_fConditionalProbMatrix[x2_y2_z2.to_ulong()][outputBox2.to_ulong()]);
                    }
                    else if (x1_y1_z1.to_ulong()==3)
                    {
                        prob011-=Cb.m_fConditionalProbMatrix[x1_y1_z1.to_ulong()][outputBox1.to_ulong()]*Cb.m_fConditionalProbMatrix[x2_y2_z2.to_ulong()][outputBox2.to_ulong()];
                    }
                    else if (x1_y1_z1.to_ulong()==5)
                    {
                        prob101-=Cb.m_fConditionalProbMatrix[x1_y1_z1.to_ulong()][outputBox1.to_ulong()]*Cb.m_fConditionalProbMatrix[x2_y2_z2.to_ulong()][outputBox2.to_ulong()];
                    }
                    else if (x1_y1_z1.to_ulong()==6)
                    {
                        prob110-=Cb.m_fConditionalProbMatrix[x1_y1_z1.to_ulong()][outputBox1.to_ulong()]*Cb.m_fConditionalProbMatrix[x2_y2_z2.to_ulong()][outputBox2.to_ulong()];
                    }
                }
                
            }
        }
        
    }
    prob=prob000 + prob011 + prob101 + prob110;
    return prob;
}













void iterate_over_space()
{
    double value=0.0;

    
    for (unsigned f2=0;f2<1;f2++)
    {
        for (unsigned g2=3;g2<4;g2++)
        {
            for (unsigned h2=3;h2<4;h2++)
            {
                for (unsigned f3=153;f3<154;f3++)
                {
                    for (unsigned g3=102;g3<103;g3++)
                    {
                        for (unsigned h3=102;h3<103;h3++)
                        {
                            for (double d=-1.0;d<1.01;d+=0.01)
                            {
                                for (double e=-1.0;e<1.01;e+=0.01)
                                {
                                    value=0.0;
                                    CBox Cb(e,d);
                                    value=nprotocol(f2,g2,h2,f3,g3,h3,Cb);
                                    if (fabs(value)>fabs(Cb.m_fGHZ))
                                    std::cout << "f2: " << f2 << " g2: " << g2 << " h2: " << h2 << " f3 " << f3 << " g3: " << g3 << " h3: " << h3 <<   " delta: " << d << " epsilon: " << e << " GHZ: " << fabs(Cb.m_fGHZ) << " value: " << fabs(value)  << "\n";
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}

#include <iostream>

int main(int argc, const char * argv[]) {
    iterate_over_space();
    return 0;
}
