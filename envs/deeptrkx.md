## (1) - Creating Environment

```bash
# tf.yaml (bleeding edge)
conda create --name tf --clone base -y
conda activate tf
pip install --upgrade pip
pip install tensorflow pandas jupyterlab tqdm matplotlib bokeh
```

```bash
# tfp.yaml (specific versions)
conda create --name tfp --clone base -y
conda activate tfp
pip install --upgrade pip
pip install tensorflow==2.3.0 pandas jupyterlab tqdm matplotlib bokeh
	
# OR (available version on conda)
conda install -c anaconda tensorflow pandas jupyterlab tqdm matplotlib bokeh
```

```bash
# tfg.yaml (GPU, specific versions)

# METHOD 1: tensorflow-gpu==2.3.0 (proper **cuDNN** and **CUDA** versions)
conda create --name tfg --clone base -y
conda activate tfg
pip install --upgrade pip
pip install tensorflow-gpu==2.3.0 pandas jupyterlab tqdm matplotlib bokeh

# METHOD 2: tensorflow==2.3.0 (manually install proper **cuDNN** and **CUDA** versions)
# See [Tested build configurations](https://www.tensorflow.org/install/source#tested_build_configurations)
conda search cudatoolkit
conda install cudatoolkit=10.1.243 -y
conda search cudnn
conda install cudnn=7.6.0=cuda10.1_0 -y
pip install tensorflow==2.3.0 pandas jupyterlab tqdm matplotlib bokeh
```

## (2) - Installing TensorFlow

- **name:** deeptrkx/tf

```bash
# create environment
conda create --name deeptrkx python=3.8
conda activate deeptrkx

# Above command is composit of three commands.
conda create --name deeptrkx
conda activate deeptrkx
conda install python=3.8
```	

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
conda env export --name deeptrkx > deeptrkx.yaml

# OR from inside of activated environment
conda activate deeptrkx
conda env export > deeptrkx.yaml
```