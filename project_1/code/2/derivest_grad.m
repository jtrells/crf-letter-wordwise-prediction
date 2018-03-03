global NUM_LETTERS;

[grad, err] = gradest(@(y,x,w,T) getLogProbYGivenX(y,x,w,T), )