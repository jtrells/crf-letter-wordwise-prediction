function [ y ] = decoder( x, W, T )

    alphabet_size = size(W,2);
    word_length = size(x,2);
    memo = zeros(1,alphabet_size);
    subword = {};
    
    for i = 1 : alphabet_size
        memo(i) = W(:,i)'*x(:,1);   
        subword{i} = [i];
    end
    
    for j = 2 : word_length
        next_memo = zeros(1,128);
        new_subword = {};

        % For each alphabetic letter, check with memoized subword + this
        % letter has the best potential
        for i = 1 : alphabet_size
            max_potential = -1000;
            max_potential_k = -1;

            for k = 1 : alphabet_size
                potential = T(k,i) + memo(k);
                if potential > max_potential
                    max_potential = potential;
                    max_potential_k = k;
                end
            end

            next_memo(i) = W(:,i)'* x(:,j) + max_potential;
            new_subword{i} = [subword{max_potential_k} i];
        end

        memo = next_memo;
        subword = new_subword;
    end

    [value, ind] = max(memo);
    y = subword{ind};

end

