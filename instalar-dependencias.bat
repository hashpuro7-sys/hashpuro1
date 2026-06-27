@echo off
title Instalando Dependências do Bot
echo ========================================
echo   Instalando Dependências
echo ========================================
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

echo 📦 Instalando dependências...
echo.

npm install

if errorlevel 1 (
    echo.
    echo ❌ Erro ao instalar dependências!
    pause
    exit /b 1
)

echo.
echo ========================================
echo   ✅ Dependências instaladas com sucesso!
echo ========================================
echo.
echo Agora execute: iniciar-bot.bat
echo.
pause
