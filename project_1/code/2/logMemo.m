function [ F, B, logz ] = logMemo(x, w, T)
    
    global NUM_LETTERS;
    WORD_LENGTH = size(x, 2);
    
    F = zeros(NUM_LETTERS, WORD_LENGTH);   % Forward-memo
    B = zeros(NUM_LETTERS, WORD_LENGTH);   % Forward-memo
    
    % initialization for forward calculation
    for i = 1 : NUM_LETTERS
        F(i, 1) = dot(w(:,i), x(:,1));   % ({w.x})
    end
%     M = max(F(:, 1));
%     for i = 1 : NUM_LETTERS
%         F(i, 1) = M + log(F(i, 1) - M);
%     end
    
    for j = 2 : WORD_LENGTH
       for d = 1 : NUM_LETTERS
           
           temp = F(:, j-1);
           
           for s = 1 : NUM_LETTERS
               % temp(s) = F(s, j-1) + T(s,d) + dot(w(:,i), x(:,j));
               temp(s) = F(s, j-1) + T(s,d) + dot(w(:,d), x(:,j));
           end
           
           M = max(temp);
           
           for s = 1 : NUM_LETTERS
               F(d, j) = F(d,j) + exp(temp(s) - M);
           end
           
           F(d,j) = M + log(F(d,j));
       end
    end
    
    % backwards calculation
    for i = 1 : NUM_LETTERS
        B(i, WORD_LENGTH) = dot(w(:,i), x(:,WORD_LENGTH));   
    end
    for j = WORD_LENGTH - 1 : -1 : 1
        for d = 1 : NUM_LETTERS
            
            temp = B(:, j+1);
            for s = 1 : NUM_LETTERS
                %temp(s) = B(s, j+1) + T(s,d) + dot(w(:,s), x(:,j+1));
                temp(s) = B(s, j+1) + T(d,s) + dot(w(:,d), x(:,j));
            end
            M = max(temp);
            
            for s = 1 : NUM_LETTERS
                B(d, j) = B(d,j) + exp(temp(s) - M);
            end
            B(d,j) = M + log(B(d,j));
            
        end
    end
    
    logz = log(sum(exp(F(:, WORD_LENGTH))));
    
    % we can get the logz using B
%     pot_B_1 = zeros(NUM_LETTERS,1);
%     for i = 1 : NUM_LETTERS
%         pot_B_1(i, 1) = dot(w(:,i), x(:,WORD_LENGTH));
%     end
%     
%     
%     logzb_prod = bsxfun(@times, pot_B_1, B(:,1));
%     logzb_prod = log(sum(exp(logzb_prod)));
%     
%     logzb_sum = pot_B_1 + B(:,1);
%     logzb_sum = log(sum(exp(logzb_sum)));
    
    %log(sum(exp(F(:, WORD_LENGTH))))
    %log(sum(exp(B(:, 1))))
    
end
