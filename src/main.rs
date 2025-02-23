// SPDX-FileCopyrightText: 2025 Matthew Mark Ibbetson
// SPDX-FileContributor: Matthew Mark Ibbetson
//
// SPDX-License-Identifier: GPL-3.0-or-later

//! CLI tool for managing notes in a minimalistic, cross-platform, free, extensible manner.

use std::{fs, path::PathBuf};

use anyhow::{anyhow, Error};
use clap::Parser;
use cli::Cli;

mod cli;

fn main() -> Result<(), Error> {
    let cli = Cli::parse();

    let config = {
        let mut config_builder = Config::builder();

        let config_base = load_config(cli_config_path.as_deref())
            .map_err(|e| anyhow!(e).context("Error loading configuration"))?;

        if let Some(base) = config_base {
            config_builder = config_builder.with_base_config(base);
        }

        if let Some(path) = cli.comment_block_open {
            config_builder = config_builder.with_file_directory(path.to_owned());
        }

        config_builder.build()
    };

    let output_path = cli_directory_path
        .as_ref()
        .map_or(config.directory, PathBuf::from)
        .join(filename);

    safe_write(&output_path, &template)?;

    if *cli_print {
        print!(
            "{}",
            output_path
                .to_str()
                .ok_or_else(|| anyhow!("Error printing new file path"))?
        );
        };
    }

    Ok(())
}
