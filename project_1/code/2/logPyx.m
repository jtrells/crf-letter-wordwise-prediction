function [ p ] = logPyx(x, w, T)
    
    global NUM_LETTERS;
    WORD_LENGTH = size(x, 2);
    
    Z = zeros(1, WORD_LENGTH);
    F = zeros(NUM_LETTERS * NUM_LETTERS, WORD_LENGTH);   % Forward-memo
    B = zeros(NUM_LETTERS, WORD_LENGTH);                 % Backward-memo

    T_ = reshape(T, NUM_LETTERS * NUM_LETTERS, 1);
    T_ = exp(T_);
    
    x_potential = zeros(NUM_LETTERS, 1);
    for i = 1 : NUM_LETTERS
        x_potential(i) = dot(w(:,i), x(:,1));
    end
    
    % initialization for forward calculation
    % I believe the marginal for the first node is just the obtained
    % potential given that there is not previous connecting node.
    F(:,1) = repmat(x_potential, [NUM_LETTERS, 1]);
    marginal_j = F(:,1);
    
    for j = 2 : WORD_LENGTH
       for i = 1 : NUM_LETTERS
          x_potential(i) = exp(dot(w(:,i), x(:,j)));
       end 
       
       pot_x_trans = bsxfun(@times, repmat(x_potential, [NUM_LETTERS,1]), T_);
       F(:,j) = bsxfun(@times, marginal_j, pot_x_trans);
       marginal_j = calculate_marginal(F(:,j));
    end
    
end

function marginal = calculate_marginal(vect_memo_entry)
    global NUM_LETTERS;

    M = reshape(vect_memo_entry, NUM_LETTERS, NUM_LETTERS);
    s = sum(M, 2);
    marginal = repmat(s, [NUM_LETTERS,1]);
end