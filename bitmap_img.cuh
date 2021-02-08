#ifndef JULIAFRACTALPATTERN_BITMAP_IMG_CUH
#define JULIAFRACTALPATTERN_BITMAP_IMG_CUH


#include <fstream>

class bitmap_img {

    uint8_t **data;
    uint32_t _height, _width;

public:
    bitmap_img(uint32_t height,uint32_t width, uint8_t **bitmap = nullptr)
            : data(bitmap), _height(height), _width(width) {}

    void setData(uint8_t **pixels) {
        bitmap_img::data = pixels;
    }

    void write() {
        std::ofstream img("img.bmp", std::ios::binary);

        uint32_t h = _height, w = _width, s = 54 + (_height * _width * 3);

        unsigned char BMPHeader[14] = {
                'B', 'M',                   //bitmapSignature
                (unsigned char)(s),
                (unsigned char)(s >> 8),
                (unsigned char)(s >> 16),
                (unsigned char)(s >> 24),   //sizeOfBitmapFile
                0, 0, 0, 0,
                54, 0, 0, 0               //pixelDataOffset
        };

        unsigned char BMPInfoHeader[40] = {
                40, 0, 0, 0,              //sizeOfThisHeader
                (unsigned char)(w),
                (unsigned char)(w >> 8),
                (unsigned char)(w >> 16),
                (unsigned char)(w >> 24),   //widthInPixels
                (unsigned char)(h),
                (unsigned char)(h >> 8),
                (unsigned char)(h >> 16),
                (unsigned char)(h >> 24),   //heightInPixels
                1, 0,                       //numberOfColorPlanes
                24, 0,                      //colorDepth
                0, 0, 0, 0,
                0, 0, 0, 0,
                0, 0, 0, 0,
                0, 0, 0, 0,
                0, 0, 0, 0,
                0, 0, 0, 0,
        };

        img.write((char *)&BMPHeader, 14);
        img.write((char *)&BMPInfoHeader, 40);

        img.write((char *)(*data), h * w * 3);

        img.close();
    }

};


#endif //JULIAFRACTALPATTERN_BITMAP_IMG_CUH
