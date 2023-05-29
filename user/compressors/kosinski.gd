extends GenericCompressor

func compress(data: PackedByteArray) -> PackedByteArray:
	var kos := GDKosinski.new()
	return kos.compress(data)

func decompress(data: PackedByteArray) -> PackedByteArray:
	var kos := GDKosinski.new()
	return kos.decompress(data)
