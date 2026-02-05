# Guida Completa al Setup - Faust.js in GitHub Codespaces

Questa guida ti aiuta a configurare un progetto Faust.js basato su https://faustjs.org/docs/how-to/basic-setup/ che funziona correttamente in GitHub Codespaces.

## 🎯 Obiettivo

Creare un setup headless WordPress + Faust.js (Next.js) che funzioni in Codespaces, dove **WordPress è referenziato tramite URL nel database e non può utilizzare localhost**.

## 📋 Prerequisiti

- Account GitHub
- Accesso a GitHub Codespaces

## 🚀 Setup Automatico

Quando apri questo progetto in Codespaces, il setup automatico:

1. ✅ Installa tutte le dipendenze Node.js
2. ✅ Avvia Docker con WordPress, MySQL, e phpMyAdmin
3. ✅ Crea il file `.env.local` con configurazione base
4. ✅ Aggiorna automaticamente gli URL di WordPress per Codespaces

## 🔧 Configurazione Manuale Necessaria

### Passo 1: Ottieni gli URL del tuo Codespace

1. In VS Code, clicca sul pannello **"PORTS"** nella parte inferiore
2. Annota gli URL pubblici per:
   - **Porta 8080** → WordPress backend
   - **Porta 3000** → Next.js frontend

Gli URL avranno il formato: `https://{nome-codespace}-{porta}.app.github.dev`

### Passo 2: Completa l'installazione WordPress

1. Apri l'URL della porta 8080 nel browser
2. Completa l'installazione guidata WordPress:
   - Seleziona la lingua (es: Italiano)
   - Inserisci titolo del sito
   - Crea username e password admin
   - Inserisci la tua email
3. Accedi al pannello admin di WordPress

### Passo 3: Installa i Plugin Necessari

**FaustWP** (obbligatorio):

1. Vai su **Plugin → Aggiungi nuovo**
2. Cerca "FaustWP"
3. Clicca **Installa** poi **Attiva**

**WPGraphQL** (consigliato, potrebbe essere già installato):

1. Vai su **Plugin → Aggiungi nuovo**
2. Cerca "WPGraphQL"
3. Clicca **Installa** poi **Attiva**

### Passo 4: Configura FaustWP

1. Vai su **Impostazioni → Headless**
2. In **"Frontend site URL"**, inserisci l'URL Codespaces della porta 3000
   - Esempio: `https://nome-codespace-3000.app.github.dev`
   - ⚠️ **NON usare localhost!**
3. Copia il **"Secret Key"** generato automaticamente

### Passo 5: Aggiorna .env.local

1. Apri il file `.env.local` nel progetto
2. Incolla la secret key:
   ```bash
   FAUST_SECRET_KEY=la-tua-secret-key-qui
   ```
3. Salva il file

### Passo 6: Configura i Permalink (importante!)

1. In WordPress, vai su **Impostazioni → Permalink**
2. Seleziona **"Nome articolo"** (Post name)
3. Clicca **Salva modifiche**

### Passo 7: Avvia Next.js

Nel terminale di Codespaces:

```bash
npm run dev
```

### Passo 8: Verifica il Setup

1. Apri l'URL della porta 3000 nel browser
2. Dovresti vedere la home page di Faust.js
3. Se vedi errori, controlla la sezione Troubleshooting sotto

## 🧪 Crea Contenuti di Test

1. In WordPress admin, vai su **Articoli → Aggiungi nuovo**
2. Crea un articolo di prova
3. Pubblica l'articolo
4. Vai alla home page Next.js per vedere l'articolo

## 📁 Struttura del Progetto

```
.
├── .devcontainer/          # Configurazione Codespaces e Docker
│   ├── devcontainer.json   # Configurazione VS Code
│   ├── docker-compose.yml  # WordPress, MySQL, phpMyAdmin
│   ├── setup.sh            # Script setup iniziale
│   └── update-urls.sh      # Aggiorna URL WordPress
├── components/             # Componenti React riutilizzabili
├── fragments/              # Frammenti GraphQL
├── pages/                  # Pagine Next.js
├── queries/                # Query GraphQL
├── styles/                 # Stili CSS
├── wp-templates/           # Template per tipi di contenuto WordPress
│   ├── front-page.js       # Template home page
│   ├── single.js           # Template singolo articolo
│   ├── page.js             # Template pagina
│   └── archive.js          # Template archivio
├── .env.local              # Configurazione ambiente (non in git)
├── faust.config.js         # Configurazione Faust.js
├── next.config.js          # Configurazione Next.js
└── package.json            # Dipendenze Node.js
```

## 🔍 URL e Servizi

| Servizio   | Porta | URL                                     | Utilizzo             |
| ---------- | ----- | --------------------------------------- | -------------------- |
| Next.js    | 3000  | https://{codespace}-3000.app.github.dev | Il tuo sito frontend |
| WordPress  | 8080  | https://{codespace}-8080.app.github.dev | Admin WordPress      |
| phpMyAdmin | 8081  | https://{codespace}-8081.app.github.dev | Gestione database    |
| MySQL      | 3306  | (interno)                               | Database WordPress   |

## ⚠️ Problemi Comuni

### WordPress mostra "localhost" nei link

**Soluzione:**

```bash
# Esegui lo script di aggiornamento URL
.devcontainer/update-urls.sh
```

### Errore "GraphQL endpoint not found"

**Causa:** WPGraphQL non è installato o attivo

**Soluzione:**

1. Vai su WordPress admin
2. Plugin → Plugin installati
3. Verifica che WPGraphQL sia attivo

### Errore CORS

**Causa:** URL frontend non configurato in WordPress

**Soluzione:**

1. Vai su WordPress: Impostazioni → Headless
2. Verifica che "Frontend site URL" sia l'URL Codespaces della porta 3000
3. Salva le impostazioni

### Immagini non si caricano

**Causa:** Domini non consentiti in next.config.js

**Soluzione:** Già configurato! Il file `next.config.js` include pattern per Codespaces.

### Docker containers non partono

**Soluzione:**

```bash
# Riavvia i container
docker compose -f .devcontainer/docker-compose.yml restart

# Se necessario, reset completo (⚠️ cancella i dati!)
docker compose -f .devcontainer/docker-compose.yml down -v
docker compose -f .devcontainer/docker-compose.yml up -d
```

## 🔐 Credenziali Database

Se hai bisogno di accedere direttamente al database:

```
Host: db (o localhost:3306)
Database: wordpress
Username: wordpress
Password: wordpress
Root Password: rootpassword
```

Usa phpMyAdmin (porta 8081) per gestione visuale.

## 📚 Risorse

- [Documentazione FaustWP](https://faustjs.org/)
- [Documentazione WPGraphQL](https://www.wpgraphql.com/)
- [Documentazione Next.js](https://nextjs.org/docs)
- [GitHub Codespaces Docs](https://docs.github.com/en/codespaces)

## 🎨 Prossimi Passi

Dopo il setup base:

1. **Personalizza i template** in `wp-templates/`
2. **Aggiungi componenti** in `components/`
3. **Crea query GraphQL** in `queries/`
4. **Installa plugin WordPress** per funzionalità aggiuntive (es: ACF)
5. **Configura stili** in `styles/`

## 💡 Best Practices

- ✅ Usa sempre gli URL Codespaces, mai localhost
- ✅ Fai commit frequenti del codice (WordPress è separato)
- ✅ Usa `npm run generate` dopo modifiche allo schema GraphQL
- ✅ Testa le query in WPGraphQL IDE prima di usarle in Next.js
- ✅ Configura permalink WordPress su "Nome articolo"

## 🔄 Workflow di Sviluppo

1. Crea/modifica contenuti in WordPress admin
2. Sviluppa template e componenti in Next.js
3. Testa in tempo reale su Codespaces
4. Commit del codice (solo Next.js, non WordPress!)
5. Deploy su produzione quando pronto

---

**Nota:** Questo setup è ottimizzato per sviluppo. Per produzione, usa un hosting WordPress dedicato e configura gli URL di conseguenza.
