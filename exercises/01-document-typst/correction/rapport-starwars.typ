// Simple numbering for non-book documents
#let equation-numbering = "(1)"
#let callout-numbering = "1"
#let subfloat-numbering(n-super, subfloat-idx) = {
  numbering("1a", n-super, subfloat-idx)
}

// Theorem configuration for theorion
// Simple numbering for non-book documents (no heading inheritance)
#let theorem-inherited-levels = 0

// Theorem numbering format (can be overridden by extensions for appendix support)
// This function returns the numbering pattern to use
#let theorem-numbering(loc) = "1.1"

// Default theorem render function
#let theorem-render(prefix: none, title: "", full-title: auto, body) = {
  if full-title != "" and full-title != auto and full-title != none {
    strong[#full-title.]
    h(0.5em)
  }
  body
}
// Some definitions presupposed by pandoc's typst output.
#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms.item: it => block(breakable: false)[
  #text(weight: "bold")[#it.term]
  #block(inset: (left: 1.5em, top: -0.4em))[#it.description]
]

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let fields = old_block.fields()
  let _ = fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => {
          let subfloat-idx = quartosubfloatcounter.get().first() + 1
          subfloat-numbering(n-super, subfloat-idx)
        })
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => block({
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          })

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let children = old_title_block.body.body.children
  let old_title = if children.len() == 1 {
    children.at(0)  // no icon: title at index 0
  } else {
    children.at(1)  // with icon: title at index 1
  }

  // TODO use custom separator if available
  // Use the figure's counter display which handles chapter-based numbering
  // (when numbering is a function that includes the heading counter)
  let callout_num = it.counter.display(it.numbering)
  let new_title = if empty(old_title) {
    [#kind #callout_num]
  } else {
    [#kind #callout_num: #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block,
    block_with_new_content(
      old_title_block.body,
      if children.len() == 1 {
        new_title  // no icon: just the title
      } else {
        children.at(0) + new_title  // with icon: preserve icon block + new title
      }))

  align(left, block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1)))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color,
        width: 100%,
        inset: 8pt)[#if icon != none [#text(icon_color, weight: 900)[#icon] ]#title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}


// syntax highlighting functions from skylighting:
/* Function definitions for syntax highlighting generated by skylighting: */
#let EndLine() = raw("\n")
#let Skylighting(fill: none, number: false, start: 1, sourcelines) = {
   let blocks = []
   let lnum = start - 1
   let bgcolor = rgb("#f1f3f5")
   for ln in sourcelines {
     if number {
       lnum = lnum + 1
       blocks = blocks + box(width: if start + sourcelines.len() > 999 { 30pt } else { 24pt }, text(fill: rgb("#aaaaaa"), [ #lnum ]))
     }
     blocks = blocks + ln + EndLine()
   }
   block(fill: bgcolor, width: 100%, inset: 8pt, radius: 2pt, blocks)
}
#let AlertTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let AnnotationTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let AttributeTok(s) = text(fill: rgb("#657422"),raw(s))
#let BaseNTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let BuiltInTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let CharTok(s) = text(fill: rgb("#20794d"),raw(s))
#let CommentTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let CommentVarTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))
#let ConstantTok(s) = text(fill: rgb("#8f5902"),raw(s))
#let ControlFlowTok(s) = text(weight: "bold",fill: rgb("#003b4f"),raw(s))
#let DataTypeTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let DecValTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let DocumentationTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))
#let ErrorTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let ExtensionTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let FloatTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let FunctionTok(s) = text(fill: rgb("#4758ab"),raw(s))
#let ImportTok(s) = text(fill: rgb("#00769e"),raw(s))
#let InformationTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let KeywordTok(s) = text(weight: "bold",fill: rgb("#003b4f"),raw(s))
#let NormalTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let OperatorTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let OtherTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let PreprocessorTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let RegionMarkerTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let SpecialCharTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let SpecialStringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let StringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let VariableTok(s) = text(fill: rgb("#111111"),raw(s))
#let VerbatimStringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let WarningTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))



#let article(
  title: none,
  subtitle: none,
  authors: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Set document metadata for PDF accessibility
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()
  set par(
    justify: true,
    leading: linestretch * 0.65em
  )
  set text(lang: lang,
           region: region,
           size: fontsize)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
   }

  let has-title-block = title != none or (authors != none and authors != ()) or date != none or abstract != none
  if has-title-block {
    place(
      top,
      float: true,
      scope: "parent",
      clearance: 4mm,
      block(below: 1em, width: 100%)[

        #if title != none {
          align(center, block(inset: 2em)[
            #set par(leading: heading-line-height) if heading-line-height != none
            #set text(font: heading-family) if heading-family != none
            #set text(weight: heading-weight)
            #set text(style: heading-style) if heading-style != "normal"
            #set text(fill: heading-color) if heading-color != black

            #text(size: title-size)[#title #if thanks != none {
              footnote(thanks, numbering: "*")
              counter(footnote).update(n => n - 1)
            }]
            #(if subtitle != none {
              parbreak()
              text(size: subtitle-size)[#subtitle]
            })
          ])
        }

        #if authors != none and authors != () {
          let count = authors.len()
          let ncols = calc.min(count, 3)
          grid(
            columns: (1fr,) * ncols,
            row-gutter: 1.5em,
            ..authors.map(author =>
                align(center)[
                  #author.name \
                  #author.affiliation \
                  #author.email
                ]
            )
          )
        }

        #if date != none {
          align(center)[#block(inset: 1em)[
            #date
          ]]
        }

        #if abstract != none {
          block(inset: 2em)[
          #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
          ]
        }
      ]
    )
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  doc
}

#set table(
  inset: 6pt,
  stroke: none
)
#show heading: it => {
  show regex("\p{Lu}"): c => lower(c.text)
  it
}
#let brand-color = (
  background: rgb("#f5f0e1"),
  foreground: rgb("#0b0b0f"),
  imperial-red: rgb("#bc1e22"),
  primary: rgb("#bc1e22"),
  sw-black: rgb("#0b0b0f"),
  sw-cream: rgb("#f5f0e1"),
  sw-yellow: rgb("#ffe81f")
)
#let brand-color-background = (
  background: color.mix((brand-color.background, 15%), (brand-color.background, 85%)),
  foreground: color.mix((brand-color.foreground, 15%), (brand-color.background, 85%)),
  imperial-red: color.mix((brand-color.imperial-red, 15%), (brand-color.background, 85%)),
  primary: color.mix((brand-color.primary, 15%), (brand-color.background, 85%)),
  sw-black: color.mix((brand-color.sw-black, 15%), (brand-color.background, 85%)),
  sw-cream: color.mix((brand-color.sw-cream, 15%), (brand-color.background, 85%)),
  sw-yellow: color.mix((brand-color.sw-yellow, 15%), (brand-color.background, 85%))
)
#set page(fill: brand-color.background)
#set text(fill: brand-color.foreground)
#set table.hline(stroke: (paint: brand-color.foreground))
#set line(stroke: (paint: brand-color.foreground))
#let brand-logo-images = (
  sw-star: (
    alt: "Étoile jaune Star Wars",
    path: "_logo-sw.svg"
  )
)
#let brand-logo = (
  medium: (
    alt: "Étoile jaune Star Wars",
    path: "_logo-sw.svg"
  )
)
#set text()
#show heading: set text(font: ("Star Jedi",), fill: rgb("#bc1e22"), )
#show link: set text(fill: rgb("#bc1e22"), )

#set page(
  paper: "a4",
  margin: (x: 2cm,y: 2.5cm,),
  numbering: "1",
  columns: 1,
)
#set page(background: align(left+top, box(inset: 0.4in, image("/_logo-sw.svg", width: 0.6in, alt: "Étoile jaune Star Wars"))))

#show: doc => article(
  title: [Anatomie d'une saga],
  subtitle: [Les colosses de la galaxie, qui sont-ils ?],
  lang: "fr",
  font: ("Inter",),
  heading-family: ("Star Jedi",),
  heading-color: rgb("#bc1e22"),
  sectionnumbering: "1.1.a",
  linestretch: 1.4,
  toc: true,
  toc_title: [Table des matières],
  toc_depth: 3,
  doc,
)

= Introduction
<introduction>
Le jeu de données #NormalTok("dplyr::starwars"); (#link("https://dplyr.tidyverse.org/reference/starwars.html")[documentation]) recense 87 personnages de la saga Star Wars, avec 14 variables (taille, masse, espèce, planète d'origine, films…). Dans ce court rapport, on regarde une question simple : #strong[qui sont les colosses de la galaxie ?]

= Top 5 des personnages les plus massifs
<top-5-des-personnages-les-plus-massifs>
#figure([
#{set text(font: ("Inter", "Segoe UI", "Roboto", "Arial", "sans-serif", "Segoe UI Emoji", "Segoe UI Symbol") , size: 12pt); table(
  columns: 5,
  align: (left,right,right,left,left,),
  table.header(table.cell(align: left, colspan: 5, fill: rgb("#ffe81f"))[#set text(size: 1.25em , weight: "bold" , fill: rgb("#0b0b0f")); Les colosses de la galaxie],
    table.cell(align: left, colspan: 5, fill: rgb("#f5f0e1"), stroke: (bottom: (paint: rgb("#d3d3d3"), thickness: 1.5pt)))[#set text(size: 0.85em , weight: "regular" , fill: rgb("#0b0b0f")); Top 5 par masse (kg)],
    table.cell(align: bottom + left, fill: rgb("#0b0b0f"))[#set text(size: 1.0em , weight: "bold" , fill: rgb("#f5f0e1")); Personnage], table.cell(align: bottom + right, fill: rgb("#0b0b0f"))[#set text(size: 1.0em , weight: "bold" , fill: rgb("#f5f0e1")); Taille (cm)], table.cell(align: bottom + right, fill: rgb("#0b0b0f"))[#set text(size: 1.0em , weight: "bold" , fill: rgb("#f5f0e1")); Masse (kg)], table.cell(align: bottom + left, fill: rgb("#0b0b0f"))[#set text(size: 1.0em , weight: "bold" , fill: rgb("#f5f0e1")); Espece], table.cell(align: bottom + left, fill: rgb("#0b0b0f"))[#set text(size: 1.0em , weight: "bold" , fill: rgb("#f5f0e1")); Planete],),
  table.hline(),
  table.cell(align: horizon + left, fill: rgb("#bc1e22"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[#set text(weight: "bold" , fill: rgb("#f5f0e1")); Jabba Desilijic Tiure], table.cell(align: horizon + right, fill: rgb("#bc1e22"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[#set text(weight: "bold" , fill: rgb("#f5f0e1")); 175], table.cell(align: horizon + right, fill: rgb("#bc1e22"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[#set text(weight: "bold" , fill: rgb("#f5f0e1")); 1 358], table.cell(align: horizon + left, fill: rgb("#bc1e22"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[#set text(weight: "bold" , fill: rgb("#f5f0e1")); Hutt], table.cell(align: horizon + left, fill: rgb("#bc1e22"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[#set text(weight: "bold" , fill: rgb("#f5f0e1")); Nal Hutta],
  table.cell(align: horizon + left, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Grievous], table.cell(align: horizon + right, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[216], table.cell(align: horizon + right, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[159], table.cell(align: horizon + left, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Kaleesh], table.cell(align: horizon + left, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Kalee],
  table.cell(align: horizon + left, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[IG-88], table.cell(align: horizon + right, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[200], table.cell(align: horizon + right, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[140], table.cell(align: horizon + left, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Droid], table.cell(align: horizon + left, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[NA],
  table.cell(align: horizon + left, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Darth Vader], table.cell(align: horizon + right, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[202], table.cell(align: horizon + right, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[136], table.cell(align: horizon + left, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Human], table.cell(align: horizon + left, fill: rgb("#e5e0d1"), stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Tatooine],
  table.cell(align: horizon + left, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Tarfful], table.cell(align: horizon + right, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[234], table.cell(align: horizon + right, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[136], table.cell(align: horizon + left, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Wookiee], table.cell(align: horizon + left, stroke: (top: (paint: rgb("#d5d0c1"), thickness: 0.75pt)))[Kashyyyk],
)}
], caption: figure.caption(
separator: "", 
position: top, 
[
]), 
kind: "quarto-float-tbl", 
supplement: "Table", 
)
<tbl-mass>


Sans surprise, #strong[Jabba the Hutt] écrase tout le monde avec ses 1 358 kg. Mais les vraies stars de la saga sont les #highlight(fill: brand-color.sw-yellow)[droïdes] : R2-D2 apparaît dans plus de films que n'importe quel humain.

= Taille vs masse
<taille-vs-masse>
#figure([
#box(image("rapport-starwars_files/figure-typst/fig-mass-1.svg", alt: "Nuage de points montrant la masse en fonction de la taille pour les 87 personnages de Star Wars. La masse est en échelle logarithmique. Deux cas remarquables sont colorés en rouge impérial et annotés : Jabba the Hutt en haut à droite, et Yoda en bas à gauche."))
], caption: figure.caption(
position: bottom, 
[
Taille et masse des personnages --- Jabba et Yoda mis en évidence (échelle log)
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
<fig-mass>


= Conclusion
<conclusion>
Une seule question, deux visualisations, un PDF lisible : Star Wars est un terrain de jeu compact mais riche. Pour aller plus loin (origines des personnages, présence dans la saga…), il faudrait étendre ce rapport en #strong[livre] --- c'est l'objet du Bloc 2 de ce tutoriel.
