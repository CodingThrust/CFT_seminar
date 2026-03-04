#let book(title: "", author: "", date: none, body) = {
  set document(title: title, author: author)
  set page(paper: "a4", margin: 2.5cm, numbering: "1")
  set text(font: "Linux Libertine", size: 11pt)
  set heading(numbering: "1.1")
  set par(justify: true, leading: 0.8em)

  // Title page
  align(center + horizon)[
    #text(size: 24pt, weight: "bold", title)
    #v(2em)
    #text(size: 16pt, author)
    #v(1em)
    #if date != none { text(size: 12pt, date.display()) }
  ]
  pagebreak()
  
  body
}