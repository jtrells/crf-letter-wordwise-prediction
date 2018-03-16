function [ val ] = get_crf_obj_gradest( WT, word_list, c, alphabet_size )
    
    W = reshape(WT(1:128*alphabet_size), 128, alphabet_size); % each column of W is w_y (128 dim)
    T = reshape(WT(128*alphabet_size+1:end), alphabet_size, alphabet_size); % T is 26*26
    
    val = get_crf_obj( word_list, W, T, c );
end

