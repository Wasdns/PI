# Install PI

Installation Guide of PI(18.02).

## Install Dependencies

1.Install dependencies from source:

```
sudo apt-get install libjudy-dev libreadline-dev valgrind libtool-bin libboost-dev libboost-system-dev
```

2.BMv2: 

```
git clone https://github.com/p4lang/behavioral-model.git
sudo mv behavioral-model bmv2
cd bmv2
sudo ./install_deps.sh
sudo ./autogen.sh && ./configure --disable-logging-macros --disable-elogger && make && sudo make install
```

3.nanomsg: https://github.com/nanomsg/nanomsg/releases/tag/1.0.0

4.Protobuf:

```
git clone https://github.com/google/protobuf.git
cd protobuf/
git checkout tags/v3.2.0
./autogen.sh
./configure
make
[sudo] make install
[sudo] ldconfig
```

5.grpc:

```
git clone https://github.com/google/grpc.git
cd grpc/
git checkout tags/v1.3.2
git submodule update --init --recursive
make
[sudo] make install
[sudo] ldconfig
```

6.sysrepo:

```
# 1.Install dependencies
# Hint: if you are installing pi under Debain system, using the following command
# build-essential cmake libpcre3-dev libavl-dev libev-dev libprotobuf-c-dev protobuf-c-compiler
sudo apt-get update
sudo apt-get install libprotobuf-c0-dev protobuf-c-compiler
sudo apt-get install cmake libpcre3-dev libavl-dev libev-dev

# 2.Install libyang
git clone https://github.com/CESNET/libyang.git
cd libyang
git checkout v0.14-r1
mkdir build
cd build
cmake ..
make
[sudo] make install

# 3.Install sysrepo:
git clone https://github.com/sysrepo/sysrepo.git
cd sysrepo
git checkout v0.7.2
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=Off -DCALL_TARGET_BINS_DIRECTLY=Off ..
make
[sudo] make install
```

## Install PI

```
git clone https://github.com/p4lang/PI.git
cd PI
git submodule update --init --recursive
./autogen.sh
./configure --with-proto --without-internal-rpc --with-bmv2 --with-fe-cpp --with-sysrepo
make
make check
[sudo] make install
```

## Reference

- [PI README](https://github.com/p4lang/PI#pi-library-repository)
