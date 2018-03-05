function [log_prob] = get_log_prob_gradest(WT, word_list, alphabet_size)
    
    w = reshape(WT(1:128*alphabet_size), 128, alphabet_size); % each column of W is w_y (128 dim)
    t = reshape(WT(128*alphabet_size+1:end), alphabet_size, alphabet_size); % T is 26*26
    
    log_prob = 0;
    for i = 1 : length(word_list)
        y = word_list{i}.letter_number;
        x = word_list{i}.image;
        log_prob = log_prob + getLogProbYGivenX( y, x, w, t );
    end
    
    log_prob = log_prob/length(word_list);
    
end

