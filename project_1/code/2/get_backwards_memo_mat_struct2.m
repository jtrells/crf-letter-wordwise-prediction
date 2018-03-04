function [B, logZ] = get_backwards_memo_mat_struct2(x, w, T)
    
    global NUM_LETTERS;
    WORD_LENGTH = size(x, 2);
    
    B = zeros(NUM_LETTERS, WORD_LENGTH);   % Backwards-memo
    % initialization at zero
    
    potential = zeros(NUM_LETTERS, 1);
    for j = WORD_LENGTH - 1: -1: 1
        for i = 1 : NUM_LETTERS
           potential(i) = w(:,i)' * x(:,j+1);  % log(e{w.x})
        end 
        B(:,j) = calculate_memo(potential, B(:, j+1), T);
    end
    
    for i = 1 : NUM_LETTERS
        potential(i) = w(:,i)' * x(:,1);
    end
    logZ = log(sum(exp(potential + B(:, 1))));
    
end

function [new_memo] = calculate_memo(potential_i, last_memo, T)
    global NUM_LETTERS;
     
    % Expand vectors to make weighted calculations easier
    feature_potential = repmat(potential_i', [NUM_LETTERS, 1]);
    feature_potential = reshape(feature_potential, NUM_LETTERS * NUM_LETTERS, 1);
    feature_T = reshape(T, NUM_LETTERS * NUM_LETTERS, 1); % log(e{T})
    last_memo = repmat(last_memo', [NUM_LETTERS, 1]);
    feature_memo = reshape(last_memo, NUM_LETTERS * NUM_LETTERS, 1);
    
    % log_alpha(k) = log{sum_k-1 exp(w.x_k + T + log_alpha(k-1)) }
    a_i = feature_potential + feature_T + feature_memo;
    % find max{a_i} for sum log trick
    M = reshape(a_i, NUM_LETTERS, NUM_LETTERS);
    M = max(M, [], 2);
    M = repmat(M, [NUM_LETTERS, 1]);
    
    % log_alpha(k) = M + log{sum_k-1 exp(a_i - b)}
    % https://youtu.be/-RVM21Voo7Q?t=734
    sum_k_1 = exp(a_i - M);
    sum_k_1 = reshape(sum_k_1, NUM_LETTERS, NUM_LETTERS);
    % sum row wise for each letter
    sum_k_1 = sum(sum_k_1, 2);
    
    new_memo = M(1:NUM_LETTERS, 1) + log(sum_k_1); 
end