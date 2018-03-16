function [ log_prob ] = getLogProbYGivenXT(XY, w, T, alphabet_size)

    % reshaping
    num_letters = XY(end,1);

    %w = reshape(Phi(1:alphabet_size*128,1), 128, alphabet_size);
    %T = reshape(Phi(3329:end,1), alphabet_size, alphabet_size);
    
    end_x = 128*num_letters;
    x = reshape(XY(1:end_x,1), 128, num_letters);
    y = reshape(XY(end_x+1:end-1), 1, num_letters); 
    
    number_letters = size(y,2);
    try
        lognum = dot(w(:,y(1)), x(:, 1));
    catch ME
        C=1;
    end
    
    for i = 2 : number_letters
        prev_letter = y(i - 1);
        letter = y(i);
        
        lognum = lognum + T(prev_letter, letter) + dot(w(:, letter), x(:,i));
    end
    
    [F, B, logz] = logMemo(x, w, T);
    log_prob = lognum - logz;
end

