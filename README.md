# Kafdrop Runner - Windows Execution Scripts

## Description

Scripts de ejecución para Kafdrop en Windows desarrollados por **Antony Monge López** - Universidad de Costa Rica.

Este proyecto contiene scripts batch para facilitar el inicio y detención de Kafdrop, una interfaz web para monitorizar clusters de Apache Kafka.

## Features

- Verificación automática de Kafka antes de iniciar
- Detección y cierre seguro de procesos
- Configuración personalizable
- Compatible con Kafka KRaft (sin ZooKeeper)

---

## Project Structure

```
kafdrop/
├── kafdrop-4.2.1-SNAPSHOT.jar    # Kafdrop executable
├── start-kafdrop.bat              # Start script
├── stop-kafdrop.bat               # Stop script
└── README.md                      # This file
```

---

## Configuration

### Required Configuration Variables

**In `start-kafdrop.bat`:**

```batch
set KAFDROP_DIR=D:\kafdrop
set JAR_FILE=%KAFDROP_DIR%\kafdrop-4.2.1-SNAPSHOT.jar
set KAFKA_BROKERS=localhost:9092
set PORT=9000
```

| Variable | Description | Default Value |
|----------|-------------|---------------|
| `KAFDROP_DIR` | Installation directory path | `D:\kafdrop` |
| `JAR_FILE` | Path to Kafdrop JAR file | `kafdrop-4.2.1-SNAPSHOT.jar` |
| `KAFKA_BROKERS` | Kafka bootstrap servers | `localhost:9092` |
| `PORT` | Kafdrop web interface port | `9000` |

**In `stop-kafdrop.bat`:**

No configuration changes are typically required.

---

## System Requirements

- **Java 17** or higher installed and configured in PATH
- **Apache Kafka** running on the configured port
- **Windows 10/11** or Windows Server
- **Network access** to Kafka broker(s)

---

## Usage

### Starting Kafdrop

```cmd
D:\kafdrop> start-kafdrop.bat
```

**The script will:**

1. Verify that Kafka is running on port 9092
2. Check that the JAR file exists
3. Start Kafdrop on http://localhost:9000

### Stopping Kafdrop

```cmd
D:\kafdrop> stop-kafdrop.bat
```

**The script will:**

1. Search for Java processes running Kafdrop
2. Terminate all related processes
3. Verify successful shutdown

---

## Troubleshooting

### Issue: "Kafka no está ejecutándose"

**Cause:** Kafka service is not running or not accessible on the configured port.

**Solution:**
```cmd
# Verify Kafka is running
netstat -an | findstr :9092

# Or check Kafka process
tasklist | findstr kafka
```

### Issue: "No se encuentra el archivo JAR"

**Cause:** The JAR file is missing or the path is incorrect.

**Solution:**
1. Verify the file exists: `dir D:\kafdrop\kafdrop-4.2.1-SNAPSHOT.jar`
2. Update the `KAFDROP_DIR` variable in the script if the location is different

### Issue: "Puerto 9000 en uso"

**Cause:** Another application is using port 9000.

**Solution:**
```batch
# In start-kafdrop.bat, change:
set PORT=9001
```

**Or find and stop the conflicting process:**
```cmd
netstat -ano | findstr :9000
taskkill /PID [PID_NUMBER] /F
```

### Issue: Kafdrop does not stop

**Solution:** Manually terminate Java processes:
```cmd
taskkill /fi "imagename eq java.exe" /fi "commandline eq *kafdrop*" /f
```

---

## Recommended Workflow

### 1. Start Kafka

```cmd
D:\kafka_2.13-4.1.0> start-kafka.bat
```

### 2. Verify Kafka is Running

```cmd
D:\kafka_2.13-4.1.0> bin\windows\kafka-topics.bat --bootstrap-server localhost:9092 --list
```

### 3. Start Kafdrop

```cmd
D:\kafdrop> start-kafdrop.bat
```

### 4. Access Web Interface

Open your browser and navigate to:
```
http://localhost:9000
```

### 5. Stop Services (when finished)

```cmd
D:\kafdrop> stop-kafdrop.bat
D:\kafka_2.13-4.1.0> stop-kafka.bat
```

---

## Advanced Configuration

### Connecting to Remote Kafka Cluster

Modify `start-kafdrop.bat`:

```batch
set KAFKA_BROKERS=kafka-server-1:9092,kafka-server-2:9092,kafka-server-3:9092
```

### Enabling JMX Monitoring

Add JMX configuration in `start-kafdrop.bat`:

```batch
set JMX_OPTS=-Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote
java %JMX_OPTS% -jar "%JAR_FILE%" --kafka.brokerConnect=%KAFKA_BROKERS% --server.port=%PORT%
```

### Custom JVM Options

Modify memory settings:

```batch
java -Xms256m -Xmx512m -jar "%JAR_FILE%" --kafka.brokerConnect=%KAFKA_BROKERS% --server.port=%PORT%
```

---

## Scripts Overview

### start-kafdrop.bat

**Purpose:** Initializes Kafdrop with pre-flight checks.

**Key Operations:**
- Validates Kafka connectivity
- Checks JAR file existence
- Launches Kafdrop Java process
- Provides feedback on startup status

### stop-kafdrop.bat

**Purpose:** Gracefully terminates Kafdrop processes.

**Key Operations:**
- Identifies running Kafdrop processes
- Terminates processes safely
- Confirms successful shutdown

---

## Environment Variables Reference

| Variable | Purpose | Example |
|----------|---------|---------|
| `JAVA_HOME` | Java installation directory | `C:\Program Files\Java\jdk-17` |
| `PATH` | System path including Java | Must include `%JAVA_HOME%\bin` |

---

## Logging and Monitoring

### View Kafdrop Logs

Logs are output to the console by default. To redirect to a file:

```batch
start-kafdrop.bat > kafdrop.log 2>&1
```

### Monitor Resource Usage

```cmd
# View Java processes
tasklist /fi "imagename eq java.exe" /v

# Monitor network connections
netstat -ano | findstr :9000
```

---

## Security Considerations

- **Network Access:** Ensure firewall rules allow access to configured ports
- **Authentication:** Consider implementing authentication for production environments
- **Data Privacy:** Be aware that Kafdrop can display message content from Kafka topics

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-01 | Initial release with basic start/stop scripts |

---

## Author

**Antony Monge López**  
Universidad de Costa Rica

*Desarrollado como parte de proyectos de integración con Apache Kafka*

---

## License

This project is licensed under the Apache License 2.0 - see the LICENSE file for details.

---

## Additional Resources

- [Kafdrop Official Repository](https://github.com/obsidiandynamics/kafdrop)
- [Apache Kafka Documentation](https://kafka.apache.org/documentation/)
- [Java SE Downloads](https://www.oracle.com/java/technologies/downloads/)

---

**Note:** These scripts assume Kafka is running on `localhost:9092`. Adjust configuration variables according to your specific environment.