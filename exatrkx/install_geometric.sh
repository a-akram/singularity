#!/bin/bash
export CUDA=cu101
export TORCH=1.6.0

pip install torch-scatter -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-sparse -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-cluster -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-spline-conv -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-geometric

# OR add --no-index during install.

# pip install --no-index torch-scatter -f https://pytorch-geometric.com/whl/torch-1.6.0+cu101.html
# pip install --no-index torch-sparse -f https://pytorch-geometric.com/whl/torch-1.6.0+cu101.html
# pip install --no-index torch-cluster -f https://pytorch-geometric.com/whl/torch-1.6.0+cu101.html
# pip install --no-index torch-spline-conv -f https://pytorch-geometric.com/whl/torch-1.6.0+cu101.html
# pip install torch-geometric
