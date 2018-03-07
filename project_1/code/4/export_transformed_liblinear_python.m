data = matfile(strcat(pwd,'/code/4/transformed_test_data_no_pad.mat'));
words = data.train_words;


fileId = fopen('2000.txt', 'wt');

count_letters = 1;
limit = 2000;
for i = 1 : length(words)
    
    word = words{i}.letter_number;
    for j = 1 : length(word)
        label = word(j);
        fprintf(fileId, '%d ',label);
        
        qid = strcat('qid:', num2str(count_letters));
        fprintf(fileId, '%s ',qid);
        
        ones_indexes = find(words{i}.image(:,j));
        for k = 1 : length(ones_indexes)
            token = strcat(num2str(ones_indexes(k)), ':1');
            fprintf(fileId, '%s ', token);
        end
        fprintf(fileId,'\n');
        count_letters = count_letters + 1;
        
        if count_letters > limit
            break;
        end
    end
    
    if count_letters > limit
       break
    end
    
end
fclose(fileId);