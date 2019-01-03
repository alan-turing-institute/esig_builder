@echo off
REM usage: .\build_all_versions.bat <esig_tar_gz_filename>
for /F "tokens=*" %%A in (python_versions.txt) do docker run --rm -v "%CD%":C:\data esig_builder_windows "$env:PATH = Get-Content -Path pathenv_%%A ;cd data; .\build_esig_in_docker.bat %1 %%A"
