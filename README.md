# kubectl-alias

![GitHub release version](https://img.shields.io/github/v/release/predatorray/kubectl-alias)
![License](https://img.shields.io/github/license/predatorray/kubectl-alias)
![Github Workflow status](https://img.shields.io/github/actions/workflow/status/predatorray/kubectl-alias/ci.yml?branch=master)

The missing `alias` command for `kubectl`.

## Examples

```sh
# "v" for version
kubectl alias v version

kubectl v --client
```

```sh
# "cd" to switch namespace
kubectl alias cd 'config set-context $(kubectl config current-context) --namespace'

kubectl cd my-namespace
```

```sh
# Get Pod's YAML spec and open it with less
kubectl alias --no-args gpyl 'get pod -o yaml $1 | less'

kubectl gpyl my-pod
```

```sh
# Make kubectl awesome!
kubectl alias avada-kedavra 'delete'
kubectl alias alohomora 'exec -it $1 -- bash'
```

## Installation

### Homebrew

1. Install [Homebrew](https://brew.sh/).

2. `brew install predatorray/brew/kubectl-alias`

3. Add this line to your rc file (e.g.: `~/.bashrc`, `~/.zshrc`).
  ```sh
  export PATH="$PATH:$(brew --prefix kubectl-alias)/alias"
  ```

### Krew

1. [Install Krew](https://krew.sigs.k8s.io/docs/user-guide/setup/install/) or upgrade to its latest version using `kubectl krew upgrade`.

2. `kubectl krew index add predatorray https://github.com/predatorray/my-krew-index.git`

3. `kubectl krew install predatorray/alias`

4. Add this line to your rc file (e.g.: `~/.bashrc`, `~/.zshrc`).
  ```sh
  export PATH="$PATH:$(kubectl alias --prefix)"
  ```

### Manually

1. Download the [latest release](https://github.com/predatorray/kubectl-alias/releases/latest).

2. Unpack the `kubectl-alias-*.tar.gz` file and copy all the files to a directory, `/usr/local/kubectl-alias` for instance.

3. Add both the `bin/` and the `alias/` directories to the `PATH`. For example, add this line to your rc file: 
  ```sh
  export PATH="$PATH:/usr/local/kubectl-alias/bin:/usr/local/kubectl-alias/alias"
  ```

4. If it is not running on GNU-Linux, install the GNU `getopt`. After that, add this line `export GNU_GETOPT_PREFIX="path/to/gnu-getopt"` to your rc file.

## Usage

### Create an alias

```sh
kubectl alias ALIAS COMMAND

kubectl alias -N ALIAS COMMAND
kubectl alias --no-args ALIAS COMMAND
```

The `-N, --no-args` flag is used when the arguments should not be passed to the end of the commands. It is useful when the offset parameter is explicitly declared in the alias command. For example,

```sh
kubectl alias --no-args gpyl 'get pod -o yaml $1 | less'
```

If the flag is absent, by executing `kubectl gpyl my-pod`, the `my-pod` argument will also be passed to the `less` commnd.

```sh
# WRONG
kubectl alias gpyl 'get pod -o yaml $1 | less'
kubectl get pod -o yaml my-pod | less my-pod 
```

### Delete an alias

```sh
kubectl alias -d ALIAS
kubectl alias --delete ALIAS
```
### List all the alias

```sh
kubectl alias -l
kubectl alias --list
```


## FAQ

### `error: unknown command "ALIAS NAME" for "kubectl"`

This means that the `alias/` directory is not correctly added to the `PATH` environment variable.

Add this line to your rc file.

```sh
export PATH="$PATH:$(brew --prefix kubectl-alias)/alias"

# Or, if installed manually.
export PATH="$PATH:${PREFIX}/alias"
```

After that, run `kubectl plugin list` to check if the aliases have been loaded successfully. If the alias is named `v`, the output of the plugin list will be:

```txt
The following compatible plugins are available:

/usr/local/bin/kubectl-alias
/usr/local/opt/kubectl-alias/alias/kubectl-v
```

## Support

Please feel free to [open an issue](https://github.com/predatorray/kubectl-alias/issues/new) if you find any bug or have any suggestion.
