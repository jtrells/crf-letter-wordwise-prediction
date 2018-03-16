function [ F, logz ] = get_forward_memo(x, w, T)
    
    global NUM_LETTERS;
    WORD_LENGTH = size(x, 2);
    
    F = zeros(NUM_LETTERS, WORD_LENGTH);   % Forward-memo
    
    % initialization for forward calculation
    for i = 1 : NUM_LETTERS
        F(i, 1) = w(:,i)' * x(:,1);   % ({w.x})
    end
    
    for j = 2 : WORD_LENGTH
       for d = 1 : NUM_LETTERS
           
           temp = F(:, j-1);
           
           for s = 1 : NUM_LETTERS
               temp(s) = F(s, j-1) + T(s,d) + w(:,d)' * x(:,j);
           end
           
           M = max(temp);
           
           for s = 1 : NUM_LETTERS
               F(d, j) = F(d,j) + exp(temp(s) - M);
           end
           
           F(d,j) = M + log(F(d,j));
       end
    end
    
    logz = log(sum(exp(F(:, WORD_LENGTH))));
    
end

