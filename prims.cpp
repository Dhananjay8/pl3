#include<omp.h>
#include<stdlib.h>
#include<iostream>
#include<fstream>
using namespace std;

class Graph
{
	int n;
	int GraphMatrix[1000][1000];
	public:
		Graph(int nodes)
		{
			n=nodes;
			for(int i=0;i<n;i++)
			{
				for(int j=0;j<n;j++)
				{
					GraphMatrix[i][j]=999;
				}
			}
		}
				
		void randomGenerator()
		{
			int random;
			srand(time(NULL));
			for(int i=0;i<n;i++)
			{
				for(int j=i+1;j<n;j++)
				{
					random=rand() % 10 + 1;
					if(random ==10){random=999;}
					GraphMatrix[i][j]=random;
					GraphMatrix[j][i]=random;
				}
			}
		}
		
		void toFile(const char * filename)
		{
			fstream fout;
			fout.open(filename,ios::out);
			for(int i=0;i<n;i++)
			{
				for(int j=0;j<n;j++)
				{
					fout<<GraphMatrix[i][j]<<"\t";
				}
				fout<<"\n";
			}
			fout.close();
		}
		
		void normalprims()
		{
			int MinCost[n];
			int EdgeFrom[n];
			int VertexSet[n];
			int edge,node,min,ev=1;
			int MST[n][n];
			
			for(int i=0;i<n;i++)
			{
				MinCost[i]=999;
				EdgeFrom[i]=-1;
				VertexSet[i]=0;
			}
			for(int i=0;i<n;i++)
			{
				for(int j=0;j<n;j++)
				{
					MST[i][j]=999;
				}	
			}
			
			VertexSet[0]=1;
			while(ev!=n)
			{
				for(int i=0;i<n;i++)
				{
					if(VertexSet[i]==1)
					{
						min=999;edge=-1;
						for(int j=0;j<n;j++)
						{
							if(GraphMatrix[i][j]<min and VertexSet[j]!=1)
							{
								min=GraphMatrix[i][j];
								edge=j;
							}
						}
						MinCost[i]=min;
						EdgeFrom[i]=edge;
					}
				}
				min=999;
				node=-1;
				for(int i=0;i<n;i++)
				{
					if(MinCost[i]<min and VertexSet[EdgeFrom[i]]!=1)
					{
						node=i;
						min=MinCost[i];
					}
				}
				MST[node][EdgeFrom[node]]=min;
				MST[EdgeFrom[node]][node]=min;
				VertexSet[EdgeFrom[node]]=1;
				ev++;
			}
			
			fstream fout;
			fout.open("/home/hp/Desktop/Final Codes/b8/Prac/normal.txt");
			for(int i=0;i<n;i++)
			{
				for(int j=0;j<n;j++)
				{
					fout<<MST[i][j]<<"\t";
				}
				fout<<"\n";
			}
		}
		
		void concprims()
		{
			int MinCost[n];
			int EdgeFrom[n];
			int VertexSet[n];
			int edge,node,min,ev=1;
			int MST[n][n];
			
			for(int i=0;i<n;i++)
			{
				MinCost[i]=999;
				EdgeFrom[i]=-1;
				VertexSet[i]=0;
			}
			for(int i=0;i<n;i++)
			{
				for(int j=0;j<n;j++)
				{
					MST[i][j]=999;
				}	
			}
			
			VertexSet[0]=1;
			while(ev!=n)
			{
				#pragma omp parallel num_threads(n)
				{
					int i=omp_get_thread_num();
					if(VertexSet[i]==1)
					{
						min=999;edge=-1;
						for(int j=0;j<n;j++)
						{
							if(GraphMatrix[i][j]<min and VertexSet[j]!=1)
							{
								min=GraphMatrix[i][j];
								edge=j;
							}
						}
						MinCost[i]=min;
						EdgeFrom[i]=edge;
					}
				}
				min=999;node=-1;
				for(int i=0;i<n;i++)
				{
					if(MinCost[i]<min and VertexSet[EdgeFrom[i]]!=1)
					{
						node=i;
						min=MinCost[i];
					}
				}
				MST[node][EdgeFrom[node]]=min;
				MST[EdgeFrom[node]][node]=min;
				VertexSet[EdgeFrom[node]]=1;
				ev++;
			}
			
			fstream fout;
			fout.open("/home/hp/Desktop/Final Codes/b8/Prac/conc.txt");
			for(int i=0;i<n;i++)
			{
				for(int j=0;j<n;j++)
				{
					fout<<MST[i][j]<<"\t";
				}
				fout<<"\n";
			}
		}
};

int main()
{
	int nodes;
	cout<<"Enter Number of Nodes:";
	cin>>nodes;
	Graph g(nodes);
	g.randomGenerator();
	g.toFile("/home/hp/Desktop/Final Codes/b8/Prac/graph.txt");
	g.normalprims();
	g.concprims();
	return 0;
}
