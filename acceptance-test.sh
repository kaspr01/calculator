#!/bin/bash
set -x
  
#!/bin/bash
CALCULATOR_PORT=$(docker-compose port calculator 8081 | cut -d: -f2)
test $(curl localhost:$CALCULATOR_PORT/sum?a=1\&b=2) -eq 3
