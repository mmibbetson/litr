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

        if cli.tangle_commented_blocks {
            config_builder = config_builder.with_tangle_commented_blocks(true);
        }

        if cli.trim_source_blanklines {
            config_builder = config_builder.with_trim_source_blanklines(true);
        }

        if cli.insert_target_blanklines {
            config_builder = config_builder.with_insert_target_blanklines(true);
        }

        if let Some(base) = config_base {
            config_builder = config_builder.with_base_config(base);
        }

        if let Some(path) = cli.comment_block_start {
            config_builder = config_builder.with_file_directory(path.to_owned());
        }

        if let Some(path) = cli.comment_block_end {
            config_builder = config_builder.with_file_directory(path.to_owned());
        }

        if let Some(path) = cli.comment_line_indicator {
            config_builder = config_builder.with_file_directory(path.to_owned());
        }

        if let Some(path) = cli.code_block_start {
            config_builder = config_builder.with_file_directory(path.to_owned());
        }

        if let Some(path) = cli.code_block_end {
            config_builder = config_builder.with_file_directory(path.to_owned());
        }

        config_builder.build()
    };

    let input_path = PathBuf::from(cli.input);
    let input_content = fs::read_to_string(&input_path)
        .map_err(|e| anyhow!(e).context("Error reading input file"))?;

    let output_directory = cli_output_directory
        .as_ref()
        .map_or(|| std::env::current_dir(), PathBuf::from);

    let files = derive_file_paths(&input, &output_directory);
    safe_write_files(&files)?;
    print!("Tangle successful!");

    Ok(())
}
