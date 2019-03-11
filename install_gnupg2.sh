#!/bin/sh
set -e -x

# This script installs a patched version of gnupg2
# The patch allows shared-access to tokens within the scdaemon

# download patch and convert from -p1 to -p0 for patch
curl https://raw.githubusercontent.com/GPGTools/MacGPG2/dev/patches/gnupg/scdaemon_shared-access.patch | sed -e 's!^--- a/!--- !' -e 's!^+++ b/!+++ !' > $(port dir gnupg2)/files/scdaemon_shared-access.diff

# extract source
port extract gnupg2

# patch the Portfile
patch --forward --ignore-whitespace --directory $(port dir gnupg2) << 'EOF'
--- Portfile	2019-03-11 11:45:29.000000000 -0400
+++ Portfile	2019-03-11 11:45:12.000000000 -0400
@@ -94,3 +94,4 @@
 livecheck.type      regex
 livecheck.url       https://gnupg.org/ftp/gcrypt/${my_name}/
 livecheck.regex     ${my_name}-(\\d+(?:\\.\\d+)*)
+patchfiles-append   scdaemon_shared-access.diff
EOF

# install gnupg2
port -d install gnupg2

# unpatch the Portfile (so we can detcted errors if rerun)
patch --forward --ignore-whitespace --directory $(port dir gnupg2) << 'EOF'
--- Portfile	2019-03-11 11:45:29.000000000 -0400
+++ Portfile	2019-03-11 11:45:12.000000000 -0400
@@ -94,4 +94,3 @@
 livecheck.type      regex
 livecheck.url       https://gnupg.org/ftp/gcrypt/${my_name}/
 livecheck.regex     ${my_name}-(\\d+(?:\\.\\d+)*)
-patchfiles-append   scdaemon_shared-access.diff
EOF
