output <- "charte-starwars.pdf"
targets <- c(
  "../exercises/01-document-typst/starter/",
  "../exercises/02-projet-book/starter/"
)
for (t in targets) {
  ok <- file.copy(output, t, overwrite = TRUE)
  if (!ok) stop("Failed to copy ", output, " to ", t)
  message("Copied ", output, " -> ", t)
}
