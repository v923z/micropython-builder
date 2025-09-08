# micropython-builder

Bleeding edge `micropython` firmware with `ulab` included.
## Contents

1. [Overview](#overview)
1. [Platforms and firmware](#platforms-and-firmware)
1. [Compiling locally](#compiling-locally)
1. [Contributing and issues](#contributing-and-issues)
    1. [Testing the build process on github](#testing-the-build-process-on-github)

## Overview

This project aims to bring [ulab](https://github.com/v923z/micropython-ulab/)
to those microcontrollers that are supported by `micropython`. Every second day, the github CI automatically
clones the latest `micropython`, and `ulab` repositories, compiles the firmware, and uploads the binary files to
[Releases](https://github.com/v923z/micropython-builder/releases).

The github [workflow file](https://github.com/v923z/micropython-builder/blob/main/.github/workflows/build.yml)
simply calls the platform-specific [build scripts](https://github.com/v923z/micropython-builder/tree/main/scripts)
one after the other, and contains no other steps. This approach results in build steps that can easily be
reproduced on any linux computer. We hope that by offering the community build scripts that are proven
to run on a freshly installed system, we can significantly lower the threshold to firmware customisation.

[Contents](#contents)

## Platforms and firmware

Unless otherwise specified, firmware is built with default settings (i.e., those given in the `mpconfigboad.h` file),
and with support for 2-dimensional complex arrays. On platforms, where flash size is a concern, the dimensionality
might be reduced, complex support might be switched off, and certain functions might be excluded from the firmware.
Compilation details, pre-processor switches etc., can always be read out of the corresponding build script. Again,
the build scripts are the only place holding information on the binary output.

Each firmware file is named after the board on which it is supposed to run, and, in addition, the binary contains
the short git hash of `micropython` (in `micropython`'s welcome prompt), and the short git hash of `ulab`
(in the `ulab.__sha__` variable). Hence, it is always possible to determine,
which [micropython](https://github.com/micropython/micropython/commits/master), and
[ulab](https://github.com/v923z/micropython-ulab/commits/master) commits, respectively, are included by looking at the 
`micropython` welcome prompt, and then 

```python
import ulab
ulab.__sha__
```

[Contents](#contents)

## Compiling locally

If you would like to compile (or customise) the firmware on a local machine, all you have to do is clone this repository
with

```bash
git clone https://github.com/v923z/micropython-builder.git
```

then

```bash
cd micropython-builder
```

and there run

```bash
./scripts/some_port/some_board.sh
```

The rest is taken care of.

[Contents](#contents)

## Contributing and issues

If your board is not listed, but you would like to see it here, you can submit a build script by means of a
[pull request](https://github.com/v923z/micropython-builder/pulls). Alternatively, you can open an
[issue](https://github.com/v923z/micropython-builder/issues) with the specifications of your board. Note that,
by definition, only those boards can be included in the CI that are supported by `micropython`.

Issues concerning `micropython`, or `ulab` themselves should be opened in their respective repositories, i.e.,
[micropython issues](https://github.com/micropython/micropython/issues), and
[ulab issues](https://github.com/v923z/micropython-ulab/issues).

### Testing the build process on github

If you have a script that compiles the firmware on the local computer, you can easily test it on github.
All you have to do is fork this repository, and create a branch called `testing` on your copy. In
`.github/workflows/template.yml`, add a section with a link to your script, and create a pull request
against your `master` branch. Make sure you go to the Actions tab and enable workflows including binary 
builds first. Otherwise, the job will not automatically trigger when you creat the pull request. Your 
script should complete without errors, and at the end of the workflow run, you should see the artifacts 
listed. Once you are satisfied with the results, you can modify the `.github/workflows/build.yml` file 
to include the new section, and open a pull request against this repository.


[Contents](#contents)
