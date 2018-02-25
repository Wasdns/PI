# Hands-on Example: L2 Forward

This example demonstrates how to use PI/P4Runtime to control substrate P4-capable switch behaviors.

In this example, the substrate topologic is composed of three hosts and one BMv2 switch. The BMv2 switch is populated with a very simple P4 program that has only one table called "l2_forward". The "l2_forward" matches against destination MAC address and forwards the traffics.

To run this demo, you should open two terminals. One terminal(TB) runs PI CLI while another terminal(TA) runs mininet.

1.Start mininet in TA:

```
./run.sh
```

2.Start PI CLI in TB:

```
./pi_CLI_bmv2 -c switch.json
```

3.Assign switch in TB:

```
PI CLI> assign_device 0 0 -- port=22222  // 0 0 : device id + config id
```

4.Populate the substrate switch with control rules in TB:

```
PI CLI> table_add l2_forward 00:00:00:00:00:01 => forward 1
PI CLI> table_add l2_forward 00:00:00:00:00:02 => forward 2
```

5.Set ARP configurations in TA:

```
mininet> h1 arp -s 10.0.0.2 00:00:00:00:00:02
mininet> h2 arp -s 10.0.0.1 00:00:00:00:00:01
```

6.Finally, try h1 ping h2 in TA:

```
mininet> h1 ping h2
```

Congratulations! You have completed this demo. 
