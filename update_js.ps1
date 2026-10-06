$html = Get-Content -Raw -Path "index.html"

$newJs = @"
const projectData = {
  "Increo": {
    desc: "Tabouni House branding and visual system.",
    images: ["projects/increo/TB1.png", "projects/increo/TB2.png"]
  }
};

function openProjectModal(card) {
  const modal = document.getElementById('project-modal');
  const body = document.getElementById('modal-body');
  
  const title = card.querySelector('.wcard-name').innerText;
  const type = card.querySelector('.wcard-type').innerText;
  const thumbSrc = card.querySelector('.wcard-img img').src;
  
  const data = projectData[title];
  
  let imagesHtml = '';
  if (data && data.images && data.images.length > 0) {
     imagesHtml = '<div style="display: flex; flex-direction: column; gap: 0;">' + data.images.map(src => '<img src="' + src + '" alt="' + title + '" style="margin-bottom: 0; border-radius: 0; width: 100%; display: block;" />').join('') + '</div>';
  } else {
     imagesHtml = '<img src="' + thumbSrc + '" alt="' + title + '" />';
  }
  
  const descHtml = data && data.desc ? data.desc : 'Detailed case study for ' + title + ' will be added here.';
  
  body.innerHTML = '<div class="modal-type">' + type + '</div><div class="modal-title">' + title + '</div><div class="modal-desc">' + descHtml + '</div>' + imagesHtml;
  
  modal.style.display = 'block';
  setTimeout(() => modal.classList.add('show'), 10);
  document.body.style.overflow = 'hidden';
}
"@

$html = $html -replace 'function openProjectModal\(card\) \{[\s\S]*?document\.body\.style\.overflow = ''hidden'';\s*\}', $newJs

Set-Content -Path "index.html" -Value $html -NoNewline
