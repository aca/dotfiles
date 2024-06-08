package main

import (
	"context"
	"log"
	"os"

	"github.com/chromedp/chromedp"
)

var chromeContext context.Context

func main() {
	cmd := os.Args[1]
	target := os.Args[2]

	var cancel func()
	chromeContext, cancel = chromedp.NewRemoteAllocator(context.Background(), "ws://127.0.0.1:9222/")
	_ = cancel
	// defer cancel()

	chromeContext, cancel = chromedp.NewContext(chromeContext)
	_ = cancel
	// defer cancel()

	if cmd == "open" {
		open(target)
	}
}

func open(target string) {
	if err := chromedp.Run(chromeContext,
		chromedp.Navigate(target),
	); err != nil {
		log.Fatal(err)
	}
}
