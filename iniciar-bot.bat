@echo off
title Bot Discord - Anúncios e Música
echo ========================================
echo   Bot Discord - Anúncios e Música
echo ========================================
echo.
echo Verificando dependências...
echo.

REM Verifica se o Node.js está instalado
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js não está instalado!
    echo Baixe em: https://nodejs.org/
    pause
    exit /b 1
)

echo ✅ Node.js encontrado
node --version
echo.

REM Verifica se o arquivo .env existe
if not exist ".env" (
    echo ⚠️ Arquivo .env não encontrado!
    echo Certifique-se de configurar o token do bot.
    pause
    exit /b 1
)

echo ✅ Arquivo .env encontrado
echo.
echo ========================================
echo   Iniciando o Bot...
echo ========================================
echo.

REM Inicia o bot
node index.js

REM Se o bot parar, pausa para ver o erro
echo.
echo ========================================
echo   Bot finalizado!
echo ========================================
pause
