function [ log_prob ] = get_log_prob_gradest_w( W, word_list, T, alphabet_size )
%GET_LOG_PROB_GRADEST_W Wrapper for the log probability function for
%testing with gradest. W is a row vector.

    w = reshape(W, 128, alphabet_size);
    log_prob = 0;
    for i = 1 : length(word_list)
        y = word_list{i}.letter_number;
        x = word_list{i}.image;
        log_prob = log_prob + getLogProbYGivenX( y, x, w, T );
    end
    log_prob = log_prob/length(word_list);
end

