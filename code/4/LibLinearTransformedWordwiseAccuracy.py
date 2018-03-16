from sklearn.externals.joblib import Memory
from sklearn.datasets import load_svmlight_file
from sklearn.svm import LinearSVC
from sklearn.datasets import make_classification
from sklearn import metrics 
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import label_binarize
import matplotlib.pyplot as plt
mem = Memory("./mycache")

trainFile = "train_struct_words.txt"
@mem.cache
def get_data(filename):
    data = load_svmlight_file(filename)
    return data[0], data[1]

X,y = get_data(trainFile)
clf = LinearSVC(C=5.603721785793162e-6,multi_class='ovr',random_state=0)
clf.fit(X, y)

totalaccuracy = [0,1,2,3]
params = ['words_500.txt', 'words_1000.txt','words_1500.txt','words_2000.txt']
for i in range(len(params)):
    X_test, y_test = get_data(params[i])
    predicted = clf.predict(X_test)
    accuracy = metrics.accuracy_score(y_test,predicted)
    percentage = accuracy*100
    totalaccuracy[i] = percentage
print(totalaccuracy)