import blogatto/config
import blogatto/config/markdown
import blogatto/config/robots
import blogatto/config/sitemap
import blogatto/post.{type Post}
import gleam/int
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

const site_url = "https://example.com"

pub fn config() -> config.Config(Nil) {
  let md_config =
    markdown.default()
    |> markdown.markdown_path("./blog")
    |> markdown.route_prefix("writing")

  config.new(site_url)
  |> config.output_dir("./dist")
  |> config.static_dir("./static")
  |> config.markdown(md_config)
  |> config.route("/", home_view)
  |> config.route("/writing", writing_view)
  |> config.route("/projects", projects_view)
  |> config.route("/snippets", snippets_view)
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

// Home page with hero and experience
fn home_view(_posts: List(Post(Nil))) -> Element(Nil) {
  page_layout(title: "P G Nithin Reddy", page_title: "", body: [
    html.section([attribute.class("")], [
      html.div([], [
        html.h3([attribute.class("text-lg font-bold")], [
          html.text("P G Nithin Reddy"),
        ]),
        html.p([attribute.class("text-muted-foreground leading-none")], [
          html.text("Full Stack Web Developer"),
        ]),
      ]),
      html.p([], [
        html.text(
          "Hi, I'm Nithin — a full-stack developer and automation enthusiast based in Bangalore, India.",
        ),
        html.br([]),
        html.br([]),
        html.text("I solve business problems with clean code and thoughtful design. My "),
        html.a([attribute.href("/projects"), attribute.class("link")], [
          html.text("projects"),
        ]),
        html.text(
          " are focused on user experience, scalability, and building products that matter.",
        ),
        html.br([]),
        html.br([]),
        html.text("Currently, I'm building products and helping teams scale their ideas. "),
        html.text("Let's work together!"),
      ]),
    ]),
    html.div([attribute.class("")], []),
    html.section([], [
      html.h4([attribute.class("text-base font-bold")], [html.text("Experience")]),
      html.div([attribute.class("space-y-6")], [
        experience_item(
          "SDE-II",
          "Durianpay",
          "Dec 2021 - Jan 2023",
          "Remote",
        ),
        experience_item(
          "SDE-II",
          "Instamojo",
          "Jan 2019 - Dec 2021",
          "Remote",
        ),
        experience_item(
          "SDE Intern",
          "Mediatek",
          "Mar 2018 - Jul 2018",
          "Taipei, Taiwan",
        ),
      ]),
    ]),
  ])
}

// Writing (blog) page
fn writing_view(_posts: List(Post(Nil))) -> Element(Nil) {
  page_layout(title: "Writing", page_title: "Writing", body: [
    html.div([attribute.class("space-y-6")], [
      writing_item(
        "First Post",
        "Welcome to my blog. Here I share thoughts on web development, design, and technology.",
        "2024",
        "Technology",
      ),
      writing_item(
        "Building with Gleam",
        "Exploring the Gleam language for building scalable backend systems.",
        "2024",
        "Programming",
      ),
      writing_item(
        "The Art of Clean Code",
        "Best practices and patterns for writing maintainable code that scales.",
        "2024",
        "Software Engineering",
      ),
    ]),
  ])
}

// Projects page
fn projects_view(_posts: List(Post(Nil))) -> Element(Nil) {
  page_layout(title: "Projects", page_title: "Projects", body: [
    html.div([attribute.class("space-y-12")], [
      project_item(
        "Durianpay Payment Platform",
        "Infrastructure and payments",
        2021,
      ),
      project_item(
        "Instamojo Storefront",
        "E-commerce platform",
        2019,
      ),
      project_item(
        "initthyself",
        "SaaS product for creators",
        2023,
      ),
    ]),
  ])
}

// Snippets page
fn snippets_view(_posts: List(Post(Nil))) -> Element(Nil) {
  page_layout(title: "Snippets", page_title: "Snippets", body: [
    html.div([attribute.class("space-y-6")], [
      snippet_item(
        "useCountdown Hook",
        "A React hook for countdown timers",
        "React",
      ),
      snippet_item(
        "Tailwind Theme Config",
        "Custom Tailwind CSS configuration with design tokens",
        "CSS",
      ),
      snippet_item(
        "Gleam Type Helpers",
        "Utility functions for type-safe Gleam development",
        "Gleam",
      ),
    ]),
  ])
}

// Helper functions for chizi.dev-style components

fn experience_item(
  role: String,
  company: String,
  date: String,
  location: String,
) -> Element(Nil) {
  html.div([attribute.class("flex flex-col justify-between gap-2 sm:flex-row-reverse sm:gap-4")], [
    html.p([attribute.class("text-sm sm:text-muted-foreground text-muted-foreground/70")], [
      html.text(date),
    ]),
    html.div([], [
      html.p([], [html.text(role)]),
      html.p([attribute.class("text-muted-foreground")], [
        html.text(company <> " - " <> location),
      ]),
    ]),
  ])
}

fn writing_item(
  title: String,
  _description: String,
  date: String,
  category: String,
) -> Element(Nil) {
  html.div([attribute.class("flex flex-col-reverse items-start justify-between gap-2 sm:flex-row")], [
    html.div([attribute.class("")], [
      html.a([attribute.href("#"), attribute.class("w-fit")], [
        html.p([], [html.text(title)]),
      ]),
      html.p([attribute.class("text-sm text-muted-foreground")], [html.text(date)]),
    ]),
    html.div([attribute.class("hidden h-6 grow items-center sm:flex")], [
      html.span([attribute.class("bg-border/40 h-px w-full")], []),
    ]),
    html.span([attribute.class("text-xs border border-border rounded px-2 py-1")], [
      html.text(category),
    ]),
  ])
}

fn project_item(title: String, description: String, year: Int) -> Element(Nil) {
  html.div([attribute.class("relative flex flex-col gap-6 lg:flex-row")], [
    html.a(
      [attribute.href("#"), attribute.class("group top-20 h-fit lg:sticky lg:flex-1")],
      [
        html.div([attribute.class("bg-muted rounded-md aspect-video")], []),
        html.div([attribute.class("mt-2 flex items-center justify-between gap-2")], [
          html.h4([attribute.class("text-base font-bold")], [html.text(title)]),
          html.p([attribute.class("text-muted-foreground lg:opacity-0 group-hover:lg:opacity-100")], [
            html.text("Case study →"),
          ]),
        ]),
      ],
    ),
    html.div([attribute.class("lg:flex-1")], [
      html.p([], [html.text(description)]),
      html.p([attribute.class("text-sm text-muted-foreground mt-4")], [
        html.text("Completed in " <> int.to_string(year)),
      ]),
    ]),
  ])
}

fn snippet_item(title: String, description: String, language: String) -> Element(Nil) {
  html.a([attribute.href("#"), attribute.class("block group")], [
    html.div([attribute.class("flex flex-col justify-between gap-2 sm:flex-row")], [
      html.div([], [
        html.p([attribute.class("font-medium group-hover:text-primary")], [html.text(title)]),
        html.p([attribute.class("text-sm text-muted-foreground")], [html.text(description)]),
      ]),
      html.span([attribute.class("text-xs text-muted-foreground")], [html.text(language)]),
    ]),
  ])
}

fn page_layout(
  title title: String,
  page_title _page_title: String,
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
    html.body([attribute.class("bg-background text-foreground")], [
      html.div([attribute.class("container flex min-h-dvh flex-col gap-20 px-4 py-10 2xl:px-12")], [
        // Header with navigation
        html.header(
          [attribute.class("flex flex-wrap items-center justify-between gap-x-20 gap-y-4")],
          [
            html.div([attribute.class("flex items-center gap-2")], [
              html.a([attribute.href("/"), attribute.class("relative")], [
                html.img([
                  attribute.src("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 28 28'%3E%3Crect width='28' height='28' fill='%23333'/%3E%3C/svg%3E"),
                  attribute.alt("Profile"),
                  attribute.class("rounded-sm"),
                  attribute.width(28),
                  attribute.height(28),
                ]),
              ]),
            ]),
            html.nav([attribute.class("flex w-full max-w-sm justify-between gap-5 text-sm sm:w-fit")], [
              html.a([attribute.href("/"), attribute.class("link w-fit")], [
                html.text("Index"),
              ]),
              html.a([attribute.href("/writing"), attribute.class("link w-fit")], [
                html.text("Writing"),
              ]),
              html.a([attribute.href("/projects"), attribute.class("link w-fit")], [
                html.text("Projects"),
              ]),
              html.a([attribute.href("/snippets"), attribute.class("link w-fit")], [
                html.text("Snippets"),
              ]),
            ]),
          ],
        ),
        // Main content
        html.main([attribute.class("flex flex-1 flex-col gap-12")], body),
        // Footer
        html.footer(
          [attribute.class("flex flex-wrap items-center justify-between gap-x-4")],
          [
            html.p([attribute.class("text-muted-foreground text-sm")], [
              html.text("Bangalore, IN"),
            ]),
          ],
        ),
      ]),
    ]),
  ])
}
