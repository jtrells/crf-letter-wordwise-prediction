function [ w, T ] = loadModel( filepath )

global LETTER_SIZE NUM_LETTERS;
Input = importdata(filepath);

% Divide the input data into letters and parameters
index_T = LETTER_SIZE * NUM_LETTERS;

w = reshape(Input(1 : index_T), LETTER_SIZE, NUM_LETTERS);
T = reshape(Input(index_T+1:end), 26, 26); 

end
