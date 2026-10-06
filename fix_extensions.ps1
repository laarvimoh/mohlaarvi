# 1. Clean up
if (Test-Path "c:\Users\MohPC\Documents\website\mohlaarvi-main\projects\herable\herable.jpg") {
    Remove-Item "c:\Users\MohPC\Documents\website\mohlaarvi-main\projects\herable\herable.jpg" -Force
}

# 2. Rename Increo
if (Test-Path "c:\Users\MohPC\Documents\website\mohlaarvi-main\projects\increo\Increo behance.png") {
    Rename-Item "c:\Users\MohPC\Documents\website\mohlaarvi-main\projects\increo\Increo behance.png" "increo.png"
}

# 3. Update HTML
$html = Get-Content -Raw -Path "c:\Users\MohPC\Documents\website\mohlaarvi-main\index.html"

# Fix thumbnails (they all use .png)
$html = $html -replace 'projects/thumbnails/kastelo\.jpg', 'projects/thumbnails/kastelo.png'
$html = $html -replace 'projects/thumbnails/increo\.jpg', 'projects/thumbnails/increo.png'
$html = $html -replace 'projects/thumbnails/herable\.jpg', 'projects/thumbnails/herable.png'
$html = $html -replace 'projects/thumbnails/logofolio\.jpg', 'projects/thumbnails/logofolio.png'

# Fix presentations in projectData
$html = $html -replace 'projects/tabouni/TB1\.jpg', 'projects/tabouni/TB1.png'
$html = $html -replace 'projects/tabouni/TB2\.jpg', 'projects/tabouni/TB2.png'
$html = $html -replace 'projects/kastelo/kastelo\.jpg', 'projects/kastelo/kastelo.png'
$html = $html -replace 'projects/increo/increo\.jpg', 'projects/increo/increo.png'
$html = $html -replace 'projects/herable/herable\.jpg', 'projects/herable/herable.png'
# logofolio remains .jpg because they didn't replace it

Set-Content -Path "c:\Users\MohPC\Documents\website\mohlaarvi-main\index.html" -Value $html -NoNewline
