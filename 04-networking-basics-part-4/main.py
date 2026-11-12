from scapy.all import *

msg = "Dear Steel Cat! This is no attack, it's my humster Pinkie you should track"
packet = IP(dst="127.0.0.1") / TCP(dport=12345) / Raw(load=msg)

send(packet, verbose=False)
