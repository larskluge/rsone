# rsone

Prints one entry of a Redis Stream to stdout, randomly or user-defined.


## Usage

```
rsone <stream> [<key>] [<field>]
```

If no key is defined an entry is randomly chosen.
If no field is defined all fields and values are printed.

First the location of a value is printed to stderr (stream, key, and field) then the value to stdout.


## Example

```sh
rsone foo | jq
# foo 123 bar
# {
#   "baz": 42
# }
```
