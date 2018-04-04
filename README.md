# Taskell

[![Build Status](https://travis-ci.org/smallhadroncollider/taskell.svg?branch=master)](https://travis-ci.org/smallhadroncollider/taskell)

A CLI kanban board/task manager for Mac and Linux

- Per project task lists
- `vim` style key-bindings
- Stored using Markdown
- Clean diffs for easy version control
- Support for sub-tasks
- Written in Haskell

![Demo](https://github.com/smallhadroncollider/taskell/blob/img/demo.gif?raw=true)

<a href="https://www.buymeacoffee.com/shc" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

## Installation

### Homebrew (Mac)

You can install Taskell on your Mac using [Homebrew](https://brew.sh):

```bash
brew install smallhadroncollider/taskell/taskell
```

There are usually bottles (binaries) available for High Sierra and Sierra. If these are not available for your computer, Homebrew will build Taskell from scratch using [Stack](https://docs.haskellstack.org/), which can take a while, particularly on older machines. Occasionally the build fails the first time, but usually works on a second attempt.

### Debian/Ubuntu

[A `.deb` package is available for Debian/Ubuntu](https://github.com/smallhadroncollider/taskell/releases). Download it and install with `dpkg -i <package-name>`.

### Fedora

Run `sudo dnf install ncurses-compat-libs` then download and run binary as described below.

### Binaries

[A binary is available for Mac and Linux](https://github.com/smallhadroncollider/taskell/releases). Download it and copy it to a directory in your `$PATH` (e.g. `/usr/local/bin` or `/usr/bin`).

## Running

- `taskell`: will use `taskell.md` in the pwd - offers to create if not found
- `taskell filename.md`: will use `filename.md` in the pwd - offers to create if not found

## Controls

Press `?` for a [list of controls](https://github.com/smallhadroncollider/taskell/blob/master/templates/controls.md)

### Tips

- If you're using a simple two-column "To Do" and "Done" then use the space bar to mark an item as complete while staying in the "To Do" list. If you're using a more complicated column setup then you will want to use `H`/`L` to move tasks between columns.

## Storage

By default stores in a `taskell.md` file in the working directory:

```md
## To Do

- Do this

## Done

- Do That
```

## Configuration

You can edit Taskell's settings by editing `~/.taskell/config.ini`:

```ini
[general]
; the default filename to create/look for
filename = taskell.md

[layout]
; the width of a column
column_width = 30

; the padding of a column
; for both sides, so 3 would give a gap of 6 between two columns
column_padding = 3

[markdown]
; the markdown to start a title line with
title = "##"

; the markdown to start a task line with
task = "-"

; the markdown to start a sub-task line with
subtask = "    *"
```

Make sure that the values in the `[markdown]` section are surrounded by **double**-quotes.

If you always use sub-tasks, an alternative setup for `[markdown]` might be:

```ini
[markdown]
title = "##"

; each task is a header
task = "###"

; subtasks are list items under the header
subtask = "-"
```

**Warning**: currently if you change your `[markdown]` settings any older files stored with different settings will not be readable.

## Theming

You can edit Taskell's colour-scheme by editing `~/.taskell/theme.ini`:

```ini
[other]

; list title
title.fg = green

; current list title
titleCurrent.fg = blue

; current task
taskCurrent.fg = magenta
```

You can also change the background and default text colour:

```ini
[default]

; the app background colour
default.bg = brightBlack

; the app text colour
default.fg = white
```

The available colours are: `black`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `white`, `brightBlack`, `brightRed`, `brightGreen`, `brightYellow`, `brightBlue`, `brightMagenta`, `brightCyan`, `brightWhite`, or `default`

---

## Roadmap

See [roadmap.md](https://github.com/smallhadroncollider/taskell/blob/develop/roadmap.md) for planned features

## Contributing

Please check the [roadmap.md](https://github.com/smallhadroncollider/taskell/blob/develop/roadmap.md) before adding any bugs/feature requests to Issues.
