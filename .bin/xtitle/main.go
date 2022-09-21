package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"

	"github.com/PuerkitoBio/goquery"
)

func main() {
	req, err := http.NewRequest(http.MethodGet, os.Args[1], nil)
	if err != nil {
		log.Fatal(err)
	}

	req.Header.Set("User-Agent", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36")

	resp, err := http.Get(os.Args[1])
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	doc, err := goquery.NewDocumentFromResponse(resp)
	if err != nil {
		log.Fatal(err)
	}

	// http://developers.facebook.com/docs/opengraph/
	doc.Find("html > head > meta").Each(func(i int, s *goquery.Selection) {
		v, _ := s.Attr("property")
		if v == "og:title" {
			v2, ok := s.Attr("content")
			if ok {
				fmt.Print(v2)
                os.Exit(0)
			}
		}
	})

	title := doc.Find("head > title").Text()

	fmt.Print(strings.TrimSuffix(title, " - Youtube"))
}
