//
// Created by ADMIN on 08-02-2021.
//

#ifndef JULIAFRACTALPATTERN_COMPLEX_CUH
#define JULIAFRACTALPATTERN_COMPLEX_CUH


struct complex {
    float r, i;
    __device__ complex(float, float);
    __device__ complex operator+(complex &k) const;
    __device__ complex operator*(complex &k) const;
    __device__ float magnitude() const;
};


#endif //JULIAFRACTALPATTERN_COMPLEX_CUH
