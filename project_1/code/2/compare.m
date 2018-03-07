function [ letter_accuracy,  word_accuracy] = compare( y_predict, word_list )
    
    total_letters = 0;
    total_words = length(word_list);
    count_same_words = 0;
    count_same_letters = 0;
    
    for i = 1 : total_words
        y = word_list{i}.letter_number;
        y_p = y_predict{i};
        
        % check word-wise comparison
        if sum(y - y_p) == 0; count_same_words = count_same_words + 1; end
        % checik letter-wise comparison
        count_same_letters = count_same_letters + sum(abs(y - y_p)==0);
        total_letters = total_letters + length(y);
    end
    
    letter_accuracy = count_same_letters / total_letters;
    word_accuracy = count_same_words / total_words;
    
end

