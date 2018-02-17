function [ X, Letters, WordsIndex ] = mySvm2mat( s, no_examples )
%MYSVM2MAT Summary of this function goes here
%   Useless attempt to parse the train_struct file
clc
fid = fopen(s);
i=1;

Letters = zeros(no_examples,1);
WordsIndex = zeros(no_examples,1);
X = zeros(no_examples,128);

while ~feof(fid) % not end of the file 
    s = fgetl(fid); % get a line 
    
    splitted_elems = strsplit(s);
    Letters(i) = str2double(splitted_elems{1});    
    WordsIndex(i) = split(splitted_elems{2},2);
    
    % loop over the pos:1 expressions
    j = 3;
    x_i = 1;
    temp_x = [];
    while j <= length(splitted_elems)
        [subarray, x_i] = decompress(x_i, splitted_elems{j});
        temp_x = [temp_x subarray];
        j = j + 1;
    end

    if x_i <= 128    
        temp_x = [temp_x zeros(1, 128 - x_i + 1)];  
    end
    
    X(i,:) = temp_x;
    i = i + 1;
end

end

function [num] = split(exp, index)
    splitted = strsplit(exp,':');
    num = str2double(splitted{index});
end

function [subarray, new_curr_index] = decompress(curr_index, exp)
    subarray = [];
    start_index = split(exp, 1);
    if start_index > curr_index
        subarray = zeros(1,start_index - curr_index);
    end
    subarray = [subarray 1];
    new_curr_index = start_index + 1;
end

