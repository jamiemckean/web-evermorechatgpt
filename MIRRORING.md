# Evermore Local Mirror

Initial mirror has been downloaded to `site-mirror/` from:
- `https://evermore.co/`

## What is already mirrored
- Core site pages and project pages discovered from the homepage crawl
- Most WordPress CSS/JS/image/video assets used for page rendering and animations
- Key external assets for visuals:
  - Slick carousel CSS/JS from `cdn.jsdelivr.net`
  - Montserrat font CSS + font files from `fonts.googleapis.com` and `fonts.gstatic.com`

## Mirror additional pages (page-by-page)
Use the helper script:

```bash
./scripts/mirror-page.sh https://evermore.co/your-page/
```

You can pass multiple pages at once:

```bash
./scripts/mirror-page.sh \
  https://evermore.co/ \
  https://evermore.co/what-we-do/ \
  https://evermore.co/who-we-are/
```

## Preview locally
Run a static server from repo root:

```bash
python3 -m http.server 4173 --directory site-mirror
```

Then open:
- `http://localhost:4173/evermore.co/index.html`

## Notes
- This is a static mirror. Dynamic backend features (forms, server-side search, WordPress APIs) will not function exactly as production.
- If you need deeper capture for a section, rerun `mirror-page.sh` for the relevant URLs.
