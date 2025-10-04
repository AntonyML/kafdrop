@echo off
title Kafdrop - Kafka Web UI
echo ===============================
echo    Iniciando Kafdrop
echo ===============================
echo.

set KAFDROP_DIR=D:\kafdrop
set JAR_FILE=%KAFDROP_DIR%\kafdrop-4.2.1-SNAPSHOT.jar
set KAFKA_BROKERS=localhost:9092
set PORT=9000

cd /d "%KAFDROP_DIR%"

echo Verificando si Kafka esta ejecutandose en el puerto 9092...
netstat -an | findstr ":9092" >nul
if not %errorlevel% == 0 (
    echo ERROR: Kafka no esta ejecutandose en el puerto 9092
    echo.
    echo Por favor, inicia Kafka primero con:
    echo D:\kafka_2.13-4.1.0\start-kafka.bat
    echo.
    pause
    exit /b 1
)

echo Kafka esta ejecutandose correctamente
echo.

if not exist "%JAR_FILE%" (
    echo ERROR: No se encuentra el archivo JAR: %JAR_FILE%
    echo Por favor, verifica la ubicacion del archivo.
    pause
    exit /b 1
)

echo Configuracion:
echo - Kafka Brokers: %KAFKA_BROKERS%
echo - Puerto Kafdrop: %PORT%
echo - URL: http://localhost:%PORT%
echo.
echo Iniciando Kafdrop...
echo.

java -jar "%JAR_FILE%" --kafdrop.bootstrap-servers=%KAFKA_BROKERS% --server.port=%PORT%

echo.
echo Kafdrop se ha cerrado.
pause