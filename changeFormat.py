from PIL import Image
import os
path=input("enter in path:")
opath=input("enter out path:")
os.chdir(path)
ls=os.listdir()
#os.mkdir(opath)
for image in ls:
	if(image.endswith(".jpg")):
		im1 = Image.open(os.path.join(path,image))
		im1.save(os.path.join(opath,image[:-4]+".jpeg"))
	elif(image.endswith(".xml")):
		with open(image,"r") as f:
			data=f.read()
		print(data)
		data=data.replace("jpg","jpeg")
		print(data)
		with open(os.path.join(opath,image),"w") as f:
			f.write(data)
			
