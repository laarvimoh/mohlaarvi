$html = Get-Content -Raw -Path "index.html"

$newWorkGrid = @"
    <div class="work-grid rv">
      <div class="wcard" onclick="openProjectModal(this)">
        <div class="wcard-img">
          <img src="projects/thumbnails/tabouni.png" alt="Tabouni House" style="width:100%;height:100%;object-fit:cover;object-position:top;transition:transform .5s ease" />
          <div class="wcard-overlay">
            <div class="ov-cat">Brand Identity & Visual System</div>
            <div class="ov-title">Tabouni House</div>
            <div class="ov-link">View Project <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg></div>
          </div>
        </div>
        <div class="wcard-meta">
          <div class="wcard-name">Tabouni House</div>
          <div class="wcard-type">Brand Identity & Visual System</div>
        </div>
      </div>

      <div class="wcard" onclick="openProjectModal(this)">
        <div class="wcard-img">
          <img src="projects/thumbnails/kastelo.png" alt="Kastelo" style="width:100%;height:100%;object-fit:cover;object-position:top;transition:transform .5s ease" />
          <div class="wcard-overlay">
            <div class="ov-cat">Brand Identity & Crest Design</div>
            <div class="ov-title">Kastelo</div>
            <div class="ov-link">View Project <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg></div>
          </div>
        </div>
        <div class="wcard-meta">
          <div class="wcard-name">Kastelo</div>
          <div class="wcard-type">Brand Identity & Crest Design</div>
        </div>
      </div>

      <div class="wcard" onclick="openProjectModal(this)">
        <div class="wcard-img">
          <img src="projects/thumbnails/increo.png" alt="Increo" style="width:100%;height:100%;object-fit:cover;object-position:top;transition:transform .5s ease" />
          <div class="wcard-overlay">
            <div class="ov-cat">Brand Identity & Visual System</div>
            <div class="ov-title">Increo</div>
            <div class="ov-link">View Project <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg></div>
          </div>
        </div>
        <div class="wcard-meta">
          <div class="wcard-name">Increo</div>
          <div class="wcard-type">Brand Identity & Visual System</div>
        </div>
      </div>

      <div class="wcard" onclick="openProjectModal(this)">
        <div class="wcard-img">
          <img src="projects/thumbnails/herable.png" alt="Herable" style="width:100%;height:100%;object-fit:cover;object-position:top;transition:transform .5s ease" />
          <div class="wcard-overlay">
            <div class="ov-cat">Brand Identity & Visual System</div>
            <div class="ov-title">Herable</div>
            <div class="ov-link">View Project <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg></div>
          </div>
        </div>
        <div class="wcard-meta">
          <div class="wcard-name">Herable</div>
          <div class="wcard-type">Brand Identity & Visual System</div>
        </div>
      </div>

      <div class="wcard" onclick="openProjectModal(this)">
        <div class="wcard-img">
          <img src="projects/thumbnails/logofolio.png" alt="Logofolio 2026" style="width:100%;height:100%;object-fit:cover;object-position:top;transition:transform .5s ease" />
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
"@

$parts = $html -split '(?s)<div class="work-grid rv">.*?</div>\s*</div>\s*</section>'
if ($parts.Count -eq 2) {
    $html = $parts[0] + $newWorkGrid + "`n    </div>`n  </div>`n</section>" + $parts[1]
    Set-Content -Path "index.html" -Value $html -NoNewline
} else {
    Write-Host "Failed to match work-grid exactly once."
}
