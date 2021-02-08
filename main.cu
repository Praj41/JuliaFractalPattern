#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>

#include "complex.cuh"
#include "bitmap_img.cuh"

#define LOG_INPUT if(0)
#define LOG_OUTPUT if(1)
#define LOG if(0)
#define DIM1 1024
#define DIM2 1024

__device__ int julia ( int x , int y ) {
    const float scale = 1.5;
    float jx = scale * (float)( DIM1 /2 - x) /( DIM1 /2) ;
    float jy = scale * (float)( DIM2 /2 - y) /( DIM2 /2) ;
    complex c ( -0.8 ,0.154) ;
    complex a(jx , jy);
    int i = 0;
    for (i =0; i <200; i ++) {
        a = a* a + c;
        if (a.magnitude() > 1000)
            return 0; // return 0 if (x , y) is not in set
    }
    return 1; // return 1 if (x , y) is in set
}

__global__ void kernel(unsigned char *ptr) {
    int x = blockIdx.x;
    int y = blockIdx.y;
    unsigned int offset = x + y * gridDim.x;

    int juliaVal = julia(x, y);
    ptr[offset*3 + 2] = 255 * juliaVal;
    ptr[offset*3 + 1] = 0;
    ptr[offset*3 + 0] = 0;
}

int main()
{
    // Error code to check return values for CUDA calls
    cudaError_t err = cudaSuccess;

    unsigned char *dev_bitmap;

    cudaMalloc((void**)&dev_bitmap, DIM1 * DIM2 * 3);

    dim3 grid(DIM1, DIM2);

    kernel<<<grid, 1>>>(dev_bitmap);

    auto *h_bitmap = (unsigned char*) malloc(DIM1 * DIM2 * 3);

    cudaMemcpy(h_bitmap, dev_bitmap, DIM1 * DIM2 * 3, cudaMemcpyDeviceToHost);

    cudaFree(dev_bitmap);

    bitmap_img image(DIM2, DIM1, &h_bitmap);

    image.write();

    free(h_bitmap);

    return 0;
}
