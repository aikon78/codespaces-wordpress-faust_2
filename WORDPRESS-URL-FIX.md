# 🔧 WordPress URL Fix - IMPORTANTE!

## ⚠️ Problema Risolto

WordPress mostra ancora "localhost" nella pagina di installazione perché il container è stato avviato prima che configurassimo l'URL corretto.

## ✅ Soluzione Applicata

1. **docker-compose.yml** → Aggiornato con `WORDPRESS_CONFIG_EXTRA` che forza l'URL dal file `.env`
2. **.devcontainer/.env** → Creato con `WORDPRESS_URL=https://scaling-space-robot-pp7496v796frv9x-8080.app.github.dev`
3. **setup.sh** → Esporta `WORDPRESS_URL` prima di lanciare i container

## 📌 Prossimo Step

### Opzione 1: Riavviare il Codespace (CONSIGLIATO)

```bash
1. Chiudi questo Codespace
2. Riapri lo stesso Codespace da GitHub
3. I container si riavvieranno con la configurazione corretta
```

### Opzione 2: Riavviare solo il container WordPress

Se hai accesso a Docker:

```bash
docker compose -f .devcontainer/docker-compose.yml restart wordpress
```

## 🧪 Verificare che funzioni

Dopo il riavvio:

1. Vai a: https://scaling-space-robot-pp7496v796frv9x-8080.app.github.dev
2. La pagina di installazione NON avrà più riferimenti a `localhost`
3. Procedi con l'installazione di WordPress normalmente

## 📝 Cosa è cambiato

**File Modificati:**

- `.devcontainer/docker-compose.yml` - Aggiunto `WORDPRESS_CONFIG_EXTRA`
- `.devcontainer/.env` - Nuovo file con `WORDPRESS_URL`
- `.devcontainer/setup.sh` - Aggiunto export di `WORDPRESS_URL`

**Come funziona:**

1. Lo script `.devcontainer/.env` definisce `WORDPRESS_URL` per docker-compose
2. docker-compose passa questa variabile al container WordPress
3. WordPress legge `WORDPRESS_CONFIG_EXTRA` e definisce `WP_HOME` e `WP_SITEURL`
4. Tutti i reindirizzamenti usano l'URL corretto

---

**Dopo il riavvio, continua con:**

1. Completa l'installazione di WordPress
2. Installa FaustWP + WPGraphQL
3. Configura la connessione a Next.js
4. Aggiorna `.env.local` con la secret key
5. `npm run dev`
