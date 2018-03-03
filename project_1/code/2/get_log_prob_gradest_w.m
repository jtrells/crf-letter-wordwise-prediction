function [ log_prob ] = get_log_prob_gradest_w( W, y, x, T, alphabet_size )
%GET_LOG_PROB_GRADEST_W Wrapper for the log probability function for
%testing with gradest. W is a row vector.

    w = reshape(W, 128, alphabet_size);
    log_prob = getLogProbYGivenX( y, x, w, T );

end

