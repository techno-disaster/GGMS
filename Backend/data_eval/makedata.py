import numpy as np
import os
# from matplotlib import pyplot as plt
import cv2
import random
import pickle
import keras


file_list = []
class_list = []

DATADIR = "data"

# All the categories you want your neural network to detect
CATEGORIES = ["pothole","garbage"]

# The size of the images that your neural network will use
IMG_SIZE = 100

img_array=[]

# Checking or all images in the data folder
training_data = []
X = [] #features
y = [] #labels
def create_training_data():
    for category in CATEGORIES :
        class_num = CATEGORIES.index(category)
        print("class_num ___________________")
        print(class_num)
        print("class_num ___________________")
        i = 0
        path = os.path.join(DATADIR, category)
        for img in os.listdir(path):
            i+=1
            try :
                print(i)
                img_array = cv2.imread(os.path.join(path, img), cv2.IMREAD_GRAYSCALE)
                new_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE))
                X.append(new_array)
                y.append(class_num)
            except Exception as e:
                pass
create_training_data()

X = np.array(X).reshape(-1, IMG_SIZE, IMG_SIZE, 1)
y = np.array(y)
indices = np.arange(X.shape[0])
np.random.shuffle(indices)

X = X[indices]
y = y[indices]

keras.utils.to_categorical(y, num_classes=2)

# Creating the files containing all the information about your model
pickle_out = open("X.pickle", "wb")
pickle.dump(X, pickle_out)
pickle_out.close()

pickle_out = open("y.pickle", "wb")
pickle.dump(y, pickle_out)
pickle_out.close()
print(X)