import blogatto/dev
import blogatto/error
import gleam/io
import me/site

pub fn main() {
  case
    site.config()
    |> dev.new()
    |> dev.build_command("gleam run")
    |> dev.start()
  {
    Ok(Nil) -> io.println("Dev server stopped.")
    Error(err) -> io.println("Dev server error: " <> error.describe_error(err))
  }
}
