# Resume Generator

My resume as code: [`resume_data.yaml`](resume_data.yaml) holds the content, [`resume.typ`](resume.typ) is a [Typst](https://typst.app) template that renders it to PDF.

Every push to `main` triggers a [GitHub Action](.github/workflows/release.yml) that compiles the PDF and publishes it as a new release — grab the latest one [here](../../releases/latest).

Build locally with `typst compile resume.typ resume.pdf`.
