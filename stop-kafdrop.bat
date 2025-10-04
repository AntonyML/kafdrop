@echo off
title Deteniendo Kafdrop
echo ===============================
echo    Deteniendo Kafdrop
echo ===============================
echo.

echo Buscando procesos Java con Kafdrop...
wmic process where "name='java.exe'" get processid,commandline | findstr "kafdrop" >nul
if %errorlevel% equ 0 (
    echo Deteniendo todos los procesos de Kafdrop...
    taskkill /fi "windowtitle eq Kafdrop - Kafka Web UI" /f >nul 2>&1
    taskkill /fi "imagename eq java.exe" /fi "commandline eq *kafdrop*" /f >nul 2>&1
    timeout /t 3 /nobreak >nul
)

echo Verificando...
wmic process where "name='java.exe'" get processid,commandline | findstr "kafdrop" >nul
if %errorlevel% equ 1 (
    echo Kafdrop ha sido detenido exitosamente.
) else (
    echo Algunos procesos pueden seguir activos.
    echo Ejecuta 'jps -m' para ver los procesos Java activos.
)

echo.
pause