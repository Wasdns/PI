# Errors when installing PI

## grpc

### make: *** [.../grpc/bins/opt/grpc_csharp_plugin] Error 1

Good solution: [Unable to install grpc on Ubuntu 16.04](https://github.com/grpc/grpc/issues/9549)

"I had the same problem on Ubuntu 16 while trying to build gRPC using Protobuf 3.2.0. This happens because the Makefile uses the system libprotobuf libraries while building the plugins, instead of using the protobuf library installed in /usr/local/lib."

"I managed to build the library by modifying the `HOST_LDLIBS_PROTOC` variable in the Makefile from:

```
HOST_LDLIBS_PROTOC += $(addprefix -l, $(LIBS_PROTOC))
```

to

```
HOST_LDLIBS_PROTOC += -L/usr/local/lib $(addprefix -l, $(LIBS_PROTOC))
```

Do a `make clean` and `make` again.

I couldn't find a cleaner way of doing this as of yet, but you should be able to get it working."

