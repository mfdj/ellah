### rbenv

- `set -e` to automatically bail on errors
- reads `$RBENV_DEBUG` to turn on debugging which is activated with `set -x` and exporting `PS4` [with custom info](http://www.thegeekstuff.com/2008/09/bash-shell-take-control-of-ps1-ps2-ps3-ps4-and-prompt_command/)
- defines an `abort` function that mostly makes sense 
	- with arguments simply prints them before exiting
	- without arguments does `cat -` which is cating stdin?
- creates `abs_dirname` to get the root-path the script is sitting in
	- tries to replace the builtin **realpath** (of [coreutils](https://www.gnu.org/software/coreutils) fame) but provides a shim
- ensures `$RBENV_ROOT` is set and exported (defaults to `~/.rbenv`) and doesn't end with a slash
- ensures `$RBENV_DIR` is set and exported (defualts to the directory where the `rbenv` command was invoked
- enables **nullglob** `shopt -s nullglob`
- creates `bin_path` which is the `abs_dirname` of the `rbenv` script (i.e. for homebrew installs it's always `/usr/local/Cellar/rbenv/< version >/libexec`) and prefixes it to a a newly exported `$PATH`
	- (see below for expansion of why this is significant) 
	- creates `$RBENV_HOOK_PATH` which is a $PATH-like variable with semicolon seperated list of values
- disables **nullglob** `shopt -u nullglob` because case statement follows below
- case proxies
	- `nothing`: show version info and help
	- `v | version`: just version
	- `h | help`: just help
	- `*`: resolves it to a prefixed command
		- `qbert` would resolve to `rbenv-qbert` and would abort execution since it probably doesn't exist in the path
	- **note** the secrete sauce to rbenv's module loading is that `/usr/local/Cellar/rbenv/< version >/libexec` is part of the `$PATH` in the `rbenv` script's context. `libexec` is a bunch of scripts prefixed `rbenv-…` so throughout all of the `rbenv` modules other modules are like normal commands but have the obvious `rbenv-…` namespace; this is cool because it's easy to find a given module by it's name/filename and it's auotloaded without manually sourcing because all modules are part of the $PATH in the `rbenv` script context
	- example: in order to run a given module like `rbenv-versions` you conventionally just run `rbenv verisons` (hai unit-testable!)
	- to recap the rbenv context exports the following environment-variables
		- mutated `$PATH` with the rbenv's plugins and libexec folders prepended
		- `$RBENV_ROOT` the location of the shims, built ruby versions, plugins
		- `$RBENV_DIR` the location where the `rbenv` command was invoked
		- `$RBENV_HOOK_PATH` (local plugins for rbenv, conventionaly inside RBENV_ROOT) and `$RBENV_DEBUG` (whether to print debug info, true by default) 

### rbenv-exec

Every rbenv shim is roughly this:

```
$ which ruby
/Users/markfox/.rbenv/shims/ruby

$ cat $(which ruby)
#!/usr/bin/env bash
set -e
[ -n "$RBENV_DEBUG" ] && set -x

program="${0##*/}"
if [ "$program" = "ruby" ]; then
  for arg; do
    case "$arg" in
    -e* | -- ) break ;;
    */* )
      if [ -f "$arg" ]; then
        export RBENV_DIR="${arg%/*}"
        break
      fi
      ;;
    esac
  done
fi

export RBENV_ROOT="/Users/markfox/.rbenv"
exec "/usr/local/Cellar/rbenv/1.0.0/libexec/rbenv" exec "$program" "$@"
```

A couple of notes about the above script:

- `$0` equals **/Users/markfox/.rbenv/shims/ruby**
- `${0##*/}` equals **ruby** so `$program` is the shimmed-executable 
	- **gem**, **bundler**, and the following were also shimmed on my system: _guard-core, airbrake, anemone, autospec, aws.rb, b2json, bundle, byebug, cap, capify, casperjs, cc-tddium-post-worker, cdiff, coderay, colortab, compass, coveralls, cucumber, decolor, dotenv, embedly_extract, embedly_objectify, embedly_oembed, embedly_preview, erb, erubis, fission, fog, foreman, guard, haml, honeybadger, html2haml, htmldiff, httparty, httpclient, irb, j2bson, kramdown, launchy, ldiff, listen, livingstyleguide, mongrel_rpm, neo4j-jars, newrelic, newrelic_cmd, nokogiri, nrdebug, oauth, posix-spawn-benchmark, powerbar-demo, pry, pry-remote, puma, pumactl, rackup, rails, rake, rbvmomish, rdoc, redcarpet, restclient, ri, rspec, rubocop, ruby, ruby-parse, ruby-rewrite, ruby_parse, ruby_parse_extract_error, safe_yaml, sass, sass-convert, scss, sdoc, sdoc-merge, setup, sidekiq, sidekiqctl, spring, sprockets, term_display, term_mandel, terminal-notifier, testrb, thin, thor, tilt, tt, unicorn, unicorn_rails, update_rubygems, wraith, yard, yardoc, yri
- therefore every `$program` is executed with **rbenv-exec** with the original arguments passed to the shim
- it uses POSIX `exec` to replace the current process with a new one
	- a simple test is to do `exec ls` which executes ls and the ends the shell session
	- in a script `exec ls; echo "no-op"` will do the ls but won't echo no-op :-P
	- in this way the shim-script is no longer in play and the shimmed program is the new process

**So what does rbenv-exec do?**

- basic `set -e` and `set -x` on debug
- checks for `--complete` flag and execs to `rbenv-shims --short`
	- ?
- exports `$RBENV_VERSION` to the result of `rbenv-version-name`
- grabs `$RBENV_COMMAND` from `$1` (i.e. whatever `$program` was passed in the shim)
	- shows help if empty
- run `rbenv-which $RBENV_COMMAND` and capture it's full-path in `$RBENV_COMMAND_PATH` and it's dir in `$RBENV_BIN_PATH`
- runs all pre-hooks related to exec (apparently no post-hooks?)
- checks if `$RBENV_VERSION` is `system` and if it isn't then adds `$RBENV_BIN_PATH` to `$PATH`
	- **NOTE:** this is how rbenv resolves specific vesions by prefixing the path dynamically
- execs the given command under the new-path-context
	- for instance running `ruby` and inserting `echo $PATH | tr ':' '\n'` right before the exec call I can see `/Users/markfox/.rbenv/versions/2.3.1/bin` is first in `$PATH` when `$RBENV_COMMAND_PATH` is `/Users/markfox/.rbenv/versions/2.3.0/bin/ruby` — that way any gems referenced during execution resolve themselves as well
	- TODO: check out why exactly `exec -a $RBENV_COMMAND …` is needed

### rbenv-init

```
rbenv init
```

prints the snippet for bootstrapping in `.bash_profile`

```
eval "$(rbenv init -)"
```

Which can also be handled cleanly with `rbenv init - >> ~/.bash_profile` although you lose some dynamic behavior since `rbenv init -` outputs something like:

```
export PATH="/Users/markfox/.rbenv/shims:${PATH}"
export RBENV_SHELL=bash
source '/usr/local/Cellar/rbenv/1.0.0/libexec/../completions/rbenv.bash'
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}
```

Which dynamically adds shims to the path, set's the shell and it's completions, and the rbenv-function which proxies `/usr/local/bin/rbenv` except for `rehash` and `shell` which use eval to dynamically run scripts in the current shell context.

### add rbenv-use plugin

```
mkdir ~/.rbenv/plugins
cd $_
git clone https://github.com/rkh/rbenv-whatis.git
git clone https://github.com/rkh/rbenv-use.git
```

In my case I had to `dotfiles setup` since `rbenv init -` bootstraps shell-plugins using the afore-mentioned `rbenv()` shell helper.

After I can do 

```
rbenv use 2.3
rbenv use 2.2
```

But is still requires manual installation if you don't have the newest version like `rbenv install 2.3.1` and `rbenv install 2.2.5`

### More Cool

- `https://github.com/rbenv/rbenv-vars` to get dotenv functionality 
- `https://github.com/rbenv/rbenv-each` to run against all known versions
