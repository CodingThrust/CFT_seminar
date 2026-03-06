#import "templates/book.typ": book

#show: book.with(
  title: "Conformal Field Theory for Babies",
  author: "Zhaohui Zhi, Hongkuan Xia, Ruijin Guo",
  date: datetime.today(),
)

// Table of contents
#outline(depth: 2)
#pagebreak()

// Include chapters
#include "chapters/ch1.typ"
#include "chapters/ch2.typ"
#include "chapters/ch3.typ"
