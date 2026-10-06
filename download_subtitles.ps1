param(
    [string[]]$TestLanguages
)

function Get-SubtitleScore {
    param([string]$LanguageTag)

    $isAi = $LanguageTag -like 'ai-*'
    $baseTag = if ($isAi) { $LanguageTag.Substring(3) } else { $LanguageTag }

    $languageRank = if ($baseTag -match '^(zh|cmn|chi)(-|$)') {
        0
    } elseif ($baseTag -match '^en(-|$)') {
        2
    } else {
        4
    }

    $aiPenalty = if ($isAi) { 1 } else { 0 }
    return $languageRank + $aiPenalty
}

function Select-BestSubtitle {
    param([string[]]$Languages)

    $candidates = $Languages |
        Where-Object { $_ -and $_ -ne 'danmaku' -and $_ -ne 'Language' } |
        Select-Object -Unique

    if (-not $candidates) {
        return $null
    }

    return $candidates |
        Sort-Object @{ Expression = { Get-SubtitleScore $_ } }, @{ Expression = { $_ } } |
        Select-Object -First 1
}

if ($TestLanguages) {
    $selected = Select-BestSubtitle -Languages $TestLanguages
    if ($selected) {
        Write-Output $selected
        exit 0
    }
    exit 2
}

$Url = Read-Host 'Paste Bilibili video URL'
if ([string]::IsNullOrWhiteSpace($Url)) {
    [Console]::Error.WriteLine('No URL provided.')
    exit 1
}

Write-Host 'Checking available subtitles...'
$listOutput = & yt-dlp --cookies-from-browser firefox --list-subs $Url 2>&1
if ($LASTEXITCODE -ne 0) {
    $listOutput | ForEach-Object { [Console]::Error.WriteLine($_) }
    exit $LASTEXITCODE
}

$languages = foreach ($line in $listOutput) {
    $text = [string]$line
    if ($text -match '^(?<lang>[A-Za-z0-9][A-Za-z0-9_-]*)\s+\S+') {
        $Matches['lang']
    }
}

$selectedLanguage = Select-BestSubtitle -Languages $languages
if (-not $selectedLanguage) {
    [Console]::Error.WriteLine('No usable subtitle track found.')
    exit 2
}

Write-Host "Selected subtitle: $selectedLanguage"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$outputDir = Join-Path $scriptDir 'subtitles'
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
$outputTemplate = Join-Path $outputDir '%(title)s [%(id)s].%(ext)s'

& yt-dlp `
    --cookies-from-browser firefox `
    --skip-download `
    --write-subs `
    --sub-langs $selectedLanguage `
    --sub-format 'srt/best' `
    --windows-filenames `
    -o $outputTemplate `
    $Url

exit $LASTEXITCODE
