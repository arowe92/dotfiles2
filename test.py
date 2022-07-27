
# Importing all necessary libraries
from keras.preprocessing.image import ImageDataGenerator, img_to_array
from keras.preprocessing.image import load_img
from keras.models import Sequential
import keras.utils as utils
from keras.layers import Conv2D, MaxPooling2D
from keras.layers import Activation, Dropout, Flatten, Dense
from keras import backend as K
from logging import basicConfig, ERROR
from pathlib import Path

basicConfig(level=ERROR)

img_width, img_height = 224, 224

train_data_dir = Path(__file__).parent / 'train'
validation_data_dir = Path(__file__).parent / 'test'
nb_train_samples = 8
nb_validation_samples = 8
epochs = 10
batch_size = 8


if K.image_data_format() == 'channels_first':
    input_shape = (3, img_width, img_height)
else:
    input_shape = (img_width, img_height, 3)


model = Sequential()
model.add(Conv2D(32, (2, 2), input_shape=input_shape))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Conv2D(32, (2, 2)))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Conv2D(64, (2, 2)))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Flatten())
model.add(Dense(64))
model.add(Activation('relu'))
model.add(Dropout(0.5))
model.add(Dense(1))
model.add(Activation('sigmoid'))

model.compile(loss='binary_crossentropy',
              optimizer='rmsprop',
              metrics=['accuracy'])

train_datagen = ImageDataGenerator(
    rescale=1. / 255,
    shear_range=0.2,
    zoom_range=0.2,
    horizontal_flip=True)

test_datagen = ImageDataGenerator(rescale=1. / 255)

train_generator = train_datagen.flow_from_directory(
    train_data_dir,
    target_size=(img_width, img_height),
    batch_size=batch_size,
    class_mode='binary')

validation_generator = test_datagen.flow_from_directory(
    validation_data_dir,
    target_size=(img_width, img_height),
    batch_size=batch_size,
    class_mode='binary')

import json
import numpy as np
# data = train_generator.next()[0]
data = img_to_array(load_img(train_data_dir / "train/rodent5.png", target_size=(224, 224)))
data = np.array([data]);

print(data.shape);
# print(data)
print(json.dumps({
     "result": float(model.predict(data)[0][0])
}))

model.fit(
    train_generator,
    steps_per_epoch=nb_train_samples // batch_size,
    epochs=epochs,
    validation_data=validation_generator,
    validation_steps=nb_validation_samples // batch_size,
    verbose = 0)

