
## FAIR/GSI Frameworks


- FairSoft
- FairRoot
- PandaRoot


```bash
# Configure PandaRoot
cmake -S ./src -B ./build -DCMAKE_INSTALL_PREFIX=./install

# Build PandaRoot
cmake --build ./build -j8

# Install PandaRoot
cmake --install ./build
```


