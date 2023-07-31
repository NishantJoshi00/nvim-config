target/release/libffi.so: src/*
	bash -c 'unset CARGO_TARGET_DIR'
	cargo build --release

load: target/release/libffi.so
	cp target/release/libcustom_ffi.dylib lua/custom_ffi.so

clean:
	cargo clean
