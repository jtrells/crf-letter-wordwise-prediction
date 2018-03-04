function [ log_prob ] = getLogProbYGivenX( y, x, w, T)
%GETLOGPROBYGIVENX Summary of this function goes here
%   Detailed explanation goes here
    
    number_letters = size(y,2);

    lognum = w(:,y(1))'* x(:, 1);
    for i = 2 : number_letters
        prev_letter = y(i - 1);
        letter = y(i);
        
        lognum = lognum + T(prev_letter, letter) + w(:, letter)'* x(:,i);
    end
    
    [junk, logz] = get_forward_memo_mat_struct2(x, w, T);
    log_prob = lognum - logz;
end

