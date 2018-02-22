function [ x, w, T ] = loadDecoderSet( filepath )

global WORD_LENGTH LETTER_SIZE NUM_LETTERS;
Input = importdata(filepath);

% Divide the input data into letters and parameters
index_w = WORD_LENGTH * LETTER_SIZE + 1;
index_T = index_w + LETTER_SIZE * NUM_LETTERS;

% Reshape vector into matrix where each column is a letter/weight
x = reshape(Input(1 : index_w - 1), LETTER_SIZE, WORD_LENGTH);
w = reshape(Input(index_w : index_T - 1), LETTER_SIZE, NUM_LETTERS);

T = reshape(Input(index_T:end), 26, 26); 

end

