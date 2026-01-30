# WordPress + Faust.js Codespaces Setup

Questo progetto è configurato per funzionare su GitHub Codespaces con:

- **WordPress** (backend headless)
- **MySQL** (database)
- **Next.js + Faust.js** (frontend)
- **phpMyAdmin** (gestione database)

## 🚀 Quick Start

1. **Apri il progetto in Codespaces**
   - Il setup automatico installerà tutte le dipendenze
   - Gli URL di WordPress e Next.js saranno automaticamente configurati per Codespaces

2. **Verifica gli URL del tuo Codespace**
   - In GitHub Codespaces, clicca su "PORTS" nella parte inferiore
   - Troverai gli URL pubblici per:
     - **3000**: Next.js Frontend
     - **8080**: WordPress
     - **8081**: phpMyAdmin

3. **Configura WordPress** (solo la prima volta)
   - Apri l'URL della porta 8080 (WordPress)
   - Completa l'installazione guidata:
     - Lingua: Italiano
     - Titolo sito: Il tuo sito
     - Username/Password: crea le credenziali admin
4. **Installa FaustWP Plugin**

   ```
   - Login WordPress admin
   - Vai su Plugin > Aggiungi nuovo
   - Cerca "FaustWP"
   - Installa e attiva
   ```

5. **Configura FaustWP**
   - Vai su Impostazioni > Headless
   - In "Frontend site URL", inserisci l'URL del tuo Codespace per la porta 3000
     (es: `https://nome-codespace-3000.app.github.dev`)
   - Copia il "Secret Key" generato

6. **Aggiorna .env.local**

   ```bash
   # Incolla la secret key copiata da WordPress
   FAUST_SECRET_KEY=la-tua-secret-key
   ```

7. **Avvia Next.js**

   ```bash
   npm run dev
   ```

8. **Visita il tuo sito**
   - Apri l'URL della porta 3000 dal pannello PORTS

## 🔗 URLs in Codespaces

**IMPORTANTE**: In Codespaces, NON usare `localhost`!

GitHub Codespaces genera automaticamente URL pubblici nel formato:

- `https://{CODESPACE_NAME}-{PORT}.app.github.dev`

Gli script di setup aggiornano automaticamente:

- `.env.local` con gli URL corretti
- Il database WordPress con gli URL Codespaces

**Trova i tuoi URL:**

1. Vai al pannello "PORTS" in basso in VS Code
2. Gli URL pubblici sono nella colonna "Forwarded Address"

## 🔗 URLs Locali (se non usi Codespaces)

| Servizio         | URL                   | Descrizione          |
| ---------------- | --------------------- | -------------------- |
| Next.js Frontend | http://localhost:3000 | Il tuo sito Faust.js |
| WordPress        | http://localhost:8080 | Admin WordPress      |
| phpMyAdmin       | http://localhost:8081 | Gestione database    |
| MySQL            | localhost:3306        | Database (interno)   |

## 🔐 Credenziali Database

```
Host: db
Database: wordpress
User: wordpress
Password: wordpress
Root Password: rootpassword
```

## 📝 Comandi Utili

```bash
# Avvia sviluppo Next.js
npm run dev

# Build produzione
npm run build

# Genera GraphQL types
npm run generate

# Formatta codice
npm run format
```

## 🐛 Troubleshooting

### WordPress non si avvia

```bash
# Controlla i container Docker
docker ps

# Riavvia WordPress
docker-compose -f .devcontainer/docker-compose.yml restart wordpress
```

### Database connection error

```bash
# Riavvia il database
docker-compose -f .devcontainer/docker-compose.yml restart db
```

### Reset completo

```bash
# Attenzione: cancella tutti i dati!
docker-compose -f .devcontainer/docker-compose.yml down -v
# Poi riavvia Codespaces
```

## 📚 Documentazione

- [FaustWP Docs](https://faustjs.org/)
- [WordPress Docs](https://wordpress.org/documentation/)
- [Next.js Docs](https://nextjs.org/docs)

## 🎨 Personalizzazione

### Aggiungi plugin WordPress

1. Accedi a WordPress admin (http://localhost:8080/wp-admin)
2. Installa i plugin necessari
3. I plugin consigliati per headless:
   - FaustWP (già richiesto)
   - WPGraphQL
   - Advanced Custom Fields (ACF)

### Tema WordPress

Non serve installare temi complessi - WordPress funziona solo come backend!

## 🔄 Workflow di Sviluppo

1. Crea contenuti in WordPress (http://localhost:8080/wp-admin)
2. Sviluppa template in Next.js (cartella `wp-templates/`)
3. Testa su http://localhost:3000
4. Commit e push su GitHub

## 💡 Tips

- Usa `npm run generate` dopo modifiche allo schema GraphQL
- Configura permalink in WordPress su "Nome articolo"
- Abilita pretty permalinks per URL puliti
- Usa WPGraphQL IDE per testare query (in WordPress admin)

## ⚠️ Problemi Comuni in Codespaces

### WordPress URL non corretti

Se i link in WordPress puntano a localhost invece dell'URL Codespaces:

```bash
# Riavvia il container per aggiornare gli URL
docker-compose -f .devcontainer/docker-compose.yml restart
# Oppure esegui manualmente lo script di aggiornamento
.devcontainer/update-urls.sh
```

### Frontend non si connette a WordPress

1. Verifica che l'URL in `.env.local` sia quello Codespaces (non localhost)
2. Verifica che il port forwarding sia pubblico (pannello PORTS)
3. Riavvia il dev server: `npm run dev`

### Errore CORS

Assicurati che in WordPress Settings > Headless, il "Frontend site URL" sia impostato all'URL Codespaces della porta 3000
