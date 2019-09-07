//
//  CBox.h
//  Nonlocal
//
//  Created by talmac on 7/7/15.
//  Copyright (c) 2015 talmac. All rights reserved.
//

#ifndef Nonlocal_CBox_h
#define Nonlocal_CBox_h

#include <bitset>
#include <cmath>

#include <string>



class CBox
{
public:
    CBox(double  Epsilon,double  Delta):m_fEpsilon(Epsilon),m_fDelta(Delta)
    {
        
        m_fGHZ=0.0;
        for (int input_x=0; input_x<CBox::m_iSIZE; ++input_x)
        {
            
            for (int output_a=0; output_a<CBox::m_iSIZE; ++output_a)
            {
                if (input_x==0)
                {
                    if (parityOrRule(output_a,input_x))
                    {
                        m_fConditionalProbMatrix[input_x][output_a]=(1+m_fEpsilon)/m_iSIZE;
                        if (input_x==0 || input_x==3 || input_x==5 || input_x==6)
                        {
                            m_fGHZ+=(1+m_fEpsilon)/m_iSIZE;
                            
                        }
                    }
                    else
                    {
                        m_fConditionalProbMatrix[input_x][output_a]=(1-m_fEpsilon)/m_iSIZE;
                        if (input_x==0 || input_x==3 || input_x==5 || input_x==6)
                        {
                            m_fGHZ-=(1-m_fEpsilon)/m_iSIZE;
                            
                        }
                    }
                    
                }
                else
                {
                    if (parityOrRule(output_a,input_x))
                    {
                        m_fConditionalProbMatrix[input_x][output_a]=(1+m_fDelta)/m_iSIZE;
                        if (input_x==0 || input_x==3 || input_x==5 || input_x==6)
                        {
                            m_fGHZ+=(1+m_fDelta)/m_iSIZE;
                            
                        }
                    }
                    else
                    {
                        m_fConditionalProbMatrix[input_x][output_a]=(1-m_fDelta)/m_iSIZE;
                        if (input_x==0 || input_x==3 || input_x==5 || input_x==6)
                        {
                            m_fGHZ-=(1-m_fDelta)/m_iSIZE;
                            
                        }
                    }
                    
                }
                
            }
        }
    }
    
    bool parityAndRule(int a,int x)
    {
        if (parity(a)==And(x))
            return true;
        else
            return false;
    }
    
    //or rule
    bool parityOrRule(int a,int x)
    {
        if (parity(a)==Or(x))
            return true;
        else
            return false;
    }
    
    bool Or(int val)
    {
        std::bitset<m_iNOOfPARTY> b(val);
        bool result=false;
        for (int i=0;i!=m_iNOOfPARTY;++i)
        {
            result|=b[i];
        }
        return result;
        
    }
    
    bool parity(int val)
    {
        std::bitset<m_iNOOfPARTY> b(val);
        bool result=false;        
        for (int i=0;i!=m_iNOOfPARTY;++i)
        {
            result^=b[i];
        }
        return result;
    }
    
    bool And(int val)
    {
        std::bitset<m_iNOOfPARTY> b(val);
        bool result=true;
        for (int i=0;i!=m_iNOOfPARTY;++i)
        {
            result&=b[i];
        }
        return result;
    }
    
    friend std::ostream &operator<<(std::ostream &output,const CBox &B )
    {
        for (int input_x=0; input_x!=CBox::m_iSIZE; ++input_x)
        {
            
            for (int output_a=0; output_a!=CBox::m_iSIZE; ++output_a)
            {
                output << B.m_fConditionalProbMatrix[input_x][output_a] << "  " ;
            }
            output << "\n";
        }        
        return output;
    }
    
    
    
    
    double  testNormalization(int row)
    {
        return 0.0;
    }

    static const int m_iSIZE=8;
    double  m_fConditionalProbMatrix[m_iSIZE][m_iSIZE];
    std::string m_strConditionalProbMatrix[m_iSIZE][m_iSIZE];
    double  m_fGHZ;
    
    
    
private:
    static const int m_iNOOfPARTY=3;
    double  m_fEpsilon;
    double  m_fDelta;
    
    
    

    
    
};




#endif
