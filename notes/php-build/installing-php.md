### [phptherightway - getting_started](http://www.phptherightway.com/#getting_started)

- homebrew
- macports
- [phpbrew](http://phpbrew.github.io/phpbrew/) **much better**
- [from source](http://php.net/manual/en/install.unix.apache2.php) **good to know**
- [php-osx.liip.ch](http://php-osx.liip.ch/) **bad**
  - installer scripts over http: `curl -s http://php-osx.liip.ch/install.sh | bash -s 5.6`
  - source of [php-osx.liip.ch/install.sh](http://php-osx.liip.ch/install.sh) states that OSX 10.10 is experimental 
  - requires sudo to install binaries into `/usr/local`
- compile from source
- all in one installers: mamp / xamp - *never again*
 
## Healthy looking 

### [homebrew/php](https://github.com/Homebrew/homebrew-php)

The gold standard for consistency in OSX. Hard to build seperate parallel versions.

### [php-build/php-build](https://github.com/php-build/php-build)

Based on [ruby-build](https://github.com/rbenv/ruby-build) and actively maintained.

### [phpbrew/phpbrew](https://github.com/phpbrew/phpbrew)

Very complete, but not foolproof. Requires OSX users to install some pre-requisite tools. Had problems installing GD for instance, because it requires that XQuartz be installed. Other issues like this.

## Deprecated

### [phpenv/phpenv](https://github.com/phpenv/phpenv)

Has some interesting features. Heavily inspired by rbenv + ruby-build (the architecture is a 1:1 port). Clearly decomposing, Last commit was 2013 and definitely wasn't able to install with it. 

Kind of interesting, they mention [ccache](https://github.com/phpenv/phpenv#phpenv-install) as a way to speed up failed builds.

Same group proposed [phpenv-virtualenv](https://github.com/phpenv/phpenv-virtualenv) which is also stale.

### [CHH/phpenv](https://github.com/CHH/phpenv)

Got it working. A definite hack-job that wraps rbenv: many of the prompts say rbenv and ruby on them. Uses `php-build` to do the building.
