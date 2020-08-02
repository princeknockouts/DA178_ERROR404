 import firebase_admin

from firebase_admin import credentials
from firebase_admin import firestore


 cred = credentials.Certificate('')

 #give the path as well as the credentials of the downloaded file        

    firebase_admin.initialize_app(cred)

    db=firestore.client()

    doc_ref = db.collection('encoded').document('e')               # Creating a new document to store the code

    doc_ref.set(
    {
    'ename':''                                               #VALUE COMES HERE
    })