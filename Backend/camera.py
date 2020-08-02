import cv2

ic=cv2.VideoCapture(0)

while(True):
	_,frame=ic.read()
	cv2.imshow("Feed",frame)
	if cv2.waitKey(1) & 0xFF == ord('q'):
		break

ic.release()
cv2.destroyAllWindows()