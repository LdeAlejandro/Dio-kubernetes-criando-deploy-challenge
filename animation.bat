@echo off
setlocal enabledelayedexpansion

call :typewriter "%~1"

exit /b

:: Função para animação de escrita
:typewriter
set "text=%~1"
set i=0
:loop

set "char=!text:~%i%,1!"

if "!char!"=="" (
    echo:
    exit /b
)

if "!char!"==" " (
    <nul set /p=-
) else (
    <nul set /p=!char!
)

:: Controle de tempo usando loop FOR
:: Aumente ou diminua o número (1,1,10) para ajustar a velocidade
for /L %%A in (1,1,25000) do rem

set /a i+=1
goto loop