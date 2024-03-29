## Horovod in Conda

See step by step details to build _**HOROVOD**_ with `conda` environment in `singularity/horovod/hvd.md` file. 

Following is the summary of instructions specific to `exatrkx` environment (same but with additional packages). Intructions are located in `singularity/horovod/exatrkx.md`.

## Summary (exatrkx)
---

- **NOTE:** [According to Official Guide](https://horovod.readthedocs.io/en/latest/conda.html)
- **NOTE:** Specific versions of packages are important to successfully build HOROVOD
- **NOTE:** Copy and paste commands successively.

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
# Conda Packages of SciPy, NumPy, Pandas, etc
pip install scikit-learn scipy numpy pandas matplotlib seaborn jupyterlab notebook jupyter-tensorboard tqdm pyyaml ipywidgets
```

### (+) - Install Deep Learning Frameworks
---

```bash
# Pip Packages of Frameworks + Additional 
pip install tensorflow-gpu==2.3.0
pip install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html
pip install pytorch-lightning==1.0.2 faiss-gpu==1.6.3 graph_nets==1.1
```
**_NOTE:_** `faiss-gpu==1.6.3`, higher version doesn't work with exatrkx code (see `utils_torch.py`).


### (+) - Install PyTorch Geometric
---

Follow official documentation of [pytorch-geometric](https://pytorch-geometric.readthedocs.io/en/latest/notes/installation.html) for installation.


```bash
# cuda=10.1, pytorch=1.6.0
pip install --no-index torch-scatter -f https://pytorch-geometric.com/whl/torch-1.6.0+cu101.html
pip install --no-index torch-sparse -f https://pytorch-geometric.com/whl/torch-1.6.0+cu101.html
pip install --no-index torch-cluster -f https://pytorch-geometric.com/whl/torch-1.6.0+cu101.html
pip install --no-index torch-spline-conv -f https://pytorch-geometric.com/whl/torch-1.6.0+cu101.html
pip install torch-geometric
```
**OR**

```bash
#!/bin/bash
CUDA=cu101
TORCH=1.6.0
pip install torch-scatter -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-sparse -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-cluster -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-spline-conv -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-geometric
```

### (+) - Install Horovod
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

### (+) - Post Build
---

```bash
# post build
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