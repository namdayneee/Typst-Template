// ============================================
// TEMPLATE COMPONENTS
// Các component dùng chung cho toàn bộ ebook DSA
// ============================================

// Box định nghĩa/khái niệm (WHAT)
#let defbox(title: "Định nghĩa", content) = block(
  fill: rgb("#E8F4F8"),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + rgb("#2196F3")),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("#1976D2"))[#title]
    #v(0.5em)
    #content
  ]
)

// Box lý do/tại sao (WHY)
#let whybox(content) = block(
  fill: rgb("#FFF3E0"),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + rgb("#FF9800")),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("#F57C00"))[💡 Tại sao cần nó?]
    #v(0.5em)
    #content
  ]
)

// Box cách hoạt động (HOW)
#let howbox(content) = block(
  fill: rgb("#F3E5F5"),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + rgb("#9C27B0")),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("#7B1FA2"))[⚙️ Cách hoạt động]
    #v(0.5em)
    #content
  ]
)

// Box thông tin/ghi chú
#let infobox(content) = block(
  fill: luma(245),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + luma(180)),
  width: 100%,
  content
)

// Box cảnh báo
#let warnbox(content) = block(
  fill: rgb("#FFEBEE"),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + rgb("#F44336")),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("#D32F2F"))[⚠️ Cảnh báo]
    #v(0.5em)
    #content
  ]
)

// Box tip/gợi ý  
#let tipbox(content) = block(
  fill: rgb("#E8F5E9"),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + rgb("#4CAF50")),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("#388E3C"))[💡 Mẹo]
    #v(0.5em)
    #content
  ]
)

// Box ứng dụng thực tế
#let appbox(content) = block(
  fill: rgb("#E0F2F1"),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + rgb("#009688")),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("#00695C"))[🌐 Ứng dụng thực tế]
    #v(0.5em)
    #content
  ]
)

// Box phân tích complexity
#let complexitybox(time: none, space: none) = block(
  fill: rgb("#FFF8E1"),
  inset: 12pt,
  radius: 4pt,
  stroke: 1pt + rgb("#FBC02D"),
  width: 100%,
  [
    #text(weight: "bold", size: 11pt)[📊 Độ phức tạp]
    #v(0.5em)
    #if time != none [
      *Time Complexity:* #time \
    ]
    #if space != none [
      *Space Complexity:* #space
    ]
  ]
)

// Box lỗi thường gặp
#let bugbox(content) = block(
  fill: rgb("#FCE4EC"),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + rgb("#E91E63")),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("#C2185B"))[🐛 Lỗi thường gặp]
    #v(0.5em)
    #content
  ]
)

// Box lịch sử
#let historybox(content) = block(
  fill: rgb("#EFEBE9"),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + rgb("#795548")),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("#5D4037"))[📜 Lịch sử & Nguồn gốc]
    #v(0.5em)
    #content
  ]
)
