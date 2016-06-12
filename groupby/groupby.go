package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

func groupby(fname string) {
	f, _ := os.Open(fname)
	b, _ := ioutil.ReadAll(f)
	s := string(b)
	m := make(map[int][]string)
	for _, l := range strings.Split(s, "\n") {
		m[len(l)] = append(m[len(l)], l)
	}
	fmt.Println(len(m))
	// for k := range m {
	// 	fmt.Println(len(m[k]))
	// }
}

func main() {
	for i := 0; i < 100; i++ {
		groupby("/usr/share/dict/american-english")
	}
}
