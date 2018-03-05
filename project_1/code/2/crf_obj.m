function [ f, g ] = crf_obj( x, word_list, alphabet_size, c )
% Compute the CRF objective and gradient on the list of words (word_list)
% evaluated at the current model x (w_y and T, stored as a vector)
  
    % x is a vector as required by the solver. So reshape it into w_y and T.
    W = reshape(x(1:128*alphabet_size), 128, alphabet_size); % each column of W is w_y (128 dim)
    T = reshape(x(128*alphabet_size+1:end), alphabet_size, alphabet_size); % T is 26*26
    
    f = get_crf_obj(word_list, W, T, c); % compute the objective value of equation (4)
    %f
    g_T = get_gradient_t( word_list, W, T, alphabet_size, c ); % compute the gradient in T (26*26)
    g_W = get_gradient_w( word_list, W, T, alphabet_size, c); % compute the gradient in W (128*26)
    g = [g_W(:); g_T(:)]; % flatten the gradient back into a vector

end

