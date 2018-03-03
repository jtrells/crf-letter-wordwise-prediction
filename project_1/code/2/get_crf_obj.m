function [ f_val ] = get_crf_obj( word_list, W, T, c )

    ALPHABET_SIZE = 26;

    n = size(word_list, 2);
    
    sum_w = 0;
    for i = 1 : ALPHABET_SIZE
        sum_w = sum_w + dot(W(:,i), W(:,i)');
    end
    sum_w = 0.5 * sum_w;

    sum_t = 0.5 * sum(sum(T.^2));
    
    sum_logs_p = 0;
    for i = 1 : n
        y = word_list{i}.letter_number;
        x = word_list{i}.image;
        sum_logs_p = sum_logs_p + getLogProbYGivenX( y, x, W, T );
    end
    sum_logs = -1 * (c/n) * sum_logs_p;
    
    f_val = sum_logs + sum_w + sum_t;
end

