Ecco un esempio completo per mettere in piedi un ambiente **WSO2 API Manager 4.2.0** (la versione più comune) collegato a un database **MySQL 8.0**.

Questa configurazione utilizza Docker Compose per gestire entrambi i servizi e automatizzare il collegamento.

### 1. Struttura delle cartelle

Crea una cartella per il progetto con questa struttura:

```text
.
├── docker-compose.yml
├── conf/
│   └── deployment.toml
└── lib/
    └── mysql-connector-j-8.x.x.jar

```

> **Nota:** Scarica il driver JDBC di MySQL (.jar) e mettilo nella cartella `lib`. È indispensabile affinché WSO2 possa parlare con il database.

---

### 2. Il file `docker-compose.yml`

Questo file definisce i due container e mappa i volumi necessari per la configurazione e il driver.

```yaml
version: '3.8'
services:
  mysql:
    image: mysql:8.0
    container_name: mysql-db
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: WSO2AM_DB
    volumes:
      - ./mysql-data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin" ,"ping", "-h", "localhost"]
      timeout: 20s
      retries: 10

  api-manager:
    image: wso2/wso2am:4.2.0
    container_name: wso2am
    ports:
      - "9443:9443" # Console (Carbon, Publisher, DevPortal)
      - "8280:8280" # Gateway HTTP
      - "8243:8243" # Gateway HTTPS
    depends_on:
      mysql:
        condition: service_healthy
    volumes:
      - ./conf/deployment.toml:/home/wso2carbon/wso2am-4.2.0/repository/conf/deployment.toml
      - ./lib/mysql-connector-j-8.0.33.jar:/home/wso2carbon/wso2am-4.2.0/repository/components/lib/mysql-connector-j-8.0.33.jar
    environment:
      - NODE_IP=127.0.0.1

```

---

### 3. Il file `conf/deployment.toml`

In questo file diciamo a WSO2 di ignorare il database interno H2 e usare MySQL. WSO2 API Manager creerà automaticamente le tabelle necessarie al primo avvio.

```toml
[server]
hostname = "localhost"
node_ip = "127.0.0.1"

[database.apim_db]
type = "mysql"
url = "jdbc:mysql://mysql:3306/WSO2AM_DB?useSSL=false&allowPublicKeyRetrieval=true"
username = "root"
password = "root_password"
driver = "com.mysql.cj.jdbc.Driver"
validation_query = "SELECT 1"

# Configurazione per la gestione degli utenti (User Store)
[database.shared_db]
type = "mysql"
url = "jdbc:mysql://mysql:3306/WSO2AM_DB?useSSL=false&allowPublicKeyRetrieval=true"
username = "root"
password = "root_password"
driver = "com.mysql.cj.jdbc.Driver"
validation_query = "SELECT 1"

```

### Come avviarlo

1. Apri il terminale nella cartella del progetto.
2. Esegui: `docker-compose up -d`.
3. Attendi circa 2-3 minuti (WSO2 è "pesante" e deve inizializzare il database).
4. Accedi alla console Publisher su: `https://localhost:9443/publisher` (credenziali di default: `admin` / `admin`).

5. Configurazione di utenti, permessi etc: `https://localhost:9443/carbon/`
6. Console di consultazione: `https://localhost:9443/devportal`

**Un piccolo trucco:** Se vedi errori di connessione al database nei log (`docker logs -f wso2am`), di solito è perché il container MySQL non è ancora pronto a ricevere connessioni. Il `healthcheck` nel file Compose serve proprio a minimizzare questo rischio.

Ti serve aiuto per configurare anche un certificato SSL personalizzato o preferisci vedere come aggiungere un **Identity Server** esterno per il Single Sign-On?