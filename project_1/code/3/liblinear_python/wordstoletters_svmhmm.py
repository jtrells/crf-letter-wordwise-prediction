import os
train_struct_words = open('train_struct_words.txt','r',encoding='cp1252')
train_struct_letters = open('train_struct_letters.txt', 'w')
count = 0;
for line in train_struct_words:
    count = count+1;
    words = line.split()
    word_id = words[1].split(":")
    word2 = word_id[0]+":"+str(count)
    words[1] = word2
#     words[1].replace(%d,str(count)
    str1 = ' '.join(words)
    print(str1)
    train_struct_letters.write("%s\n" % str1)
#   print(line)
train_struct_words.close()
train_struct_letters.close()