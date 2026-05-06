import blogatto/config
import blogatto/config/markdown
import blogatto/config/robots
import blogatto/config/sitemap
import blogatto/post.{type Post}
import gleam/list
import gleam/time/timestamp
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

const site_url = "https://example.com"

pub fn config() -> config.Config(Nil) {
  let md_config =
    markdown.default()
    |> markdown.markdown_path("./blog")
    |> markdown.route_prefix("blog")

  config.new(site_url)
  |> config.output_dir("./dist")
  |> config.static_dir("./static")
  |> config.markdown(md_config)
  |> config.route("/", home_view)
  |> config.route("/about", about_view)
  |> config.sitemap(sitemap.new("/sitemap.xml"))
  |> config.robots(
    robots.new(site_url <> "/sitemap.xml")
    |> robots.robot(
      robots.Robot(
        user_agent: "*",
        allowed_routes: ["/"],
        disallowed_routes: [],
      ),
    ),
  )
}

fn home_view(posts: List(Post(Nil))) -> Element(Nil) {
  let sorted = list.sort(posts, fn(a, b) { timestamp.compare(b.date, a.date) })

  page_layout(title: "me", body: [
    html.section([attribute.class("hero")], [
      html.p([attribute.class("eyebrow")], [html.text("Lustre + Blogatto")]),
      html.h1([], [html.text("A Gleam static site with Lustre views")]),
      html.p([], [
        html.text(
          "Use Lustre for your hand-built pages and Blogatto for the static build pipeline.",
        ),
      ]),
      html.p([attribute.class("actions")], [
        html.a([attribute.href("/about")], [html.text("About this site")]),
        html.a([attribute.href("/blog/first-post")], [
          html.text("Read the first post"),
        ]),
      ]),
    ]),
    html.section([attribute.class("posts")], [
      html.h2([], [html.text("Posts")]),
      posts_list(sorted),
    ]),
  ])
}

fn about_view(_posts: List(Post(Nil))) -> Element(Nil) {
  page_layout(title: "About", body: [
    html.section([attribute.class("page")], [
      html.h1([], [html.text("About")]),
      html.p([], [
        html.text(
          "This route is rendered from a Lustre view at build time. Add more pages by registering routes in src/me/site.gleam.",
        ),
      ]),
      html.p([], [
        html.a([attribute.href("/")], [html.text("Back to the homepage")]),
      ]),
    ]),
  ])
}

fn posts_list(posts: List(Post(Nil))) -> Element(Nil) {
  case posts {
    [] ->
      html.p([], [
        html.text("No posts yet. Add one under ./blog to populate this list."),
      ])
    _ ->
      html.ul(
        [],
        list.map(posts, fn(post) {
          html.li([], [
            html.article([], [
              html.h3([], [
                html.a([attribute.href("/blog/" <> post.slug <> "/")], [
                  html.text(post.title),
                ]),
              ]),
              html.p([], [html.text(post.description)]),
            ]),
          ])
        }),
      )
  }
}

fn page_layout(
  title title: String,
  body body: List(Element(Nil)),
) -> Element(Nil) {
  html.html([attribute.lang("en")], [
    html.head([], [
      html.meta([attribute.charset("utf-8")]),
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),
      html.title([], title),
      html.link([
        attribute.rel("stylesheet"),
        attribute.href("/style.css"),
      ]),
    ]),
    html.body([], [
      html.header([attribute.class("site-header")], [
        html.a([attribute.href("/"), attribute.class("brand")], [
          html.text("me"),
        ]),
        html.nav([], [
          html.a([attribute.href("/")], [html.text("Home")]),
          html.a([attribute.href("/about")], [html.text("About")]),
        ]),
      ]),
      html.main([attribute.class("site-main")], body),
    ]),
  ])
}
