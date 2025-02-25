// SPDX-FileCopyrightText: 2025 Matthew Mark Ibbetson
// SPDX-FileContributor: Matthew Mark Ibbetson
//
// SPDX-License-Identifier: GPL-3.0-or-later

//! CLI definition for litr.

use std::path::PathBuf;

use clap::{ArgAction, Parser};

#[derive(Parser)]
#[command(
    name = "litr",
    version = "0.1.0",
    about = "A command to tangle source code blocks out of document files"
)]
pub struct Cli {
    /// foo
    pub input: String,

    #[arg(
        short = 'd',
        long = "output-directory",
        action = ArgAction::Set)]
    pub output_directory: Option<PathBuf>,

    #[arg(
        short = 't',
        long = "tangle-commented",
        action = ArgAction::SetTrue)]
    pub tangle_commented_blocks: bool,

    #[arg(
        short = 'b',
        long = "trim-blanklines",
        action = ArgAction::SetTrue)]
    pub trim_source_blanklines: bool,

    #[arg(
        short = 'B',
        long = "insert-blanklines",
        action = ArgAction::Set)]
    pub insert_target_blanklines: bool,

    /// Print the input
    #[arg(
        short = 's',
        long = "comment-block-open",
        action = ArgAction::Set)]
    pub comment_block_start: Option<String>,

    /// Print the input
    #[arg(
        short = 'e',
        long = "comment-block-close",
        action = ArgAction::Set)]
    pub comment_block_end: Option<String>,

    /// Print the input
    #[arg(
        short = 'c',
        long = "comment-line-indicator",
        action = ArgAction::Set)]
    pub comment_line_indicator: Option<String>,

    /// Print the input
    #[arg(
        short = 'S',
        long = "code-block-start",
        action = ArgAction::Set)]
    pub code_block_start: Option<String>,

    /// Print the input
    #[arg(
        short = 'E',
        long = "code-block-end",
        action = ArgAction::Set)]
    pub code_block_end: Option<String>,
}
