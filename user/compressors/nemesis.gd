extends GenericCompressor

func compress(data: PackedByteArray) -> PackedByteArray:
	var nem := GDNemesis.new()
	return nem.compress(data)

func decompress(data: PackedByteArray) -> PackedByteArray:
	var nem := GDNemesis.new()
	return nem.decompress(data)
