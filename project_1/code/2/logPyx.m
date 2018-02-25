function [ F, B, Z ] = logPyx(x, w, T)
    
    global NUM_LETTERS;
    WORD_LENGTH = size(x, 2);
    
    Z = 0;
    F = zeros(NUM_LETTERS * NUM_LETTERS, WORD_LENGTH);   % Forward-memo
    B = zeros(NUM_LETTERS * NUM_LETTERS, WORD_LENGTH);   % Backward-memo

    T_ = reshape(T, NUM_LETTERS * NUM_LETTERS, 1);       % log(e{T})
    
    x_potential = zeros(NUM_LETTERS, 1);
    for i = 1 : NUM_LETTERS
        x_potential(i) = dot(w(:,i), x(:,1));   % log(e{w.x})
    end
    
    % initialization for forward calculation
    F(:,1) = repmat(x_potential, [NUM_LETTERS, 1]);
    Z = sum(x_potential);
    
    for j = 2 : WORD_LENGTH
       for i = 1 : NUM_LETTERS
           x_potential(i) = dot(w(:,i), x(:,j));  % log(e{w.x})
       end 
       
       pot_plus_trans = repmat(x_potential, [NUM_LETTERS,1]) + T_;
       a_j = pot_plus_trans + F(:, j-1);
       
       % now do log sum trick before assigning it to the memo entry
       % M stores the max potential for each letter
       M = reshape(a_j, NUM_LETTERS, NUM_LETTERS);
       M = max(M, [], 2);
       M = repmat(M, [NUM_LETTERS, 1]);
       
       [log_marginal_j, Z] = calculate_marginal(a_j, M, Z);
       F(:,j) = M + log_marginal_j;
    end
    
    
    x_potential = zeros(NUM_LETTERS, 1);
    for i = 1 : NUM_LETTERS
        x_potential(i) = dot(w(:,i), x(:,WORD_LENGTH));   % log(e{w.x})
    end
    % initialization for forward calculation
    B(:,WORD_LENGTH) = repmat(x_potential, [NUM_LETTERS, 1]);
    for j = WORD_LENGTH - 1: -1: 1
       for i = 1 : NUM_LETTERS
           x_potential(i) = dot(w(:,i), x(:,j));  % log(e{w.x})
       end 
       
       pot_plus_trans = repmat(x_potential, [NUM_LETTERS,1]) + T_;
       a_j = pot_plus_trans + B(:, j+1);
       
       M = reshape(a_j, NUM_LETTERS, NUM_LETTERS);
       M = max(M, [], 2);
       M = repmat(M, [NUM_LETTERS, 1]);
       
       log_marginal_j = calculate_marginal(a_j, M, Z);
       B(:,j) = M + log_marginal_j;
    end
    
    c = 1;
end

function [marginal, Z] = calculate_marginal(a_j, M, Z)
% Marginalize over each letter to get the log(sum_i e^(a_i - b))
% to do log trick, https://youtu.be/-RVM21Voo7Q?t=734
    global NUM_LETTERS;
    
    marginal = exp(a_j - M);
    marginal = reshape(marginal, NUM_LETTERS, NUM_LETTERS);
    marginal = log(sum(marginal, 2));
    
    Z = Z + sum(marginal);
    marginal = repmat(marginal, [NUM_LETTERS,1]);
end