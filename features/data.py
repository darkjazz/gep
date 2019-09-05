import couchdb
import numpy as np
import progressbar as pb
import en_core_web_lg

class TagData:
	def __init__(self):
		srv = couchdb.Server()
		self.db = srv['ges-freesound-tags']
		self.dict_db = srv['ges-synth-dict']
		self.view = 'views/tags_by_name'

	def load(self, nlp=None):
		if not nlp:
			self.nlp = en_core_web_lg.load()
		else:
			self.nlp = nlp
		self.tags = { }
		self.unique_tags = [ ]
		bar = pb.ProgressBar(max_value=len(self.db.view(self.view)))
		for _i, row in enumerate(self.db.view(self.view)):
			_tokens = self.nlp(" ".join([ _w.lower() for _w in row.value ]))
			if _tokens.vector_norm:
				self.tags[row.key] = _tokens
				[ self.unique_tags.append(_t.text) for _t in _tokens if not _t.text in self.unique_tags ]
			bar.update(_i)
		bar.finish()
		print('loaded tokens for %d synths' % len(self.tags))

	def make_dict(self):
		self.dict = { }
		for _name in self.tags:
			_tokens = self.tags[_name]
			for _token in _tokens:
				if not _token.text in self.dict:
					self.dict[_token.text] = [ _name ]
				elif not _token.text in self.dict[_token.text]:
					self.dict[_token.text].append(_name)

	def save_dict(self):
		for _word in self.dict:
			self.dict_db.save({ '_id': _word, 'names': self.dict[_word	] })

	def load_dict(self):
		self.dict = { }
		for _row in self.dict_db.view('views/names_by_tag'):
			self.dict[_row.key] = _row.value

	def search(self, text):
		names = [ ]
		words = { }
		for _word in text.split(" "):
			if _word in self.dict:
				words[_word] = self.dict[_word]
				names = self.dict[_word]
		names = [ set(names) & set(_names) for _names in words.values() ]
		return list(names[0])

class FeatureData:
	def __init__(self):
		srv = couchdb.Server()
		self.db = srv['ges-features']
		self.view = 'views/stats_by_name'

	def load(self):
		self.features = { }
		bar = pb.ProgressBar(max_value=len(self.db.view(self.view)))
		for _i, _row in enumerate(self.db.view(self.view)):
			_doc = _row.value
			_ftr = _doc['mfcc']['mean']
			_ftr.extend(list(np.array(_doc['mfcc']['cov']).diagonal()))
			_ftr.extend(_doc['spectral_contrast_coeffs']['mean'])
			_ftr.extend(_doc['spectral_contrast_coeffs']['stdev'])
			_ftr.extend(_doc['spectral_contrast_valleys']['mean'])
			_ftr.extend(_doc['spectral_contrast_valleys']['stdev'])
			_ftr.append(_doc['melbands_flatness_db']['mean'])
			_ftr.append(_doc['melbands_flatness_db']['stdev'])
			_ftr.append(_doc['spectral_complexity']['mean'])
			_ftr.append(_doc['spectral_complexity']['stdev'])
			self.features[_row.key] = _ftr
			bar.update(_i)
		bar.finish()
		print('loaded features for %d synths' % len(self.features))
