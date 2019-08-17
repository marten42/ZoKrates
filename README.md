
<img src="http://www.redaktion.tu-berlin.de/fileadmin/fg308/icons/projekte/logos/ZoKrates_logo.svg" width="100%" height="180">

# ZoKrates

[![Join the chat at https://gitter.im/ZoKrates/Lobby](https://badges.gitter.im/ZoKrates/Lobby.svg)](https://gitter.im/ZoKrates/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![CircleCI master](https://img.shields.io/circleci/project/github/Zokrates/ZoKrates/master.svg?label=master)](https://circleci.com/gh/Zokrates/ZoKrates/tree/master)
[![CircleCI develop](https://img.shields.io/circleci/project/github/Zokrates/ZoKrates/develop.svg?label=develop)](https://circleci.com/gh/Zokrates/ZoKrates/tree/develop)

ZoKrates is a toolbox for zkSNARKs on Ethereum.

_This is a proof-of-concept implementation. It has not been tested for production._

## Getting Started

```bash
curl -LSfs get.zokrat.es | sh
```

Have a look at the [documentation](https://zokrates.github.io/) for more information about using ZoKrates.  
A getting started tutorial can be found [here](https://zokrates.github.io/sha256example.html).

## Getting Help

If you run into problems, ZoKrates has a Gitter room. You can come ask for help on [Gitter](https://gitter.im/ZoKrates/Lobby).

## License

ZoKrates is released under the GNU Lesser General Public License v3.

## Contributing

We happily welcome contributions. You can either pick an existing issue, or reach out on [Gitter](https://gitter.im/ZoKrates/Lobby).

Unless you explicitly state otherwise, any contribution you intentionally submit for inclusion in the work shall be licensed as above, without any additional terms or conditions.

## Using a sample development image

Entrypoint script is included as part of the build image. Run the following instruction for usage:
`docker run -itd kartheek14/zokrates_dev:081419 help`
There are individual commands to substitute for 'help' above: `all, compile, compute-witness, export-verifier, generate-proof, output, setup`.
`all`: Runs all steps in sequence for compiling code, to proof generation and storing results to a local dir.
Example: `docker run -itd kartheek14/zokrates_dev:081419 all`
`compile`: Runs Zokrates built-in compiler to compile the code in a local dir (`/home/zokrates/zok_code` or `/home/zokrates/examples`) to saves the output files within the container. Takes in a single argument which is the path to the local code file.
Example: `docker run -itd kartheek14/zokrates_dev:081419 compile /examples/factorization.code`
`compute-witness`: Runs witness generation and saves outputs locally within the container.
Example: `docker run -itd kartheek14/zokrates_dev:081419 compute-witness 6 2 3`
`export-verifier, generate-proof, setup`: These comamnds execute the trusted set up, generation of proofs, and exporting verifier code as output locally within the container.
`output`: Moves the files on the root dir of the container to a mountable `/home/zokrates/output` within the container.

Note that each of the above commands except for `all`, would only result in partial outputs, and would need to be run sequentially either by running the container in -d mode appending something like `&& tail -f /dev/null` to the entrypoint arguments.