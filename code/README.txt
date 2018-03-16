README
----------------------------
CS-594: Project 1
Team: Kristine H. Lee, Ashwini Naik, Juan Trelles Trabucco

To execute the code please set Matlab's pwd to the folder containing /code, /data /result

1c) folder 1
-----------
Run the script decoder1c_dp.m to decode the input sequence. 
- loadDecoderSet reads the input file
- decoder1c_bf1.m and bruteForcePotential.m implement the brute force approach.
- decoder.m is a compact version used in question 2.

2) folder 2
-----------
For reporting the values required in 2a. Run the script report_2a.m
For reporting the values required in 2b. Run the script report_2b.m
The data files have been loaded in:
- test.mat: Data from test.txt
- train_wods_x.mat: Data from train.txt
Data is stored as a set of words. Each word has a vector containing the letters and the images per letter.

Other important files:
- Forward algorithm: get_forward_memo_mat_struct2.m 
- Backward algorithm: get_backwards_memo_mat_struct2.m
- Objective function: crf_obj.m
- Test predictions: crf_test_out.m
- Gradient T: get_gradient_t.m
- Gradient W: get_gradient_w.m
- Log P(Y|X): getLogProbYGivenX
- Decode sequence: crf_decode
- ref_optimize: Provided template for optimization filled with our functions
- Optimal model for C=1000: optimal_model_c_100.mat


3) folder 3
------------
To get liblinear wordwise accuracy run linearsvc_wordwise_accuracy.py
To get liblinear letterwise accuracy run liblinearletterwise.m
To get SVM HMM letterwise accuracy run svm_hmm_letters.sh //we do need svm_hmm_learn and svm_hmm_classify binaries in the current folder
To get SVM HMM wordwise accuracy run svm_hmm_words.sh // we do need svm_hmm_learn and svm_hmm_classify binaries in the current folder

Other important files
- wordstoletters.py - converts train_words_struct.txt and test_words_struct.txt into letterwise for liblinear
- wordstoletters_svmhmm.py - converts train_words_struct.txt and test_words_struct.txt into letterwise for svmhmm

4) folder 4
------------
Important files:
- Tampered data set: transformed_test_data_no_pad.mat
- Export data for liblinear on python: export_transformed_liblinear_python.m
We removed the padding from rotation.m and translation.m to avoid adding noise.

