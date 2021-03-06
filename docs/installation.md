# Install PI

Installation Guide of PI(18.02). System: Ubuntu 14.04, 64 bits.

If you get some troubles when installing PI, maybe this file [install_errors.md](install_errors.md) can help.

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
# Hint: if you are installing pi under Debain system, using the following command:
# build-essential cmake libpcre3-dev libavl-dev libev-dev libprotobuf-c-dev protobuf-c-compiler
# and then skip the 1,2,3 steps.

# 1.Install CMocka
git clone git://git.cryptomilk.org/projects/cmocka.git
cd cmocka
mkdir build; cd build
cmake -DCMAKE_BUILD_TYPE=Debug ..
make
make install

# 2.Install Protobuf-c
git clone https://github.com/protobuf-c/protobuf-c.git
cd protobuf-c
./autogen.sh && ./configure --prefix=/usr
make
make install

# 3.Install libredblack
git clone https://github.com/sysrepo/libredblack.git
cd libredblack
./configure
make
make install

# 4.Install libyang
git clone https://github.com/CESNET/libyang.git
cd libyang
git checkout v0.14-r1
mkdir build
cd build
cmake ..
make
[sudo] make install

# 5.Install sysrepo:
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
./configure --with-proto --with-bmv2 --with-fe-cpp --with-sysrepo [--without-internal-rpc] [--without-cli]
make
make check
[sudo] make install
```

Hint: I don't add the option arguments include `[--without-internal-rpc]` and `[--without-cli]` when applying `make`.

## Reference

- [PI README](https://github.com/p4lang/PI#pi-library-repository)
