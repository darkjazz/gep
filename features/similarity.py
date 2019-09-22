from data import TagData, FeatureData
import spacy, en_core_web_lg
import numpy as np
import hdbscan as hd
import progressbar as pb
from sklearn.manifold import TSNE

class TagSimilarity:
	def __init__(self, model='md', include_pos=None):
		self.data = TagData()
		self.model = model
		self.include_pos = include_pos

	def calculate_matrix(self):
		self.data.load(self.model, self.include_pos)
		self.size = len(self.data.tags)
		self.similarity_matrix = np.zeros((self.size, self.size))
		self.names = list(self.data.tags.keys())
		shrink = self.names.copy()
		bar = pb.ProgressBar(max_value=len(self.names))
		self.labels = []
		for _x, _name in enumerate(self.names):
			shrink.remove(_name)
			_setA = self.data.tags[_name]
			self.similarity_matrix[_x, _x] = 1.0
			for _y, _other in enumerate(shrink):
				_setB = self.data.tags[_other]
				_score = _setA.similarity(_setB)
				self.similarity_matrix[_x, _y] = _score
				self.similarity_matrix[_y, _x] = _score
			bar.update(_x)
		bar.finish()

	def calculate_coordinates(self):
		self.tsne = TSNE(n_components=2, verbose=1, metric='precomputed')
		self.coordinates = self.tsne.fit_transform(self.similarity_matrix)

	def make_clusters(self, min_size=17):
		self.clusterer = hd.HDBSCAN(min_cluster_size=min_size, metric='euclidean',
			p=1, min_samples=1, cluster_selection_method='leaf', leaf_size=min_size*2)
		self.clusterer.fit(self.coordinates)
		# self.soft_clusters = hd.all_points_membership_vectors(self.clusterer)
		print("finished making clusters ..")

	def collect_cluster_tags(self):
		if not hasattr(self.data, 'tags'):
			self.data.load(self.nlp)
		self.cluster_tags = [ { } for _ in range(max(self.clusterer.labels_) + 1) ]
		for _synth_index, _cluster_index in enumerate(self.clusterer.labels_):
			if self.clusterer.probabilities_[_synth_index] == 1.0:
				_tags = self.data.tags[self.names[_synth_index]]
				for _tag in _tags:
					if not _tag.text in self.cluster_tags[_cluster_index]:
						self.cluster_tags[_cluster_index][_tag.text] = 1
					else:
						self.cluster_tags[_cluster_index][_tag.text] += 1
		for _i, _tags in enumerate(self.cluster_tags):
			self.cluster_tags[_i] = { k:v for k,v in sorted(_tags.items(), key=lambda x: x[1], reverse=True) }

	def compare_index_variances(self):
		self.tag_matrix = [ ]
		limit = min([ len(_tags) for _tags in self.cluster_tags ]) - 1
		[ self.tag_matrix.append(_tags[:limit]) for _tags in [ list(_t.keys()) for _t in self.cluster_tags ] ]
		inverted = np.array(self.tag_matrix).T
		sets = [ len(set(_a)) for _a in inverted ]

class FeatureSimilarity:
	def __init__(self):
		self.data = FeatureData()

	def make_clusters(self, min_size=5, use_soft=True):
		self.data.load()
		self.clusterer = hd.HDBSCAN(min_cluster_size=min_size, metric='euclidean',
			p=1, min_samples=1, cluster_selection_method='leaf', leaf_size=min_size*2,
			prediction_data=use_soft)
		result = self.clusterer.fit(list(self.data.features.values()))
		if use_soft:
			self.soft_clusters = hd.all_points_membership_vectors(self.clusterer)
		print("finished making clusters ..")

class AudioSimilarity:
	def __init__(self):
		sefl.data = TagData()


class GenotypeSimilarity:
	def __init__(self):
		sefl.data = TagData()	
