% Side note: To avoid problems with the relative path, make sure
% your matlab current folder is project_1

global WORD_LENGTH LETTER_SIZE NUM_LETTERS;
% to avoid passing them through the recursion
global X W T word max_potential max_word WORD_RECURSION_LENGTH;

WORD_LENGTH = 100;
LETTER_SIZE = 128;
NUM_LETTERS = 26;
WORD_RECURSION_LENGTH = 4;

[X, W, T] = loadDecoderSet('/data/decode_input.txt'); 

max_potential = -1000;
max_word = zeros(1, WORD_LENGTH);

% Create all possible combinations for words
% of max size WORD_RECURSION_LENGTH
for i = 1 : NUM_LETTERS
    word = [];
    word(1) = i;
    
    p = dot(W(:,i), X(:, 1));
    bruteForcePotential(p, 2); 
end

fileId = fopen('result/decode_output2.txt', 'wt');
fprintf(fileId, '%d\n', max_word);
fclose(fileId);