function [letter_accuracy, word_accuracy] = crf_test_out( model, word_list, alphabet_size)
% copy of the function from ref_optimize but without considering the stop parameter 

    % x is a vector.  So reshape it into w_y and T
    W = reshape(model(1:128*alphabet_size), 128, alphabet_size); % each column of W is w_y (128 dim)
    T = reshape(model(128*alphabet_size+1:end), alphabet_size, alphabet_size); % T is 26*26
    
    % Compute the CRF prediction of test data using W and T
    y_predict = crf_decode(W, T, word_list);
    % Compute test accuracy by comparing the prediction with the ground truth
    [letter_accuracy, word_accuracy] = compare(y_predict, word_list);

end

