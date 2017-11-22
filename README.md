# Taskell

A CLI task manager, written in Haskell

- Tasks stored in a `json` file in the current working directory - for easy version control
- Uses `vim` style key-bindings

## Controls

- `a` add a task (`Enter`/`Esc` to stop)
- `e` edit a task (`Enter`/`Esc` to stop)
- `Space`: mark as complete
- `j`: move down
- `k`: move up
- `h`: move left 
- `l`: move right
- `J`: shift task down
- `K`: shift task up
- `q`: quit

## Storage

Stores in a local `taskell.json` file:

```json
[
    {
        "completed": true,
        "description": "Do this"
    },
    {
        "completed": false,
        "description": "Do that"
    }
]
```

---

## Roadmap

### 0.2

- cursor support
- better layout
- scrolling long lists
- add tags/labels to tasks
- filter by tag/label
- delete with `dd`

### 0.3

- multiple lists?
- undo with `u`
- run with a filename to open any file
- 'o' open file
