# post_process

Post process code generated by OpenAPI Generator.

Often, you want to slightly modify the code generated by OpenAPI Generator with a few find and replace tasks.

`post_process` automates this process with a configuration file.

It might support more task types in the future.

## Installation

### Install from Git

Add the following to shard.yaml

```yaml
development_dependencies:
  post_process:
    github: cyangle/post_process
    version: ~> 0.1.0
```

## Usage

Run `post_process` binary within your project to find and replace strings with regex patterns.

## Configuration

Default configuration file is `.post_process.yml`.
It allows to configure multiple find and replace tasks.

Example configuration file:

```yaml
tasks: # Required, an array of find and replace tasks.
  -
    name: 'Remove common method prefix "drive_[api_name]_"' # Required, name of the task.
    file_glob: './src/google_drive/api/*.cr' # Required, file path glob pattern for the files to be processed.
    pattern: 'drive_%{api_name}_' # Required, string template for the regex pattern to find strings to change, supports interpolation.
    new_value: 'Drive_%{capitalized_api_name}_' # Required, string template for the new string to replace the ones found by the pattern, supports interpolation.
    multi_line: false # Optional, whether to match multiple lines, default to false.

```

For each file, before processing, `pattern` and `new_value` would be interpolated with below two variables:

- `api_name`
- `capitalized_api_name`

Given example file path `src/google_drive/api/files_api.cr`, the `api_name` for this file is `files`, and the `capitalized_api_name` for this file is `Files`.

the above configuration file after interpolation:

```yaml
tasks: # Required, an array of find and replace tasks.
  -
    name: 'Remove common method prefix "drive_[api_name]_"' # Required, name of the task.
    file_glob: './src/google_drive/api/files_api.cr' # Required, file path glob pattern for the files to be processed.
    pattern: 'drive_files_' # Required, string template for the pattern to find strings to change, supports interpolation.
    new_value: 'Drive_Files_' # Required, string template for the new string to replace the ones found by the pattern, , supports interpolation.
    multi_line: false # Optional, whether to match multiple lines, default to false

```

## Development

Install dependencies

```shell
shards
```

Run the tests:

```shell
crystal spec
```

Run lints

```shell
./bin/ameba
crystal tool format --check
```

## Contributing

1. Fork it (<https://github.com/cyangle/post_process/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chao Yang](https://github.com/cyangle) - creator and maintainer
