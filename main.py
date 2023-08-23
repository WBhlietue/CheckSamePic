import cv2
import numpy as np
import sys
import os


def GetRate(img1Url, img2Url):
    image1 = cv2.imread(img1Url)
    image2 = cv2.imread(img2Url)
    (height, width, channel) = image1.shape
    image1 = cv2.resize(image1, (width, height))
    image2 = cv2.resize(image2, (width, height))
    mse = calculate_mse(image1, image2)
    return mse


def calculate_mse(image1, image2):
    diff = cv2.absdiff(image1, image2)
    mse = np.mean(diff ** 2)
    return mse


a = GetRate(sys.argv[1:][0], sys.argv[1:][1])
print(a)


# folder_path = "images"
# file_names = os.listdir(folder_path)

# for i in range(len(file_names)):
#     for j in range(i, len(file_names)):
#         if(i >= j):
#             continue
#         print(GetRate(folder_path + "/" + file_names[i], folder_path + "/" + file_names[j]))
#         print(i)
