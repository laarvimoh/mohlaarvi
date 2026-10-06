$html = Get-Content -Raw -Path "index.html"

# Update HTML Card 1 (Tabouni House)
$html = $html -replace '<div class="ov-title">Increo Studio</div>', '<div class="ov-title">Tabouni House</div>'
$html = $html -replace '<div class="wcard-name">Increo Studio</div>', '<div class="wcard-name">Tabouni House</div>'

# Update HTML Card 3 (Increo) replacing Logofolio 2026
$html = $html -replace '<div class="ov-title">Logofolio 2026</div>', '<div class="ov-title">Increo</div>'
$html = $html -replace '<div class="wcard-name">Logofolio 2026</div>', '<div class="wcard-name">Increo</div>'
$html = $html -replace '<div class="wcard-type">Herable \uFFFD MHS \uFFFD Engline \uFFFD Zkibaty \uFFFD Nexys \uFFFD Increo</div>', '<div class="wcard-type">Brand Identity & Visual System</div>'
$html = $html -replace '<div class="wcard-type">Herable .*? Increo</div>', '<div class="wcard-type">Brand Identity & Visual System</div>'
$html = $html -replace '<div class="ov-cat">Herable .*? Increo</div>', '<div class="ov-cat">Brand Identity & Visual System</div>'

# Update HTML Card 4 (Herable) replacing Mental Health Society
$html = $html -replace '<div class="ov-title">Mental Health Society</div>', '<div class="ov-title">Herable</div>'
$html = $html -replace '<div class="wcard-name">Mental Health Society</div>', '<div class="wcard-name">Herable</div>'

# Update JS projectData
$newJsData = @"
const projectData = {
  "Tabouni House": {
    desc: "Tabouni House branding and visual system.",
    images: ["projects/tabouni/TB1.png", "projects/tabouni/TB2.png"]
  },
  "Kastelo": {
    desc: "Kastelo brand identity and heraldic crest design.",
    images: ["projects/kastelo/kastelo.png"]
  },
  "Increo": {
    desc: "Increo visual system and identity design.",
    images: ["projects/increo/increo.png"]
  },
  "Herable": {
    desc: "Herable brand identity and visual language.",
    images: ["projects/herable/herable.png"]
  }
};
"@

$html = $html -replace 'const projectData = \{[\s\S]*?\};', $newJsData

Set-Content -Path "index.html" -Value $html -NoNewline
