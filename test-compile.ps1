# Test compile
Write-Host "Compiling..."
& .\mvnw.cmd clean package -DskipTests
Write-Host "Done! Exit code: $LASTEXITCODE"
