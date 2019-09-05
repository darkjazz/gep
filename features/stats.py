from data import TagData
import spacy, en_core_web_md

class TagStats:
	def __init__(self):
		self.data = TagData()
		self.nlp = en_core_web_md.load()
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
			for _tag in _tags:
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
			_token = self.nlp(_name)[0]
			_pos = _token.pos_
			if not _pos in self.positions:
				self.positions[_pos] = 1
			else:
				self.positions[_pos] += 1
		return {k: v for k, v in sorted(self.positions.items(), key=lambda x: x[1], reverse=True)}
