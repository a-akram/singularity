## (1) - Creating Environment

- **name:** tfg

Create environemnt from scratch either using _`conda`_ or _`anaconda-navigator`_.

```bash
# create environment
conda create --name tfg python=3.8

# Above is a composite command
conda create --name tfg
conda activate tfg
conda install python=3.8
```	
OR, we can `clone` the `base` environment which have many packages installed already.

```bash
# clone the base environment
conda create --name tfg --clone base -y
conda activate tfg
pip install --upgrade pip
```

## (2) - Installing TensorFlow with CUDA
### (+) CUDA, CuDNN, etc
For proper versions, see [Tested build configurations](https://www.tensorflow.org/install/source#tested_build_configurations)

```bash
# search & install cudatoolkit
conda search cudatoolkit
conda install cudatoolkit=10.1.243 -y

# search & install cudnn
conda search cudnn
conda install cudnn=7.6.0=cuda10.1_0 -y
```
### (+) Install TensorFlow from Anaconda using Conda

```bash
# Latest
conda install tensorflow-gpu

# Specific Version
conda install tensorflow-gpu==2.3.0
```
### (+) Install TensorFlow from PyPi using Pip

```bash
# Latest
pip install tensorflow-gpu

# Specific Version
pip install tensorflow-gpu==2.3.0
```
## (3) - Install Additional Packages

```bash
# essential packages (conda)
conda install scikit-learn scipy numpy pandas matplotlib seaborn jupyter tqdm pyyaml ipywidgets
```
## (4) - Installing TrackML from VCS (Git)

```bash
# activate environment
conda activate deeptrkx

# Inside Conda environment: $HOME/anaconda/envs/heptrkx/lib/python3.8/site-packages
pip install git+https://github.com/LAL/trackml-library.git

# Outside Conda environment: $HOME/.local/lib/python3.8/site-packages
pip install --user git+https://github.com/LAL/trackml-library.git                   
```
### (+) Alternative Methods to Install from VCS
There are other ways to instsall packages from VCS (Git, Gitlab, etc), see details in `workspace/linux/pip.md` or gist named `pip-install.md` on GitHub. 

```bash
# Installing from Tarball/Zip
pip install https://github.com/LAL/trackml-library/tarball/main   

# Following PEP440 Refs.                             
pip install trackml@https://github.com/LAL/trackml-library/tarball/master#egg=trackml-3    
pip install "trackml@ https://github.com/LAL/trackml-library/tarball/master#egg=trackml-3"
pip install trackml@git+https://github.com/LAL/trackml-library.git@master
```
## (5) - Export Environment File

```bash
# From outside of deactivated environment
conda env export --name tfg > tfg.yaml

# OR from inside of activated environment
conda activate tfg
conda env export > tfg.yaml
```
