% Side note: To avoid problems with the relative path, make sure
% your matlab current folder is project_1

global WORD_LENGTH LETTER_SIZE NUM_LETTERS ALPHABET;

WORD_LENGTH = 100;
LETTER_SIZE = 128;
NUM_LETTERS = 26;

[x, w, T] = loadDecoderSet('/data/decode_input.txt'); 

max_potential = -1000;
max_word = zeros(1, WORD_LENGTH);

function recurse = f(word, p, depth)
    if depth < WORD_LENGTH
        for i = 1 : NUM_LETTERS
            word(depth) = i;
            potential = dot(w(:,i), x(:,depth)) + T(word(depth - 1), i);
            f(word, p + potential, depth + 1);
        end
    elseif p > max_potential
        max_potential = p;
        max_word = copy(word); % deep clone since original gets mutated
    end
end

for i = 1 : NUM_LETTERS
    f([i], dot(w(:,i), x(:, 0), 1);
end

fileId = fopen('result/decode_output2.txt', 'wt');
fprintf(fileId, '%d\n', max_word);
fclose(fileId);