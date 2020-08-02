import imghdr     
import os
ls=os.listdir()
for file in ls:
	if not file.endswith(".xml"):    
	    image = cv2.imread(file)
	    file_type = imghdr.what(file)  
	    if file_type != 'jpeg':  
	        print(file +  " - invalid - " +  str(file_type))  
	        cv2.imwrite(file, image)