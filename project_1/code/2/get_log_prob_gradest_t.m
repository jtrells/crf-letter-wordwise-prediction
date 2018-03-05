function [ log_prob ] = get_log_prob_gradest_t( T, word_list, w, alphabet_size )
%GET_LOG_PROB_GRADEST_T Wrapper for the log probability function for
%testing with gradest. T is a row vector.

    t = reshape(T, alphabet_size, alphabet_size);
    
    log_prob = 0;
    for i = 1 : length(word_list)
        y = word_list{i}.letter_number;
        x = word_list{i}.image;
        log_prob = log_prob + getLogProbYGivenX( y, x, w, t );
    end
    
    log_prob = log_prob/length(word_list);
    
end
