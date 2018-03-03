function [ log_prob ] = get_log_prob_gradest_t( T, y, x, w, alphabet_size )
%GET_LOG_PROB_GRADEST_T Wrapper for the log probability function for
%testing with gradest. T is a row vector.

    t = reshape(T, alphabet_size, alphabet_size);
    log_prob = getLogProbYGivenX( y, x, w, t );

end
