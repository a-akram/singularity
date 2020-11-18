## Singularity Container
Let's use a Singularity container provided by **SeSEGPU**.

## Create Container
	$ `sudo singularity build sesegpu.sif sesegpu_nividia.def`
	
	OR 
	
	$ `sudo singularity build --sandbox sesegpu.sif sesegpu_nividia.def`
	

## Run Container

	$ `singularity run --nv ~/current/sesegpu.sif -c "conda activate tf-gpu && jupyter lab"`

## Install TensorFlow w/ GPUs (In Def file)

**From: https://www.tensorflow.org/install/source#tested_build_configurations**
Version				Python version	Compiler	Build tools		cuDNN	CUDA
tensorflow-2.3.0	3.5-3.8			GCC 7.3.1	Bazel 3.1.0		7.6		10.1

# Create an environment
conda activate base
conda create --name tf-gpu-test --clone base -y
conda activate tf-gpu-test
conda install -c anaconda cudnn tensorflow==2.2.0=gpu* -y

# OR, custom install of cudatoolkit, cudnn and tensorflow-gpu (conda & pip)
conda search cudatoolkit
conda install cudatoolkit=10.1.168 -y

conda search cudnn
conda install cudnn=7.6.0=cuda10.1_0 -y

# Install latest version of tensorflow-gpu
pip install tensorflow-gpu

# OR install a specific version
pip install tensorflow-gpu==2.3.0

# OR, upgrade an older version to latest one.
pip install --upgrade tensorflow-gpu

# Remove Any older installation
pip uninstall tensorflow-gpu -y
