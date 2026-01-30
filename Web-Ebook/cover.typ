#let m = yaml("metadata.yml")

#set page(
  paper: "a4",
  margin: (
    top: 13mm,
    bottom: 13mm,
    left: 10mm,
    right: 10mm,
  ),
)

#set align(center)

#box(
  inset: 5pt,
  stroke: (
    paint: black, 
    thickness: 1pt, 
  ),
  width: 100%, 
  height: 100%, 

  box(
    stroke: (
      paint: black, 
      thickness: 5pt, 
    ),
    inset: (
      top: 15mm,    
      bottom: 10mm, 
      left: 10mm,   
      right: 10mm   
    ),
    width: 100%,
    height: 100%,
    [
      #v(1fr)
      
      #[
        #set text(size: 15pt, weight: "bold")
        #set par(leading: 1.2em)
        EBOOK
      ]
      
      #v(0.5cm)
      
      #[
        #set text(size: 28pt, weight: "bold")
        #set align(center)
        #m.title
      ]
      
      #v(0.3cm)
      
      #[
        #set text(size: 18pt)
        #set align(center)
        #m.subtitle
      ]
      
      #v(1cm)
      
      #line(length: 50%, stroke: 2pt + black)
      
      #v(1cm)
      
      #[
        #set text(size: 14pt)
        #set align(center)
        Hướng dẫn toàn diện về lập trình web từ cơ bản đến nâng cao
      ]
      
      #v(0.5cm)
      
      #[
        #set text(size: 12pt)
        Bao gồm 9 chương với 57+ chủ đề
      ]
            
      #v(1fr)
      
      #line(length: 30%, stroke: 1pt + black)
      
      #v(0.3cm)
      
      #[
        #set text(size: 12pt)
        #set align(center)
        #m.date
      ]
    ]
  )
)
