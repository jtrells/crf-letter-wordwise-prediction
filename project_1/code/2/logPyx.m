function [ p ] = logPyx(x, w, T)
    
    global NUM_LETTERS;
    WORD_LENGTH = size(x, 2);
    
    Z = zeros(1, WORD_LENGTH);
    F = zeros(NUM_LETTERS * NUM_LETTERS, WORD_LENGTH);   % Forward-memo
    B = zeros(NUM_LETTERS, WORD_LENGTH);                 % Backward-memo

    T_ = reshape(T, NUM_LETTERS * NUM_LETTERS, 1);       % log(e{T})
    
    x_potential = zeros(NUM_LETTERS, 1);
    for i = 1 : NUM_LETTERS
        x_potential(i) = dot(w(:,i), x(:,1));   % log(e{w.x})
    end
    
    % initialization for forward calculation
    % I believe the marginal for the first node is just the obtained
    % potential given that there is not previous connecting node.
    F(:,1) = repmat(x_potential, [NUM_LETTERS, 1]);
  
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
       
       log_marginal_j = calculate_marginal(a_j, M);
       F(:,j) = M + log_marginal_j;
    end
    
end

function marginal = calculate_marginal(a_j, M)
% Marginalize over each letter to get the log(sum_i e^(a_i - b))
% to do log trick, https://youtu.be/-RVM21Voo7Q?t=734
    global NUM_LETTERS;
    
    marginal = exp(a_j - M);
    marginal = reshape(marginal, NUM_LETTERS, NUM_LETTERS);
    marginal = log(sum(marginal, 2));
    
    marginal = repmat(marginal, [NUM_LETTERS,1]);
end