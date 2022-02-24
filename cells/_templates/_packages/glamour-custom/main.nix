{context}: ''
  package main

  import (
  	"fmt"
  	"github.com/charmbracelet/glamour"
  )

  func main() {
  	${context}
  	out, _ := glamour.Render(hello, "dark")
  	fmt.Print(out)
  }
''
