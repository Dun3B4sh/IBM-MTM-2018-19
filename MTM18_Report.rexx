/* rexx */
Arg mbr
 if mbr = '' then
   Do
   Say 'Enter Z31035.SOURCE memeber name'
   parse pull mbr
   End
call open_output
call report_header
call zos_SYS_MVS_info
"allocate dataset (source("mbr")) fi(rpt) shr reuse"
"execio * diskr rpt (stem rpt. finis)"
   do i=1 to rpt.O
     parse var rpt.i w1 w2 w3 w4 w5 w6 w7
     select
      when w4 = 'IXC3371' then call xcf_info
      when w1 = 'JOBS' then call ts_info
      when w1 = 'PROCESSOR' then call cpu_info
      otherwise iterate
     end
   end
"free fi(rpt)"
call storage_info
call net_info
call write_output
exit 0
/ ****************************** /
open_output:
"allocate dataset (p3.output (#15)) fi(#15) shr reuse"
"execio O diskw #15 (stem o. open)"
return
/ ****************************** /
report_header:
o.1 = '--------------------------------------------------------------------------'
o.2 = '                 ===  ===   =     =   '
o.3 = '                  =   =  =  ==   ==   '
o.4 = '                  =   ===   =  =  =   '
o.5 = '                  =   =  =  =  =  =   '
o.6 = '                 ===  ===   =  =  =   '
o.7 = '--------------------------------------------------------------------------'
o.8 = '                                                                          '
o.9 = '                 zzzzz     //    ooo    ssss      '
o.10 ='                    z     //    o   o  s          '
o.11 ='                   z     //     o   o   sss       '
o.12 ='                  z     //      o   o      s      '
o.13 ='                 zzzzz //        ooo   ssss       '
o.14 ='__________________________________________________________________________'
o.15 =' '
o.16 ='This report was created by REXX routine Z31035.SOURCE(MYINFO) '
o.17 ='by submitting Z31035.JCL(CH15JCL) which also generates        '
o.18 ='Z31035.SOURCE(PMP) member containing system command output.'
0.19 ='---------------------------------------------------------------'
o.20 ='BY MAINFRAMER Z31035'
o.21 ='@@@@@@@@@@@@@@@@@@@@'
o.22 =' '
o.23 ='Hi, New z/OS User. '
o.24 ='After going through this report, you will have information about '
o.25 ='this z/OS system which you can share and tell others about. '
o.26 =' '
rpt_time = time()
rpt_date = date)
o.27 = rpt_date rpt_time
o.28 = ' '
o.29 = 'z/OS is a 64-bit operating system for IBM mainframes.'
o.30 = '----      ------                      -------------- '
o.31 = ' '
o.32 = 'Connection details to connect to Z/OS. mainframe for MTM contest'
0.33 = '----------------------------------------------------------------'
o.34 = 'z/OS IP address : 192.86.32.153'
o.35 = ' '
o.36 = 'Service | Port'
0.37 = '--------------'
o.38 = 'TN3270  | 23  '
o.39 = 'SSH | 22 '
o.40 = ' '
o.41 = ' '
return
/ ****************************** /
zos_SYS_MVS_info:
o.42 = 'Syustem Info'
o.43 = '------------'
o.44 = 'Susplex Name :' mvsvar('sysplex' )
o.45 = 'System Name :' mvsvar(' sysname' )
o.46 = 'OS version :' mvsvar(' sysopsys' )
o.47 = 'MVS version :' mvsvar('sysmvs' )
o.48 = 'JES version :' sysvar('sysjes' )
o.49 = 'TSO/VE version:' sysvar('systsoe' )
o.50 = ' '
o.51 = '(!) TSO(Time Sharing Option) is an interactive time-sharing'
o.52 = ' environment for IBM mainframe operating sustems. '
o.53 = ' Time-sharing means multiple users can concurrently use '
0.54 = ' the system.'
o.55 = '(!) JES( Job Entry Subsystem) is the most critical z/OS sub-'
o.56 = ' system required to start VTAM,TCPIP,TSO,DB2 etc.'
o.57 = ' '
o.58 = '(!) z/OS environment includes MVS data sets and Unix files.'
o.59 = ' So, programs of both types can be run and processed on z/OS'
o.60 = ' '
0.61 = '******************************************************************'
return
/ ****************************** /
xcf_info:
k = i+12
parse var rpt.k al a2 a3 a4 a5
guestvm = a1 a2 a3 a4
o.62 = ' '
o.63 = '(!) Did you know this system is 'guestvm'.'
o.64 = ' And the hypervisor for this VM is called z/VM.'
return
/ ****************************** /
ts_info:
l = i+1
parse var rpt.l a1 a2 a3 a4
job = a1
/*
users = outtrap("us",1)
q users
parse var us1 t2 t3 t3 t4
num = t2
*/
o.65 = ' '
o.66 = '(!) There are 'job' active batch jobs on this system now.'
o.67 = ' '
o.68 = '******************************************************************'
return
/ ****************************** /
cpu_info:
/*
cpu = outtrap("cp",1)
q cpuid
parse var cp1 t2 t2 t3 t4
cpuid = t3
vcode = substr(cpuid,1,2)
proc = substr(cpuid,3,6)
model = substr(cpuid,9,4)
mchk = substr(cpuid,13,4)
*/
m = i+2
parse var rpt.m a1 a2 a3 a4
serial_num = a3
proc = substr(serial_num,1,6)
model = substr(serial_num,7,4)
m = m+5
parse var rpt.m a1 a2 a3 a4 a5
mn=a2
o.69 = '  '
o.70 = 'You can get useful information about this system'
o.71 = 'from the CPU serial number'
o.72 = '  '
o.73 = 'CPU serial number for this sustem is:' serial_num
o.74 = '  '
o.75 = 'The following substrings from the serial no. give us info like:'
0.76 = '--------------------------------------------------------------'
o.77 = ' Processor identifier:' proc '-identifies the processor'
o.78 = ' CPU model:' model '-identifies model type of real machine'
o.79 = '  '
o.80 = 'This IBM 2964 z13 Model' mn 'has 1 to 96 PUs(Phyusical Units),'
o.81 = '64 to 7584 GB memory and 30 PCI-e I/O hubs.'
o.82 = '  '
o.83 = '******************************************************************'
return
/ ****************************** /
storage_info:
/*
storage=outtrap("st",1)
q virtual storage
parse var st1 t1 t3 t3
stcap = t3
*/
stcap = '4G'
o.84 = '  '
o.85 = 'This VM has a storage of' stcap'B'
o.86 = 'You can practice & save a lot of files of JCL,REXX,COBOL,C etc!'
o.87 = '  '
o.88 = '******************************************************************'
o.89 = '  '
return
/ ****************************** /
net_info:
/*
netw=outtrap("net",9)
q nic 0400 det
parse var net1 a1 a2 a3 a4 a5 a6 a7 a8
parse var net2 b1 b2 b3 b4 b5 b6 b7 b8
parse var net7 f1 f3 f3 f4 f5 f6 f7 f8
parse var net8 g1 g2 g3 g4 g5 g6 g7 g8
parse var net9 h1 h2 h3 h4 h5 h6 h7 h8
*/
o.90 = 'Here is some info about the simulated network interface card'
o.91 = 'in your VM configuration.'
o.92 = '-------------------------'
o.93 = '  '
o.94 = 'NIC adaper type : QDIO ( Adapters can be QDIO or HIPERSockets )'
o.95 = 'Adapter name : DEVOSA1 '
o.96 = 'MAC Address : #######'
o.97 = 'No of devices that form this adapter = 3'
o.98 = 'Names of devices : 0400 0401 0402'
return
/ ****************************** /
write_output:
o.99 = '  '
o.100 = '******************************************************************'
o.101 = '  '
o.102 = 'Mainframes also, popularly known as BIG IRON, are used in'
o.103 = 'financial transactions, airline ticketing systems, payroll etc'
o.104 = '& have made our lives easy in unimaginable ways'
o.105 = '  '
o.106 = 'Hope this report has sparked an interest in you to explore'
o.107 = 'MAINFRAMES. '
o.108 = '  '
o.109 = '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<END>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
"execio * diskw #15 (stem o. finis)"
"free fi(#15)"
return