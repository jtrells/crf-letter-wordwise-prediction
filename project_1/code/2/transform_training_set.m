trainData = matfile(strcat(pwd,'/code/2/train_words_x.mat'));
train_words = trainData.words;

%transform_data = importdata('/data/transform.txt');

transform_file = '/data/transform.txt';
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
            train_words{word_index}.image(:,i) = ...
                rotation(word.image(:,i), rotation_angle);
        end    
    elseif line{1} == 't'
        translation = [str2num(line{3}) str2num(line{4})];
     
        for i = 1 : word_size
            train_words{word_index}.image(:,i) = ...
                translation(word.image(:,i), translation);
        end
    end
end

save('transformed_training_data.mat', 'train_words');