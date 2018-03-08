function [F, logz] = get_forward_memo_mat_struct2(x, w, T)
% Get the forward memo using a vectorized approach and log trick

% Changing the struct so we go potential x_i and potential y_i, y_i+1 on
% each iteration. Only changes in the initialization and the potential

    alphabet_size = size(w, 2);
    WORD_LENGTH = size(x, 2);
    
    F = zeros(alphabet_size, WORD_LENGTH);   % Forward-memo
    % alpha_1 = 0
    
    potential = zeros(alphabet_size, 1);
    for j = 2 : WORD_LENGTH
        potential = sum(bsxfun(@times, w, x(:,j-1)))';
%         for i = 1 : alphabet_size
%             potential(i) = w(:,i)' * x(:,j-1);
%         end
        F(:, j) = calculate_memo(potential, F(:, j-1), T, alphabet_size);
    end
    
    for i = 1 : alphabet_size
        potential(i) = w(:,i)' * x(:,WORD_LENGTH);
    end
    logz = log(sum(exp(potential + F(:, WORD_LENGTH))));
end

function [new_memo] = calculate_memo(potential_i, last_memo, T, alphabet_size)
     
    % Expand vectors to make weighted calculations easier
    feature_potential = repmat(potential_i', [alphabet_size, 1]);
    feature_potential = reshape(feature_potential, alphabet_size * alphabet_size, 1);
    feature_T = reshape(T', alphabet_size * alphabet_size, 1); % log(e{T})
    last_memo = repmat(last_memo', [alphabet_size, 1]);
    feature_memo = reshape(last_memo, alphabet_size * alphabet_size, 1);
    
    % log_alpha(k) = log{sum_k-1 exp(w.x_k + T + log_alpha(k-1)) }
    a_i = feature_potential + feature_T + feature_memo;
    % find max{a_i} for sum log trick
    M = reshape(a_i, alphabet_size, alphabet_size);
    M = max(M, [], 2);
    M = repmat(M, [alphabet_size, 1]);
    
    % log_alpha(k) = M + log{sum_k-1 exp(a_i - b)}
    % https://youtu.be/-RVM21Voo7Q?t=734
    sum_k_1 = exp(a_i - M);
    sum_k_1 = reshape(sum_k_1, alphabet_size, alphabet_size);
    % sum row wise for each letter
    sum_k_1 = sum(sum_k_1, 2);
    
    new_memo = M(1:alphabet_size, 1) + log(sum_k_1); 
end