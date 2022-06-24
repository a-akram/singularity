
## Spack Package Manager

- Latest Documentation on [spack.readthedocs.io](https://spack.readthedocs.io/en/latest/index.html)

I am interested in `Spack` environments that are similar to `Conda` environments.

```bash
# get spack
$ git clone -c feature.manyFiles=true https://github.com/spack/spack.git

# set up spack env variables
$ . spack/share/spack/setup-env.sh
```

&nbsp;

## Using Environments
Here we follow a typical use case of creating, concretizing, installing and loading an environment.


### _Summary Commands_

```bash
# installation
$ spack env activate -p <myenv>
[myenv]$ spack add py-torch@1.10.0~cuda~caffe2~valgrind
[myenv]$ spack concretize
[myenv]$ spack install

# OR, directly install (add + concretize + install)
[myenv]$ spack add py-torch@1.10.0~cuda~caffe2~valgrind
[myenv]$ spack install py-torch@1.10.0~cuda~caffe2~valgrind
```

### _(1.) Create a Named Environment_

```bash
# create a spack env
spack env create <myenv>
```

```bash
# OR from a spack.yaml env file
spack env create <myenv> spack.yaml

# OR from spack.loc env file
spack env create <myenv> spack.lock
```

### _(2.) Activate an Environment_
```bash
# Activating an Environment
$ spack env activate <myenv>
$ spack env activate -p <myenv>  # Get env prefix on terminal
[myenv]$ spack find
```

### _(3.) Deactivate an Environment_
```bash
# Deactivating an Environment
spack env deactivate              

# OR, use the shorthand as
despacktivate
```

### _(4.) Add Specs and Concretize an Environment_

```bash
# Add Specs
[myenv]$ spack add mpileaks python

# Or, do it as 
[myenv]$ spack -e <myenv> add mpileaks python
```

Once some user specs have been added to an environment, they can be concretized.

```bash
# Concretize Environment
[myenv]$ spack concretize  # -f, to force all packages to concretize once again.
```

### _(5.) Installing an Environment_

In addition to installing individual specs into an Environment, one can install the entire Environment at once using the command

```bash
[myenv]$ spack install
```

If the Environment has been concretized, Spack will install the concretized specs. Otherwise, `spack install` will first concretize the Environment and then install the concretized specs.

### _(5.) Loading an Environment_

Once an environment has been installed, the following creates a load script for it:

```bash
[myenv]$ spack env loads -r
```

This creates a file called `loads` in the environment directory. Sourcing that file in Bash will make the environment available to the user; and can be included in `.bashrc` files, etc. The `loads` file may also be copied out of the environment, renamed, etc.

&nbsp;

## Configuring Environments