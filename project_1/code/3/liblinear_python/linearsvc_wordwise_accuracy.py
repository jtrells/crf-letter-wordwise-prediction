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
testFile = "test_struct_words.txt"
@mem.cache
def get_data(filename):
    data = load_svmlight_file(filename)
    return data[0], data[1]

X,y = get_data(trainFile)
# print(y)
X_test, y_test = get_data(testFile)
totalaccuracy = [0,1,2,3,4,5]
# params = []
params = [1.120744357158632e-8, 1.120744357158632e-7, 1.120744357158632e-6, 5.603721785793162e-6,1.120744357158632e-5,5.603721785793162e-5]
for i in range(len(params)):
#     print(params[i])
    clf = LinearSVC(C=params[i],multi_class='ovr',random_state=0)
    clf.fit(X, y)
    predicted = clf.predict(X_test)
#     print(predicted)
    accuracy = metrics.accuracy_score(y_test,predicted)
    percentage = accuracy*100
    totalaccuracy[i] = percentage
print(totalaccuracy)