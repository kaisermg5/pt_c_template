class Rom:
	SYMBOL_DICT = None

	@classmethod
	def load_symbols(cls):
		if cls.SYMBOL_DICT is None:
			cls.SYMBOL_DICT = {}
			with open('build/offsets.txt') as f:
				for line in f:
					parts = line.split()
					if len(parts) == 3:
						cls.SYMBOL_DICT[parts[2]] = int(parts[0], base=16)

	@classmethod
	def get_symbol(cls, symbol_name):
		cls.load_symbols()

		return cls.SYMBOL_DICT[symbol_name]


class RomPatch:
	def __init__(self, offset, txt):
		self.offset = offset
		self.data = self.parse(txt)

	@staticmethod
	def parse(txt):
		ret = ''

		i = 0
		while i < len(txt):
			if txt[i] == '#':
				cmd = txt[i + 1]
				if cmd == '{':
					raise Exception('Missing command')
				elif txt[i + 2] != '{':
					raise Exception('Missing "{" at start of expression')
				
				expression_start = i + 3
				expression_end = txt.find('}', expression_start) - 1
				if expression_end < 0:
					raise Exception('Expression not closed')
				elif expression_end == expression_start:
					raise Exception('Expresion empty')
				i += 5 + expression_end - expression_start 

				ret += RomPatch.get_expression_data(cmd, txt[expression_start:expression_end + 1])
			else:
				ret += txt[i]
				i += 1

		return bytes.fromhex(''.join(ret.split()))

	@staticmethod
	def get_expression_data(cmd, expression):
		if cmd == 'f': # inserts file data
			with open(expression, 'rb') as f:
				return f.read().hex()
		elif cmd == 'w': # reads word from extension's symbols
			return Rom.get_symbol(expression).to_bytes(4, 'little').hex()
		elif cmd == 't': # reads word from extension's symbols, and sets thumb bit
			return (Rom.get_symbol(expression) | 1).to_bytes(4, 'little').hex()
		else:
			raise Exception('Invalid command')


	def patch_rom(self, rom):
		rom.seek(self.offset)
		rom.write(self.data)

	def __repr__(self):
		return self.data.hex().upper()

	