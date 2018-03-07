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

% count_letters = 1;
% limit = 1000;
% 
% % print the first X transformed letters
% for i = 1 : length(words)
%     word = words{i}.letter_number;
%     for j = 1 : length(word)
%         label = word(j);
%         fprintf(fileId, '%d ',label);
%         
%         qid = strcat('qid:', num2str(i));
%         fprintf(fileId, '%s ',qid);
%         
%         ones_indexes = find(words{i}.image(:,j));
%         for k = 1 : length(ones_indexes)
%             token = strcat(num2str(ones_indexes(k)), ':1');
%             fprintf(fileId, '%s ', token);
%         end
%         fprintf(fileId,'\n');
%         count_letters = count_letters + 1;
%         
%         if count_letters > limit
%             break;
%         end
%     end
%     
%     if count_letters > limit
%        break
%     end  
% end
% 
% % fill the file with the remaining letters
% transform_file = strcat(pwd,'/data/test_struct.txt');
% fid = fopen(transform_file);
% count_transformed = 1;
% while ~feof(fid)
%     s = fgetl(fid); % get a line
%     if count_transformed <= limit
%         count_transformed = count_transformed + 1;
%     else
%         fprintf(fileId, '%s\n', s);
%     end
%     
%     %s = fgetl(fid); % get a line
%     %line = strsplit(s);
%     %fprintf(fileId, '%s\n', s);
%     %line{2} = strcat('qid:', num2str(count_letters));
%     
% %     for i = 1 : length(line)
% %         if i ~= 2
% %             fprintf(fileId, '%s ', line{i});
% %         end
% %     end
%     %fprintf(fileId, '\n');
%     count_letters = count_letters + 1;
% end
% 
% fclose(fileId);