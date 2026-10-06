Add-Type -AssemblyName System.Drawing

function ConvertTo-Jpeg {
    param (
        [string]$SourcePath,
        [string]$DestPath
    )
    if (Test-Path $SourcePath) {
        $img = [System.Drawing.Image]::FromFile($SourcePath)
        
        $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageDecoders() | Where-Object { $_.FormatID -eq [System.Drawing.Imaging.ImageFormat]::Jpeg.Guid }
        
        $encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]75)
        
        $img.Save($DestPath, $codec, $encParams)
        $img.Dispose()
        Write-Host "Converted: $DestPath"
        
        Remove-Item $SourcePath -Force
    }
}

$base = "c:\Users\MohPC\Documents\website\mohlaarvi-main\projects"

ConvertTo-Jpeg "$base\tabouni\TB1.png" "$base\tabouni\TB1.jpg"
# TB2 was already converted, just remove the old png
if (Test-Path "$base\tabouni\TB2.png") { Remove-Item "$base\tabouni\TB2.png" -Force }
ConvertTo-Jpeg "$base\kastelo\kastelo.png" "$base\kastelo\kastelo.jpg"
ConvertTo-Jpeg "$base\increo\Increo behance.png" "$base\increo\increo.jpg"
ConvertTo-Jpeg "$base\herable\Herable.png" "$base\herable\herable.jpg"
ConvertTo-Jpeg "$base\logofolio\logofolio.png" "$base\logofolio\logofolio.jpg"

# Now update index.html projectData to use .jpg
$html = Get-Content -Raw -Path "c:\Users\MohPC\Documents\website\mohlaarvi-main\index.html"
$html = $html -replace 'TB1\.png', 'TB1.jpg'
$html = $html -replace 'TB2\.png', 'TB2.jpg'
$html = $html -replace 'kastelo\.png', 'kastelo.jpg'
$html = $html -replace 'increo\.png', 'increo.jpg'
$html = $html -replace 'herable\.png', 'herable.jpg'
$html = $html -replace 'logofolio\.png', 'logofolio.jpg'

Set-Content -Path "c:\Users\MohPC\Documents\website\mohlaarvi-main\index.html" -Value $html -NoNewline
