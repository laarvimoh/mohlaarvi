$html = Get-Content -Raw -Path "index.html"

$newCardHtml = @"
      <div class="wcard" onclick="openProjectModal(this)">
        <div class="wcard-img">
          <img src="thumb_logofolio.jpg" alt="Logofolio 2026" style="width:100%;height:100%;object-fit:cover;object-position:top;transition:transform .5s ease" />
          <div class="wcard-overlay">
            <div class="ov-cat">Logo Collection</div>
            <div class="ov-title">Logofolio 2026</div>
            <div class="ov-link">View Project <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg></div>
          </div>
        </div>
        <div class="wcard-meta">
          <div class="wcard-name">Logofolio 2026</div>
          <div class="wcard-type">Collection of logos and marks designed in 2026</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ABOUT -->
"@

$html = $html -replace '(?s)\s*</div>\s*</div>\s*</section>\s*<!-- ABOUT -->', ("`n" + $newCardHtml)

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
  },
  "Logofolio 2026": {
    desc: "A collection of logos and marks designed in 2026.",
    images: ["projects/logofolio/logofolio.png"]
  }
};
"@

$html = $html -replace '(?s)const projectData = \{.*?\};', $newJsData

Set-Content -Path "index.html" -Value $html -NoNewline
