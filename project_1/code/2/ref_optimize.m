function accuracy = ref_optimize(train_data, test_data, c, alphabet_size)  
  
  fprintf(['Training CRF ... c = ' num2str(c) '\n']);
  
  % The function handle of CRF objective and gradient
  obj = @(model)crf_obj(model, train_data, alphabet_size);
  
  % A function handle which computes the test error at each iteration
  test_obj = @(model, optimValues, state)crf_test(model, test_data, alphabet_size);
  
  % Initial value of the parameters W and T, stored in a vector
  x0 = zeros(128*alphabet_size+alphabet_size^2,1);

  opt = optimset('display', 'iter-detailed', ... % print detailed information at each iteration of optimization
                 'LargeScale', 'off', ... % This makes sure that quasi-Newton algorithm is used. Do not use the active set algorithm (when LargeScale is set to 'on')
                 'GradObj', 'on', ... % the function handle supplied in calling fminunc provides gradient information
                 'MaxIter', 100, ...  % Run maximum 100 iterations. Terminate after that.
                 'MaxFunEvals', 100, ...  % Allow CRF objective/gradient to be evaluated at most 100 times. Terminate after that.
                 'TolFun', 1e-3, ...  % Terminate when tolerance falls below 1e-3
                 'OutputFcn', test_obj);  % each iteration, invoke the function handle test_obj to print the test error of the current model

  [model, fval, flag] = fminunc(obj, x0, opt);
  save('model.mat', 'model', 'fval', 'flag');  
  [~, accuracy] = crf_test(model, test_data, alphabet_size, c);
  fprintf('CRF test accuracy for c=%g: %g\n', c, accuracy);
  

  % Compute the CRF objective and gradient on the list of words (word_list)
  % evaluated at the current model x (w_y and T, stored as a vector)
  function [f, g] = crf_obj(x, word_list, alphabet_size)
    
    % x is a vector as required by the solver. So reshape it into w_y and T.
    W = reshape(x(1:128*alphabet_size), 128, alphabet_size); % each column of W is w_y (128 dim)
    T = reshape(x(128*alphabet_size+1:end), alphabet_size, alphabet_size); % T is 26*26
    
    f = get_crf_obj(word_list, W, T, c); % compute the objective value of equation (4)
    f
    g_T = get_gradient_t( word_list, W, T, alphabet_size ); % compute the gradient in T (26*26)
    g_W = get_gradient_w( word_list, W, T, alphabet_size); % compute the gradient in W (128*26)
    g = [g_W(:); g_T(:)]; % flatten the gradient back into a vector
  end


  % Compute the test accuracy on the list of words (word_list)
  % x is the current model (w_y and T, stored as a vector)
  function [stop, accuracy] = crf_test(x, word_list, alphabet_size, c)  
      
    stop = false;   % solver can be terminated if stop is set to true
    
    % x is a vector.  So reshape it into w_y and T
    W = reshape(x(1:128*alphabet_size), 128, alphabet_size); % each column of W is w_y (128 dim)
    T = reshape(x(128*alphabet_size+1:end), alphabet_size, alphabet_size); % T is 26*26
    
    % Compute the CRF prediction of test data using W and T
    y_predict = crf_decode(W, T, word_list);
    % Compute test accuracy by comparing the prediction with the ground truth
    accuracy = compare(y_predict, word_list);
    fprintf('Accuracy = %g\n', accuracy);
    
  end

end
