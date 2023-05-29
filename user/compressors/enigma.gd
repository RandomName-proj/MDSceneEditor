extends GenericCompressor

func compress(data: PackedByteArray) -> PackedByteArray:
	var en := GDEnigma.new()
	return en.compress(data)

func decompress(data: PackedByteArray) -> PackedByteArray:
	var en := GDEnigma.new()
	return en.decompress(data)
