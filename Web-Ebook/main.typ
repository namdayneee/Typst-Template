
// ============================================
// BẢN ĐỒ TỔNG THỂ LẬP TRÌNH WEB
// Từ Gốc Đến Ngọn
// ============================================

#let m = yaml("metadata.yml")

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
  set text(size: 18pt, weight: "bold")
  set block(above: 1.5em, below: 1em)
  it
}

#show heading.where(level: 2): it => {
  set text(size: 14pt, weight: "bold")
  set block(above: 1.2em, below: 0.8em)
  it
}

#show heading.where(level: 3): it => {
  set text(size: 12pt, weight: "bold")
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
  set text(size: 10pt)
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
      set text(size: 10pt, style: "italic")
      [Bản Đồ Tổng Thể Lập Trình Web]
      h(1fr)
      [Từ Gốc Đến Ngọn]
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
  #set text(size: 18pt, weight: "bold")
  #align(center)[MỤC LỤC]
]

#v(1em)

#outline(
  title: none,
  depth: 2,
  indent: 1.5em,
)

#pagebreak()

// ============================================
// CHƯƠNG 1: TẦNG NGƯỜI DÙNG (CLIENT SIDE)
// ============================================
#include "chapters/01-client-side.typ"

#pagebreak()

// ============================================
// CHƯƠNG 2: FRONTEND FRAMEWORK
// ============================================
#include "chapters/02-frontend-framework.typ"

#pagebreak()

// ============================================
// CHƯƠNG 3: GIAO TIẾP - NETWORK
// ============================================
#include "chapters/03-network.typ"

#pagebreak()

// ============================================
// CHƯƠNG 4: SERVER - HẠ TẦNG
// ============================================
#include "chapters/04-server-infrastructure.typ"

#pagebreak()

// ============================================
// CHƯƠNG 5: BACKEND - LOGIC
// ============================================
#include "chapters/05-backend-logic.typ"

#pagebreak()

// ============================================
// CHƯƠNG 6: DATABASE
// ============================================
#include "chapters/06-database.typ"

#pagebreak()

// ============================================
// CHƯƠNG 7: AUTH & SECURITY
// ============================================
#include "chapters/07-auth-security.typ"

#pagebreak()

// ============================================
// CHƯƠNG 8: DEVOPS & TRIỂN KHAI
// ============================================
#include "chapters/08-devops-deployment.typ"

#pagebreak()

// ============================================
// CHƯƠNG 9: KIẾN TRÚC
// ============================================
#include "chapters/09-architecture.typ"


