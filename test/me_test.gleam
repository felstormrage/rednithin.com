import gleeunit
import me/site

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn config_uses_dist_output_test() {
  assert site.config().output_dir == "./dist"
}
