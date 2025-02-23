// SPDX-FileCopyrightText: 2025 Matthew Mark Ibbetson
// SPDX-FileContributor: Matthew Mark Ibbetson
//
// SPDX-License-Identifier: GPL-3.0-or-later

//! CLI definition for litr.

use clap::{ArgAction, Parser};

#[derive(Parser)]
#[command(
    name = "litr",
    version = "0.1.0",
    about = "A command to tangle source code blocks out of document files"
)]
pub struct Cli {
    /// Print the input
    #[arg(
        short = 'p',
        long = "print",
        action = ArgAction::SetTrue)]
    comment_block_open: Option<String>,

    /// Print the input
    #[arg(
        short = 'p',
        long = "print",
        action = ArgAction::SetTrue)]
    comment_block_close: Option<String>,

    /// Print the input
    #[arg(
        short = 'p',
        long = "print",
        action = ArgAction::SetTrue)]
    comment_line: Option<String>,

    /// Print the input
    #[arg(
        short = 'p',
        long = "print",
        action = ArgAction::SetTrue)]
    code_block_open: Option<String>,

    /// Print the input
    #[arg(
        short = 'p',
        long = "print",
        action = ArgAction::SetTrue)]
    code_block_close: Option<String>,
}
