cmake_minimum_required(VERSION 3.19)
project(JuliaFractalPattern CUDA)

set(CMAKE_CUDA_STANDARD 14)

add_executable(JuliaFractalPattern main.cu complex.cu complex.cuh bitmap_img.cuh)

set_target_properties(
        JuliaFractalPattern
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)