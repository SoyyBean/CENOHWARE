# Builds CENOHWARE.exe from src\ with the C# compiler that ships with Windows (.NET Framework 4.8). No Visual Studio needed.
#   powershell -ExecutionPolicy Bypass -File build.ps1 [-Out build\CENOHWARE.exe]
# Optional: put ks_blast.wav (the shot) and ks_cock.wav (the rack) in assets\ for the Shotgun Keys sounds. They are not part
# of the repository; without them that tab says the sounds are missing and everything else works.
param([string]$Out = (Join-Path $PSScriptRoot 'build\CENOHWARE.exe'))
$ErrorActionPreference = 'Stop'
$fw = "$env:WINDIR\Microsoft.NET\Framework64\v4.0.30319"; $csc = "$fw\csc.exe"
if (-not (Test-Path $csc)) { throw "The .NET Framework C# compiler was not found at $csc" }
$src = Join-Path $PSScriptRoot 'src'
$tmp = Join-Path $env:TEMP 'cenohware_src_build'
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
New-Item -ItemType Directory $tmp | Out-Null
New-Item -ItemType Directory -Force (Split-Path $Out -Parent) | Out-Null

# 1. the exe icon: the Cacenoh chip, drawn by MakeIcon.cs
& $csc /nologo /target:exe "/out:$tmp\MakeIcon.exe" /r:System.Drawing.dll "$src\MakeIcon.cs" "$src\CasinoLogo.cs"
if ($LASTEXITCODE -ne 0) { throw 'the icon tool failed to compile' }
& "$tmp\MakeIcon.exe" "$tmp\CENOHWARE.ico" chip

# 2. Hold Click is compiled into its own namespace (HcApp)
function Wrap([string]$ns, [string[]]$files, [string]$out) {
  $usings = New-Object System.Collections.Generic.SortedSet[string]
  $body = New-Object System.Text.StringBuilder
  foreach ($f in $files) {
    foreach ($line in ([IO.File]::ReadAllText($f) -split "`r?`n")) {
      if ($line -match '^using\s+[\w\.]+;\s*$') { [void]$usings.Add($line.Trim()) }
      elseif ($line -match '^\s*\[assembly:') { }
      else { [void]$body.AppendLine($line) }
    }
  }
  $text = ($usings -join "`r`n") + "`r`nnamespace $ns`r`n{`r`n" + $body.ToString() + "`r`n}`r`n"
  [IO.File]::WriteAllText($out, $text, (New-Object Text.UTF8Encoding($false)))
}
Wrap 'HcApp' @("$src\holdclick\HoldClick.cs", "$src\holdclick\Splash.cs") "$tmp\hc.cs"

# 3. the server-PC helper for the Minecraft tab is carried inside the exe (the tab can save a copy of it)
& $csc /nologo /target:winexe "/out:$tmp\McHelper.exe" /r:System.Windows.Forms.dll /r:System.Drawing.dll "$src\mchelper\McHelper.cs"
if ($LASTEXITCODE -ne 0) { throw 'McHelper failed to compile' }
$res = @("/resource:$tmp\McHelper.exe,mchelper.exe")
foreach ($k in 'ks_blast.wav', 'ks_cock.wav') { $p = Join-Path $PSScriptRoot "assets\$k"; if (Test-Path $p) { $res += "/resource:$p,$k" } }

# 4. CENOHWARE itself
$files = @(Get-ChildItem $src -Filter *.cs | Where-Object { $_.Name -ne 'MakeIcon.cs' } | ForEach-Object { $_.FullName }) + "$tmp\hc.cs"
& $csc /nologo /target:winexe /main:HubProgram "/out:$Out" "/win32icon:$tmp\CENOHWARE.ico" $res `
  /r:System.Windows.Forms.dll /r:System.Drawing.dll /r:System.Web.Extensions.dll /r:System.IO.Compression.dll /r:System.IO.Compression.FileSystem.dll /r:System.Security.dll /r:Microsoft.VisualBasic.dll "/lib:$fw\WPF" /r:PresentationCore.dll /r:WindowsBase.dll /r:System.Xaml.dll /r:PresentationFramework.dll /r:WindowsFormsIntegration.dll "/r:$env:WINDIR\Microsoft.NET\assembly\GAC_MSIL\System.Speech\v4.0_4.0.0.0__31bf3856ad364e35\System.Speech.dll" `
  /nowarn:0649,0169,0414,0219,0168,0162,0429 $files
if ($LASTEXITCODE -ne 0) { throw 'CENOHWARE failed to compile' }
"built $Out ($([int]((Get-Item $Out).Length / 1KB)) KB)"
