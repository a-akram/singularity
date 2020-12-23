## (1) - Creating Environment

- **name:** heptrkx

```bash
# create environment
conda create -n heptrkx python=3.8
conda activate heptrkx
```
## (2) - Installing PyTorch


### (i) Install PyTorch from Anaconda using Conda
```bash
# Latest
conda install pytorch torchvision torchaudio cudatoolkit=10.1 -c pytorch

# Specific Version
conda install pytorch==1.6.0 torchvision==0.7.0 cudatoolkit=10.1 -c pytorch
```

### (ii) Install PyTorch from PyPi using Pip

```bash
# Latest
pip install torch==1.7.0+cu101 torchvision==0.8.1+cu101 torchaudio==0.7.0 -f https://download.pytorch.org/whl/torch_stable.html

# Specific Version
pip install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html
```

## (3) - Install Additional Packages

```bash
# essential packages (conda)
$ conda install scikit-learn scipy numpy pandas matplotlib seaborn bokeh jupyter tqdm pyyaml ipywidgets
$ pip install torchsummary
```
## (4) - Installing TrackML from VCS (Git)

```bash
# activate environment
conda activate heptrkx

# Inside Conda environment: $HOME/anaconda/envs/heptrkx/lib/python3.8/site-packages
pip install git+https://github.com/LAL/trackml-library.git

# Outside Conda environment: $HOME/.local/lib/python3.8/site-packages
pip install --user git+https://github.com/LAL/trackml-library.git                   
```

### * Alternative Methods to Install from VCS
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
conda env export --name heptrkx > heptrkx.yaml

# OR from inside of activated environment
conda activate heptrkx
conda env export > heptrkx.yaml
```