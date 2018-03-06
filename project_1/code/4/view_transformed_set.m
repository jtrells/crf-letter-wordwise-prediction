train_data = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
train_words = train_data.words;

transformed_data = matfile(strcat(pwd,'/code/4/transformed_training_data.mat'));
transformed_words = transformed_data.train_words;

% r 2551 15
% r 3213 15
% r 1327 15
% r 582 15
% t 1140 3 3
% t 843 3 3
% t 3037 3 3
% t 3386 3 3
% t 851 3 3


% afeteria
close all;
show_transformed(train_words, transformed_words, 3213);
show_transformed(train_words, transformed_words, 851);
%show_transformed(train_words, transformed_words, 1140);

image = reshape(train_words{3213}.image(:,1), 8, 16);
rotated_image = rotation(image, 15);
translated_image = translation(image, [3, 3]);
figure;imshow(rotated_image');
figure;imshow(translated_image');

%show_transformed(train_words, transformed_words, 582); 