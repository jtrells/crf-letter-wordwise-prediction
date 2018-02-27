% Side note: To avoid problems with the relative path, make sure
% your matlab current folder is project_1

global WORD_LENGTH LETTER_SIZE NUM_LETTERS ALPHABET;

WORD_LENGTH = 100;
LETTER_SIZE = 128;
NUM_LETTERS = 26;
ALPHABET = 'abcdefghijklmnopqrstuvwxyz';

[x, w, T] = loadDecoderSet('/data/decode_input.txt'); 

% Initialize memo table for first character against alphabet
memo = zeros(1,NUM_LETTERS);
subword = [];
for i = 1 : NUM_LETTERS
    memo(i) = dot(w(:,i), x(:,1));
    subword{i} = ALPHABET(i);
end

% For each of the next 99 characters.
for j = 2 : WORD_LENGTH
    next_memo = zeros(1,NUM_LETTERS);
    
    % For each alphabetic letter, check with memoized subword + this
    % letter has the best potential
    for i = 1 : NUM_LETTERS
        max_potential = -1000;
        max_potential_k = -1;
        
        for k = 1 : NUM_LETTERS
            potential = T(k,i) + memo(k);
            if potential > max_potential
                max_potential = potential;
                max_potential_k = k;
            end
        end
        
        next_memo(i) = dot(w(:,i), x(:,j)) + max_potential;
        new_subword{i} = strcat(subword{max_potential_k}, ALPHABET(i));
    end
    
    memo = next_memo;
    subword = new_subword;
end

% Get the maximum value from the memoized table
[value, ind] = max(memo);
value
word = subword{ind}

% Output requirements: 1 letter {1..26} per line
output = zeros(1, WORD_LENGTH);
for i = 1 : length(word)
    output(i) = strfind(ALPHABET, word(i));
end

fileId = fopen('result/decode_output.txt', 'wt');
fprintf(fileId, '%d\n',output');
fclose(fileId);