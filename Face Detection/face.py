import face_recognition as fr
import os
import cv2
import face_recognition
import numpy as np
from time import sleep
from PIL import Image
from datetime import datetime
import firebase_admin
import random
from datetime import datetime
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate('akey.json')

firebase_admin.initialize_app(cred)
# def fn(NAME):
#   with open(NAME,"rb") as f:
#     data=f.read()
#     from base64 import urlsafe_b64encode,urlsafe_b64decode
#     base64data=urlsafe_b64encode(data)

SAVE_PATH="C:\\face_rec\\unknown"

def get_encoded_faces():
    encoded = {}

    for dirpath, dnames, fnames in os.walk("./faces"):
        for f in fnames:
            if f.endswith(".jpg") or f.endswith(".png"):
                face = fr.load_image_file("faces/" + f)
                encoding = fr.face_encodings(face)[0]
                encoded[f.split(".")[0]] = encoding

    return encoded


def unknown_image_encoded(img):
    face = fr.load_image_file("faces/" + img)
    encoding = fr.face_encodings(face)[0]

    return encoding


def classify_face(im):
    faces = get_encoded_faces()
    faces_encoded = list(faces.values())
    known_face_names = list(faces.keys())

    img = cv2.imread(im, 1)
 
    face_locations = face_recognition.face_locations(img)
    unknown_face_encodings = face_recognition.face_encodings(img, face_locations)

    face_names = []
    for face_encoding in unknown_face_encodings:
        matches = face_recognition.compare_faces(faces_encoded, face_encoding)
        name = "Unknown"
        img2=img.copy()
        NAME=SAVE_PATH+"\\"+datetime.now().strftime("%d-%m-%Y_%H-%M-%S")+".jpeg"
        print(NAME)
        img3=Image.fromarray(img)
        img3.save(NAME)
        with open(NAME,"rb") as f:
            data=f.read()
            from base64 import urlsafe_b64encode,urlsafe_b64decode
            base64data=urlsafe_b64encode(data)
            #important if you are using flutter as frontend
            ims=base64data.decode('ascii')
        db=firestore.client()
        id=random.random()
        doc_ref = db.collection('Alert').document(str(id))  
        doc_ref.set({
                    'alertId':str(id),
                    'classId':'100',
                    'className':'CO6IC',
                    'img':str(ims),
                    'name':'UNKNOWN PERSON DETECTED',
                    'timestamp':str(datetime.now()),
                    'verify':'0'
            })



        face_distances = face_recognition.face_distance(faces_encoded, face_encoding)
        best_match_index = np.argmin(face_distances)
        if matches[best_match_index]:
            name = known_face_names[best_match_index]

        face_names.append(name)

        for (top, right, bottom, left), name in zip(face_locations, face_names):
            # Draw a box around the face
            cv2.rectangle(img, (left-20, top-20), (right+20, bottom+20), (255, 0, 0), 2)

            # Draw a label with a name below the face
            cv2.rectangle(img, (left-20, bottom -15), (right+20, bottom+20), (255, 0, 0), cv2.FILLED)
            font = cv2.FONT_HERSHEY_DUPLEX
            cv2.putText(img, name, (left -20, bottom + 15), font, 1.0, (255, 255, 255), 2)


    # Display the resulting image
    while True:

        cv2.imshow('Video', img)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            return face_names 


print(classify_face("test2.jpg"))

