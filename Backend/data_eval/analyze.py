from keras.metrics import categorical_accuracy
import tensorflow as tf 
from tensorflow.keras.models import Sequential
import tensorflow.keras.optimizers as ko
from tensorflow.keras.layers import Dense, Dropout, Activation, Flatten, Conv2D, MaxPooling2D
import pickle
from keras.models import model_from_json
from keras.models import load_model
# import matplotlib.pyplot as plt

X = pickle.load(open("X.pickle", "rb"))
y = pickle.load(open("y.pickle", "rb"))

X = X/255.0

model = Sequential()
model.add(Conv2D(64, (3, 3), input_shape = X.shape[1:], activation='relu'))
model.add(MaxPooling2D(pool_size=(2,2)))

model.add(Conv2D(64, (3, 3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2,2)))

model.add(Conv2D(64, (3, 3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2,2)))
model.add(Dropout(0.10))

model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dense(128, activation='relu'))
# model.add(Dense(64, activation='sigmoid'))
model.add(Dense(1, activation='sigmoid'))

ada = ko.Adam(learning_rate=0.001, beta_1=0.9, beta_2=0.999, amsgrad=False)
model.compile(loss='binary_crossentropy', optimizer=ada, metrics=['accuracy'])

model.fit(X, y, epochs=3, validation_split=0.3)

model_json = model.to_json()
with open("model.json", "w") as json_file :
	json_file.write(model_json)

model.save("model.h5")
print("Saved model to disk")
