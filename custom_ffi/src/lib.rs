use nvim_oxi as oxi;
use oxi::{Dictionary, Function};

#[derive(thiserror::Error, Debug)]
#[error(transparent)]
pub struct WrapperError(#[from] anyhow::Error);

type Result<T> = std::result::Result<T, WrapperError>;

#[oxi::module]
fn custom_ffi() -> oxi::Result<Dictionary> {
    Ok(Dictionary::from_iter([("hi", Function::from_fn(hello))]))
}

fn hello(_: ()) -> Result<String> {
    Ok("Hello, World!".to_string())
}


