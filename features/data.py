import couchdb
import numpy as np
import progressbar as pb
import spacy
from pymongo import MongoClient

conn_str = "mongodb+srv://darkjazz:{pwd}@gep.2uoeb.mongodb.net/{db_name}?retryWrites=true&w=majority"

class MongoCloud:
	def __init__(self):
		self.cli = MongoClient(conn_str.format(pwd="5yNt43sIz3", db_name="gep"))
		self.db = self.cli.gep
		self.coll = self.db.ges_ld_00
		self.couch = couchdb.Server()["ges_ld_00"]

	def sync(self):
		synced = 0
		prg = pb.ProgressBar(max_value=len(self.couch))
		for _i, _id in enumerate(self.couch):
			if self.coll.count_documents({"_id": _id}) == 0:
				_doc = self.couch[_id]
				self.coll.insert_one(_doc)
				synced += 1
			prg.update(_i)
		prg.finish()
		print("synced {synced} synths to cloud".format(synced=synced))

class TagData:
	def __init__(self):
		srv = couchdb.Server()
		self.db = srv['ges-freesound-tags']
		self.dict_db = srv['ges-synth-dict']
		self.view = 'views/tags_by_name'

	#shuffle synths
	def load(self, model='lg', include_pos=None):
		self.nlp = spacy.load('en_core_web_%s' % model)
		self.tags = { }
		self.unique_tags = [ ]
		bar = pb.ProgressBar(max_value=len(self.db.view(self.view)))
		for _i, row in enumerate(self.db.view(self.view)):
			# _valid_tags = []
			# for _tag in row.value:
			# 	_tokens = self.nlp(_tag.lower().replace("-", " "))
			# 	for _token in _tokens:
			# 		if _token.has_vector and (include_pos and _token.pos_ in include_pos):
			# 			_valid_tags.append(_token.text)
			self.tags[row.key] = self.nlp(" ".join([ _w.lower().replace("-", " ") for _w in row.value ]))
			[ self.unique_tags.append(_t.text) for _t in self.tags[row.key] if not _t.text in self.unique_tags ]
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
