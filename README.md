# micropython-builder

## Contents

1. [Overview](#overview)
1. [Platforms and firmware](#platforms-and-firmware)
1. [Contributing and issues](#contributing-and-issues)

## Overview

`micropython-builder` is a project aiming to bring [ulab](https://github.com/v923z/micropython-ulab/)
to those microcontrollers that are supported by `micropython`. Every second day, the github CI automatically
clones the latest `micropython`, and `ulab` repositories, compiles the firmware, and uploads the binary files to
[Releases](https://github.com/v923z/micropython-builder/releases).

The github [workflow file](https://github.com/v923z/micropython-builder/blob/main/.github/workflows/build.yml)
simply calls the platform-specific [build scripts](https://github.com/v923z/micropython-builder/tree/main/scripts)
one after the other, and contains no other steps. By resorting to this design, we definitely miss out on many
github features and actions, but this approach results in build steps that can easily be reproduced on any linux
computer. We hope that by offering the community build scripts that are proven to run on a freshly
installed system, much frustration can be avoided.

[Contents](#contents)

## Platforms and firmware

Unless otherwise specified, firmware is built with default settings (i.e., those given in the mpconfigboad.h file),
and with support for 2-dimensional complex arrays. On platforms, where flash size is a concern, the firmware details
can be read out of the corresponding build script.

Each binary file is named after the board on which it is supposed to run, and, in addition, contains the short
git hash of `micropython`, and the short git hash of `ulab`, so that by inspecting the name of the binary, it is always
possible to determine, which [micropython](https://github.com/micropython/micropython/commits/master), and
[ulab](https://github.com/v923z/micropython-ulab/commits/master) commits, respectively, are included.

[Contents](#contents)

## Contributing and issues

If your board is not listed, but you would like to see it here, you can submit a build script by means of a
[pull request](https://github.com/v923z/micropython-builder/pulls). Alternatively, you can open an
[issue](https://github.com/v923z/micropython-builder/issues) with the specifications of your board. Note that,
by definition, only those boards can be included in the CI that are supported by `micropython`.

### Testing a build process on github

If you have a script that compiles the firmware on the local computer, you can easily test it on github.
All you have to do is fork this repository, and create a branch called `testing` on your copy. In
`.github/workflows/template.yml`, add a link to your script, and create a pull request against your `master` branch.
This should trigger the job to run. Your script should complete without errors, and at the end of the workflow run,
you should see the artifacts listed. Once you are satisfied with the results, you can open a pull request against
this repository.


[Contents](#contents)
