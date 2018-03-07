trainData = matfile(strcat(pwd,'/code/2/test.mat'));
train_words = trainData.words;

%transform_data = importdata('/data/transform.txt');

transform_file = strcat(pwd,'/data/transform.txt');
fid = fopen(transform_file);
while ~feof(fid)
    s = fgetl(fid); % get a line
    line = strsplit(s);    
    word_index = str2num(line{2});
    
    word = train_words{word_index};
    word_size = size(word.image, 2);
    
    if line{1} == 'r'
        rotation_angle = str2num(line{3});
        
        for i = 1 : word_size
            image = reshape(word.image(:,i), 8, 16);
            rotated_image = rotation(image, rotation_angle);
            train_words{word_index}.image(:,i) = ...
                reshape(rotated_image, 128, 1);
        end    
    elseif line{1} == 't'
        offset = [str2num(line{3}) str2num(line{4})];
     
        for i = 1 : word_size
            image = reshape(word.image(:,i), 8, 16);
            translated_image = translation(image, offset);
            train_words{word_index}.image(:,i) = ...
                reshape(translated_image, 128, 1);
        end
    end
end

save('transformed_test_data_no_pad.mat', 'train_words');