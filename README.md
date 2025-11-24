# Moccasin Project

🐍 Welcome to your Moccasin project!

## Quickstart

1. Run Tests on a fake chain using the batch script or run

```bash
mox test
```

2. Test Coverage using commands

```bash
mox test --coverage
```

3. To run tests or deploy anything on actual/forked chain, create and .env file providing your own RPC, and include the address for the VRF_Coordinator and VRF_Wrapper found here https://docs.chain.link/vrf/v2-5/supported-networks. Then to run for the forked version, use the batch file provided (remember to provide your own wallet and add into mox) or:

```bash
mox test --network sepolia --fork
```

_For documentation, please run `mox --help` or visit [the Moccasin documentation](https://cyfrin.github.io/moccasin)_
