import os
import MeCab
# bug of words를 작성하기 위한 라이브러리 로드
from gensim import corpora, matutils

mc =  MeCab.Tagger('-d /usr/local/lib/mecab/dic/mecab-ko-dic')
txt_word_list = []

# 텍스트 파일의 폴더를 읽어들임
files = os.listdir('../../../data/txt/')

# 폴더 아래의 텍스트 파일을 하나씩 읽어 들임
for file in files:
  # 텍스트 파일에서 명사와 동사인 단어를 추출한 리스트를 작성(Q11-1의 처리와 같다)
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

      # 텍스트 파일마다 단어 리스트를 추가
      txt_word_list.append(word_list)

# bug of words를 작성하기 위해 모든 종류의 단어를 파악하고, 단어에 ID를 부여한 사전을 작성
corpus_dic = corpora.Dictionary(txt_word_list)

# 각 문장의 단어 리스트를 말뭉치(사전의 단어 ID와 단어의 출현 횟수) 리스트로 변환
corpus_list = [corpus_dic.doc2bow(word_in_text) for word_in_text in txt_word_list]

# 말뭉치 리스트를 희소 행렬(csc형)로 변환
word_matrix = matutils.corpus2csc(corpus_list)
# print(word_matrix,txt_word_list)