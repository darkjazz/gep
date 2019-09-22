from stats import TagStats
import spacy

t = TagStats()

c = t.collect_tag_counts()
nlp = spacy.load("en_core_web_lg")
all_tags = list(c.keys())

all_tags = [ _tag.replace('-', ' ') for _tag in all_tags ]

tags = []
for _tag in all_tags:
    _tokens = nlp(_tag)
    if sum([1 for _t in _tokens if _t.has_vector]) == len(_tag.split(' ')):
        tags.append(_tag)
no_tags = []
for _tag in all_tags:
    _tokens = nlp(_tag)
    if sum([1 for _t in _tokens if _t.has_vector]) != len(_tag.split(' ')):
        no_tags.append(_tag)

for _i, _tag in enumerate(tags):
    _sim = nlp('sound').similarity(nlp(_tag))
    sound_sims.append({ 'tag': _tag, 'sim': _sim })
    prg.update(_i)

for _tag in closest:
    _doc = nlp(_tag['tag'])
    if len(_doc) == 1 and _doc[0].pos_=="ADJ":
        print(_tag)

for _tag in tags[:100]:
    _tkn = nlp(_tag)[0]
    print(_tag, _tkn.pos_, _tkn.tag_, _tkn.rank, _tkn.cluster)


clust = {}
pos = {}
for _tag in tags:
    _tkn = nlp(_tag)[0]
    if not _tkn.pos_ in pos:
        pos[_tkn.pos_] = 1
    else:
        pos[_tkn.pos_] += 1
        if not _tkn.cluster in clust:
            clust[_tkn.cluster] = 1
        else:
            clust[_tkn.cluster] += 1



from similarity import TagSimilarity
s = TagSimilarity()
s.calculate_matrix()
from stats import TagStatistics
t = TagStatistics(s.data)
counts = t.collect_tag_counts()
t.collect_wordnet_categories()
net = {k: v for k, v in sorted(t.wordnet.items(), key=lambda x: x[1], reverse=True)}
