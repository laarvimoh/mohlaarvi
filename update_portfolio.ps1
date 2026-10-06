$html = Get-Content -Raw -Path "index.html"

# 1. Remove Behance link from work-head
$html = $html -replace '(?i)<a href="https://www\.behance\.net/laarvimoh" target="_blank" class="btn-ghost">[\s\S]*?</a>', ''

# 2. Update .wcard onclick to openModal(this)
$html = $html -replace '(?i)onclick="window\.open\(''https://www\.behance\.net/.*?'',''_blank''\)"', 'onclick="openProjectModal(this)"'

# 3. Change "View on Behance" to "View Project" and remove href/target/onclick
$html = $html -replace '(?i)<a class="ov-link" href="https://www\.behance\.net/laarvimoh" target="_blank" onclick="event\.stopPropagation\(\)">View on Behance', '<div class="ov-link">View Project'
$html = $html -replace '(?i)</svg></a>', '</svg></div>'

# 4. Insert Modal CSS before </style>
$modalCss = @"
/* Modal */
.modal { display: none; position: fixed; inset: 0; z-index: 1000; background: rgba(12, 12, 15, 0.95); backdrop-filter: blur(8px); overflow-y: auto; padding: 40px 24px; opacity: 0; transition: opacity 0.3s ease; }
.modal.show { display: block; opacity: 1; }
.modal-content { background: var(--bg2); border: 1px solid var(--border); border-radius: 16px; max-width: 900px; margin: 0 auto; position: relative; padding: 40px; transform: translateY(20px); transition: transform 0.3s ease; }
.modal.show .modal-content { transform: translateY(0); }
.modal-close { position: absolute; top: 20px; right: 20px; background: rgba(255,255,255,0.1); border: none; color: var(--text); font-size: 24px; width: 40px; height: 40px; border-radius: 50%; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: background 0.2s, transform 0.2s; }
.modal-close:hover { background: rgba(255,255,255,0.2); transform: scale(1.05); }
.modal-body img { width: 100%; border-radius: 8px; margin-bottom: 20px; }
.modal-title { font-family: var(--font); font-size: 32px; font-weight: 700; margin-bottom: 8px; color: var(--text); }
.modal-type { font-size: 14px; color: var(--orange); letter-spacing: .1em; text-transform: uppercase; margin-bottom: 24px; }
.modal-desc { font-size: 15px; color: var(--muted); line-height: 1.8; margin-bottom: 24px; }
</style>
"@
$html = $html -replace '(?i)</style>', $modalCss

# 5. Insert Modal HTML before </body>
$modalHtml = @"
<!-- Project Modal -->
<div id="project-modal" class="modal">
  <div class="modal-content">
    <button class="modal-close" onclick="closeModal()">&times;</button>
    <div class="modal-body" id="modal-body">
      <!-- Content goes here -->
    </div>
  </div>
</div>
</body>
"@
$html = $html -replace '(?i)</body>', $modalHtml

# 6. Insert JS before </script>
$modalJs = @"
function openProjectModal(card) {
  const modal = document.getElementById('project-modal');
  const body = document.getElementById('modal-body');
  
  const title = card.querySelector('.wcard-name').innerText;
  const type = card.querySelector('.wcard-type').innerText;
  const imgSrc = card.querySelector('.wcard-img img').src;
  
  body.innerHTML = `
    <div class="modal-type">` + type + `</div>
    <div class="modal-title">` + title + `</div>
    <div class="modal-desc">Detailed case study for ` + title + ` will be added here.</div>
    <img src="` + imgSrc + `" alt="` + title + `" />
  `;
  
  modal.style.display = 'block';
  setTimeout(() => modal.classList.add('show'), 10);
  document.body.style.overflow = 'hidden';
}

function closeModal() {
  const modal = document.getElementById('project-modal');
  modal.classList.remove('show');
  setTimeout(() => {
    modal.style.display = 'none';
    document.body.style.overflow = '';
  }, 300);
}

document.getElementById('project-modal').addEventListener('click', function(e) {
  if (e.target === this) closeModal();
});
</script>
"@
$html = $html -replace '(?i)</script>', $modalJs

Set-Content -Path "index.html" -Value $html -NoNewline
