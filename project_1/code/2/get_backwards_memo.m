function [ B, logz ] = get_backwards_memo(x, w, T)
    
    global NUM_LETTERS;
    WORD_LENGTH = size(x, 2);
    
    B = zeros(NUM_LETTERS, WORD_LENGTH);   % Backwards-memo
    
    % backwards calculation
    for i = 1 : NUM_LETTERS
        B(i, WORD_LENGTH) = w(:,i)' * x(:,WORD_LENGTH);   
    end
    for j = WORD_LENGTH - 1 : -1 : 1
        for d = 1 : NUM_LETTERS
            
            temp = B(:, j+1);
            for s = 1 : NUM_LETTERS
                temp(s) = B(s, j+1) + T(d,s) + w(:,d)' * x(:,j);
            end
            M = max(temp);
            
            for s = 1 : NUM_LETTERS
                B(d, j) = B(d,j) + exp(temp(s) - M);
            end
            B(d,j) = M + log(B(d,j));
            
        end
    end
    
    logz = log(sum(exp(B(:, 1))));
    
end