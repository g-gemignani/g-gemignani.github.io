# CV source

`files/CV.pdf` is built from `cv.typ` with [Typst](https://typst.app).

To build, with `typst` on the PATH:

```console
./build.sh
```

Everything the build needs is in this directory, so the output does not
depend on a font that a machine happens to have.

## Why this exists

The first version of the CV was made in Canva, and the repository kept only
the PDF. An update then needed the Canva account and the original design
file. This is a rebuild in Typst that copies the layout of that PDF.

The numbers in `cv.typ` are measured from the original, not guessed:

- Fonts: Poppins and Tenor Sans, the two families the old PDF embedded.
- Sizes: 9pt body, 12pt job titles, 13pt section headings, 17pt subtitle, 28pt name.
- Color: `#822434` for the rule and the maroon text.
- Columns: the rule at 220.7pt, the sidebar text at 33pt, the main column from 247.9pt to 548pt.
- Justification: on for the profile and the keyword lines, off everywhere else.

`photo.jpg` and the four `icon-*.png` files are taken out of the original
PDF, so the portrait and the contact icons are the same images.

## Fonts

`fonts/` holds Poppins and Tenor Sans under the SIL Open Font License. The
license of each family is next to the font files.
