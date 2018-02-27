global WORD_LENGTH LETTER_SIZE NUM_LETTERS ALPHABET;

WORD_LENGTH = 100;
LETTER_SIZE = 128;
NUM_LETTERS = 26;
ALPHABET = 'abcdefghijklmnopqrstuvwxyz';

[x, w, T] = loadDecoderSet('/data/decode_input.txt'); 
logPyx(x, w, T);