
## Environments

## (1) - TensorFlow
For releases 1.15 and older, CPU and GPU packages are separate. The TensorFlow 2.x **pip** package includes both CPU and GPU support for CUDA®-enabled cards, see instruction on official install guide.

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

# METHOD 2: Available Packages on Anaconda
conda install -c anaconda cudnn tensorflow==2.3.0=gpu* -y
```
### NOTE

```bash
conda create --name tfg tensorflow-gpu==2.3.0 

# Above command is composit of three commands.
conda create --name tfg
conda activate tfg
conda install tensorflow-gpu==2.3.0
```	

```bash
# tfh.yaml (No GPU, with HOROVOD)
conda create --name tfh --clone base -y
conda activate tfh
pip install --upgrade pip
pip install tensorflow==2.3.0 pandas jupyterlab tqdm matplotlib bokeh

# Plus Horovod + Dependencies
# See Official Guide
```

## (2) - PyTorch

```bash
# pytc.yaml: from conda
conda install pytorch torchvision torchaudio cpuonly -c pytorch
conda install pytorch torchvision torchaudio cudatoolkit=10.1 -c pytorch
```

```bash
# pytp.yaml: from pip
pip install torch==1.7.0+cpu torchvision==0.8.1+cpu torchaudio==0.7.0 -f https://download.pytorch.org/whl/torch_stable.html
pip install torch==1.7.0+cu101 torchvision==0.8.1+cu101 torchaudio==0.7.0 -f https://download.pytorch.org/whl/torch_stable.html
```

## (3) - Horovod

```bash
# tfh.yaml: similar to tfg.yaml + HOROVOD	
```

## (4) - Exa.TrkX

```bash
# exatrkx.yaml: from pip (specific versions)	
pip install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html
conda install cudatoolkit=10.1.243 -y
conda install cudnn=7.6.0=cuda10.1_0 -y
pip install tensorflow-gpu==2.3.0 pandas jupyterlab tqdm matplotlib bokeh
```


	
