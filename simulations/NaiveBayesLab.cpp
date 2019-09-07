// reading a text file
#include <iostream>
#include <fstream>
#include <string.h>
#include <sstream>
#include <vector>
#include <stdio.h>
#include <stdlib.h>
#include <algorithm>
#include <map>

using namespace std;

std::vector<std::string> &split(const std::string &s, char delim, std::vector<std::string> &elems) {
    std::stringstream ss(s);
    std::string item;
    while (std::getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
}

//Loads data from CSV file to arrays
void LoadData(string fileName,vector<vector<string> > &d)
{
	string line;

	ifstream myfile (fileName.c_str());

	if (myfile.is_open())
	{
		getline (myfile,line) ; //skip first line
		int row =0;

		while ( getline (myfile,line) )
		{
			std::vector<std::string> elems;
		  std::vector<std::string> x = split(line, ',',elems);

		  d.push_back(x);

		  row++;
		}
		myfile.close();
	}

	else cout << "Unable to open file";
	}




 vector<string> retrieveLabels (vector<vector<string> > trainingData){

  std::vector<string> labels;
  bool find = false;
  int col = trainingData[0].size();
  for (int i = 0; i < trainingData.size(); i++){
  	string el = trainingData[i][col-1];

   if (std::find(labels.begin(), labels.end(), el) != labels.end())
   {
       find = true;
    }

    else {
   labels.push_back(el);
   find = false;
   }

  }

return labels;

}


float computePrior (vector<vector<string> > trainingData, string classLabel){

	int class_var = 0;
	int col = trainingData[0].size();
    for (int i = 0; i < trainingData.size(); i++){
  	string el = trainingData[i][col-1];
  	if (el == classLabel)
  		class_var++;
  }

  return (float)class_var/(float)trainingData.size();

}

float computeConditional (vector<vector<string> > trainingData, int colIndex, string colValue, string classLabel){

 	int class_val = 0;
    int cl = 0;//one counter of class value
      //one counter attribute value
 	int col = trainingData[0].size();

   for (int i = 0; i < trainingData.size(); i++) {

   	string attribute = trainingData[i][colIndex];
   	string label = trainingData[i][col-1];
   	  if (label == classLabel){

        cl++;
   	  }

   	  if (attribute == colValue && label == classLabel){

   	  	class_val++;

   	  }
   }

  return (float) class_val / (float)cl;
 }


float computePosterior(vector<vector<string> > &trainingData, vector <string> record  ,string classLabel){

	float prob = 1;
	for (int i = 0; i < record.size(); i++){
		prob = prob * computeConditional (trainingData, i, record[i], classLabel);
	}
	return computePrior(trainingData, classLabel) * prob;
}



string Predicted(vector<vector<string> > &trainingData, vector <string> record ){

   vector<string> labels;
   float max_post = 0.0;
   string max_lab;
   labels = retrieveLabels(trainingData);

for(std::vector<int>::size_type i = 0; i != labels.size(); i++) {
   if (computePosterior(trainingData, record, labels[i]) > max_post) {
     max_post = computePosterior(trainingData, record, labels[i]);
     max_lab = labels[i];
   }
}
return max_lab;
}


void model (vector<vector<string> > &testData,vector <string> record, int &accuracy, int &precision,int &recall) {
  string pred;
  int ep =0;
  int en =0;
  int pp =0;
  int pn =0;
  for(std::vector<int>::size_type i = 0; i != record.size() - 1; i++) {

     cout << record[i];
     actual = Predicted(testData, record);
     pred = testData[i][col-1];
     if (actual == testData[i][col-1][0]){
        if (actual == "e" && pred = "e"){
            ep++;
        }
        else if (actual == "e" && pred = "p"){
            en++;
        }
        else if (actual == "p" && pred = "p"){
            pp++;
        }
        else if (actual == "p" && pred = "e"){
            pn++;
        }

     }
     accuracy = ep + pp / (ep+en+pp+pn);
     precision = ep / (ep + pp);
     recall = ep / (ep + en);

}
}





int main () {

  //Load training data
  vector<vector<string> > trainingData;

  LoadData("MushroomTraining.csv", trainingData);

 int col = trainingData[0].size();

 vector <string> new;

  for (int i = 0; i < retrieveLabels(trainingData).size(); i++){
  	cout << retrieveLabels(trainingData)[i] <<endl;
  }

  //string record[] = {"f","s","w","f","n","f","w","b","h","t","e","f","f","w","w","p","w","o","e","k","s","g"};

  cout << computePrior(trainingData, "e" ) << endl;

  cout << computeConditional(trainingData, 0, "f", "e") <<endl;



  vector <string> record = trainingData[1];

  cout << computePosterior(trainingData, record , "e") <<endl;



cout << "predicted " <<  Predicted(trainingData, record) << endl;

  for (int i=0; i<testData.size(); i++) {
cout << "model: " << model (trainingData, record,);
}


  cout<<"Number of rows in training Data:"<<trainingData.size()<<endl;
  if (trainingData.size() > 0)
  	cout<<"Number of cols in training Data:"<<trainingData[1][22]<<endl;


  return -1;
}


