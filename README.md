### ubuntu subsystem on mac

- you need docker installed 
- create `ubuntu.sh` and put it on `PATH` (e.g. `/usr/local/bin`) 
  Make sure that the correct username is set so the right home directory can be mounted in the subsystem.
- create `.ubunturc` and put it in user's home directory 
  (I further split the startup shell commands into one that is run on startup and one that is run when entering the subsystem's shell, so I called them `.ubuntu_launchrc` and `.ubuntu_shrc`)
- edit `.bashrc` (or `.bash_profiles`) file in home directory to allow executing 
  this shell script with a simple command, e.g. 
  ```
  alias ubuntu=./ubuntu.sh
  ```
- create a .plist file to make it run on startup using launchd 
  https://superuser.com/questions/229773/run-command-on-startup-login-mac-os-x
  I named it `ubuntu.subsystem.plist`
  put it in `/Library/LaunchAgents/`
  and run it using
  ```
  sudo launchctl load /Library/LaunchAgents/<plist file>
  ```
  so, in my case
  ```
  sudo launchctl load /Library/LaunchAgents/ubuntu.subsystem.plist
  ```

Troubleshooting resources:
- https://stackoverflow.com/questions/28063598/error-while-executing-plist-file-path-had-bad-ownership-permissions 
