// ============================================
// CẤU TRÚC DỮ LIỆU VÀ GIẢI THUẬT
// Data Structures and Algorithms
// ============================================

// Import components
#import "components/template.typ": *

// ============================================
// THIẾT LẬP FONT VÀ STYLE ĐỒNG NHẤT
// ============================================
#set text(
  font: "Times New Roman",
  size: 12pt,
  lang: "vi",
)

#set par(
  leading: 1em,
  justify: true,
  first-line-indent: 0em,
)

#set heading(numbering: "1.1.")

// Style cho heading
#show heading.where(level: 1): it => {
  set text(size: 18pt, weight: "bold", fill: rgb("#1976D2"))
  set block(above: 1.5em, below: 1em)
  pagebreak(weak: true)
  it
}

#show heading.where(level: 2): it => {
  set text(size: 14pt, weight: "bold", fill: rgb("#424242"))
  set block(above: 1.2em, below: 0.8em)
  it
}

#show heading.where(level: 3): it => {
  set text(size: 12pt, weight: "bold", fill: rgb("#616161"))
  set block(above: 1em, below: 0.6em)
  it
}

// Style cho block quotes
#show quote: it => {
  block(
    fill: luma(245),
    inset: 12pt,
    radius: 4pt,
    stroke: (left: 3pt + luma(200)),
    it
  )
}

// Style cho code blocks
#show raw.where(block: true): it => {
  set text(size: 10pt, font: "Consolas")
  block(
    fill: luma(245),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    it
  )
}

// Style cho inline code
#show raw.where(block: false): it => {
  box(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    it
  )
}

// Style cho tables
#set table(
  stroke: 0.5pt + luma(200),
  inset: 8pt,
)

#show table.cell.where(y: 0): set text(weight: "bold")
#show table.cell.where(y: 0): set table.cell(fill: luma(230))

// Style cho figures
#show figure: it => {
  set align(center)
  block(
    breakable: false,
    it
  )
}

#show figure.caption: it => {
  set text(size: 10pt, style: "italic")
  it
}

// ============================================
// TRANG BÌA
// ============================================
#include "cover.typ"

#pagebreak()

// ============================================
// THIẾT LẬP TRANG CHO NỘI DUNG
// ============================================
#set page(
  paper: "a4",
  margin: (
    top: 25mm,
    bottom: 25mm,
    left: 25mm,
    right: 20mm,
  ),
  header: context {
    if counter(page).get().first() > 1 {
      set text(size: 10pt, style: "italic", fill: rgb("#616161"))
      [Cấu trúc dữ liệu và Giải thuật]
      h(1fr)
      [Data Structures and Algorithms]
    }
  },
  footer: context {
    set align(center)
    set text(size: 10pt)
    line(length: 100%, stroke: 0.5pt + luma(200))
    v(0.3em)
    counter(page).display("1")
  },
)

// Reset page counter
#counter(page).update(1)

// ============================================
// MỤC LỤC
// ============================================
#[
  #set text(size: 18pt, weight: "bold", fill: rgb("#1976D2"))
  #align(center)[MỤC LỤC]
]

#v(1em)

#outline(
  title: none,
  depth: 3,
  indent: 1.5em,
)

#pagebreak()

// ============================================
// LỜI NÓI ĐẦU
// ============================================
= Lời nói đầu

Cấu trúc dữ liệu và Giải thuật (Data Structures and Algorithms - DSA) là nền tảng của khoa học máy tính. Đây không chỉ là môn học mà còn là kỹ năng cốt lõi mà mọi lập trình viên chuyên nghiệp cần nắm vững.

Cuốn sách này được viết với mục tiêu giúp bạn *hiểu bản chất*, không chỉ ghi nhớ máy móc. Mỗi chương được thiết kế để trả lời 3 câu hỏi cơ bản:

- *WHAT* (Nó là gì?) - Định nghĩa và khái niệm
- *WHY* (Tại sao cần nó?) - Lý do ra đời và giá trị thực tiễn
- *HOW* (Nó hoạt động như thế nào?) - Cơ chế hoạt động trong máy tính

Cuốn sách này dành cho sinh viên khoa học máy tính, với code minh họa bằng C++ - ngôn ngữ phổ biến trong giảng dạy DSA. Tuy nhiên, các khái niệm và nguyên lý có thể áp dụng cho bất kỳ ngôn ngữ lập trình nào.

Chúc bạn học tập hiệu quả!

#pagebreak()

// ============================================
// CÁC CHƯƠNG
// ============================================

#include "chapters/01-introduction.typ"
#include "chapters/02-algorithm-complexity.typ"
#include "chapters/03-recursion.typ"
#include "chapters/04-lists.typ"
#include "chapters/05-stack-queue.typ"
#include "chapters/06-tree.typ"
#include "chapters/07-avl.typ"
#include "chapters/08-heap.typ"
#include "chapters/09-hash.typ"
#include "chapters/10-sort.typ"
#include "chapters/11-graph.typ"
