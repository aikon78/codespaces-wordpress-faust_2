# Setup Faust.js + WordPress in GitHub Codespaces

## 📋 Cosa abbiamo

Questo Codespace ha:

- ✅ WordPress 6 (Port 8080)
- ✅ MySQL Database
- ✅ phpMyAdmin (Port 8081)
- ✅ Next.js + Faust.js (Port 3000)

## 🚀 Come usarlo

### 1. URL del tuo ambiente

Gli URL del tuo Codespace sono:

```
WordPress:    https://scaling-space-robot-pp7496v796frv9x-8080.app.github.dev
Next.js:      https://scaling-space-robot-pp7496v796frv9x-3000.app.github.dev
phpMyAdmin:   https://scaling-space-robot-pp7496v796frv9x-8081.app.github.dev
```

### 2. Completa l'installazione WordPress

1. Apri: https://scaling-space-robot-pp7496v796frv9x-8080.app.github.dev
2. Seleziona la lingua
3. Inserisci i dettagli del sito
4. Crea username e password per admin

### 3. Configura WordPress

**Installa i plugin necessari:**

1. Vai a: Plugins → Add New
2. Cerca e installa:
   - **FaustWP** (obbligatorio)
   - **WPGraphQL** (se non presente)

**Configura FaustWP:**

1. Vai a: Settings → Headless
2. Imposta "Frontend site URL" a:
   ```
   https://scaling-space-robot-pp7496v796frv9x-3000.app.github.dev
   ```
3. Copia il "Secret Key" generato

**Configura i Permalink:**

1. Vai a: Settings → Permalinks
2. Seleziona "Post name"
3. Clicca "Save Changes"

### 4. Aggiorna .env.local

1. Apri `.env.local` nel progetto
2. Incolla la secret key:
   ```
   FAUST_SECRET_KEY=<la-tua-secret-key>
   ```

### 5. Avvia Next.js

Nel terminale:

```bash
npm run dev
```

Visita: https://scaling-space-robot-pp7496v796frv9x-3000.app.github.dev

## 🔧 Risoluzione problemi

**WordPress mostra "Cannot connect to database":**

- Aspetta 30-60 secondi che MySQL si avvii
- Ricarica la pagina

**Permalink non funzionano:**

- Assicurati di aver configurato i Permalink a "Post name"
- Verifica che WPGraphQL sia attivo

**Next.js non si connette a WordPress:**

- Verifica che FAUST_SECRET_KEY sia corretto in .env.local
- Assicurati che WPGraphQL sia attivo
- Controlla la console per gli errori GraphQL

## 📚 Documentazione

- [Faust.js Docs](https://faustjs.org/docs/)
- [WPGraphQL Docs](https://www.wpgraphql.com)
- [WP Engine Headless Platform](https://wpengine.com/headless-wordpress/)
