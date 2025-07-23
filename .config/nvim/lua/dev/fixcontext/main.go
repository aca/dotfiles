package main

import (
	"context"
	"log"
)

func main() {
	log.Println("start")

		x := 3
		_ = x

	ctx := context.Background()

	c(ctx)




}

func c(ctx context.Context) {

}
