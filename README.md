
# SHD-FormalVerificationRec

This repository provides the start code for the [Formal Verification of RTL Implementation Recitation](http://csg.csail.mit.edu/6.S983/recs/formal_recitation/) of Secure Hardware Design Course at MIT.




## Environment Setup

To setup with docker:

```shell
cd SHD-FormalVerificationRec
docker-compose up -d
docker-compose exec env bash
cd /vagrant
# docker-compose down --rmi all  # Clean up everything when you finish
```

You can test the environment with `cd framework && python3 scripts/v2rkt.py && python3 scripts/veri.py && cd ..`.
It should print an execution trace and say "No Counterexample".




## Run the Code

Please follow the instructions on the [recitation webstie](http://csg.csail.mit.edu/6.S983/recs/formal_recitation/).

