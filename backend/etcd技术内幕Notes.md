
#### sample: etcd

~~~go
func (ms* MemoryStorage) CreateSnapshot(i uint64, cs* pb.ConfState, data[] byte) (pb.Snapshot, error) {
	...
	offset := ms.ents[0].Index
	ms.snapshot.Metadata.Index = i
	ms.snapshot.Metadata.Term = ms.ents[i - offset].Term
	if cs != nil {
		ms.snapshot.Metadata.ConfState = *cs
	}
	ms.snapshot.Data = data
	return ms.snapshot, nil
}

~~~
