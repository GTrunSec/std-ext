{context}: ''
  package main

  import (
  	"fmt"
  	"github.com/charmbracelet/glamour"
  )

  func main() {
  	${context}
  	out, _ := glamour.Render(hello, "dark")
    out_1, _ := glamour.Render(comment_1, "dark")
    out_2, _ := glamour.Render(comment_2, "dark")
  	fmt.Print(out)
    fmt.Print(out_1)
    fmt.Print(out_2)
  }
''
