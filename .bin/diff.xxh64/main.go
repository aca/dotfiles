package main

import (
	"io"
	"log"
	"os"
	"sync"

	"github.com/cespare/xxhash/v2"
)

// diff.xxh64 $1 $2 $3
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
		log.Fatal(err)
	}
	defer f1.Close()
	f2, err := os.Open(f2Name)
	if err != nil {
		log.Fatal(err)
	}
	defer f2.Close()

	f1Stat, _ := f1.Stat()
	f2Stat, _ := f2.Stat()
	
	if f1Stat.Size() != f2Stat.Size() {
		log.Fatalf("different size %v %v", f1Name, f2Name)
	}
	
	wg := sync.WaitGroup{}
	wg.Add(2)

	var f1Hash uint64 = 0
	var f2Hash uint64 = 0

	go func() {
		f1Hash = getHash(f1)
		wg.Done()
	}()
	go func() {
		f2Hash = getHash(f2)
		wg.Done()
	}()

	wg.Wait()

	if f1Hash == 0 || f2Hash == 0 {
		log.Fatalf("error calculating %v %v", f1Name, f2Name)
	}

	if f1Hash != f2Hash {
		log.Fatalf("different hash %v:%016x %v:%016x", f1Name, f1Hash, f2Name, f2Hash)
	}

	err = os.Remove(removeTarget)
	if err != nil {
		log.Fatal(err)
	}
}

func getHash(r io.Reader) uint64 {
	h := xxhash.New()
	if _, err := io.Copy(h, r); err != nil {
		log.Fatal(err)
	}
	return h.Sum64()
}
