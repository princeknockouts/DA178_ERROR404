import firebase_admin
import random
from datetime import datetime
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate('akey.json') #give the path as well as the credentials of the downloaded file        

firebase_admin.initialize_app(cred)

db=firestore.client()
id=random.random()
doc_ref = db.collection('Alert').document(str(id))               # Creating a new document to store the code
	
doc_ref.set({
					'alertId':str(id),
					'classId':'100',
					'className':'CO6IC',
					'img':'dsgs',
					'name':'Copying',
					'timestamp':datetime.now(),
					'verify':'0'
			})
            
            #create an environment and download the library 'pip install firebase_admin'
            
            
            
          