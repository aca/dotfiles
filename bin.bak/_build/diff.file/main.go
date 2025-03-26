package main

import (
	"io"
	"log"
	"os"
	"sync"

	"github.com/cespare/xxhash/v2"
)

// diff.file $1 $2 $3
// if $1 $2 is same, return true and remove $3
// if $1 $2 is different return error

func main() {
	log.SetPrefix("#")
	log.SetFlags(0)

	if len(os.Args) != 3 && len(os.Args) != 4 {
		log.Fatal("len(os.Args) != 3 && len(os.Args) != 4")
	}

	log.Println(os.Args)

	var removeTarget string
	if len(os.Args) == 4 {
		removeTarget = os.Args[3]
	}

	f1Name := os.Args[1]
	f2Name := os.Args[2]
	f1, err := os.Open(f1Name)
	if err != nil {
		if os.IsNotExist(err) {
			log.Println("file not exists")
			os.Exit(0)
		} else {
			log.Fatal(err)
		}
	}
	defer f1.Close()
	f2, err := os.Open(f2Name)
	if err != nil {
		if os.IsNotExist(err) {
			log.Println("file not exists")
			os.Exit(0)
		} else {
			log.Fatal(err)
		}
	}
	defer f2.Close()

	f1Stat, _ := f1.Stat()
	f2Stat, _ := f2.Stat()

	if f1Stat.Size() != f2Stat.Size() {
		log.Fatalf("different size %v %v", f1Name, f2Name)
	}
	log.Printf("same size %v %v, checking hash", f1Stat.Size(), f2Stat.Size())

	wg := sync.WaitGroup{}
	wg.Add(2)

	var f1Hash uint64 = 0
	var f2Hash uint64 = 0

	go func() {
		f1Hash = getHash(f1, f1Stat.Size())
		log.Printf("hash %v, %016x", f1Name, f1Hash)
		wg.Done()
	}()
	go func() {
		f2Hash = getHash(f2, f2Stat.Size())
		log.Printf("hash %v, %016x", f2Name, f2Hash)
		wg.Done()
	}()

	wg.Wait()

	if f1Hash == 0 || f2Hash == 0 {
		log.Fatalf("error calculating %v %v", f1Name, f2Name)
	}

	if f1Hash != f2Hash {
		log.Fatalf("different hash %v:%016x %v:%016x", f1Name, f1Hash, f2Name, f2Hash)
	}

	log.Printf("same hash %v:%016x %v:%016x", f1Name, f1Hash, f2Name, f2Hash)

	if removeTarget != "" {
		err = os.Remove(removeTarget)
		if err != nil {
			log.Fatal(err)
		}
	}
}

func getHash(r io.Reader, size int64) uint64 {
	h := xxhash.New()
	r = io.TeeReader(r, &WriteCounter{Size: size})
	if _, err := io.Copy(h, r); err != nil {
		log.Fatal(err)
	}
	return h.Sum64()
}

type WriteCounter struct {
	Total int64 // Total # of bytes transferred
	Size  int64
	Counter int64
}

func (wc *WriteCounter) Write(p []byte) (int, error) {
	n := len(p)
	wc.Total += int64(n)
	wc.Counter += int64(n)

	if wc.Counter > 1024*1024*100 {
		log.Printf("Read %v, %v, %v",  float64(wc.Total) / float64(wc.Size) * 100, wc.Size, wc.Total)
		wc.Counter = 0
	}

	return n, nil
}
