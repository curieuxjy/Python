import MeCab

# 사용할 한글 사전을 지정하여 mecab을 실행할 오브젝트를 생성
mc = MeCab.Tagger('-d /usr/local/lib/mecab/dic/mecab-ko-dic')

# 운수좋은 날 텍스트 파일 열기
with open('../../../data/txt/lucky.txt', 'r') as f:
  txt = f.read()

word_list = []
# MeCab을 사용하여 형태소 분석을 실행
node = mc.parseToNode(txt)

while node:
  feature = node.feature.split(',')
  part = feature[0]
  # 분석 결과에서 문장의 시작 또는 끝이 아니고 명사와 동사인 단어를 구함
  if ((part != 'BOS/EOS') and (part == 'NNG' or part == 'NNP' or part == 'NNB' or part == 'VV')):
    word_list.append((part,node.surface))
  node = node.next
# print(word_list);