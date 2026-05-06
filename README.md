# me

[![Package Version](https://img.shields.io/hexpm/v/me)](https://hex.pm/packages/me)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/me/)

This project is set up as a Lustre-powered static site using [Blogatto](https://github.com/veeso/blogatto).

## Project layout

```text
blog/
  first-post/
    index.md
dev/
  me_dev.gleam
src/
  me.gleam
  me/
    site.gleam
static/
  style.css
```

## Commands

```sh
mise trust        # Trust the repo's mise.toml once
mise install      # Install pinned Node, Erlang, Gleam, and Rebar
mise run build    # Build Tailwind CSS and generate the static site into ./dist
mise run dev      # Start the Blogatto dev server with live reload
mise run test     # Run tests and format checks
```

## Customisation

- Edit `src/me/site.gleam` to change Lustre routes and layout.
- Add markdown posts under `blog/`.
- Update `static/style.css` for site styling.
- Replace the placeholder `site_url` with your real domain before deploying.

## Development

```sh
mise run build
mise run test
```
