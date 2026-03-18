// ============================================
// TRANG BÌA
// ============================================

#set page(
  paper: "a4",
  margin: 0mm,
)

#set align(center + horizon)

// Logo hoặc biểu tượng
#v(2cm)

#block(
  width: 80%,
  [
    #text(size: 36pt, weight: "bold", fill: rgb("#1976D2"))[
      CẤU TRÚC DỮ LIỆU
    ]
    
    #v(0.5em)
    
    #text(size: 36pt, weight: "bold", fill: rgb("#1976D2"))[
      VÀ GIẢI THUẬT
    ]
    
    #v(1em)
    
    #text(size: 18pt, style: "italic", fill: rgb("#424242"))[
      Data Structures and Algorithms
    ]
  ]
)

#v(2cm)

#line(length: 60%, stroke: 2pt + rgb("#1976D2"))

#v(1cm)

#text(size: 14pt, fill: rgb("#616161"))[
  *Hiểu Bản Chất • Nắm Vững Ứng Dụng • Thành Thạo Kỹ Năng*
]

#v(3cm)

#text(size: 12pt, fill: rgb("#757575"))[
  Dành cho sinh viên Khoa học Máy tính
  
  #v(0.5em)
  
  Ngôn ngữ minh họa: C++
]

#v(1fr)

#text(size: 11pt, fill: rgb("#9E9E9E"))[
  #datetime.today().display("[year]")
]

#v(1cm)
