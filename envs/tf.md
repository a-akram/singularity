## (1) - Creating Environment

- **name:** tf

Create environemnt from scratch either using _`conda`_ or _`anaconda-navigator`_.

```bash
# create environment
conda create --name tf python=3.8

# Above is a composite command
conda create --name tf
conda activate tf
conda install python=3.8
```	
OR, we can `clone` the `base` environment which have many packages installed already.

```bash
# clone the base environment
conda create --name tfg --clone base -y
conda activate tf
pip install --upgrade pip
```
## (2) - Installing TensorFlow
### (+) Install TensorFlow from Anaconda using Conda
```bash
# Latest
conda install tensorflow

# Specific Version
conda install tensorflow==2.3.0
```
### (+) Install TensorFlow from PyPi using Pip

```bash
# Latest
pip install tensorflow

# Specific Version
pip install tensorflow==2.3.0
```
## (3) - Install Additional Packages

```bash
# essential packages (conda)
conda install scikit-learn scipy numpy pandas matplotlib seaborn tqdm pyyaml ipywidgets jupyterlab notebook jupyter-tensorboard

# OR use Pip
pip install scikit-learn scipy numpy pandas matplotlib seaborn tqdm pyyaml ipywidgets jupyterlab notebook jupyter-tensorboard
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
conda env export --name tf > tf.yaml

# OR from inside of activated environment
conda activate deeptrkx
conda env export > tf.yaml
```