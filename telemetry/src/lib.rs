use bytecheck::CheckBytes;
use magic_map::MagicMap;
use nvim_oxi::{Dictionary, Function, Object};
use once_cell::sync::OnceCell;
use std::collections::HashMap;

#[derive(rkyv::Archive, rkyv::Serialize, rkyv::Deserialize, Debug)]
#[archive_attr(derive(CheckBytes))]
struct Metrics {
    lookup: HashMap<Key, Value>,
}

#[derive(rkyv::Archive, rkyv::Serialize, rkyv::Deserialize, Debug, Eq, Hash, PartialEq)]
#[archive_attr(derive(Eq, Hash, PartialEq, CheckBytes, Debug))]
struct Key {
    mode: String,
    pattern: String,
}

#[derive(rkyv::Archive, rkyv::Serialize, rkyv::Deserialize, Debug)]
#[archive_attr(derive(CheckBytes, Debug))]
struct Value {
    description: Option<String>,
    count: usize,
}

static MAP: OnceCell<MagicMap<Metrics>> = OnceCell::new();

fn create(file: &str) {
    let map = MAP.get_or_init(|| MagicMap::<Metrics>::new(file.into()));

    let start = Metrics {
        lookup: HashMap::new(),
    };
    map.clone()
        .create(start)
        .expect("Failed while creating the map");
}

fn increment(file: &str, mode: &str, pattern: &str, desc: &str) {
    let magic_map = MAP.get_or_init(|| MagicMap::<Metrics>::new(file.into()));

    let output = magic_map.clone().write(
        |mut value| {
            value
                .lookup
                .entry(Key {
                    mode: mode.to_string(),
                    pattern: pattern.to_string(),
                })
                .and_modify(|v| v.count += 1)
                .or_insert(Value {
                    description: Some(desc.to_string()),
                    count: 1,
                });
            Ok(value)
        },
        (),
    );

    match output {
        Ok(_) => (),
        Err(_e) => panic!("{}", _e),
    }
}

fn generate_metrics(file: &str) -> String {
    let magic_map = MAP.get_or_init(|| MagicMap::<Metrics>::new(file.into()));

    let output = magic_map.clone().get_owned().unwrap();

    output.lookup.iter().fold(
        String::from(
            "# TYPE keybind counter\n# HELP keybind gives a distribution of keybind usage\n",
        ),
        |mut acc, (key, value)| {
            acc.push_str(&format!(
                "keybind{{mode=\"{}\", pattern=\"{}\"}} {}\n",
                key.mode, key.pattern, value.count
            ));
            acc
        },
    )
}

#[nvim_oxi::plugin]
pub fn telemetry() -> Dictionary {
    let create = Function::from_fn(|filename: String| create(&filename));
    let increment = Function::from_fn(
        |(filename, mode, pattern, description): (String, String, String, String)| {
            increment(&filename, &mode, &pattern, &description)
        },
    );

    let generate = Function::from_fn(|filename: String| generate_metrics(&filename));

    Dictionary::from_iter([
        ("create", Object::from(create)),
        ("increment", Object::from(increment)),
        ("generate", Object::from(generate)),
    ])
}
