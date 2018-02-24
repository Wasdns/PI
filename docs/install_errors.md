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

## PI

### make: *** [all] Error 2

Complete error log:

```
pi_tables_imp.cpp: In function 'pi_status_t _pi_table_default_action_reset(pi_session_handle_t, pi_dev_tgt_t, pi_p4_id_t)':
pi_tables_imp.cpp:449:17: error: 'class bm_runtime::standard::StandardClient' has no member named 'bm_mt_reset_default_entry'
       client.c->bm_mt_reset_default_entry(0, t_name);
                 ^
pi_tables_imp.cpp:451:17: error: 'class bm_runtime::standard::StandardClient' has no member named 'bm_mt_indirect_reset_default_entry'
       client.c->bm_mt_indirect_reset_default_entry(0, t_name);
                 ^
make[4]: *** [pi_tables_imp.lo] Error 1
make[4]: Leaving directory `/home/wasdns/PI/targets/bmv2'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/home/wasdns/PI/targets/bmv2'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/wasdns/PI/targets'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/wasdns/PI'
make: *** [all] Error 2
```

Good solution: [make error](https://github.com/p4lang/PI/issues/162)

