# WordPress + Faust.js Codespaces Setup

Questo progetto è configurato per funzionare su GitHub Codespaces con:

- **WordPress** (backend headless)
- **MySQL** (database)
- **Next.js + Faust.js** (frontend)
- **phpMyAdmin** (gestione database)

## 🚀 Quick Start

1. **Apri il progetto in Codespaces**
   - Il setup automatico installerà tutte le dipendenze

2. **Configura WordPress**
   - Accedi a WordPress: http://localhost:8080
   - Completa l'installazione guidata:
     - Lingua: Italiano
     - Titolo sito: Il tuo sito
     - Username/Password: crea le credenziali admin
3. **Installa FaustWP Plugin**

   ```
   - Login WordPress admin
   - Vai su Plugin > Aggiungi nuovo
   - Cerca "FaustWP"
   - Installa e attiva
   ```

4. **Configura FaustWP**

   ```
   - Vai su Impostazioni > Headless
   - Copia il "Secret Key"
   - Frontend site URL: http://localhost:3000
   ```

5. **Aggiorna .env.local**

   ```bash
   # Incolla la secret key copiata da WordPress
   FAUST_SECRET_KEY=la-tua-secret-key
   ```

6. **Avvia Next.js**

   ```bash
   npm run dev
   ```

7. **Visita il tuo sito**
   - Frontend: http://localhost:3000
   - Backend: http://localhost:8080

## 🔗 URLs

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

### Container creation errors

Se ricevi errori durante la creazione dei container:

```bash
# Rimuovi tutti i container e volumi esistenti
docker compose -f .devcontainer/docker-compose.yml down -v

# Riavvia i container
docker compose -f .devcontainer/docker-compose.yml up -d

# Verifica lo stato
docker compose -f .devcontainer/docker-compose.yml ps
```

### WordPress non si avvia

```bash
# Controlla i container Docker
docker ps

# Riavvia WordPress
docker compose -f .devcontainer/docker-compose.yml restart wordpress
```

### Database connection error

```bash
# Riavvia il database
docker compose -f .devcontainer/docker-compose.yml restart db
```

### Reset completo

```bash
# Attenzione: cancella tutti i dati!
docker compose -f .devcontainer/docker-compose.yml down -v
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
