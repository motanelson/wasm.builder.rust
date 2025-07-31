
use std::fs::File;
use std::io::{Write, Result};

fn main() -> Result<()> {
    println!("\x1B[43;30m\nCriando ficheiro main.wasm...\n");

    let mut file = File::create("main.wasm")?;

    // Cabeçalho
    file.write_all(&[0x00, b'a', b's', b'm'])?;           // WASM magic
    file.write_all(&[0x01, 0x00, 0x00, 0x00])?;           // WASM version

    // Seção de tipos (type)
    file.write_all(&[0x01, 0x07])?;                       // section ID = 1, size = 7
    file.write_all(&[0x01, 0x60, 0x02, 0x7F, 0x7F, 0x01, 0x7F])?; // 1 func (i32, i32) -> i32

    // Seção de funções (function)
    file.write_all(&[0x03, 0x02, 0x01, 0x00])?;           // section ID = 3, size = 2, 1 func of type 0

    // Seção de exportações (export)
    file.write_all(&[0x07, 0x07, 0x01, 0x03])?;           // section ID = 7, size = 7, 1 export, name length = 3
    file.write_all(b"sum")?;                              // name = "sum"
    file.write_all(&[0x00, 0x00])?;                       // export kind = func, index = 0

    // Seção de código (code)
    file.write_all(&[0x0A, 0x09, 0x01, 0x07, 0x00])?;     // section ID = 10, size = 9, 1 func, body size = 7, no locals
    file.write_all(&[0x20, 0x00, 0x20, 0x01, 0x6A, 0x0B])?; // get_local 0, get_local 1, i32.add, end

    println!("Ficheiro main.wasm criado com sucesso!");

    Ok(())
}
