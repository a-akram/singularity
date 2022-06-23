## Horovod in Conda

See step by step details to build _**HOROVOD**_ with `conda` environment in `singularity/horovod/hvd.md` file. 

Following is the summary of instructions specific to `tfh` environment (same but with additional packages). Intructions are located in `singularity/horovod/tfh.md`.


## Summary (tfh)
---

- **NOTE:** [According to Official Guide](https://horovod.readthedocs.io/en/latest/conda.html)
- **NOTE:** specific versions of packages are important to successfully build HOROVOD
- **NOTE:** copy and paste commands successively.

### (+) - Creating Conda Environment
---

```bash
# create environment
# conda create --name exatrkx --clone base -y      # OR
conda create --name exatrkx python=3.8
conda activate exatrkx
```

### (+) - NVCC: Install cudatoolkit-dev when cudatoolkit isn't installed w/ APT.
---

```bash
# conda install <package>
conda install cudatoolkit-dev==10.1.243 cudnn=7.6 nccl=2.5 cupti=10.1 cmake=3.16 mpi4py=3.0 cxx-compiler=1.0 bokeh=1.4 nodejs=13
```

### (+) - NVCC: Install nvcc_linux-64 package when cudatoolkit is installed w/ APT.
---

```bash
# Conda Packages of NVCC, CuDNN, NCCL, etc. (cudatoolkit installed w/ apt.)
$ conda install nvcc_linux-64=10.1 cudnn=7.6 nccl=2.5 cupti=10.1 cmake=3.16 mpi4py=3.0 cxx-compiler=1.0 bokeh=1.4 nodejs=13
```
### (+) - Additional Conda Packages
---

```bash
# Additional Packages of SciPy, NumPy, Pandas, etc
pip install scikit-learn scipy numpy pandas matplotlib seaborn jupyterlab notebook jupyter-tensorboard tqdm pyyaml ipywidgets
```

### (+) - Install Deep Learning Frameworks
---

```bash
# TensorFlow
pip install tensorflow-gpu==2.4.0
```

### (+) Install Horovod
---

```bash
#!/bin/bash
HOROVOD_CUDA_HOME=$CUDA_HOME && \
HOROVOD_NCCL_HOME=$CONDA_PREFIX  && \
HOROVOD_CPU_OPERATIONS=MPI  && \
HOROVOD_GPU_OPERATIONS=NCCL  && \
HOROVOD_WITH_MPI=1  && \
HOROVOD_WITHOUT_GLOO=1  && \
HOROVOD_WITHOUT_PYTORCH=1  && \
HOROVOD_WITH_TENSORFLOW=1  && \
pip install horovod==0.19.* jupyterlab-nvdashboard==0.2.* jupyter-tensorboard==0.2.* --no-binary=horovod

[Worked]
```

**OR**

```bash
#!/bin/bash
HOROVOD_CUDA_HOME=$CUDA_HOME && \
HOROVOD_NCCL_HOME=$CONDA_PREFIX  && \
HOROVOD_GPU_OPERATIONS=NCCL  && \
HOROVOD_WITH_MPI=1  && \
pip install horovod==0.19.* jupyterlab-nvdashboard==0.2.* jupyter-tensorboard==0.2.* --no-binary=horovod

[SAME, Worked]
```

**OR**

```bash
#!/bin/bash
HOROVOD_CUDA_HOME=$CUDA_HOME && \
HOROVOD_NCCL_HOME=$CONDA_PREFIX  && \
HOROVOD_GPU_OPERATIONS=NCCL  && \
HOROVOD_WITH_MPI=1  && \
pip install --no-cache-dir horovod==0.19.* jupyterlab-nvdashboard==0.2.* jupyter-tensorboard==0.2.* --no-binary=horovod

[SAME, Worked]
```

### (+) Post Build

```bash
jupyter labextension install --no-build jupyterlab-nvdashboard
jupyter labextension install --no-build jupyterlab_tensorboard
jupyter lab build
```

### (+) - Check Build
---

```bash
# check build
horovodrun --check-build

Horovod v0.19.5
Available Frameworks:
    [X] TensorFlow
    [X] PyTorch
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
---
