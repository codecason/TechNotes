
### Class 1.
Google File System

GFS
#### Map Reduce
	Usually Map is reading from local system
	shuffle
		some in streams of data
	10 Tegabyte

### Class 2. Rpc and Threads
- Use Go in the Lab
Go has good rpc;amazing in threads,lock,concurrent.
	Reference book: Effective Go.
- goroutine
reason to use threads:
- I/O concurrency
- Multi-core parallelism
- Convenience compared to event-driven
Channel in Go.
#### Coodination
	Channels
	sync.Cond
	waitGroup

~~~go
// Serial Crawler
func Serial(url string, fetcher Fecther, fetched map[string]bool) {
	if fetched[url] {
		return
	}
	fetched[url] = true
	urls, err := fetcher.Fetch(url)
	if err != nil {
		return
	}
	for _, u := range urls {
		Serial(u, fetcher, fetched)
	}
	return
}

// Concurrent crawler
type fetchState struct {
	mu     Sync.Mutex
	fetched map[string]bool
}

func ConcurrentMutex(url string, fetcher Fetcher, f *fetchState) {
	f.mu.Lock()
	already := f.fetched[url]
	f.fetched[url] = true
	f.mu.Unlock()
	if already {
		return
	}
	urls, err := fetcher.Fetch(url)
	if err != nil {
		return
	}
	var done sync.WaitGroup
	for _, u := range urls {
		done.Add(1)
		go func(u string) {
			defer done.Done()
			ConcurrentMutex(u, fetcher, f)
		}(u)
	}
	done.Wait()
	return
}


func makeState() *fetchState {
}

func worker(url string, ch chan []string, fetcher Fetcher) {
	urls, err := fetcher.Fetch(url)
	if err != nil {
		ch <- [] string{}
	} else {
		ch <- urls
	}
}

func master(ch chan []string, fetcher Fetcher) {
	n := 1
	fetched := make(map[string]bool)
	for urls := range ch {
		for _, u := range urls {
			if fetched[u] == false {
				fetched[u] = true
				n += 1
				go worker(u, ch, fetcher)
			}
		}
		n -= 1
		if n == 0 {
			break
		}
	}
}

func ConcurrentChannel(url string, fetcher Fetcher) {
	ch := make(chan []string)
	go func() {
		ch <- []string{url}
	}()
	master(ch, fetcher)
}

Shell code:
go run crawler.go

closure 的参数变量会分配到堆上
~~~
go: race detector
