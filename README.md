# kubectl-alias

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
# Avada Kedavra: A complicated curse
kubectl alias avada-kedavra 'delete --all pods'

kubectl avada-kedavra --force=true --wait=false
```

## Installation

### Homebrew

1. Install [Homebrew](https://brew.sh/).

2. `brew install predatorray/brew/kubectl-alias`

3. Make sure the `alias/` is added to your `PATH`.

### Manually

1. Download the [latest release](https://github.com/predatorray/kubectl-alias/releases/latest).

2. Unpack the kubectl-alias-*.tar.gz file and copy all the files to a directory, `/usr/local/kubectl-alias` for instance.

3. Add the `bin/` and the `alias/` directories to `PATH`. For example, add this line to your rc file: `export PATH="$PATH:/usr/local/kubectl-alias/bin:/usr/local/kubectl-alias/alias"`.

4. (for Mac users) Install GNU `getopt` if it is not running on GNU-Linux. After that, add this line `export GNU_GETOPT_PREFIX="path/to/gnu-getopt"` to your rc file.

### Usage

#### Create an alias

```sh
kubectl alias ALIAS COMMAND

kubectl alias -N ALIAS COMMAND
kubectl alias --no-args ALIAS COMMAND
```

The `-N, --no-args` flag TBD.

#### Delete an alias

```sh
kubectl alias -d ALIAS
kubectl alias --delete ALIAS
```
#### List all the alias

```sh
kubectl alias -l
kubectl alias --list
```
