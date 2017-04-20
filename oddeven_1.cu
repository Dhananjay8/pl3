#include"iostream"
  using namespace std;
  __global__ void sort(int *in, int n)
  {
       int temp;
       bool oddeven=true;
      __shared__ bool oddswap, evenswap;          // shared variables only, don't use private ones
       while(true)
       {
            if(oddeven==true)                         // Even turn
            {
                 __syncthreads();
                evenswap=false;
                 __syncthreads();
                      int idx=threadIdx.x;
                      if(idx<(n/2))
                      {
                           if (in[2*idx]>in[2*idx+1] )          // swapping
                           {
                                temp = in[2*idx];
                                in[2*idx]=in[2*idx+1];
                                in[2*idx+1]=temp;
                                evenswap=true;
                           }
                      }
                 __syncthreads();
            }
            else                                        // odd turn
            {
                 __syncthreads();
                 oddswap=false;
                 __syncthreads();
                      int idx=threadIdx.x;
                      if(idx<(n/2))
                      {
                           if (in[2*idx+1]>in[2*idx+2] && (2*idx+2)<n)     // swapping
                           {
                                temp= in[2*idx+1];
                                in[2*idx+1]=in[2*idx+2];
                                in[2*idx+2]=temp;
                                oddswap=true;
                           }
                      }
                 __syncthreads();
           }
            if(!(oddswap||evenswap))               // when to stop
                 break;
            oddeven=!oddeven;
       }
  }
  int main()
  {
       int *a, *d_a, n;
       cout<<"\nEnter no. of elements you want to sort: ";
       cin>>n;
       size_t size = sizeof(int)*n;
      a = new int[n];                         // allocate size for a on main memory(RAM)
      cudaMalloc((void**)&d_a, size);             // allocate size for a on global memory(GPU memory)
       cout<<"\n\nEnter no.s to be sorted: \n";
       for(int i=0;i<n;i++)
       {
            cin>>a[i];
       }
       cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
       sort<<<1,n/2>>>(d_a,n);
       cudaMemcpy(a, d_a, size, cudaMemcpyDeviceToHost);
       cout<<"\nSorted array is: \n";
       for (int i=0;i<n;i++)
       {
            cout<<a[i]<<" ";
       }
       delete(a);               // free allocated space from main memory & global memory
       cudaFree(d_a);
       return 0;
 }
