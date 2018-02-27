A = importdata("decode_input.txt");

WORD_LENGTH = 100;
ALPHABETS = 26;
IMAGE_SIZE = 128;

X = reshape(A(1:WORD_LENGTH * IMAGE_SIZE), [IMAGE_SIZE, WORD_LENGTH]);
W = reshape(A(WORD_LENGTH * IMAGE_SIZE + 1:(WORD_LENGTH + ALPHABETS) * IMAGE_SIZE), [128,26]);
T_trans = reshape(A((WORD_LENGTH + ALPHABETS) * IMAGE_SIZE + 1:end),[26,26]);
T = T_trans';

Y = X'*W;

% small case alphabets from a to z
a_z = char(97:122);
for i = 1 : 26
    subword{i} = a_z(i);
end

% for next 99 letters 
for j=2:100
    for i=1:26
        Tij =  + Y(j-1,:) + T(i,:);
        [r1,i1] = max(Tij,[],2);
        % predicting/populating previous letter, given current letter
        new_subword{i} = strcat(subword{i1}, a_z(i)); 
    end
    subword = new_subword;
end
[Max_value, index] = max(Y(j,:));
word = subword{index}

% converting back to int
for i=1:100
     final_result(i) = strfind(a_z, word(i));
end
   










