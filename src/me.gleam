import blogatto
import blogatto/error
import gleam/io
import me/site

pub fn main() -> Nil {
  case blogatto.build(site.config()) {
    Ok(Nil) -> io.println("Site built successfully in ./dist")
    Error(err) -> io.println("Build failed: " <> error.describe_error(err))
  }
}
