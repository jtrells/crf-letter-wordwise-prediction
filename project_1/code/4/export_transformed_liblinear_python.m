data_transformed = matfile(strcat(pwd,'/code/4/transformed_test_data_no_pad.mat'));
words_transformed = data_transformed.train_words;

data_test = matfile(strcat(pwd,'/code/2/test.mat'));
words_test = data_test.words;

limit = 2000;
fileWrite = fopen(strcat('words_', num2str(limit),'.txt'), 'wt');

transform_file = strcat(pwd,'/data/transform.txt');
fid = fopen(transform_file);
count = 1;

while ~feof(fid)
    if count < limit
        s = fgetl(fid);
        line = strsplit(s);
        
        index_to_replace = str2num(line{2});
        words_test{index_to_replace} = words_transformed{index_to_replace};
        count = count + 1;
    else 
        break
    end
end

% words in test data replace. write to file
for i = 1 : length(words_test)
    word = words_test{i}.letter_number;
    for j = 1 : length(word)
        label = word(j);
        fprintf(fileWrite, '%d ',label);
        
        qid = strcat('qid:', num2str(i));
        fprintf(fileWrite, '%s ',qid); % don't print for letter case
        
        ones_indexes = find(words_test{i}.image(:,j));
        for k = 1 : length(ones_indexes)
            token = strcat(num2str(ones_indexes(k)), ':1');
            fprintf(fileWrite, '%s ', token);
        end
        fprintf(fileWrite,'\n');
    end
end
fclose(fileWrite);