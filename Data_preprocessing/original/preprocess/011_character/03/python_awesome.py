import MeCab
import os
from gensim import corpora

mc = MeCab.Tagger('-d /usr/local/lib/mecab/dic/mecab-ko-dic')

txt_list = []
files = os.listdir('../../../data/txt/')

for file in files:
    with open('../../../data/txt/'+file, 'r') as f:
        ext = os.path.splitext(file)[1]
        if ext == '.txt':
            txt = f.read()
            word_list = []
            node = mc.parseToNode(txt)
            while node:
                feature = node.feature.split(',')
                part = feature[0]
                if ((part != 'BOS/EOS') and (part == 'NNG' or part == 'NNP' or part == 'NNB' or part == 'VV')):
                    word_list.append(node.surface)
                node = node.next
            txt_list.append(word_list)

dictionary = corpora.Dictionary(txt_list)
corpus_list = [dictionary.doc2bow(txt) for txt in txt_list]

# 아래 부터 책에 게재
from gensim import matutils, models

# corpus_list를 준비하는 코드는 생략

# TF-IDF의 모델 생성
tfidf_model = models.TfidfModel(corpus_list, normalize=True)

# corpus에 TF-IDF를 적용
corpus_list_tfidf = tfidf_model[corpus_list]
word_matrix = matutils.corpus2csc(corpus_list_tfidf)
# print(word_matrix)
