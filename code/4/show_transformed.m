function show_transformed(data_set, transformed_data_set, index)

    figure('NumberTitle', 'off', 'Name', data_set{index}.letter);
    num_letters = size(data_set{index}.letter_number, 2);
    
    for i = 1 : num_letters
       l1  = reshape(data_set{index}.image(:,i), 8, 16);
       tl1 = reshape(transformed_data_set{index}.image(:,i), 8, 16);  

       subplot(2,num_letters,i);imshow(l1');
       subplot(2,num_letters,i + num_letters);imshow(tl1');
    end
    
end

