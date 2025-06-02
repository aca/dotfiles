package main

import "os"

func main() {
	zoo()
}

func x() error {
	return nil
}

func y() (int, error) {
	return 0, nil
}

type X struct {
	Name string
}

func (x X) px() (int, int, error) {

	xx, err := os.Open("ewr")
	_ = xx

	return 0, 0, nil
}

func Print() (int, error) {
	f, err := os.Open("hello")
	if err != nil {
		return 0, nil
	}
	_ = f
	return 0, nil
}

// this should be here
// this should be here
// this should be here
// this should be here
// this should be here

// func (x *X) Print() (int, error) {
// 	f, err := os.Open("hello")
// 	_ = f
//
//
// 	return 0, nil
// }

func zoo() (int, err error) {

	x := func() error {
		return nil
	}
	_ = x

	var cc = func() error {
		return nil
	}
	_ = cc

	for i := range 3 {
		_ = i
	}

	return
}
