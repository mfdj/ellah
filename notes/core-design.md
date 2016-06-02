
### Design Focus

- Create isolated configurable environemnts in the PATH
- Build, switch, and manage languages, web-servers, database per environemnt 
  - first: PHP, Apache, MySQL 
  - later NGNIX Maria, Postgres, Mongo, RabbitMQ Redis…
  - allow version pinning
- Create simple expressive commands to switch, install, build
- Manage web-servers and databases auto-magically with simple commands
- Focus on modern versions and configurations that satisfy contemporary framework needs
  - to restate: *WILL NOT* a manage any version with any extension and any configurations
  - future: warn about security advisories
- OSX focused
  - BASH/POSIX-shell focused (aim to be compatible with Zsh and Fish)
  - backed by Hombrew (homebrew versions) 
  — might consider macports if there is a visbile need 
  - might be able to patch it for Debian/Ubuntu once OSX is stable
  - no plans to support Windows (open to sponsorship)
- Allow project specific versions (with non-magic command ala nvm)
- Simple manifest format that can be stored in project repos (embededd in composer.json? ini or yaml format?) making one step installs of 
