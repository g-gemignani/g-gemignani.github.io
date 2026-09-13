# CV source

`files/CV.pdf` is built from `cv.typ` with [Typst](https://typst.app).

The original document was made in Canva and had no source file. This rebuild
copies its layout: the same two columns, the same maroon rule, and the same
type. The fonts are Poppins and Tenor Sans, both under the SIL Open Font
License. Get the files from https://fonts.google.com and put them in a
`fonts/` directory next to this file.

To build:

```console
typst compile --font-path fonts cv.typ ../files/CV.pdf
```
