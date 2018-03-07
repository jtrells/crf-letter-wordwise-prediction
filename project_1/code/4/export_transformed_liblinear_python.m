data = matfile(strcat(pwd,'/code/4/transformed_test_data_no_pad.mat'));
words = data.train_words;


fileId = fopen('500.txt', 'wt');

count_letters = 1;
limit = 500;

% print the first X transformed letters
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

% fill the file with the remaining letters
transform_file = strcat(pwd,'/data/test_struct.txt');
fid = fopen(transform_file);
count_transformed = 1;
while ~feof(fid)
    if count_transformed < limit
        count_transformed = count_transformed + 1;
        continue;
    end
    
    s = fgetl(fid); % get a line
    line = strsplit(s);
    line{2} = strcat('qid:', num2str(count_letters));
    
    for i = 1 : length(line)
        if i ~= 2
            fprintf(fileId, '%s ', line{i});
        end
    end
    fprintf(fileId, '\n');
    count_letters = count_letters + 1;
end

fclose(fileId);