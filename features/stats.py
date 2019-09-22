from data import TagData
import spacy, en_core_web_md
from spacy_wordnet.wordnet_annotator import WordnetAnnotator

class TagStatistics:
	def __init__(self, data=None):
		if data:
			self.data = data
		else:
			self.data = TagData()
			self.data.load(self.nlp)

	def collect_tag_counts(self):
		self.tag_counts = { }
		for _name in self.data.tags:
			_tags = self.data.tags[_name]
			for _tag in _tags:
				if not _tag.text in self.tag_counts:
					self.tag_counts[_tag.text] = 1
				else:
					self.tag_counts[_tag.text] += 1
		return {k: v for k, v in sorted(self.tag_counts.items(), key=lambda x: x[1], reverse=True)}

	def collect_tag_weights(self):
		self.tag_weights = { }
		for _name in self.data.tags:
			_tags = self.data.tags[_name]
			for _i, _tag in enumerate(_tags):
				if not _tag.text in self.tag_weights:
					self.tag_weights[_tag.text] = round(1 / (_i + 1), 2)
				else:
					self.tag_weights[_tag.text] += round(1 / (_i + 1), 2)
		return {k: v for k, v in sorted(self.tag_weights.items(), key=lambda x: x[1], reverse=True)}

	def collect_tag_counts_by_position(self, pos):
		self.tag_counts = { }
		for _name in self.data.tags:
			_tags = self.data.tags[_name]
			for _tag in _tags:
				if _tag.pos_ == pos:
					if not _tag.text in self.tag_counts:
						self.tag_counts[_tag.text] = 1
					else:
						self.tag_counts[_tag.text] += 1
		return {k: v for k, v in sorted(self.tag_counts.items(), key=lambda x: x[1], reverse=True)}

	def collect_positions(self):
		self.positions = { }
		for _name in self.tag_counts:
			_token = self.data.nlp(_name)[0]
			_pos = _token.pos_
			if not _pos in self.positions:
				self.positions[_pos] = 1
			else:
				self.positions[_pos] += 1
		return {k: v for k, v in sorted(self.positions.items(), key=lambda x: x[1], reverse=True)}

	def collect_wordnet_categories(self):
		self.wordnet = { }
		self.data.nlp.add_pipe(WordnetAnnotator(self.data.nlp.lang), after='tagger')
		for _name in self.tag_counts:
			_token = self.data.nlp(_name)[0]
			_cat = _token._.wordnet.wordnet_domains()
			if len(_cat) > 0:
				if not _cat[0] in self.wordnet:
					self.wordnet[_cat[0]] = [_name]
				else:
					self.wordnet[_cat[0]].append(_name)
