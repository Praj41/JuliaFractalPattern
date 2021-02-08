#include "complex.cuh"

__device__ complex::complex(float real, float img) : r(real), i(img) {}

__device__ complex complex::operator+(complex &k) const {
    return {r+k.r, i+k.i};
}

__device__ complex complex::operator*(complex &k) const {
    return {r*k.r - i*k.i, i*k.r + r*k.i};
}

__device__ float complex::magnitude() const {return r*r + i*i;}

