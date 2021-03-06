function [ y_predict ] = crf_decode( W, T, word_list )
% decode the entire word list based on the estimated parameters

    y_predict = {};
    for i = 1 : length(word_list)
        y_predict{i} = decoder(word_list{i}.image, W, T);
    end

end

