
global NUM_LETTERS;
NUM_LETTERS = 26;

[w, T] = loadModel(strcat(pwd,'\code\2\model.txt'));
data = matfile(strcat(pwd,'\code\2\train_words_x.mat'));
words = data.words;

x = words{1}.image;
% num_letters = size(words{1}.letter_number,2);
% 
% Phi = reshape(w, 128*26, 1);
% Phi = [Phi; reshape(T, 26*26,1)];
% 
% XY = [reshape(x, num_letters * 128, 1)];
% XY = [XY; words{1}.letter_number'];
% XY = [XY; num_letters];

% build small test case, alphabet_size = 3
NUM_LETTERS = 3;

alphabet_size = 3;
w = w(:,1:3);
t = T(1:3,1:3);
x = words{1}.image(:,1:3);
y = [2 1 3];
num_letters = size(y,2);

Phi = reshape(w, 128*alphabet_size,1);
Phi = [Phi; reshape(t, alphabet_size * alphabet_size,1)];
XY = reshape(x, num_letters * 128, 1);
XY = [XY; y'];
XY = [XY; num_letters];

p = getLogProbYGivenXT(XY, w, t);

g = @(XY) getLogProbYGivenXT(XY,w,t,alphabet_size);

%y = reshape(x, num_letters * 128, 1);

[a, b] = gradest(g,XY);