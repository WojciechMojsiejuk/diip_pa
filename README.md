# diip_pa
Digital Imaging and Image Preprocessing Practical Assignment

Pre-processing

1. Data loading (image) -> data + 6x1 class
2. Calibration
- [Chessboard detection](https://docs.opencv.org/3.0.0/d9/d0c/group__calib3d.html#ga6a10b0bb120c4907e5eabbcd22319022)

*STEPS:*

1. Measuring geometry

- [Hough Circle Transform][https://se.mathworks.com/help/images/ref/imfindcircles.html]
(detect circles in the image, then use the information about their radii in prediction, convert pixel values to milimiters)
- [OpenCV 1](https://dev.to/tinazhouhui/coin-detection-discovering-opencv-with-python-1ka1).
- [OpenCV 2](https://dev.to/tinazhouhui/coin-amount-calculation-discovering-opencv-with-python-52gn)
- [OpenCV 3](https://docs.opencv.org/4.x/d3/db4/tutorial_py_watershed.html?fbclid=IwAR2_SYNdkmvdvxSRO3RvLcmKP8yq2s3wizs_pLUK6EsA_snwiX0I94BTC5Y)
- [Detecting checkerboard][https://se.mathworks.com/matlabcentral/answers/24467-identifying-objects-in-a-picture-containing-several-objects]
2. Measuring colors

- [White balance][https://se.mathworks.com/help/images/comparison-of-auto-white-balance-algorithms.html]
- Reference image of the coins color
- Binary thresholding to segment coins from background
- Gaussian blur to reduce the noise in the image
- K-means clustering to simplify the detected coin to two colors (k=2, because 
- Compute the distance of the colors to the model coins colors and choose one with the smallest distance

3. Measuring intensity
- ?
- histogram comparisions?

4. Measuring image objects
-?
- cNN convolutional neural network to detect objects?
