#!/bin/bash

values='1 10 100 1000'
for value in $values
do
        ./svm_hmm_learn -c $value train_struct_letters.txt modelfile_letters_$value.dat
        ./svm_hmm_classify test_struct_words.txt modelfile_letters_$value.dat classify.tags >> outfile_lettermodel_wordwise.txt
        ./svm_hmm_classify test_struct_letters.txt modelfile_letters_$value.dat  classify.tags >> outfile_lettermodel_letterwise.txt
done
echo All done
