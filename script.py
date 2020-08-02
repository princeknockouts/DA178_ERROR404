
import os
import pathlib
import numpy as np
from datetime import datetime
#import os
import six.moves.urllib as urllib
import sys
import tarfile
import tensorflow as tf
import zipfile

from collections import defaultdict
from io import StringIO
from matplotlib import pyplot as plt
from PIL import Image
from IPython.display import display

from object_detection.utils import ops as utils_ops
from object_detection.utils import label_map_util
from object_detection.utils import visualization_utils as vis_util

# patch tf1 into `utils.ops`
utils_ops.tf = tf.compat.v1

# Patch the location of gfile
tf.gfile = tf.io.gfile
tf.compat.v1.enable_eager_execution()
MODEL_PATH="C:\\tensorflow1\\models\\research\\object_detection\\faster_rcnn"
SAVE_PATH="C:\\tensorflow1\\models\\research\\object_detection\\saved_images"

try:
  os.mkdir(SAVE_PATH)
except:
  pass

def load_model():
  model_dir = f"{MODEL_PATH}/saved_model"
  model = tf.compat.v2.saved_model.load(str(model_dir), None)
  #model = tf.saved_model.load(export_dir=model_dir,tags=None)
  return model

# List of the strings that is used to add correct label for each box.
PATH_TO_LABELS = f'{MODEL_PATH}/labelmap.pbtxt'
category_index = label_map_util.create_category_index_from_labelmap(PATH_TO_LABELS, use_display_name=True)


detection_model = load_model()

detection_model.signatures['serving_default'].output_dtypes

detection_model.signatures['serving_default'].output_shapes

def run_inference_for_single_image(model, image ):
  #image = np.asarray(image)
  # The input needs to be a tensor, convert it using `tf.convert_to_tensor`.
  input_tensor = tf.convert_to_tensor(image)
  # The model expects a batch of images, so add an axis with `tf.newaxis`.
  input_tensor = input_tensor[tf.newaxis,...]

  # Run inference
  model_fn = model.signatures['serving_default']
  output_dict = model_fn(input_tensor)

  # All outputs are batches tensors.
  # Convert to numpy arrays, and take index [0] to remove the batch dimension.
  # We're only interested in the first num_detections.
  num_detections = int(output_dict.pop('num_detections'))
  output_dict = {key:value[0, :num_detections].numpy() 
                 for key,value in output_dict.items()}
  output_dict['num_detections'] = num_detections

  # detection_classes should be ints.
  output_dict['detection_classes'] = output_dict['detection_classes'].astype(np.int64)
   
  # Handle models with masks:
  if 'detection_masks' in output_dict:
    # Reframe the the bbox mask to the image size.
    detection_masks_reframed = utils_ops.reframe_box_masks_to_image_masks(
              output_dict['detection_masks'], output_dict['detection_boxes'],
               image.shape[0], image.shape[1])      
    detection_masks_reframed = tf.cast(detection_masks_reframed > 0.5,
                                       tf.uint8)
    output_dict['detection_masks_reframed'] = detection_masks_reframed.numpy()
    
  return output_dict

def show_inference(model, image_path):
  # the array based representation of the image will be used later in order to prepare the
  # result image with boxes and labels on it.
  image_np = np.array(Image.open(image_path))
  # Actual detection.
  output_dict = run_inference_for_single_image(detection_model, image_np)
  # Visualization of the results of a detection.
  vis_util.visualize_boxes_and_labels_on_image_array(
      image_np,
      output_dict['detection_boxes'],
      output_dict['detection_classes'],
      output_dict['detection_scores'],
      category_index,
      instance_masks=output_dict.get('detection_masks_reframed', None),
      use_normalized_coordinates=True,
      line_thickness=8)

  display(Image.fromarray(image_np))


# def fn(NAME):
#   with open(NAME,"rb") as f:
#     data=f.read()
    #from base64 import urlsafe_b64encode,urlsafe_b64decode
    #base64data=urlsafe_b64encode(data)

import cv2
ic=cv2.VideoCapture(0)

while(True):
  _,frame=ic.read()
  cv2.imshow("Feed",frame)
  frame1=frame.copy()
  output_dict = run_inference_for_single_image(detection_model, frame1)
  # Visualization of the results of a detection.
  vis_util.visualize_boxes_and_labels_on_image_array(
      frame1,
      output_dict['detection_boxes'],
      output_dict['detection_classes'],
      output_dict['detection_scores'],
      category_index,
      instance_masks=output_dict.get('detection_masks_reframed', None),
      use_normalized_coordinates=True,
      line_thickness=8)

  count=0
  for x in output_dict["detection_scores"]:
    if(x>0.5):
        count+=1
  criteria=list(output_dict["detection_classes"][0:count])
  c_set=set(criteria)
  found=""
  d={}
  for item in c_set:
    item_name=category_index[item]["name"]
    if item_name in d:
      d[item_name]+=1
    else:
      d[item_name]=1

  if("cell phone" in d):
    print(d)
    NAME=SAVE_PATH+"\\"+datetime.now().strftime("%d-%m-%Y_%H-%M-%S")+".jpeg"
    print(NAME)
    img=Image.fromarray(frame1)
    img.save(NAME)
  cv2.imshow("Output",frame1)
  # fn(NAME)
  if cv2.waitKey(1) & 0xFF == ord('q'):
    break


ic.release()
cv2.destroyAllWindows()