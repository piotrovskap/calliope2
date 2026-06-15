# Calliope

Statyczny landing page (HTML/CSS/JS) hostowany na Cloudflare Pages.

## Struktura

```
public/         # pliki strony (deployowany katalog)
  index.html
  styles.css
  script.js
wrangler.toml   # konfiguracja Cloudflare Pages
package.json
```

## Lokalny podgląd

```bash
npm install
npm run dev      # uruchamia wrangler pages dev na public/
```

Albo po prostu otwórz `public/index.html` w przeglądarce.

## Wdrożenie na Cloudflare Pages

```bash
npx wrangler login     # jednorazowo
npm run deploy         # wrangler pages deploy public
```

Alternatywnie: w panelu Cloudflare Pages podłącz repozytorium GitHub
i ustaw katalog wyjściowy na `public` (bez build command).
