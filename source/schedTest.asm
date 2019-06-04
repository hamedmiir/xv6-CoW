
_schedTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void lotteryTest();
void multilevelQueue();
void showProcessScheduling();

int main(int argc, char const *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    set_lottery_ticket(50, getpid());
  11:	e8 d1 07 00 00       	call   7e7 <getpid>
  16:	83 ec 08             	sub    $0x8,%esp
  19:	50                   	push   %eax
  1a:	6a 32                	push   $0x32
  1c:	e8 06 08 00 00       	call   827 <set_lottery_ticket>
    multilevelQueue();
  21:	e8 1a 03 00 00       	call   340 <multilevelQueue>
    exit();
  26:	e8 3c 07 00 00       	call   767 <exit>
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <showProcessScheduling>:
}

void showProcessScheduling()
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
    show_processes_scheduling();
}
  33:	5d                   	pop    %ebp
    show_processes_scheduling();
  34:	e9 fe 07 00 00       	jmp    837 <show_processes_scheduling>
  39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000040 <priorityTest>:

void priorityTest()
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	56                   	push   %esi
  44:	53                   	push   %ebx
  set_sched_queue(PRIORITY, getpid());
  45:	e8 9d 07 00 00       	call   7e7 <getpid>
  4a:	83 ec 08             	sub    $0x8,%esp
  4d:	50                   	push   %eax
  4e:	6a 01                	push   $0x1
  50:	e8 da 07 00 00       	call   82f <set_sched_queue>
  set_priority(0, getpid());
  55:	e8 8d 07 00 00       	call   7e7 <getpid>
  5a:	59                   	pop    %ecx
  5b:	5b                   	pop    %ebx
  5c:	50                   	push   %eax
  5d:	6a 00                	push   $0x0
  int pid = getpid();
  5f:	bb 04 00 00 00       	mov    $0x4,%ebx
  set_priority(0, getpid());
  64:	e8 b6 07 00 00       	call   81f <set_priority>
  int pid = getpid();
  69:	e8 79 07 00 00       	call   7e7 <getpid>
  6e:	83 c4 10             	add    $0x10,%esp
  71:	89 c6                	mov    %eax,%esi
    
    int i;
    for(i = 1; i < NCHILD; i++)
    {
        if(pid > 0)
  73:	85 f6                	test   %esi,%esi
  75:	7f 49                	jg     c0 <priorityTest+0x80>
    for(i = 1; i < NCHILD; i++)
  77:	83 eb 01             	sub    $0x1,%ebx
  7a:	75 f7                	jne    73 <priorityTest+0x33>
                break;
            
        }
    }
       
    if(pid < 0)
  7c:	85 f6                	test   %esi,%esi
  7e:	0f 88 ab 00 00 00    	js     12f <priorityTest+0xef>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0)
  84:	74 48                	je     ce <priorityTest+0x8e>
    }
    else
    {
        int i;
        for(i = 0; i < NCHILD; i++)
            wait();
  86:	e8 e4 06 00 00       	call   76f <wait>
  8b:	e8 df 06 00 00       	call   76f <wait>
  90:	e8 da 06 00 00       	call   76f <wait>
  95:	e8 d5 06 00 00       	call   76f <wait>
  9a:	e8 d0 06 00 00       	call   76f <wait>
        printf(1, "Main user program finished pid %d\n", getpid());
  9f:	e8 43 07 00 00       	call   7e7 <getpid>
  a4:	83 ec 04             	sub    $0x4,%esp
  a7:	50                   	push   %eax
  a8:	68 6c 0c 00 00       	push   $0xc6c
  ad:	6a 01                	push   $0x1
  af:	e8 3c 08 00 00       	call   8f0 <printf>
  b4:	83 c4 10             	add    $0x10,%esp
    }
}
  b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ba:	5b                   	pop    %ebx
  bb:	5e                   	pop    %esi
  bc:	5d                   	pop    %ebp
  bd:	c3                   	ret    
  be:	66 90                	xchg   %ax,%ax
            pid = fork();
  c0:	e8 9a 06 00 00       	call   75f <fork>
            if(pid > 0)
  c5:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
  c8:	89 c6                	mov    %eax,%esi
            if(pid > 0)
  ca:	7f 44                	jg     110 <priorityTest+0xd0>
            if(pid == 0 )
  cc:	75 a9                	jne    77 <priorityTest+0x37>
        ownPid = getpid();
  ce:	e8 14 07 00 00       	call   7e7 <getpid>
  d3:	bb 40 0d 03 00       	mov    $0x30d40,%ebx
  d8:	89 c6                	mov    %eax,%esi
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            delay(200000000);
  e0:	83 ec 0c             	sub    $0xc,%esp
  e3:	68 00 c2 eb 0b       	push   $0xbebc200
  e8:	e8 43 06 00 00       	call   730 <delay>
        for(i = 0 ; i < 200000 ; i++)
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	83 eb 01             	sub    $0x1,%ebx
  f3:	75 eb                	jne    e0 <priorityTest+0xa0>
        printf(1, "%d\n", ownPid);
  f5:	83 ec 04             	sub    $0x4,%esp
  f8:	56                   	push   %esi
  f9:	68 54 0c 00 00       	push   $0xc54
  fe:	6a 01                	push   $0x1
 100:	e8 eb 07 00 00       	call   8f0 <printf>
 105:	83 c4 10             	add    $0x10,%esp
}
 108:	8d 65 f8             	lea    -0x8(%ebp),%esp
 10b:	5b                   	pop    %ebx
 10c:	5e                   	pop    %esi
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret    
 10f:	90                   	nop
            set_sched_queue(PRIORITY, pid);
 110:	83 ec 08             	sub    $0x8,%esp
 113:	50                   	push   %eax
 114:	6a 01                	push   $0x1
 116:	e8 14 07 00 00       	call   82f <set_sched_queue>
            set_priority(10-i, pid);
 11b:	58                   	pop    %eax
 11c:	8d 43 05             	lea    0x5(%ebx),%eax
 11f:	5a                   	pop    %edx
 120:	56                   	push   %esi
 121:	50                   	push   %eax
 122:	e8 f8 06 00 00       	call   81f <set_priority>
 127:	83 c4 10             	add    $0x10,%esp
 12a:	e9 48 ff ff ff       	jmp    77 <priorityTest+0x37>
        printf(2, "fork error\n");
 12f:	83 ec 08             	sub    $0x8,%esp
 132:	68 48 0c 00 00       	push   $0xc48
 137:	6a 02                	push   $0x2
 139:	e8 b2 07 00 00       	call   8f0 <printf>
 13e:	83 c4 10             	add    $0x10,%esp
}
 141:	8d 65 f8             	lea    -0x8(%ebp),%esp
 144:	5b                   	pop    %ebx
 145:	5e                   	pop    %esi
 146:	5d                   	pop    %ebp
 147:	c3                   	ret    
 148:	90                   	nop
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000150 <SJFTest>:

void SJFTest(){
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	56                   	push   %esi
 154:	53                   	push   %ebx

  int pid = getpid();
   set_sched_queue(SJF, getpid());
 155:	bb 0c 00 00 00       	mov    $0xc,%ebx
  int pid = getpid();
 15a:	e8 88 06 00 00       	call   7e7 <getpid>
 15f:	89 c6                	mov    %eax,%esi
   set_sched_queue(SJF, getpid());
 161:	e8 81 06 00 00       	call   7e7 <getpid>
 166:	83 ec 08             	sub    $0x8,%esp
 169:	50                   	push   %eax
 16a:	6a 02                	push   $0x2
 16c:	e8 be 06 00 00       	call   82f <set_sched_queue>
 171:	83 c4 10             	add    $0x10,%esp
    
    int i;
    for(i = 1; i < NCHILD; i++)
    {
        if(pid > 0)
 174:	85 f6                	test   %esi,%esi
 176:	7f 58                	jg     1d0 <SJFTest+0x80>
 178:	83 c3 02             	add    $0x2,%ebx
    for(i = 1; i < NCHILD; i++)
 17b:	83 fb 14             	cmp    $0x14,%ebx
 17e:	75 f4                	jne    174 <SJFTest+0x24>
            if(pid == 0 )
                break;
        }
    }
       
    if(pid < 0)
 180:	85 f6                	test   %esi,%esi
 182:	0f 88 b4 00 00 00    	js     23c <SJFTest+0xec>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0)
 188:	74 54                	je     1de <SJFTest+0x8e>
    }
    else
    {
        int i;
        for(i = 0; i < NCHILD + 1; i++)
            wait();
 18a:	e8 e0 05 00 00       	call   76f <wait>
 18f:	e8 db 05 00 00       	call   76f <wait>
 194:	e8 d6 05 00 00       	call   76f <wait>
 199:	e8 d1 05 00 00       	call   76f <wait>
 19e:	e8 cc 05 00 00       	call   76f <wait>
 1a3:	e8 c7 05 00 00       	call   76f <wait>
        printf(1, "Main user program finished pid %d\n", getpid());
 1a8:	e8 3a 06 00 00       	call   7e7 <getpid>
 1ad:	83 ec 04             	sub    $0x4,%esp
 1b0:	50                   	push   %eax
 1b1:	68 6c 0c 00 00       	push   $0xc6c
 1b6:	6a 01                	push   $0x1
 1b8:	e8 33 07 00 00       	call   8f0 <printf>
 1bd:	83 c4 10             	add    $0x10,%esp
    }
}
 1c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c3:	5b                   	pop    %ebx
 1c4:	5e                   	pop    %esi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            pid = fork();
 1d0:	e8 8a 05 00 00       	call   75f <fork>
            if(pid > 0)
 1d5:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
 1d8:	89 c6                	mov    %eax,%esi
            if(pid > 0)
 1da:	7f 44                	jg     220 <SJFTest+0xd0>
            if(pid == 0 )
 1dc:	75 9a                	jne    178 <SJFTest+0x28>
        ownPid = getpid();
 1de:	e8 04 06 00 00       	call   7e7 <getpid>
 1e3:	bb 20 4e 00 00       	mov    $0x4e20,%ebx
 1e8:	89 c6                	mov    %eax,%esi
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            delay(200000000);
 1f0:	83 ec 0c             	sub    $0xc,%esp
 1f3:	68 00 c2 eb 0b       	push   $0xbebc200
 1f8:	e8 33 05 00 00       	call   730 <delay>
        for(i = 0 ; i < 20000 ; i++)
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	83 eb 01             	sub    $0x1,%ebx
 203:	75 eb                	jne    1f0 <SJFTest+0xa0>
        printf(1, "%d\n", ownPid);
 205:	83 ec 04             	sub    $0x4,%esp
 208:	56                   	push   %esi
 209:	68 54 0c 00 00       	push   $0xc54
 20e:	6a 01                	push   $0x1
 210:	e8 db 06 00 00       	call   8f0 <printf>
 215:	83 c4 10             	add    $0x10,%esp
}
 218:	8d 65 f8             	lea    -0x8(%ebp),%esp
 21b:	5b                   	pop    %ebx
 21c:	5e                   	pop    %esi
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret    
 21f:	90                   	nop
                set_sched_queue(SJF, pid);
 220:	83 ec 08             	sub    $0x8,%esp
 223:	50                   	push   %eax
 224:	6a 02                	push   $0x2
 226:	e8 04 06 00 00       	call   82f <set_sched_queue>
                set_burst_time(10 + 2*i, pid);
 22b:	58                   	pop    %eax
 22c:	5a                   	pop    %edx
 22d:	56                   	push   %esi
 22e:	53                   	push   %ebx
 22f:	e8 e3 05 00 00       	call   817 <set_burst_time>
 234:	83 c4 10             	add    $0x10,%esp
 237:	e9 3c ff ff ff       	jmp    178 <SJFTest+0x28>
        printf(2, "fork error\n");
 23c:	83 ec 08             	sub    $0x8,%esp
 23f:	68 48 0c 00 00       	push   $0xc48
 244:	6a 02                	push   $0x2
 246:	e8 a5 06 00 00       	call   8f0 <printf>
 24b:	83 c4 10             	add    $0x10,%esp
}
 24e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 251:	5b                   	pop    %ebx
 252:	5e                   	pop    %esi
 253:	5d                   	pop    %ebp
 254:	c3                   	ret    
 255:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <lotteryTest>:

void lotteryTest(){
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
  int pid = getpid();
 265:	bb 04 00 00 00       	mov    $0x4,%ebx
 26a:	e8 78 05 00 00       	call   7e7 <getpid>
 26f:	89 c6                	mov    %eax,%esi
    
    int i;
    for(i = 1; i < NCHILD; i++)
    {
        if(pid > 0)
 271:	85 f6                	test   %esi,%esi
 273:	7f 33                	jg     2a8 <lotteryTest+0x48>
    for(i = 1; i < NCHILD; i++)
 275:	83 eb 01             	sub    $0x1,%ebx
 278:	75 f7                	jne    271 <lotteryTest+0x11>
            
        }
            
    }
       
    if(pid < 0)
 27a:	85 f6                	test   %esi,%esi
 27c:	0f 88 9d 00 00 00    	js     31f <lotteryTest+0xbf>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0)
 282:	74 32                	je     2b6 <lotteryTest+0x56>
    }
    else
    {
        int i;
        for(i = 0; i < NCHILD; i++)
            wait();
 284:	e8 e6 04 00 00       	call   76f <wait>
 289:	e8 e1 04 00 00       	call   76f <wait>
 28e:	e8 dc 04 00 00       	call   76f <wait>
 293:	e8 d7 04 00 00       	call   76f <wait>
    }
}
 298:	8d 65 f8             	lea    -0x8(%ebp),%esp
 29b:	5b                   	pop    %ebx
 29c:	5e                   	pop    %esi
 29d:	5d                   	pop    %ebp
            wait();
 29e:	e9 cc 04 00 00       	jmp    76f <wait>
 2a3:	90                   	nop
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            pid = fork();
 2a8:	e8 b2 04 00 00       	call   75f <fork>
            if(pid > 0)
 2ad:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
 2b0:	89 c6                	mov    %eax,%esi
            if(pid > 0)
 2b2:	7f 4c                	jg     300 <lotteryTest+0xa0>
            if(pid == 0 )
 2b4:	75 bf                	jne    275 <lotteryTest+0x15>
        ownPid = getpid();
 2b6:	e8 2c 05 00 00       	call   7e7 <getpid>
 2bb:	bb 00 2d 31 01       	mov    $0x1312d00,%ebx
 2c0:	89 c6                	mov    %eax,%esi
 2c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            delay(2000000000);
 2c8:	83 ec 0c             	sub    $0xc,%esp
 2cb:	68 00 94 35 77       	push   $0x77359400
 2d0:	e8 5b 04 00 00       	call   730 <delay>
        for(i = 0 ; i < 20000000 ; i++)
 2d5:	83 c4 10             	add    $0x10,%esp
 2d8:	83 eb 01             	sub    $0x1,%ebx
 2db:	75 eb                	jne    2c8 <lotteryTest+0x68>
        printf(1, "%d\n", ownPid);
 2dd:	83 ec 04             	sub    $0x4,%esp
 2e0:	56                   	push   %esi
 2e1:	68 54 0c 00 00       	push   $0xc54
 2e6:	6a 01                	push   $0x1
 2e8:	e8 03 06 00 00       	call   8f0 <printf>
 2ed:	83 c4 10             	add    $0x10,%esp
}
 2f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2f3:	5b                   	pop    %ebx
 2f4:	5e                   	pop    %esi
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                set_sched_queue(LOTTERY, pid);
 300:	83 ec 08             	sub    $0x8,%esp
 303:	50                   	push   %eax
 304:	6a 03                	push   $0x3
 306:	e8 24 05 00 00       	call   82f <set_sched_queue>
                set_lottery_ticket(10-i, pid);
 30b:	58                   	pop    %eax
 30c:	8d 43 05             	lea    0x5(%ebx),%eax
 30f:	5a                   	pop    %edx
 310:	56                   	push   %esi
 311:	50                   	push   %eax
 312:	e8 10 05 00 00       	call   827 <set_lottery_ticket>
 317:	83 c4 10             	add    $0x10,%esp
 31a:	e9 56 ff ff ff       	jmp    275 <lotteryTest+0x15>
        printf(2, "fork error\n");
 31f:	83 ec 08             	sub    $0x8,%esp
 322:	68 48 0c 00 00       	push   $0xc48
 327:	6a 02                	push   $0x2
 329:	e8 c2 05 00 00       	call   8f0 <printf>
 32e:	83 c4 10             	add    $0x10,%esp
}
 331:	8d 65 f8             	lea    -0x8(%ebp),%esp
 334:	5b                   	pop    %ebx
 335:	5e                   	pop    %esi
 336:	5d                   	pop    %ebp
 337:	c3                   	ret    
 338:	90                   	nop
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000340 <multilevelQueue>:

void multilevelQueue() {
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
                    set_priority(NCHILD * 3 - i, pid);
                }
                else if( i < NCHILD * 2)
                {
                    set_sched_queue(SJF, pid);
                    set_burst_time(NCHILD * 5 - i, pid);
 346:	be 19 00 00 00       	mov    $0x19,%esi
    for(i = 0; i < 3 * NCHILD; i++)
 34b:	31 db                	xor    %ebx,%ebx
void multilevelQueue() {
 34d:	83 ec 0c             	sub    $0xc,%esp
    int pid = getpid();
 350:	e8 92 04 00 00       	call   7e7 <getpid>
 355:	89 c7                	mov    %eax,%edi
 357:	eb 0f                	jmp    368 <multilevelQueue+0x28>
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < 3 * NCHILD; i++)
 360:	83 c3 01             	add    $0x1,%ebx
 363:	83 fb 0f             	cmp    $0xf,%ebx
 366:	74 50                	je     3b8 <multilevelQueue+0x78>
        if(pid > 0)
 368:	85 ff                	test   %edi,%edi
 36a:	7e f4                	jle    360 <multilevelQueue+0x20>
            pid = fork();
 36c:	e8 ee 03 00 00       	call   75f <fork>
            if(pid > 0)
 371:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
 374:	89 c7                	mov    %eax,%edi
            if(pid > 0)
 376:	0f 8e 84 00 00 00    	jle    400 <multilevelQueue+0xc0>
                if(i < NCHILD)
 37c:	83 fb 04             	cmp    $0x4,%ebx
 37f:	0f 8e cb 00 00 00    	jle    450 <multilevelQueue+0x110>
                else if( i < NCHILD * 2)
 385:	83 fb 09             	cmp    $0x9,%ebx
 388:	0f 8f ea 00 00 00    	jg     478 <multilevelQueue+0x138>
                    set_sched_queue(SJF, pid);
 38e:	83 ec 08             	sub    $0x8,%esp
 391:	50                   	push   %eax
 392:	6a 02                	push   $0x2
 394:	e8 96 04 00 00       	call   82f <set_sched_queue>
                    set_burst_time(NCHILD * 5 - i, pid);
 399:	59                   	pop    %ecx
 39a:	58                   	pop    %eax
 39b:	89 f0                	mov    %esi,%eax
 39d:	57                   	push   %edi
 39e:	29 d8                	sub    %ebx,%eax
    for(i = 0; i < 3 * NCHILD; i++)
 3a0:	83 c3 01             	add    $0x1,%ebx
                    set_burst_time(NCHILD * 5 - i, pid);
 3a3:	50                   	push   %eax
 3a4:	e8 6e 04 00 00       	call   817 <set_burst_time>
 3a9:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < 3 * NCHILD; i++)
 3ac:	83 fb 0f             	cmp    $0xf,%ebx
 3af:	75 b7                	jne    368 <multilevelQueue+0x28>
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            }
        }
            
    }
       
    if(pid < 0)
 3b8:	85 ff                	test   %edi,%edi
 3ba:	0f 88 00 01 00 00    	js     4c0 <multilevelQueue+0x180>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0 && (queue == LOTTERY || queue == SJF))
 3c0:	74 4d                	je     40f <multilevelQueue+0xcf>
    {
        printf(1, "IO bound process with pid %d finished\n", getpid());
    }
    else
    {
        show_processes_scheduling();
 3c2:	bb 0f 00 00 00       	mov    $0xf,%ebx
 3c7:	e8 6b 04 00 00       	call   837 <show_processes_scheduling>
 3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        int i;
        for(i = 0; i < NCHILD * 3 ; i++)
            wait();
 3d0:	e8 9a 03 00 00       	call   76f <wait>
        for(i = 0; i < NCHILD * 3 ; i++)
 3d5:	83 eb 01             	sub    $0x1,%ebx
 3d8:	75 f6                	jne    3d0 <multilevelQueue+0x90>
        printf(1, "main program with pid %d finished\n", getpid());
 3da:	e8 08 04 00 00       	call   7e7 <getpid>
 3df:	83 ec 04             	sub    $0x4,%esp
 3e2:	50                   	push   %eax
 3e3:	68 90 0c 00 00       	push   $0xc90
 3e8:	6a 01                	push   $0x1
 3ea:	e8 01 05 00 00       	call   8f0 <printf>
 3ef:	83 c4 10             	add    $0x10,%esp
    }
 3f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f5:	5b                   	pop    %ebx
 3f6:	5e                   	pop    %esi
 3f7:	5f                   	pop    %edi
 3f8:	5d                   	pop    %ebp
 3f9:	c3                   	ret    
 3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if(pid == 0 )
 400:	0f 85 5a ff ff ff    	jne    360 <multilevelQueue+0x20>
                queue = i < NCHILD ? PRIORITY : i < NCHILD * 2 ? SJF : LOTTERY;
 406:	83 fb 04             	cmp    $0x4,%ebx
 409:	0f 8e 91 00 00 00    	jle    4a0 <multilevelQueue+0x160>
    for(i = 0; i < 3 * NCHILD; i++)
 40f:	bb 90 d0 03 00       	mov    $0x3d090,%ebx
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            delay(2000000000);
 418:	83 ec 0c             	sub    $0xc,%esp
 41b:	68 00 94 35 77       	push   $0x77359400
 420:	e8 0b 03 00 00       	call   730 <delay>
        for(i = 0 ; i < 250000 ; i++)
 425:	83 c4 10             	add    $0x10,%esp
 428:	83 eb 01             	sub    $0x1,%ebx
 42b:	75 eb                	jne    418 <multilevelQueue+0xd8>
        printf(1, "pid %d finished\n", getpid());
 42d:	e8 b5 03 00 00       	call   7e7 <getpid>
 432:	83 ec 04             	sub    $0x4,%esp
 435:	50                   	push   %eax
 436:	68 58 0c 00 00       	push   $0xc58
 43b:	6a 01                	push   $0x1
 43d:	e8 ae 04 00 00       	call   8f0 <printf>
    {
 442:	83 c4 10             	add    $0x10,%esp
 445:	8d 65 f4             	lea    -0xc(%ebp),%esp
 448:	5b                   	pop    %ebx
 449:	5e                   	pop    %esi
 44a:	5f                   	pop    %edi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
 44d:	8d 76 00             	lea    0x0(%esi),%esi
                    set_sched_queue(PRIORITY, pid);
 450:	83 ec 08             	sub    $0x8,%esp
 453:	50                   	push   %eax
 454:	6a 01                	push   $0x1
 456:	e8 d4 03 00 00       	call   82f <set_sched_queue>
                    set_priority(NCHILD * 3 - i, pid);
 45b:	58                   	pop    %eax
 45c:	b8 0f 00 00 00       	mov    $0xf,%eax
 461:	5a                   	pop    %edx
 462:	29 d8                	sub    %ebx,%eax
 464:	57                   	push   %edi
 465:	50                   	push   %eax
 466:	e8 b4 03 00 00       	call   81f <set_priority>
 46b:	83 c4 10             	add    $0x10,%esp
 46e:	e9 ed fe ff ff       	jmp    360 <multilevelQueue+0x20>
 473:	90                   	nop
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                    set_sched_queue(LOTTERY, pid);
 478:	83 ec 08             	sub    $0x8,%esp
 47b:	50                   	push   %eax
 47c:	6a 03                	push   $0x3
 47e:	e8 ac 03 00 00       	call   82f <set_sched_queue>
                    set_lottery_ticket(NCHILD * 4 - i, pid);
 483:	58                   	pop    %eax
 484:	b8 14 00 00 00       	mov    $0x14,%eax
 489:	5a                   	pop    %edx
 48a:	29 d8                	sub    %ebx,%eax
 48c:	57                   	push   %edi
 48d:	50                   	push   %eax
 48e:	e8 94 03 00 00       	call   827 <set_lottery_ticket>
 493:	83 c4 10             	add    $0x10,%esp
 496:	e9 c5 fe ff ff       	jmp    360 <multilevelQueue+0x20>
 49b:	90                   	nop
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "IO bound process with pid %d finished\n", getpid());
 4a0:	e8 42 03 00 00       	call   7e7 <getpid>
 4a5:	83 ec 04             	sub    $0x4,%esp
 4a8:	50                   	push   %eax
 4a9:	68 b4 0c 00 00       	push   $0xcb4
 4ae:	6a 01                	push   $0x1
 4b0:	e8 3b 04 00 00       	call   8f0 <printf>
 4b5:	83 c4 10             	add    $0x10,%esp
 4b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4bb:	5b                   	pop    %ebx
 4bc:	5e                   	pop    %esi
 4bd:	5f                   	pop    %edi
 4be:	5d                   	pop    %ebp
 4bf:	c3                   	ret    
        printf(2, "fork error\n");
 4c0:	83 ec 08             	sub    $0x8,%esp
 4c3:	68 48 0c 00 00       	push   $0xc48
 4c8:	6a 02                	push   $0x2
 4ca:	e8 21 04 00 00       	call   8f0 <printf>
 4cf:	83 c4 10             	add    $0x10,%esp
 4d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d5:	5b                   	pop    %ebx
 4d6:	5e                   	pop    %esi
 4d7:	5f                   	pop    %edi
 4d8:	5d                   	pop    %ebp
 4d9:	c3                   	ret    
 4da:	66 90                	xchg   %ax,%ax
 4dc:	66 90                	xchg   %ax,%ax
 4de:	66 90                	xchg   %ax,%ax

000004e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	53                   	push   %ebx
 4e4:	8b 45 08             	mov    0x8(%ebp),%eax
 4e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4ea:	89 c2                	mov    %eax,%edx
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4f0:	83 c1 01             	add    $0x1,%ecx
 4f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 4f7:	83 c2 01             	add    $0x1,%edx
 4fa:	84 db                	test   %bl,%bl
 4fc:	88 5a ff             	mov    %bl,-0x1(%edx)
 4ff:	75 ef                	jne    4f0 <strcpy+0x10>
    ;
  return os;
}
 501:	5b                   	pop    %ebx
 502:	5d                   	pop    %ebp
 503:	c3                   	ret    
 504:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 50a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000510 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 55 08             	mov    0x8(%ebp),%edx
 517:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 51a:	0f b6 02             	movzbl (%edx),%eax
 51d:	0f b6 19             	movzbl (%ecx),%ebx
 520:	84 c0                	test   %al,%al
 522:	75 1c                	jne    540 <strcmp+0x30>
 524:	eb 2a                	jmp    550 <strcmp+0x40>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 530:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 533:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 536:	83 c1 01             	add    $0x1,%ecx
 539:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 53c:	84 c0                	test   %al,%al
 53e:	74 10                	je     550 <strcmp+0x40>
 540:	38 d8                	cmp    %bl,%al
 542:	74 ec                	je     530 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 544:	29 d8                	sub    %ebx,%eax
}
 546:	5b                   	pop    %ebx
 547:	5d                   	pop    %ebp
 548:	c3                   	ret    
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 550:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 552:	29 d8                	sub    %ebx,%eax
}
 554:	5b                   	pop    %ebx
 555:	5d                   	pop    %ebp
 556:	c3                   	ret    
 557:	89 f6                	mov    %esi,%esi
 559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000560 <strlen>:

uint
strlen(const char *s)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 566:	80 39 00             	cmpb   $0x0,(%ecx)
 569:	74 15                	je     580 <strlen+0x20>
 56b:	31 d2                	xor    %edx,%edx
 56d:	8d 76 00             	lea    0x0(%esi),%esi
 570:	83 c2 01             	add    $0x1,%edx
 573:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 577:	89 d0                	mov    %edx,%eax
 579:	75 f5                	jne    570 <strlen+0x10>
    ;
  return n;
}
 57b:	5d                   	pop    %ebp
 57c:	c3                   	ret    
 57d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 580:	31 c0                	xor    %eax,%eax
}
 582:	5d                   	pop    %ebp
 583:	c3                   	ret    
 584:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 58a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000590 <memset>:

void*
memset(void *dst, int c, uint n)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 597:	8b 4d 10             	mov    0x10(%ebp),%ecx
 59a:	8b 45 0c             	mov    0xc(%ebp),%eax
 59d:	89 d7                	mov    %edx,%edi
 59f:	fc                   	cld    
 5a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5a2:	89 d0                	mov    %edx,%eax
 5a4:	5f                   	pop    %edi
 5a5:	5d                   	pop    %ebp
 5a6:	c3                   	ret    
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005b0 <strchr>:

char*
strchr(const char *s, char c)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	53                   	push   %ebx
 5b4:	8b 45 08             	mov    0x8(%ebp),%eax
 5b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 5ba:	0f b6 10             	movzbl (%eax),%edx
 5bd:	84 d2                	test   %dl,%dl
 5bf:	74 1d                	je     5de <strchr+0x2e>
    if(*s == c)
 5c1:	38 d3                	cmp    %dl,%bl
 5c3:	89 d9                	mov    %ebx,%ecx
 5c5:	75 0d                	jne    5d4 <strchr+0x24>
 5c7:	eb 17                	jmp    5e0 <strchr+0x30>
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5d0:	38 ca                	cmp    %cl,%dl
 5d2:	74 0c                	je     5e0 <strchr+0x30>
  for(; *s; s++)
 5d4:	83 c0 01             	add    $0x1,%eax
 5d7:	0f b6 10             	movzbl (%eax),%edx
 5da:	84 d2                	test   %dl,%dl
 5dc:	75 f2                	jne    5d0 <strchr+0x20>
      return (char*)s;
  return 0;
 5de:	31 c0                	xor    %eax,%eax
}
 5e0:	5b                   	pop    %ebx
 5e1:	5d                   	pop    %ebp
 5e2:	c3                   	ret    
 5e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <gets>:

char*
gets(char *buf, int max)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5f6:	31 f6                	xor    %esi,%esi
 5f8:	89 f3                	mov    %esi,%ebx
{
 5fa:	83 ec 1c             	sub    $0x1c,%esp
 5fd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 600:	eb 2f                	jmp    631 <gets+0x41>
 602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 608:	8d 45 e7             	lea    -0x19(%ebp),%eax
 60b:	83 ec 04             	sub    $0x4,%esp
 60e:	6a 01                	push   $0x1
 610:	50                   	push   %eax
 611:	6a 00                	push   $0x0
 613:	e8 67 01 00 00       	call   77f <read>
    if(cc < 1)
 618:	83 c4 10             	add    $0x10,%esp
 61b:	85 c0                	test   %eax,%eax
 61d:	7e 1c                	jle    63b <gets+0x4b>
      break;
    buf[i++] = c;
 61f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 623:	83 c7 01             	add    $0x1,%edi
 626:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 629:	3c 0a                	cmp    $0xa,%al
 62b:	74 23                	je     650 <gets+0x60>
 62d:	3c 0d                	cmp    $0xd,%al
 62f:	74 1f                	je     650 <gets+0x60>
  for(i=0; i+1 < max; ){
 631:	83 c3 01             	add    $0x1,%ebx
 634:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 637:	89 fe                	mov    %edi,%esi
 639:	7c cd                	jl     608 <gets+0x18>
 63b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 63d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 640:	c6 03 00             	movb   $0x0,(%ebx)
}
 643:	8d 65 f4             	lea    -0xc(%ebp),%esp
 646:	5b                   	pop    %ebx
 647:	5e                   	pop    %esi
 648:	5f                   	pop    %edi
 649:	5d                   	pop    %ebp
 64a:	c3                   	ret    
 64b:	90                   	nop
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 650:	8b 75 08             	mov    0x8(%ebp),%esi
 653:	8b 45 08             	mov    0x8(%ebp),%eax
 656:	01 de                	add    %ebx,%esi
 658:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 65a:	c6 03 00             	movb   $0x0,(%ebx)
}
 65d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 660:	5b                   	pop    %ebx
 661:	5e                   	pop    %esi
 662:	5f                   	pop    %edi
 663:	5d                   	pop    %ebp
 664:	c3                   	ret    
 665:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <stat>:

int
stat(const char *n, struct stat *st)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	56                   	push   %esi
 674:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 675:	83 ec 08             	sub    $0x8,%esp
 678:	6a 00                	push   $0x0
 67a:	ff 75 08             	pushl  0x8(%ebp)
 67d:	e8 25 01 00 00       	call   7a7 <open>
  if(fd < 0)
 682:	83 c4 10             	add    $0x10,%esp
 685:	85 c0                	test   %eax,%eax
 687:	78 27                	js     6b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 689:	83 ec 08             	sub    $0x8,%esp
 68c:	ff 75 0c             	pushl  0xc(%ebp)
 68f:	89 c3                	mov    %eax,%ebx
 691:	50                   	push   %eax
 692:	e8 28 01 00 00       	call   7bf <fstat>
  close(fd);
 697:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 69a:	89 c6                	mov    %eax,%esi
  close(fd);
 69c:	e8 ee 00 00 00       	call   78f <close>
  return r;
 6a1:	83 c4 10             	add    $0x10,%esp
}
 6a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6a7:	89 f0                	mov    %esi,%eax
 6a9:	5b                   	pop    %ebx
 6aa:	5e                   	pop    %esi
 6ab:	5d                   	pop    %ebp
 6ac:	c3                   	ret    
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 6b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6b5:	eb ed                	jmp    6a4 <stat+0x34>
 6b7:	89 f6                	mov    %esi,%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006c0 <atoi>:

int
atoi(const char *s)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	53                   	push   %ebx
 6c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6c7:	0f be 11             	movsbl (%ecx),%edx
 6ca:	8d 42 d0             	lea    -0x30(%edx),%eax
 6cd:	3c 09                	cmp    $0x9,%al
  n = 0;
 6cf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 6d4:	77 1f                	ja     6f5 <atoi+0x35>
 6d6:	8d 76 00             	lea    0x0(%esi),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 6e0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 6e3:	83 c1 01             	add    $0x1,%ecx
 6e6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 6ea:	0f be 11             	movsbl (%ecx),%edx
 6ed:	8d 5a d0             	lea    -0x30(%edx),%ebx
 6f0:	80 fb 09             	cmp    $0x9,%bl
 6f3:	76 eb                	jbe    6e0 <atoi+0x20>
  return n;
}
 6f5:	5b                   	pop    %ebx
 6f6:	5d                   	pop    %ebp
 6f7:	c3                   	ret    
 6f8:	90                   	nop
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000700 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	56                   	push   %esi
 704:	53                   	push   %ebx
 705:	8b 5d 10             	mov    0x10(%ebp),%ebx
 708:	8b 45 08             	mov    0x8(%ebp),%eax
 70b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 70e:	85 db                	test   %ebx,%ebx
 710:	7e 14                	jle    726 <memmove+0x26>
 712:	31 d2                	xor    %edx,%edx
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 718:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 71c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 71f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 722:	39 d3                	cmp    %edx,%ebx
 724:	75 f2                	jne    718 <memmove+0x18>
  return vdst;
}
 726:	5b                   	pop    %ebx
 727:	5e                   	pop    %esi
 728:	5d                   	pop    %ebp
 729:	c3                   	ret    
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000730 <delay>:

void delay(int numberOfClocks)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	53                   	push   %ebx
 734:	83 ec 04             	sub    $0x4,%esp
    int firstClock = uptime();
 737:	e8 c3 00 00 00       	call   7ff <uptime>
 73c:	89 c3                	mov    %eax,%ebx
    int incClock = uptime();
 73e:	e8 bc 00 00 00       	call   7ff <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 743:	03 5d 08             	add    0x8(%ebp),%ebx
 746:	39 d8                	cmp    %ebx,%eax
 748:	7c 0f                	jl     759 <delay+0x29>
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    {
        incClock = uptime();
 750:	e8 aa 00 00 00       	call   7ff <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 755:	39 d8                	cmp    %ebx,%eax
 757:	7d f7                	jge    750 <delay+0x20>
    }
}
 759:	83 c4 04             	add    $0x4,%esp
 75c:	5b                   	pop    %ebx
 75d:	5d                   	pop    %ebp
 75e:	c3                   	ret    

0000075f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 75f:	b8 01 00 00 00       	mov    $0x1,%eax
 764:	cd 40                	int    $0x40
 766:	c3                   	ret    

00000767 <exit>:
SYSCALL(exit)
 767:	b8 02 00 00 00       	mov    $0x2,%eax
 76c:	cd 40                	int    $0x40
 76e:	c3                   	ret    

0000076f <wait>:
SYSCALL(wait)
 76f:	b8 03 00 00 00       	mov    $0x3,%eax
 774:	cd 40                	int    $0x40
 776:	c3                   	ret    

00000777 <pipe>:
SYSCALL(pipe)
 777:	b8 04 00 00 00       	mov    $0x4,%eax
 77c:	cd 40                	int    $0x40
 77e:	c3                   	ret    

0000077f <read>:
SYSCALL(read)
 77f:	b8 05 00 00 00       	mov    $0x5,%eax
 784:	cd 40                	int    $0x40
 786:	c3                   	ret    

00000787 <write>:
SYSCALL(write)
 787:	b8 10 00 00 00       	mov    $0x10,%eax
 78c:	cd 40                	int    $0x40
 78e:	c3                   	ret    

0000078f <close>:
SYSCALL(close)
 78f:	b8 15 00 00 00       	mov    $0x15,%eax
 794:	cd 40                	int    $0x40
 796:	c3                   	ret    

00000797 <kill>:
SYSCALL(kill)
 797:	b8 06 00 00 00       	mov    $0x6,%eax
 79c:	cd 40                	int    $0x40
 79e:	c3                   	ret    

0000079f <exec>:
SYSCALL(exec)
 79f:	b8 07 00 00 00       	mov    $0x7,%eax
 7a4:	cd 40                	int    $0x40
 7a6:	c3                   	ret    

000007a7 <open>:
SYSCALL(open)
 7a7:	b8 0f 00 00 00       	mov    $0xf,%eax
 7ac:	cd 40                	int    $0x40
 7ae:	c3                   	ret    

000007af <mknod>:
SYSCALL(mknod)
 7af:	b8 11 00 00 00       	mov    $0x11,%eax
 7b4:	cd 40                	int    $0x40
 7b6:	c3                   	ret    

000007b7 <unlink>:
SYSCALL(unlink)
 7b7:	b8 12 00 00 00       	mov    $0x12,%eax
 7bc:	cd 40                	int    $0x40
 7be:	c3                   	ret    

000007bf <fstat>:
SYSCALL(fstat)
 7bf:	b8 08 00 00 00       	mov    $0x8,%eax
 7c4:	cd 40                	int    $0x40
 7c6:	c3                   	ret    

000007c7 <link>:
SYSCALL(link)
 7c7:	b8 13 00 00 00       	mov    $0x13,%eax
 7cc:	cd 40                	int    $0x40
 7ce:	c3                   	ret    

000007cf <mkdir>:
SYSCALL(mkdir)
 7cf:	b8 14 00 00 00       	mov    $0x14,%eax
 7d4:	cd 40                	int    $0x40
 7d6:	c3                   	ret    

000007d7 <chdir>:
SYSCALL(chdir)
 7d7:	b8 09 00 00 00       	mov    $0x9,%eax
 7dc:	cd 40                	int    $0x40
 7de:	c3                   	ret    

000007df <dup>:
SYSCALL(dup)
 7df:	b8 0a 00 00 00       	mov    $0xa,%eax
 7e4:	cd 40                	int    $0x40
 7e6:	c3                   	ret    

000007e7 <getpid>:
SYSCALL(getpid)
 7e7:	b8 0b 00 00 00       	mov    $0xb,%eax
 7ec:	cd 40                	int    $0x40
 7ee:	c3                   	ret    

000007ef <sbrk>:
SYSCALL(sbrk)
 7ef:	b8 0c 00 00 00       	mov    $0xc,%eax
 7f4:	cd 40                	int    $0x40
 7f6:	c3                   	ret    

000007f7 <sleep>:
SYSCALL(sleep)
 7f7:	b8 0d 00 00 00       	mov    $0xd,%eax
 7fc:	cd 40                	int    $0x40
 7fe:	c3                   	ret    

000007ff <uptime>:
SYSCALL(uptime)
 7ff:	b8 0e 00 00 00       	mov    $0xe,%eax
 804:	cd 40                	int    $0x40
 806:	c3                   	ret    

00000807 <incNum>:
SYSCALL(incNum)
 807:	b8 16 00 00 00       	mov    $0x16,%eax
 80c:	cd 40                	int    $0x40
 80e:	c3                   	ret    

0000080f <getprocs>:
SYSCALL(getprocs)
 80f:	b8 17 00 00 00       	mov    $0x17,%eax
 814:	cd 40                	int    $0x40
 816:	c3                   	ret    

00000817 <set_burst_time>:
SYSCALL(set_burst_time)
 817:	b8 18 00 00 00       	mov    $0x18,%eax
 81c:	cd 40                	int    $0x40
 81e:	c3                   	ret    

0000081f <set_priority>:
SYSCALL(set_priority)
 81f:	b8 19 00 00 00       	mov    $0x19,%eax
 824:	cd 40                	int    $0x40
 826:	c3                   	ret    

00000827 <set_lottery_ticket>:
SYSCALL(set_lottery_ticket)
 827:	b8 1a 00 00 00       	mov    $0x1a,%eax
 82c:	cd 40                	int    $0x40
 82e:	c3                   	ret    

0000082f <set_sched_queue>:
SYSCALL(set_sched_queue)
 82f:	b8 1b 00 00 00       	mov    $0x1b,%eax
 834:	cd 40                	int    $0x40
 836:	c3                   	ret    

00000837 <show_processes_scheduling>:
SYSCALL(show_processes_scheduling)
 837:	b8 1c 00 00 00       	mov    $0x1c,%eax
 83c:	cd 40                	int    $0x40
 83e:	c3                   	ret    

0000083f <getNumFreePages>:
 83f:	b8 1d 00 00 00       	mov    $0x1d,%eax
 844:	cd 40                	int    $0x40
 846:	c3                   	ret    
 847:	66 90                	xchg   %ax,%ax
 849:	66 90                	xchg   %ax,%ax
 84b:	66 90                	xchg   %ax,%ax
 84d:	66 90                	xchg   %ax,%ax
 84f:	90                   	nop

00000850 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	57                   	push   %edi
 854:	56                   	push   %esi
 855:	53                   	push   %ebx
 856:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 859:	85 d2                	test   %edx,%edx
{
 85b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 85e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 860:	79 76                	jns    8d8 <printint+0x88>
 862:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 866:	74 70                	je     8d8 <printint+0x88>
    x = -xx;
 868:	f7 d8                	neg    %eax
    neg = 1;
 86a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 871:	31 f6                	xor    %esi,%esi
 873:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 876:	eb 0a                	jmp    882 <printint+0x32>
 878:	90                   	nop
 879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 880:	89 fe                	mov    %edi,%esi
 882:	31 d2                	xor    %edx,%edx
 884:	8d 7e 01             	lea    0x1(%esi),%edi
 887:	f7 f1                	div    %ecx
 889:	0f b6 92 e4 0c 00 00 	movzbl 0xce4(%edx),%edx
  }while((x /= base) != 0);
 890:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 892:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 895:	75 e9                	jne    880 <printint+0x30>
  if(neg)
 897:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 89a:	85 c0                	test   %eax,%eax
 89c:	74 08                	je     8a6 <printint+0x56>
    buf[i++] = '-';
 89e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 8a3:	8d 7e 02             	lea    0x2(%esi),%edi
 8a6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 8aa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 8ad:	8d 76 00             	lea    0x0(%esi),%esi
 8b0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 8b3:	83 ec 04             	sub    $0x4,%esp
 8b6:	83 ee 01             	sub    $0x1,%esi
 8b9:	6a 01                	push   $0x1
 8bb:	53                   	push   %ebx
 8bc:	57                   	push   %edi
 8bd:	88 45 d7             	mov    %al,-0x29(%ebp)
 8c0:	e8 c2 fe ff ff       	call   787 <write>

  while(--i >= 0)
 8c5:	83 c4 10             	add    $0x10,%esp
 8c8:	39 de                	cmp    %ebx,%esi
 8ca:	75 e4                	jne    8b0 <printint+0x60>
    putc(fd, buf[i]);
}
 8cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8cf:	5b                   	pop    %ebx
 8d0:	5e                   	pop    %esi
 8d1:	5f                   	pop    %edi
 8d2:	5d                   	pop    %ebp
 8d3:	c3                   	ret    
 8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8d8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 8df:	eb 90                	jmp    871 <printint+0x21>
 8e1:	eb 0d                	jmp    8f0 <printf>
 8e3:	90                   	nop
 8e4:	90                   	nop
 8e5:	90                   	nop
 8e6:	90                   	nop
 8e7:	90                   	nop
 8e8:	90                   	nop
 8e9:	90                   	nop
 8ea:	90                   	nop
 8eb:	90                   	nop
 8ec:	90                   	nop
 8ed:	90                   	nop
 8ee:	90                   	nop
 8ef:	90                   	nop

000008f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	56                   	push   %esi
 8f5:	53                   	push   %ebx
 8f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 8fc:	0f b6 1e             	movzbl (%esi),%ebx
 8ff:	84 db                	test   %bl,%bl
 901:	0f 84 b3 00 00 00    	je     9ba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 907:	8d 45 10             	lea    0x10(%ebp),%eax
 90a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 90d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 90f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 912:	eb 2f                	jmp    943 <printf+0x53>
 914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 918:	83 f8 25             	cmp    $0x25,%eax
 91b:	0f 84 a7 00 00 00    	je     9c8 <printf+0xd8>
  write(fd, &c, 1);
 921:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 924:	83 ec 04             	sub    $0x4,%esp
 927:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 92a:	6a 01                	push   $0x1
 92c:	50                   	push   %eax
 92d:	ff 75 08             	pushl  0x8(%ebp)
 930:	e8 52 fe ff ff       	call   787 <write>
 935:	83 c4 10             	add    $0x10,%esp
 938:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 93b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 93f:	84 db                	test   %bl,%bl
 941:	74 77                	je     9ba <printf+0xca>
    if(state == 0){
 943:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 945:	0f be cb             	movsbl %bl,%ecx
 948:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 94b:	74 cb                	je     918 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 94d:	83 ff 25             	cmp    $0x25,%edi
 950:	75 e6                	jne    938 <printf+0x48>
      if(c == 'd'){
 952:	83 f8 64             	cmp    $0x64,%eax
 955:	0f 84 05 01 00 00    	je     a60 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 95b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 961:	83 f9 70             	cmp    $0x70,%ecx
 964:	74 72                	je     9d8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 966:	83 f8 73             	cmp    $0x73,%eax
 969:	0f 84 99 00 00 00    	je     a08 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 96f:	83 f8 63             	cmp    $0x63,%eax
 972:	0f 84 08 01 00 00    	je     a80 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 978:	83 f8 25             	cmp    $0x25,%eax
 97b:	0f 84 ef 00 00 00    	je     a70 <printf+0x180>
  write(fd, &c, 1);
 981:	8d 45 e7             	lea    -0x19(%ebp),%eax
 984:	83 ec 04             	sub    $0x4,%esp
 987:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 98b:	6a 01                	push   $0x1
 98d:	50                   	push   %eax
 98e:	ff 75 08             	pushl  0x8(%ebp)
 991:	e8 f1 fd ff ff       	call   787 <write>
 996:	83 c4 0c             	add    $0xc,%esp
 999:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 99c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 99f:	6a 01                	push   $0x1
 9a1:	50                   	push   %eax
 9a2:	ff 75 08             	pushl  0x8(%ebp)
 9a5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9a8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 9aa:	e8 d8 fd ff ff       	call   787 <write>
  for(i = 0; fmt[i]; i++){
 9af:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 9b3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 9b6:	84 db                	test   %bl,%bl
 9b8:	75 89                	jne    943 <printf+0x53>
    }
  }
}
 9ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9bd:	5b                   	pop    %ebx
 9be:	5e                   	pop    %esi
 9bf:	5f                   	pop    %edi
 9c0:	5d                   	pop    %ebp
 9c1:	c3                   	ret    
 9c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 9c8:	bf 25 00 00 00       	mov    $0x25,%edi
 9cd:	e9 66 ff ff ff       	jmp    938 <printf+0x48>
 9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 9d8:	83 ec 0c             	sub    $0xc,%esp
 9db:	b9 10 00 00 00       	mov    $0x10,%ecx
 9e0:	6a 00                	push   $0x0
 9e2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 9e5:	8b 45 08             	mov    0x8(%ebp),%eax
 9e8:	8b 17                	mov    (%edi),%edx
 9ea:	e8 61 fe ff ff       	call   850 <printint>
        ap++;
 9ef:	89 f8                	mov    %edi,%eax
 9f1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9f4:	31 ff                	xor    %edi,%edi
        ap++;
 9f6:	83 c0 04             	add    $0x4,%eax
 9f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 9fc:	e9 37 ff ff ff       	jmp    938 <printf+0x48>
 a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 a08:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a0b:	8b 08                	mov    (%eax),%ecx
        ap++;
 a0d:	83 c0 04             	add    $0x4,%eax
 a10:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 a13:	85 c9                	test   %ecx,%ecx
 a15:	0f 84 8e 00 00 00    	je     aa9 <printf+0x1b9>
        while(*s != 0){
 a1b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 a1e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 a20:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 a22:	84 c0                	test   %al,%al
 a24:	0f 84 0e ff ff ff    	je     938 <printf+0x48>
 a2a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 a2d:	89 de                	mov    %ebx,%esi
 a2f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a32:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 a35:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 a38:	83 ec 04             	sub    $0x4,%esp
          s++;
 a3b:	83 c6 01             	add    $0x1,%esi
 a3e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a41:	6a 01                	push   $0x1
 a43:	57                   	push   %edi
 a44:	53                   	push   %ebx
 a45:	e8 3d fd ff ff       	call   787 <write>
        while(*s != 0){
 a4a:	0f b6 06             	movzbl (%esi),%eax
 a4d:	83 c4 10             	add    $0x10,%esp
 a50:	84 c0                	test   %al,%al
 a52:	75 e4                	jne    a38 <printf+0x148>
 a54:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 a57:	31 ff                	xor    %edi,%edi
 a59:	e9 da fe ff ff       	jmp    938 <printf+0x48>
 a5e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 a60:	83 ec 0c             	sub    $0xc,%esp
 a63:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a68:	6a 01                	push   $0x1
 a6a:	e9 73 ff ff ff       	jmp    9e2 <printf+0xf2>
 a6f:	90                   	nop
  write(fd, &c, 1);
 a70:	83 ec 04             	sub    $0x4,%esp
 a73:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a76:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a79:	6a 01                	push   $0x1
 a7b:	e9 21 ff ff ff       	jmp    9a1 <printf+0xb1>
        putc(fd, *ap);
 a80:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 a83:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a86:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 a88:	6a 01                	push   $0x1
        ap++;
 a8a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 a8d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 a90:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a93:	50                   	push   %eax
 a94:	ff 75 08             	pushl  0x8(%ebp)
 a97:	e8 eb fc ff ff       	call   787 <write>
        ap++;
 a9c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 a9f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 aa2:	31 ff                	xor    %edi,%edi
 aa4:	e9 8f fe ff ff       	jmp    938 <printf+0x48>
          s = "(null)";
 aa9:	bb dc 0c 00 00       	mov    $0xcdc,%ebx
        while(*s != 0){
 aae:	b8 28 00 00 00       	mov    $0x28,%eax
 ab3:	e9 72 ff ff ff       	jmp    a2a <printf+0x13a>
 ab8:	66 90                	xchg   %ax,%ax
 aba:	66 90                	xchg   %ax,%ax
 abc:	66 90                	xchg   %ax,%ax
 abe:	66 90                	xchg   %ax,%ax

00000ac0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ac0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac1:	a1 ec 10 00 00       	mov    0x10ec,%eax
{
 ac6:	89 e5                	mov    %esp,%ebp
 ac8:	57                   	push   %edi
 ac9:	56                   	push   %esi
 aca:	53                   	push   %ebx
 acb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 ace:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad8:	39 c8                	cmp    %ecx,%eax
 ada:	8b 10                	mov    (%eax),%edx
 adc:	73 32                	jae    b10 <free+0x50>
 ade:	39 d1                	cmp    %edx,%ecx
 ae0:	72 04                	jb     ae6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae2:	39 d0                	cmp    %edx,%eax
 ae4:	72 32                	jb     b18 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ae6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ae9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 aec:	39 fa                	cmp    %edi,%edx
 aee:	74 30                	je     b20 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 af0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 af3:	8b 50 04             	mov    0x4(%eax),%edx
 af6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 af9:	39 f1                	cmp    %esi,%ecx
 afb:	74 3a                	je     b37 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 afd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 aff:	a3 ec 10 00 00       	mov    %eax,0x10ec
}
 b04:	5b                   	pop    %ebx
 b05:	5e                   	pop    %esi
 b06:	5f                   	pop    %edi
 b07:	5d                   	pop    %ebp
 b08:	c3                   	ret    
 b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b10:	39 d0                	cmp    %edx,%eax
 b12:	72 04                	jb     b18 <free+0x58>
 b14:	39 d1                	cmp    %edx,%ecx
 b16:	72 ce                	jb     ae6 <free+0x26>
{
 b18:	89 d0                	mov    %edx,%eax
 b1a:	eb bc                	jmp    ad8 <free+0x18>
 b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b20:	03 72 04             	add    0x4(%edx),%esi
 b23:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b26:	8b 10                	mov    (%eax),%edx
 b28:	8b 12                	mov    (%edx),%edx
 b2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b2d:	8b 50 04             	mov    0x4(%eax),%edx
 b30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b33:	39 f1                	cmp    %esi,%ecx
 b35:	75 c6                	jne    afd <free+0x3d>
    p->s.size += bp->s.size;
 b37:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b3a:	a3 ec 10 00 00       	mov    %eax,0x10ec
    p->s.size += bp->s.size;
 b3f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b42:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b45:	89 10                	mov    %edx,(%eax)
}
 b47:	5b                   	pop    %ebx
 b48:	5e                   	pop    %esi
 b49:	5f                   	pop    %edi
 b4a:	5d                   	pop    %ebp
 b4b:	c3                   	ret    
 b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
 b53:	57                   	push   %edi
 b54:	56                   	push   %esi
 b55:	53                   	push   %ebx
 b56:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b59:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b5c:	8b 15 ec 10 00 00    	mov    0x10ec,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b62:	8d 78 07             	lea    0x7(%eax),%edi
 b65:	c1 ef 03             	shr    $0x3,%edi
 b68:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b6b:	85 d2                	test   %edx,%edx
 b6d:	0f 84 9d 00 00 00    	je     c10 <malloc+0xc0>
 b73:	8b 02                	mov    (%edx),%eax
 b75:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b78:	39 cf                	cmp    %ecx,%edi
 b7a:	76 6c                	jbe    be8 <malloc+0x98>
 b7c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b82:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b87:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b8a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b91:	eb 0e                	jmp    ba1 <malloc+0x51>
 b93:	90                   	nop
 b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b98:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b9a:	8b 48 04             	mov    0x4(%eax),%ecx
 b9d:	39 f9                	cmp    %edi,%ecx
 b9f:	73 47                	jae    be8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ba1:	39 05 ec 10 00 00    	cmp    %eax,0x10ec
 ba7:	89 c2                	mov    %eax,%edx
 ba9:	75 ed                	jne    b98 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 bab:	83 ec 0c             	sub    $0xc,%esp
 bae:	56                   	push   %esi
 baf:	e8 3b fc ff ff       	call   7ef <sbrk>
  if(p == (char*)-1)
 bb4:	83 c4 10             	add    $0x10,%esp
 bb7:	83 f8 ff             	cmp    $0xffffffff,%eax
 bba:	74 1c                	je     bd8 <malloc+0x88>
  hp->s.size = nu;
 bbc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 bbf:	83 ec 0c             	sub    $0xc,%esp
 bc2:	83 c0 08             	add    $0x8,%eax
 bc5:	50                   	push   %eax
 bc6:	e8 f5 fe ff ff       	call   ac0 <free>
  return freep;
 bcb:	8b 15 ec 10 00 00    	mov    0x10ec,%edx
      if((p = morecore(nunits)) == 0)
 bd1:	83 c4 10             	add    $0x10,%esp
 bd4:	85 d2                	test   %edx,%edx
 bd6:	75 c0                	jne    b98 <malloc+0x48>
        return 0;
  }
}
 bd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 bdb:	31 c0                	xor    %eax,%eax
}
 bdd:	5b                   	pop    %ebx
 bde:	5e                   	pop    %esi
 bdf:	5f                   	pop    %edi
 be0:	5d                   	pop    %ebp
 be1:	c3                   	ret    
 be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 be8:	39 cf                	cmp    %ecx,%edi
 bea:	74 54                	je     c40 <malloc+0xf0>
        p->s.size -= nunits;
 bec:	29 f9                	sub    %edi,%ecx
 bee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 bf1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bf4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 bf7:	89 15 ec 10 00 00    	mov    %edx,0x10ec
}
 bfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c00:	83 c0 08             	add    $0x8,%eax
}
 c03:	5b                   	pop    %ebx
 c04:	5e                   	pop    %esi
 c05:	5f                   	pop    %edi
 c06:	5d                   	pop    %ebp
 c07:	c3                   	ret    
 c08:	90                   	nop
 c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 c10:	c7 05 ec 10 00 00 f0 	movl   $0x10f0,0x10ec
 c17:	10 00 00 
 c1a:	c7 05 f0 10 00 00 f0 	movl   $0x10f0,0x10f0
 c21:	10 00 00 
    base.s.size = 0;
 c24:	b8 f0 10 00 00       	mov    $0x10f0,%eax
 c29:	c7 05 f4 10 00 00 00 	movl   $0x0,0x10f4
 c30:	00 00 00 
 c33:	e9 44 ff ff ff       	jmp    b7c <malloc+0x2c>
 c38:	90                   	nop
 c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 c40:	8b 08                	mov    (%eax),%ecx
 c42:	89 0a                	mov    %ecx,(%edx)
 c44:	eb b1                	jmp    bf7 <malloc+0xa7>
