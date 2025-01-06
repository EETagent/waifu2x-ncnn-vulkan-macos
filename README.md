<h1 align="center"><br><img width="175" alt="Waifu2X Icon" src="https://github.com/user-attachments/assets/bccc76b2-3d6c-428d-a599-7ce7f58e6976" /></h1>

<h3 align="center">Waifu2X</h3>
<p align="center">
    Tool for image magnification using the waifu2x/realsr model and Vulkan API.
    <br />
    <strong>Version: </strong>1.7
    <br />
    <br />
    <img src="https://img.shields.io/badge/macOS-12-purple.svg">
    <img src="https://img.shields.io/badge/Objective-C-gold.svg">
    <img src="https://img.shields.io/badge/Vulkan-🌋-red.svg">
    <img src="https://img.shields.io/badge/Apple-Silicon-black.svg">
    <img src="https://img.shields.io/badge/Intel-blue.svg">
    <br />
    <br />
  </p>
</p>


### Acknowledgement
- [waifu2x-ncnn-vulkan](https://github.com/nihui/waifu2x-ncnn-vulkan)
- [realsr-ncnn-vulkan](https://github.com/nihui/realsr-ncnn-vulkan)
- [ncnn](https://github.com/Tencent/ncnn)
- [Vulkan SDK](https://vulkan.lunarg.com/sdk/home)
- [Icon](https://macosicons.com/#/u/Appleseed)

### Thanks
Thanks to [@moeoverflow](https://github.com/moeoverflow) for the original repo.

Thanks to [@shincurry](https://github.com/shincurry) for contributing to the UI of this project.

### Usage

#### Single Mode
1. Click `Single` in the top tab.
2. Drag the image you want to enlarge to the left cell of the app.
3. Adjust the settings at the bottom.
4. Click `2x!` and the generated image will be displayed on the right.
5. Drag the image from the right cell to the location where you want to save it (the file name will be `waifu2x-output.png`).

![screenshot](.github/img/screenshot-v1.6-single-image.png)

#### Multiple Mode
1. Click `Multiple` in the top tab
2. Drag and drop images or directories into the table. (Only decodable images will be processed.)
3. Adjust the settings at the bottom
4. Click on `2x!` and the generated images will be saved to the location from where they originated with the `.png` extension. For example:

Input

```
.
├── 1
│   ├── IMG_2185.JPG
│   ├── IMG_2211.JPG
│   └── IMG_2212.JPG
├── 2
│   └── IMG_2208.PNG
└── IMG_2213.JPG
```

Output
```
.
.
├── 1
│   ├── IMG_2185.JPG
│   ├── IMG_2185.JPG.png
│   ├── IMG_2211.JPG
│   ├── IMG_2211.JPG.png
│   ├── IMG_2212.JPG
│   └── IMG_2212.JPG.png
├── 2
│   ├── IMG_2208.PNG
│   └── IMG_2208.PNG.png
├── IMG_2213.JPG
└── IMG_2213.JPG.png
```

![screenshot](.github/img/screenshot-v1.6-multiple-images.png)

#### Benchmark

To run the benchmark, click on `waifu2x-gui` -> `Benchmark`.

![screenshot](.github/img//screenshot-v1.6-benchmark.png)

### Build Instructions (macOS arm64)

Download the lastest Vulkan SDK at [https://vulkan.lunarg.com/sdk/home#mac](https://vulkan.lunarg.com/sdk/home#mac).

At the time of writing this README.md file, the latest version for macOS was 1.3.250.1.

Copy VulkanSDK/1.3.250.1 (or other version) as waifu2x-ncnn-vulkan-macos/waifu2x/VulkanSDK

```bash
brew install protobuf libomp

# if you have installed libomp before, you may have to forcefully reinstall it
brew link --force libomp

# clone this repo first
git clone --recursive --depth=1 https://github.com/EETagent/waifu2x-ncnn-vulkan-macos

# check your cmake installation
which cmake

# copy your VulkanSDK

cp -r /Users/mac/VulkanSDK/1.3.250.1 waifu2x-ncnn-vulkan-macos/waifu2x/VulkanSDK

# replace signing data in Xcode project and build app
xcodebuild
```

### Notice

Double check if all included libraries in the Xcode exists

## Speed Comparison between Macs

### Environment 0

- MacBook Pro 14-inch 2023
- macOS 14.0 (23A5286i)
- Apple M2 Max
- Apple M2 Max 30-core 32 GB

|Model|Image Size|Target Size|Block Size|Total Time(sec)|GPU Memory(MB)|
|---|---|---|---|---|---|
|models-cunet|200x200|400x400|400/200/100|0.25/0.23/0.22|240/240/49|
|models-cunet|400x400|800x800|400/200/100|0.38/0.34/0.36|944/240/49|
|models-cunet|1000x1000|2000x2000|400/200/100|1.17/1.17/1.28|962/241/49|
|models-cunet|2000x2000|4000x4000|400/200/100|3.86/4.03/4.48|964/258/50|
|models-cunet|4000x4000|8000x8000|400/200/100|14.53/15.21/17.23|987/261/67|
|models-upconv_7_anime_style_art_rgb|200x200|400x400|400/200/100|0.18/0.15/0.15|141/141/33|
|models-upconv_7_anime_style_art_rgb|400x400|800x800|400/200/100|0.22/0.20/0.21|539/141/33|
|models-upconv_7_anime_style_art_rgb|1000x1000|2000x2000|400/200/100|0.58/0.59/0.62|541/142/49|
|models-upconv_7_anime_style_art_rgb|2000x2000|4000x4000|400/200/100|1.89/1.93/2.06|543/159/50|
|models-upconv_7_anime_style_art_rgb|4000x4000|8000x8000|400/200/100|6.68/6.88/7.43|566/162/51|

noise: 2, scale: 2, gpuid: 0, tta mode: NO

### Environment 1

- MacBook Pro 15-inch 2018
- macOS 10.14.6 (18G103)
- Intel Core i9 8950HK
- AMD Radeon Pro Vega 20

|Model|Image Size|Target Size|Block Size|Total Time(sec)|GPU Memory(MB)|
|---|---|---|---|---|---|
|models-cunet|200x200|400x400|400/200/100|0.47/0.43/0.49|613/613/172|
|models-cunet|400x400|800x800|400/200/100|0.97/0.88/0.95|2407/614/173|
|models-cunet|1000x1000|2000x2000|400/200/100|3.56/3.61/4.18|2415/617/175|
|models-cunet|2000x2000|4000x4000|400/200/100|12.72/13.22/15.49|2420/669/193|
|models-cunet|4000x4000|8000x8000|400/200/100|49.79/51.51/60.60|2452/645/197|
|models-upconv_7_anime_style_art_rgb|200x200|400x400|400/200/100|0.26/0.24/0.20|460/460/119|
|models-upconv_7_anime_style_art_rgb|400x400|800x800|400/200/100|0.47/0.40/0.40|1741/460/120|
|models-upconv_7_anime_style_art_rgb|1000x1000|2000x2000|400/200/100|1.67/1.64/1.73|1765/463/121|
|models-upconv_7_anime_style_art_rgb|2000x2000|4000x4000|400/200/100|6.12/6.11/6.49|1769/466/122|
|models-upconv_7_anime_style_art_rgb|4000x4000|8000x8000|400/200/100|23.75/23.71/25.27|1801/489/142|

noise: 2, scale: 2, gpuid: 0, tta mode: NO

### Environment 2

- MacBook Pro 15-inch 2018
- macOS 10.14.6 (18G84)
- Intel Core i9 8850HK
- AMD Radeon 560X

|Model|Image Size|Target Size|Block Size|Total Time(sec)|GPU Memory(MB)|
|---|---|---|---|---|---|
|models-cunet|200x200|400x400|400/200/100|2.00/0.53/0.56|613/613/172|
|models-cunet|400x400|800x800|400/200/100|1.29/1.18/1.26|2407/614/173|
|models-cunet|1000x1000|2000x2000|400/200/100|5.20/5.17/5.85|2415/617/175|
|models-cunet|2000x2000|4000x4000|400/200/100|19.07/19.35/22.25|2420/669/193|
|models-cunet|4000x4000|8000x8000|400/200/100|74.49/76.73/88.12|2452/644/197|
|models-upconv_7_anime_style_art_rgb|200x200|400x400|400/200/100|0.31/0.27/0.27|460/460/119|
|models-upconv_7_anime_style_art_rgb|400x400|800x800|400/200/100|0.65/0.54/0.55|1741/460/119|
|models-upconv_7_anime_style_art_rgb|1000x1000|2000x2000|400/200/100|2.41/2.34/2.48|1765/463/121|
|models-upconv_7_anime_style_art_rgb|2000x2000|4000x4000|400/200/100|8.74/8.84/9.43|1769/466/122|
|models-upconv_7_anime_style_art_rgb|4000x4000|8000x8000|400/200/100|32.66/33.00/35.29|1801/489/142|

noise: 2, scale: 2, gpuid: 0, tta mode: NO

### Environment 3

- MacBook Pro 15-inch 2018
- macOS 10.14.6 (18G103)
- Intel Core i9 8950HK
- Intel UHD Graphics 630

|Model|Image Size|Target Size|Block Size|Total Time(sec)|GPU Memory(MB)|
|---|---|---|---|---|---|
|models-cunet|200x200|400x400|400/200/100|0.95/0.99/0.87|616/616/176|
|models-cunet|400x400|800x800|400/200/100|2.53/2.27/2.48|2408/616/176|
|models-cunet|1000x1000|2000x2000|400/200/100|12.40/12.00/13.31|2408/616/176|
|models-cunet|2000x2000|4000x4000|400/200/100|44.50/46.81/52.13|2408/669/196|
|models-cunet|4000x4000|8000x8000|400/200/100|175.64/185.56/222.58|2431/637/196|
|models-upconv_7_anime_style_art_rgb|200x200|400x400|400/200/100|1.07/1.27/0.83|466/466/125|
|models-upconv_7_anime_style_art_rgb|400x400|800x800|400/200/100|2.30/1.09/1.11|1746/466/125|
|models-upconv_7_anime_style_art_rgb|1000x1000|2000x2000|400/200/100|6.30/5.70/5.92|1762/466/125|
|models-upconv_7_anime_style_art_rgb|2000x2000|4000x4000|400/200/100|22.12/22.48/23.71|1762/466/125|
|models-upconv_7_anime_style_art_rgb|4000x4000|8000x8000|400/200/100|87.28/89.11/93.98|1780/482/141|

noise: 2, scale: 2, gpuid: 1, tta mode: NO

### Environment 4

- MacBook 12-inch Early 2016
- macOS 10.14.6 (18G84)
- Intel Core m7 6Y75
- Intel HD Graphics 515

|Model|Image Size|Target Size|Block Size|Total Time(sec)|GPU Memory(MB)|
|---|---|---|---|---|---|
|models-cunet|200x200|400x400|400/200/100|1.12/1.41/1.23|616/616/176|
|models-cunet|400x400|800x800|400/200/100|3.06/2.90/3.34|2408/616/176|
|models-cunet|1000x1000|2000x2000|400/200/100|18.29/17.81/19.89|2408/616/176|
|models-cunet|2000x2000|4000x4000|400/200/100|66.55/71.79/85.83|2408/665/196|
|models-cunet|4000x4000|8000x8000|400/200/100|288.38/337.44/385.85|2431/637/196|
|models-upconv_7_anime_style_art_rgb|200x200|400x400|400/200/100|0.63/0.69/0.53|466/466/125|
|models-upconv_7_anime_style_art_rgb|400x400|800x800|400/200/100|1.62/1.43/1.47|1746/466/125|
|models-upconv_7_anime_style_art_rgb|1000x1000|2000x2000|400/200/100|9.19/9.06/9.46|1762/466/125|
|models-upconv_7_anime_style_art_rgb|2000x2000|4000x4000|400/200/100|35.52/37.66/41.57|1762/466/125|
|models-upconv_7_anime_style_art_rgb|4000x4000|8000x8000|400/200/100|199.20/182.04/159.11|1780/482/141|

noise: 2, scale: 2, gpuid: 0, tta mode: NO

## Speed Comparison (not really) with waifu2x-caffe-cui & waifu2x-ncnn-vulkan

### Environment (waifu2x-caffe-cui & waifu2x-ncnn-vulkan)

- Windows 10 1809
- AMD R7-1700
- Nvidia GTX-1070
- Nvidia driver 419.67
- CUDA 10.1.105
- cuDNN 10.1

### Environment (waifu2x-ncnn-vulkan-macos)

- macOS 10.14.6 (18G103)
- Intel Core i9 8950HK
- AMD Radeon Pro Vega 20

### cunet

||Image Size|Target Size|Block Size|Total Time(s)|GPU Memory(MB)|
|---|---|---|---|---|---|
|waifu2x-ncnn-vulkan-macOS|200x200|400x400|400/200/100|0.46/0.44/0.43|621/621/180|
|waifu2x-ncnn-vulkan|200x200|400x400|400/200/100|0.86/0.86/0.82|638/638/197|
|waifu2x-caffe-cui|200x200|400x400|400/200/100|2.54/2.39/2.36|3017/936/843|
|waifu2x-ncnn-vulkan-macOS|400x400|800x800|400/200/100|0.91/0.84/0.92|2415/621/180|
|waifu2x-ncnn-vulkan|400x400|800x800|400/200/100|1.17/1.04/1.02|2430/638/197|
|waifu2x-caffe-cui|400x400|800x800|400/200/100|2.91/2.43/2.7|3202/1389/1178|
|waifu2x-ncnn-vulkan-macOS|1000x1000|2000x2000|400/200/100|3.54/3.58/4.18|2422/624/182|
|waifu2x-ncnn-vulkan|1000x1000|2000x2000|400/200/100|2.35/2.26/2.46|2430/638/197|
|waifu2x-caffe-cui|1000x1000|2000x2000|400/200/100|4.04/3.79/4.35|3258/1582/1175|
|waifu2x-ncnn-vulkan-macOS|2000x2000|4000x4000|400/200/100|12.83/13.25/15.44|2426/676/200|
|waifu2x-ncnn-vulkan|2000x2000|4000x4000|400/200/100|6.46/6.59/7.49|2430/686/213|
|waifu2x-caffe-cui|2000x2000|4000x4000|400/200/100|7.01/7.54/10.11|3258/1499/1200|
|waifu2x-ncnn-vulkan-macOS|4000x4000|8000x8000|400/200/100|49.56/51.44/60.56|2459/651/203|
|waifu2x-ncnn-vulkan|4000x4000|8000x8000|400/200/100|22.78/23.78/27.61|2448/654/213|
|waifu2x-caffe-cui|4000x4000|8000x8000|400/200/100|18.45/21.85/31.82|3325/1652/1236|

### upconv_7_anime_style_art_rgb

||Image Size|Target Size|Block Size|Total Time(s)|GPU Memory(MB)|
|---|---|---|---|---|---|
|waifu2x-ncnn-vulkan-macOS|200x200|400x400|400/200/100|0.23/0.20/0.22|465/465/125|
|waifu2x-ncnn-vulkan|200x200|400x400|400/200/100|0.74/0.75/0.72|482/482/142|
|waifu2x-caffe-cui|200x200|400x400|400/200/100|2.04/1.99/1.99|995/546/459|
|waifu2x-ncnn-vulkan-macOS|400x400|800x800|400/200/100|0.49/0.42/0.41|1747/466/125|
|waifu2x-ncnn-vulkan|400x400|800x800|400/200/100|0.95/0.83/0.81|1762/482/142|
|waifu2x-caffe-cui|400x400|800x800|400/200/100|2.08/2.12/2.11|995/546/459|
|waifu2x-ncnn-vulkan-macOS|1000x1000|2000x2000|400/200/100|1.67/1.60/1.68|1770/468/127|
|waifu2x-ncnn-vulkan|1000x1000|2000x2000|400/200/100|1.52/1.41/1.44|1778/482/142|
|waifu2x-caffe-cui|1000x1000|2000x2000|400/200/100|2.72/2.60/2.68|1015/570/459|
|waifu2x-ncnn-vulkan-macOS|2000x2000|4000x4000|400/200/100|6.11/5.89/6.18|1774/472/128|
|waifu2x-ncnn-vulkan|2000x2000|4000x4000|400/200/100|3.45/3.42/3.63|1778/482/142|
|waifu2x-caffe-cui|2000x2000|4000x4000|400/200/100|3.90/4.01/4.35|1015/521/462|
|waifu2x-ncnn-vulkan-macOS|4000x4000|8000x8000|400/200/100|22.92/22.70/24.16|1806/495/147|
|waifu2x-ncnn-vulkan|4000x4000|8000x8000|400/200/100|11.16/11.29/12.07|1796/498/158|
|waifu2x-caffe-cui|4000x4000|8000x8000|400/200/100|9.24/9.81/11.16|995/546/436|
