function [ f_val ] = get_crf_obj( word_list, W, T, c )

    ALPHABET_SIZE = size(W,2);

    n = size(word_list, 2);
    
    sum_w = 0;
    for i = 1 : ALPHABET_SIZE
        sum_w = sum_w + norm(W(:,i));%W(:,i)'* W(:,i);
    end
    sum_w = 0.5 * sum_w;

    sum_t = 0.5 * sum(sum(T.^2));
    
    sum_logs_p = 0;
    for i = 1 : n
        y = word_list{i}.letter_number;
        x = word_list{i}.image;
        sum_logs_p = sum_logs_p + getLogProbYGivenX( y, x, W, T );
    end
    avg_log_likelihood = sum_logs_p / n;
    
    f_val = - (c * avg_log_likelihood) + sum_w + sum_t;
end

