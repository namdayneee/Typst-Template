// ============================================
// TEMPLATE COMPONENTS
// Các component dùng chung cho toàn bộ ebook
// ============================================

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
  fill: luma(250),
  inset: 12pt,
  radius: 4pt,
  stroke: (left: 3pt + luma(100)),
  width: 100%,
  content
)

// Box tip/gợi ý  
#let tipbox(content) = block(
  fill: luma(245),
  inset: 12pt,
  radius: 4pt,
  stroke: 1pt + luma(200),
  width: 100%,
  content
)
