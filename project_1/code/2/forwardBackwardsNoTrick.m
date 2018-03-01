function [ F ] = forwardBackwardsNoTrick(x, w, T)
    
    global NUM_LETTERS;
    WORD_LENGTH = size(x, 2);
    
    F = zeros(NUM_LETTERS, WORD_LENGTH);   % Forward-memo
    
    % initialization for forward calculation
    x_potential = zeros(NUM_LETTERS, 1);
    for i = 1 : NUM_LETTERS
        x_potential(i) = dot(w(:,i), x(:,1));   % ({w.x})
    end
    
    F(:,1) = exp(x_potential);
    for j = 2 : WORD_LENGTH
%        for i = 1 : NUM_LETTERS
%            x_potential(i) = exp(dot(w(:,i), x(:,j)));  % (e{w.x})
%        end 
       
       for d = 1 : NUM_LETTERS
           for s = 1 : NUM_LETTERS
               F(d,j) = F(d,j) + F(d,j-1) * exp(T(s, d)) * exp(dot(w(:,d), x(:,j)));
           end
       end
    end
end

% 
% function [new_memo] = calculate_memo(potential_i, last_memo, T)
%     global NUM_LETTERS;
%     
%     T = exp(T);
%     % Expand vectors to make weighted calculations easier
%     feature_potential = repmat(potential_i, [NUM_LETTERS, 1]);
%     feature_T = reshape(T, NUM_LETTERS * NUM_LETTERS, 1); % (e{T})
%     feature_memo = repmat(last_memo, [NUM_LETTERS, 1]);
%     
%     a_i = bsxfun(@times,feature_potential,feature_T);
%     a_i = bsxfun(@times,a_i,feature_memo);
%     sum_a_i = reshape(a_i, NUM_LETTERS, NUM_LETTERS);
%     % sum row wise for each letter
%     new_memo = sum(sum_a_i, 2);
% end