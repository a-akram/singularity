## Horovod in Conda

Follow the guides 

- https://horovod.readthedocs.io/en/stable/conda.html
- https://towardsdatascience.com/building-a-conda-environment-for-horovod-773bd036bf64


First creat a conda environment using conda or anaconda-navigator. Activate the environment: **_horovod_**.

```bash
# activate environment
$ conda activate horovod
```

## (1) Install CUDA + NVCC, CuDNN, NCCL, CUPTI

- NCCL and CuDNN are available on Anaconda
- Horovod Needs [NVCC](https://docs.nvidia.com/cuda/archive/10.1/cuda-compiler-driver-nvcc/index.html)

There are two ways to get NVCC along with CUDATOOLKIT.

#### (a) - Method # 1

- Install [CUDA 10.1](https://developer.nvidia.com/cuda-10.1-download-archive-update2) on Linux (Ubuntu) which has NVCC installed. More precisely it `10.1.243`, 2nd update.
- Install [nvcc_linux-64](https://anaconda.org/conda-forge/nvcc_linux-64) meta-package from conda-forge repository which will configure conda environment to use CUDA+NVCC from Linux OS.
- Install [CuDNN](), [NCCL]() using conda install.

```bash
$ conda install nvcc_linux-64=10.1                    # NVCC : conda search nvcc_linux-64
$ conda install cudnn=7.6.5=cuda10.1_0                # CuDNN: conda search cudnn
$ conda install nccl=2.8.3                            # NCCL : conda search nccl
$ conda install cupti=10.1                            # CUPTI: conda search cupti
```


#### (b) - Method # 2

- Install CUDATOOLKIT-dev package from conda-forge it includes NVCC as well
- Install [CuDNN](), [NCCL]() using conda install.

```bash
$ conda install cudatoolkit-dev==10.1.243             # CUDA : conda search cudatoolkit-dev 
$ conda install cudnn=7.6.5=cuda10.1_0                # CuDNN: conda search cudnn
$ conda install nccl=2.8.3                            # NCCL : conda search nccl
$ conda install cupti=10.1                            # CUPTI: conda search cupti
```

Finally, install cmake, mpi4py, cxx-compiler, bokeh etc

```bash
$ conda install cmake=3.16                            # cmake : conda search cmake
$ conda install mpi4py=3.0                            # mpi4py: conda search mpi4py
$ conda install cxx-compiler=1.1                      # cxx-compiler: conda search cxx-compiler
$ conda install bokeh=1.4                             # bokeh: conda search bokeh
```

### _(2a) - Install TensorFlow, PyTorch, TrackML_

We have now installed necessary packages for installing HOROVOD. It's time to install Deep Learning frameworks such as TensorFlow and/or PyTorch.

```bash
# TensorFlow
pip install tensorflow-gpu==2.3.0 pandas jupyterlab tqdm

# PyTorch
pip install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html

# TrackML (Tarball) OR install with --user flag.
pip install --user 'trackml@ https://github.com/LAL/trackml-library/tarball/master#egg=trackml-3'
```

### _(2b) - Exa.TrkX_

In case of EXA.TrkX project installthe following instead.

(i) - TensorFlow & PyTorch:

```bash
pip install tensorflow-gpu==2.3.0 pandas jupyterlab tqdm
pip install pytorch-lighting faiss-gpu 'graph_nets>=1.1'
pip install --user 'trackml@ https://github.com/LAL/trackml-library/tarball/master#egg=trackml-3'
```

(ii) - PyTorch Geometric:

```bash
CUDA=cu101
TORCH=1.6.0
pip install torch-scatter==latest+${CUDA} -f https://pytorch-geometric.com/whl/torch-${TORCH}.html
pip install torch-sparse==latest+${CUDA} -f https://pytorch-geometric.com/whl/torch-${TORCH}.html
pip install torch-cluster==latest+${CUDA} -f https://pytorch-geometric.com/whl/torch-${TORCH}.html
pip install torch-spline-conv==latest+${CUDA} -f https://pytorch-geometric.com/whl/torch-${TORCH}.html
pip install torch-geometric
```

### (3) - Install Horovod

- Set ENV variables for HOROVOD
- Important are MPI/GLOO, NCCL, DL Framework, etc

To install Horovod with specific settings set environment variables for Horovod, absence usually mean building with support of all possible options.

```bash
# HOROVOD
export ENV_PREFIX=$CONDA_PREFIX           # Get name of currently activated env
export HOROVOD_CUDA_HOME=$CUDA_HOME       # CUDA installation e.g. /usr/local/cuda
export HOROVOD_NCCL_HOME=$CONDA_PREFIX    # NCCL installation e.g. ~/anaconda/envs/horovod 

export HOROVOD_CPU_OPERATIONS=MPI         # MPI/GLOO/CCL for CPU tensor allreduce, allgather, and broadcast.
export HOROVOD_GPU_OPERATIONS=NCCL        # NCCL/MPI for GPU tensor allreduce, allgather, and broadcast

# Default: both will be enabled
export HOROVOD_WITH_MPI=1                 # MPI enabled. To use MPI instead of horovodrun MPI wrapper
export HOROVOD_WITHOUT_GLOO=1             # Gloo disabled. To use Gloo instead of horovodrun MPI wrapper

export HOROVOD_WITH_PYTORCH=1             # Force installation with PyTorch, use *_WITHOUT_*=1 if not needed.
export HOROVOD_WITH_TENSORFLOW=1          # Force installation with TensorFlow, use *_WITHOUT_*=1 if not needed.

pip install horovod==0.20                 # OR, how to give [tensorflow,pytorch] ???
pip install horovod[tensorflow,pytorch]   # how to give version ???
```

### (4) - Check Build

After successfully installing Horovod, run:

```bash
$ horovodrun --check-build
Horovod v0.20.0:

Available Frameworks:
    [X] TensorFlow
    [ ] PyTorch
    [ ] MXNet

Available Controllers:
    [X] MPI
    [X] Gloo

Available Tensor Operations:
    [X] NCCL
    [ ] DDL
    [ ] CCL
    [X] MPI
    [X] Gloo
```

Every feature that was successfully enabled will be marked with an ‘X’. If you intended to install Horovod with a feature that is not listed as enabled, you can reinstall Horovod, setting the appropriate environment variables to diagnose failures:


## Summary 

- [According to Official Guide](https://horovod.readthedocs.io/en/latest/conda.html)
- **NOTE:** specific versions of packages are important to successfully build HOROVOD

### (1) Install packages with NVCC

#### 1.1. NVCC: Install nvcc_linux-64 with cudatoolkit on Linux


```bash
# conda install <package>
$ conda install nvcc_linux-64=10.1 cudnn=7.6 nccl=2.5 cupti=10.1 cmake=3.16 mpi4py=3.0 cxx-compiler=1.0 bokeh=1.4 nodejs=13

'For Linux 64, Open MPI is built with CUDA awareness but this support is disabled by default.
To enable it, please set the environmental variable OMPI_MCA_opal_cuda_support=true before
launching your MPI processes. Equivalently, you can set the MCA parameter in the command line:
mpiexec --mca opal_cuda_support 1'
```

#### 1.2. NVCC: Install cudatoolkit-dev instead of cudatoolkit

```bash
# conda install <package>
conda install cudatoolkit-dev==10.1.243 cudnn=7.6 nccl=2.5 cupti=10.1 cmake=3.16 mpi4py=3.0 cxx-compiler=1.0 bokeh=1.4 nodejs=13
```

**NOTE:** Either section 1.1 or 1.2 should be considered.

### (2) Install TensorFlow

```bash
pip install tensorflow-gpu==2.3.0 pandas jupyterlab tqdm
pip install 'trackml@ https://github.com/LAL/trackml-library/tarball/master#egg=trackml-3'
```

### (3) Install Horovod

```bash
# CUDA on Linux (.bashrc or .bash_profile)
# export CUDA_HOME=/usr/local/cuda
# export PATH=$CUDA_HOME/bin:$PATH
# export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# Important HOROVOD Variables
# export ENV_PREFIX=$CONDA_PREFIX
# export HOROVOD_CUDA_HOME=$CUDA_HOME
# export HOROVOD_NCCL_HOME=$ENV_PREFIX
# export HOROVOD_GPU_OPERATIONS=NCCL

# Install HOROVOD
HOROVOD_CUDA_HOME=$CUDA_HOME && \
HOROVOD_NCCL_HOME=$CONDA_PREFIX  && \
HOROVOD_CPU_OPERATIONS=MPI  && \
HOROVOD_GPU_OPERATIONS=NCCL  && \
HOROVOD_WITH_MPI=1  && \
HOROVOD_WITHOUT_GLOO=1  && \
HOROVOD_WITHOUT_PYTORCH=1  && \
HOROVOD_WITH_TENSORFLOW=1  && \
pip install horovod==0.20 jupyterlab-nvdashboard==0.2.* jupyter-tensorboard==0.2.* --no-binary=horovod

[Worked]
```

**OR**

```bash
# Example
pip uninstall horovod
HOROVOD_CUDA_HOME=$CUDA_HOME && \
HOROVOD_NCCL_HOME=$CONDA_PREFIX  && \
HOROVOD_CPU_OPERATIONS=MPI  && \
HOROVOD_GPU_OPERATIONS=NCCL  && \
HOROVOD_WITH_MPI=1  && \
HOROVOD_WITHOUT_GLOO=1  && \
HOROVOD_WITHOUT_PYTORCH=1  && \
HOROVOD_WITH_TENSORFLOW=1  && \
pip install --no-cache-dir horovod
```


### (4) Post Build

```bash
jupyter labextension install --no-build jupyterlab-nvdashboard
jupyter labextension install --no-build jupyterlab_tensorboard
jupyter lab build
```

### (5) Check Build

```bash
horovodrun --check-build
```
