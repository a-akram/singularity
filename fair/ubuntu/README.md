
## FAIR/GSI Frameworks


- FairSoft
- FairRoot
- PandaRoot

Both FairSoft and FairRoot are tested on Ubuntu 18.04, 20.04 and 22.04.

But PandaRoot is only tested on Ubuntu 18.04. For higher distributions one needs to switch off the VC library (it won't compile with GCC > 7.5.5). Here is what Tobias has tested:

_I have just compiled PandaRoot in the docker image of Ubuntu 22. The only thing I had to do was to set `-DBUILD_PANDA_WITHOUT_VC=TRUE` in the cmake call._

One need to add `-DBUILD_PANDA_WITHOUT_VC=TRUE` to cmake configuration.


```bash
# Configure PandaRoot
cmake -S ./src -B ./build -DCMAKE_INSTALL_PREFIX=./install -DBUILD_PANDA_WITHOUT_VC=TRUE

# Build PandaRoot
cmake --build ./build -j8

# Install PandaRoot
cmake --install ./build
```


