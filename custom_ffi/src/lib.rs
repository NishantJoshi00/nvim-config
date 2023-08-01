use nvim_oxi as oxi;
use oxi::{Dictionary, Function};

type Result<T> = std::result::Result<T, FError>;

#[derive(thiserror::Error, Debug)]
enum FError {
    // #[error(transparent)]
}
#[oxi::module]
fn custom_ffi() -> oxi::Result<Dictionary> {
    Ok(Dictionary::from_iter([("hi", Function::from_fn(hello))]))
}

fn hello(_: ()) -> Result<String> {
    Ok("Hello, World!".to_string())
}
