# gnupg-scdaemon-shared-access 👫 🔑

A script to install gnupg2 with the GPGTools scdaemon shared-access patch

## How To

- Install [MacPorts](https://www.macports.org)
- Sanity check [the script](https://github.com/felddy/gnupg-scdaemon-shared-access/blob/master/install_gnupg2.sh) in this repo.
- If you trust what you read execute:
  - `curl https://raw.githubusercontent.com/felddy/gnupg-scdaemon-shared-access/master/install_gnupg2.sh | bash`
- Add `shared-access` to your `.gnupg/scdaemon.conf`
- Insert your token.
- `killall -9 gpg-agent; gpg --card-status`

## The Problem

On Mac OS X, `tokend` connects to a token immediately upon its insertion, which is necessary to present the token as a (PIV) keychain in the Keychain Access, and make its keys/certificates otherwise available to the Mac OS X applications.

However, when you try to use `gpg`, `scdaemon` detects that the token is already being used - and refuses to connect to it. [GPGTools](https://gpgtools.org) patched `scdaemon` to support a shared-access mode, but the pull request was [not accepted upstream](https://dev.gnupg.org/T3267).

This script will apply that patch to a MacPorts `Portfile` and install `gnupg2` with the shared functionality.

For more information see:

- https://dev.gnupg.org/T3267
- https://github.com/OpenSC/OpenSC/issues/953
- https://github.com/GPGTools/MacGPG2/blob/dev/patches/gnupg/scdaemon_shared-access.patch
