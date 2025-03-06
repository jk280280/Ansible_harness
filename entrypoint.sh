echo -e '#!/bin/sh\n\necho "Starting Container..."\nexec "$@"' > entrypoint.sh
chmod +x entrypoint.sh
