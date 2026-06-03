// resume.typ — reads all data from resume_data.yaml
#let data = yaml("resume_data.yaml")

// ── Palette ───────────────────────────────────────────────────────────────────

#let accent  = rgb("#0f172a")   // near-black (used where accent was)
#let dark    = rgb("#0f172a")   // near-black
#let body-c  = rgb("#1e293b")   // body text
#let muted   = rgb("#64748b")   // timestamps / secondary
#let rule-c  = rgb("#94a3b8")   // thin divider lines (slightly darker for contrast)

// ── Document Setup ────────────────────────────────────────────────────────────

#set document(title: data.bio.Name + " — Resume", author: data.bio.Name)
#set page(paper: "us-letter", margin: (x: 0.65in, y: 0.5in))
#set text(font: ("Helvetica Neue", "Helvetica", "Arial", "Liberation Sans"), size: 10pt, fill: body-c)
#set par(leading: 0.55em, justify: false)

// ── Components ────────────────────────────────────────────────────────────────

// Section header: "EXPERIENCE ───────────────"
#let section(title, body) = {
  v(0.6em)
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.7em,
    align: horizon,
  )[
    #text(size: 9pt, weight: "bold", fill: accent, tracking: 2pt)[#upper(title)]
  ][
    #line(length: 100%, stroke: 0.5pt + rule-c)
  ]
  v(0.3em)
  body
}

// Company header: company name (left) and location (right)
#let company-header(company, location) = {
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
  )[
    #text(weight: "bold", size: 11.5pt, fill: dark)[#company]
  ][
    #text(size: 9pt, fill: muted)[#location]
  ]
  v(0.05em)
}

// Role entry nested under a company: title + optional team (left), dates (right)
#let role-entry(title, team, duration, bullets) = {
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
  )[
    #text(weight: "bold", size: 10.5pt, fill: dark)[#title]
    #if team != "" [
      #text(fill: muted, size: 10pt)[  ·  #team]
    ]
  ][
    #text(size: 9pt, fill: muted)[#duration]
  ]
  v(0.15em)
  // Bullet points with ▸ character
  for b in bullets {
    grid(
      columns: (0.55em, 1fr),
      column-gutter: 0.45em,
      align: (top, top),
    )[
      #text(fill: accent, size: 9pt)[▸]
    ][
      #text(size: 10pt)[#b]
    ]
    v(0.05em)
  }
  v(0.3em)
}

// Education entry
#let edu-entry(degree, institution, year) = {
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
  )[
    #text(weight: "bold", size: 11pt, fill: dark)[#institution]
  ][
    #text(size: 9pt, fill: muted)[#year]
  ]
  v(0.05em)
  text(fill: accent)[#degree]
  v(0.5em)
}

// Skills row: "Category    value1, value2, value3"
#let skill-row(category, values) = {
  grid(
    columns: (1.75in, 1fr),
    column-gutter: 0.6em,
    align: (left, left),
  )[
    #text(weight: "bold", size: 10pt, fill: dark)[#category]
  ][
    #text(size: 10pt, fill: body-c)[#values]
  ]
  v(0.18em)
}

// ── Header ────────────────────────────────────────────────────────────────────

#align(center)[
  #text(size: 20pt, weight: "bold", fill: dark, tracking: 0.3pt)[#data.bio.Name]
  #v(0.12em)
  #text(size: 10.5pt, fill: accent, weight: "medium", tracking: 0.5pt)[#data.bio.tagline]
  #v(0.12em)
  #text(size: 9pt, fill: muted)[
    #data.bio.Email
    #h(0.9em)#text(fill: rule-c)[|]#h(0.9em)
    #link(data.bio.linked_in)[linkedin.com/in/nathan-silverman-094103170]
    #h(0.9em)#text(fill: rule-c)[|]#h(0.9em)
    #link(data.bio.github)[github.com/natesil]
  ]
]

#v(0.3em)
#line(length: 100%, stroke: 1pt + dark)
#v(0.3em)
#text(size: 10pt, fill: body-c)[#data.bio.summary]

// ── Experience ────────────────────────────────────────────────────────────────

#section("Experience")[
  #for org in data.experience {
    company-header(org.Company, org.Location)
    for role in org.Roles {
      role-entry(
        role.at("Job Title"),
        role.Team,
        role.Duration,
        role.Responsibilities,
      )
    }
  }
]

// ── Education ─────────────────────────────────────────────────────────────────

#section("Education")[
  #for edu in data.education {
    edu-entry(
      edu.Degree,
      edu.Institution,
      str(edu.at("Graduation Year")),
    )
  }
]

// ── Skills ────────────────────────────────────────────────────────────────────

#section("Skills")[
  #for entry in data.skills {
    let cat = entry.keys().first()
    skill-row(cat, entry.at(cat))
  }
]
