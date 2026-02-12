# 🎉 Progetto Faust.js + WordPress Funzionante!

## ✅ Setup Completato

Il progetto è ora configurato e funzionante! Ecco le informazioni principali:

### 🌐 URL Importanti

- **Frontend Faust.js**: https://cautious-barnacle-64vqwp6v56fr4g7-3000.app.github.dev
- **WordPress Admin**: https://cautious-barnacle-64vqwp6v56fr4g7-8080.app.github.dev/wp-admin
  - Username: `admin`
  - Password: `admin`
- **GraphQL Endpoint**: https://cautious-barnacle-64vqwp6v56fr4g7-8080.app.github.dev/index.php?graphql

### 🚀 Come Avviare il Progetto

Per avviare il server di sviluppo, usa semplicemente:

```bash
./start-dev.sh
```

Oppure manualmente:

```bash
source .env && npx next dev
```

### 📦 Plugin WordPress Installati

- ✅ WPGraphQL 2.9.0
- ✅ FaustWP 1.8.0

### 🔧 Configurazione

Le variabili d'ambiente sono già configurate in `.env` e `.env.local`:

- `NEXT_PUBLIC_WORDPRESS_URL`: URL pubblico di WordPress
- `NEXT_PUBLIC_SITE_URL`: URL pubblico del frontend
- `FAUST_SECRET_KEY`: Chiave segreta sincronizzata

### 📝 Comandi Utili

```bash
# Avvia il server di sviluppo
./start-dev.sh

# Genera types GraphQL
npm run generate

# Build per produzione
npm run build

# Avvia in produzione
npm run start
```

### 🐛 Troubleshooting

Se il server non si avvia o ci sono problemi:

1. Verifica che WordPress sia attivo:

   ```bash
   docker ps | grep wordpress
   ```

2. Riavvia WordPress se necessario:

   ```bash
   docker restart devcontainer-wordpress-1
   ```

3. Verifica le variabili d'ambiente:
   ```bash
   cat .env
   ```

### 🎯 Prossimi Passi

1. Accedi a WordPress Admin e crea contenuti
2. Visualizza i contenuti sul frontend Faust.js
3. Modifica i template in `wp-templates/`
4. Personalizza i componenti in `components/`

Buon divertimento! 🎉
