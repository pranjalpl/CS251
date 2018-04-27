#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>



#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);


__global__ void XOR(int *dA,int num, int offset){ 
      int i = blockIdx.x * blockDim.x + threadIdx.x;
      if(((i+offset) < num) && ((i%(2*offset)) == 0)){	
	  dA[i] = dA[i]^dA[i+offset];
      }
}

int main(int argc, char **argv){
    int num,ctr,blocks;
    int seed;
    int offset = 1;
    num = atoi(argv[1]);
    seed = atoi(argv[2]);
    
    int *hA;
  
    int *dA; 
   
    int size = num * sizeof(int); 

    /*Allocate memory on the host (CPU) */

    hA = (int *) malloc(size);
    if(!hA){
          perror("malloc");
          exit(-1);
    }
    
    /*Initialize hA*/

    srand(seed);
    for(ctr=0; ctr < num; ++ctr){
	    hA[ctr] = random();
    }
    
   /*Allocate memory on the device (GPU) */

    cudaMalloc(&dA,  size);
    CUDA_ERROR_EXIT("cudaMalloc");
   
    /*Copy hA --> dA */
    
    cudaMemcpy(dA, hA, size, cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("memcpy1");
    
    
     /*Invoke the kernel*/
    blocks = num /1024;
    
    if(num % 1024)
           ++blocks;
    
    for(offset = 1; offset < num; offset*=2){
	    XOR<<<blocks, 1024>>>(dA,num,offset);
	    CUDA_ERROR_EXIT("kernel invocation");
    }
   
    printf("kernel successful\n"); 

    /*Copy back results*/
    cudaMemcpy(hA, dA, size, cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");

    printf("%d\n", hA[0]);
    
    free(hA);  
    cudaFree(dA);
}
