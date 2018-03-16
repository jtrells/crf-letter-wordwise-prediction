import os
words = open('train_struct_words.txt','r',encoding='cp1252')
letters = open('train_struct_letters.txt', 'w')
for line in words:
    words = line.split()
    del words[1]
    str1 = ' '.join(words)
    print(str1)
    letters.write("%s\n" % str1)
#   print(line)
words.close()
letters.close()