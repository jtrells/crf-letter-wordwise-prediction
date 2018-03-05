function [ accuracy ] = compare( y_predict, word_list )
    
    count = 0;
    total_letters = 0;
    
    %2b asks for letters-wise comparison
    for i = 1 : length(word_list)
        y = word_list{i}.letter_number;
        y_p = y_predict{i};
        
        for j = 1 : length(y)
            if y(j) == y_p(j)
                count = count + 1;
            end
            total_letters = total_letters + 1;
        end
    end
    
    accuracy = count / total_letters;
    
end

