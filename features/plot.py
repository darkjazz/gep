import couchdb, IPython
import matplotlib.pyplot as plt
import seaborn as sb
from pylab import plot, show, figure, imshow
import numpy as np
from sklearn.manifold import TSNE

class GesPlotter:
	def __init__(self):
		self.srv = couchdb.Server()
		self.db = self.srv["ges-features"]

	def plot(self, defname):
		for row in self.db.view("views/doc_by_defname", key=defname):
			doc = row.value
		if doc:
			self.showMelBands(doc['frames']['lowlevel']['melbands'])

	def showMelBands(self, bands):
		melbands = np.array(bands).T
		imshow(melbands[:,:], aspect = 'auto', origin='lower', interpolation='none')
		plt.title("Mel band spectral energies in frames")
		show()

class SimilarityPlotter:
	def plot_similarities(self, matrix, labels=None):
		self.tsne = TSNE(n_components=2, verbose=1, metric='precomputed')
		self.emb = self.tsne.fit_transform(matrix)
		plt.scatter(*self.emb.T,s=13, linewidth=0, alpha=0.7)
		if labels:
			for _i, _label in enumerate(labels):
				coords = self.emb[_label["index"]]
				plt.annotate(_label["label"], (coords[0], coords[1]))
		plt.show()

	def plot_features(self, features):
		self.tsne = TSNE(n_components=2, verbose=1)
		self.emb = self.tsne.fit_transform(features)
		plt.scatter(*self.emb.T, s=13, linewidth=0, alpha=0.7)
		plt.show()

	def plot_clusters(self, features, clusterer, clusters):
		self.tsne = TSNE(n_components=2, verbose=1)
		self.emb = self.tsne.fit_transform(features)
		color_palette = sb.color_palette('Paired', max(clusterer.labels_) + 1)
		cluster_colors = [color_palette[np.argmax(x)] for x in clusters]
		plt.scatter(*self.emb.T,s=13, linewidth=0, c=cluster_colors, alpha=0.75)
		plt.show()

	def plot_exemplars(self, clusterer):
		exemplars = [ ]
		exemplar_labels = [ ]
		for _i, _array in enumerate(clusterer.exemplars_):
			[ exemplars.append(_a) for _a in _array ]
			[ exemplar_labels.append(_i) for _a in _array ]
		self.tsne = TSNE(n_components=2, verbose=1)
		self.emb = self.tsne.fit_transform(exemplars)
		color_palette = sb.color_palette('Paired', max(exemplar_labels) + 1)
		cluster_colors = [color_palette[c] for c in exemplar_labels]
		plt.scatter(*self.emb.T,s=17, linewidth=0, c=cluster_colors, alpha=0.75)
		plt.show()

# GesPlotter().plot('gep_gen000_010_151007_165550')
