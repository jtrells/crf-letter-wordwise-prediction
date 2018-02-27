function bruteForcePotential(p, depth)
    global WORD_RECURSION_LENGTH NUM_LETTERS;
    global X W T word max_potential max_word;

    if depth <= WORD_RECURSION_LENGTH
        for i = 1 : NUM_LETTERS
            word(depth) = i;
            potential = dot(W(:,i), X(:,depth)) + T(word(depth - 1), i);
            bruteForcePotential(p + potential, depth + 1);
        end
    elseif p > max_potential
        max_potential = p;
        max_word = word; % deep clone since original gets mutated
    end
end