
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 58 08 00 00       	push   $0x858
  19:	e8 99 03 00 00       	call   3b7 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 9f 00 00 00    	js     c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 bc 03 00 00       	call   3ef <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 b0 03 00 00       	call   3ef <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\nHamed,Mehrab,Ali\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 98 08 00 00       	push   $0x898
  50:	6a 01                	push   $0x1
  52:	e8 a9 04 00 00       	call   500 <printf>
    pid = fork();
  57:	e8 13 03 00 00       	call   36f <fork>
    if(pid < 0){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	85 c0                	test   %eax,%eax
    pid = fork();
  61:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  63:	78 2c                	js     91 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  65:	74 3d                	je     a4 <main+0xa4>
  67:	89 f6                	mov    %esi,%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 0a 03 00 00       	call   37f <wait>
  75:	85 c0                	test   %eax,%eax
  77:	78 cf                	js     48 <main+0x48>
  79:	39 c3                	cmp    %eax,%ebx
  7b:	74 cb                	je     48 <main+0x48>
      printf(1, "zombie!\n");
  7d:	83 ec 08             	sub    $0x8,%esp
  80:	68 8c 08 00 00       	push   $0x88c
  85:	6a 01                	push   $0x1
  87:	e8 74 04 00 00       	call   500 <printf>
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	eb df                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  91:	53                   	push   %ebx
  92:	53                   	push   %ebx
  93:	68 60 08 00 00       	push   $0x860
  98:	6a 01                	push   $0x1
  9a:	e8 61 04 00 00       	call   500 <printf>
      exit();
  9f:	e8 d3 02 00 00       	call   377 <exit>
      exec("sh", argv);
  a4:	50                   	push   %eax
  a5:	50                   	push   %eax
  a6:	68 90 0b 00 00       	push   $0xb90
  ab:	68 73 08 00 00       	push   $0x873
  b0:	e8 fa 02 00 00       	call   3af <exec>
      printf(1, "init: exec sh failed\n");
  b5:	5a                   	pop    %edx
  b6:	59                   	pop    %ecx
  b7:	68 76 08 00 00       	push   $0x876
  bc:	6a 01                	push   $0x1
  be:	e8 3d 04 00 00       	call   500 <printf>
      exit();
  c3:	e8 af 02 00 00       	call   377 <exit>
    mknod("console", 1, 1);
  c8:	50                   	push   %eax
  c9:	6a 01                	push   $0x1
  cb:	6a 01                	push   $0x1
  cd:	68 58 08 00 00       	push   $0x858
  d2:	e8 e8 02 00 00       	call   3bf <mknod>
    open("console", O_RDWR);
  d7:	58                   	pop    %eax
  d8:	5a                   	pop    %edx
  d9:	6a 02                	push   $0x2
  db:	68 58 08 00 00       	push   $0x858
  e0:	e8 d2 02 00 00       	call   3b7 <open>
  e5:	83 c4 10             	add    $0x10,%esp
  e8:	e9 3c ff ff ff       	jmp    29 <main+0x29>
  ed:	66 90                	xchg   %ax,%ax
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fa:	89 c2                	mov    %eax,%edx
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 100:	83 c1 01             	add    $0x1,%ecx
 103:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 107:	83 c2 01             	add    $0x1,%edx
 10a:	84 db                	test   %bl,%bl
 10c:	88 5a ff             	mov    %bl,-0x1(%edx)
 10f:	75 ef                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 55 08             	mov    0x8(%ebp),%edx
 127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 12a:	0f b6 02             	movzbl (%edx),%eax
 12d:	0f b6 19             	movzbl (%ecx),%ebx
 130:	84 c0                	test   %al,%al
 132:	75 1c                	jne    150 <strcmp+0x30>
 134:	eb 2a                	jmp    160 <strcmp+0x40>
 136:	8d 76 00             	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 140:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 143:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 146:	83 c1 01             	add    $0x1,%ecx
 149:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 14c:	84 c0                	test   %al,%al
 14e:	74 10                	je     160 <strcmp+0x40>
 150:	38 d8                	cmp    %bl,%al
 152:	74 ec                	je     140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 154:	29 d8                	sub    %ebx,%eax
}
 156:	5b                   	pop    %ebx
 157:	5d                   	pop    %ebp
 158:	c3                   	ret    
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 162:	29 d8                	sub    %ebx,%eax
}
 164:	5b                   	pop    %ebx
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strlen>:

uint
strlen(const char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 39 00             	cmpb   $0x0,(%ecx)
 179:	74 15                	je     190 <strlen+0x20>
 17b:	31 d2                	xor    %edx,%edx
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	83 c2 01             	add    $0x1,%edx
 183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 187:	89 d0                	mov    %edx,%eax
 189:	75 f5                	jne    180 <strlen+0x10>
    ;
  return n;
}
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    
 18d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 190:	31 c0                	xor    %eax,%eax
}
 192:	5d                   	pop    %ebp
 193:	c3                   	ret    
 194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 19a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	89 d0                	mov    %edx,%eax
 1b4:	5f                   	pop    %edi
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	74 1d                	je     1ee <strchr+0x2e>
    if(*s == c)
 1d1:	38 d3                	cmp    %dl,%bl
 1d3:	89 d9                	mov    %ebx,%ecx
 1d5:	75 0d                	jne    1e4 <strchr+0x24>
 1d7:	eb 17                	jmp    1f0 <strchr+0x30>
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e0:	38 ca                	cmp    %cl,%dl
 1e2:	74 0c                	je     1f0 <strchr+0x30>
  for(; *s; s++)
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	0f b6 10             	movzbl (%eax),%edx
 1ea:	84 d2                	test   %dl,%dl
 1ec:	75 f2                	jne    1e0 <strchr+0x20>
      return (char*)s;
  return 0;
 1ee:	31 c0                	xor    %eax,%eax
}
 1f0:	5b                   	pop    %ebx
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    
 1f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 206:	31 f6                	xor    %esi,%esi
 208:	89 f3                	mov    %esi,%ebx
{
 20a:	83 ec 1c             	sub    $0x1c,%esp
 20d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 210:	eb 2f                	jmp    241 <gets+0x41>
 212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 218:	8d 45 e7             	lea    -0x19(%ebp),%eax
 21b:	83 ec 04             	sub    $0x4,%esp
 21e:	6a 01                	push   $0x1
 220:	50                   	push   %eax
 221:	6a 00                	push   $0x0
 223:	e8 67 01 00 00       	call   38f <read>
    if(cc < 1)
 228:	83 c4 10             	add    $0x10,%esp
 22b:	85 c0                	test   %eax,%eax
 22d:	7e 1c                	jle    24b <gets+0x4b>
      break;
    buf[i++] = c;
 22f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 233:	83 c7 01             	add    $0x1,%edi
 236:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 239:	3c 0a                	cmp    $0xa,%al
 23b:	74 23                	je     260 <gets+0x60>
 23d:	3c 0d                	cmp    $0xd,%al
 23f:	74 1f                	je     260 <gets+0x60>
  for(i=0; i+1 < max; ){
 241:	83 c3 01             	add    $0x1,%ebx
 244:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 247:	89 fe                	mov    %edi,%esi
 249:	7c cd                	jl     218 <gets+0x18>
 24b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 250:	c6 03 00             	movb   $0x0,(%ebx)
}
 253:	8d 65 f4             	lea    -0xc(%ebp),%esp
 256:	5b                   	pop    %ebx
 257:	5e                   	pop    %esi
 258:	5f                   	pop    %edi
 259:	5d                   	pop    %ebp
 25a:	c3                   	ret    
 25b:	90                   	nop
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 260:	8b 75 08             	mov    0x8(%ebp),%esi
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	01 de                	add    %ebx,%esi
 268:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 26a:	c6 03 00             	movb   $0x0,(%ebx)
}
 26d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 270:	5b                   	pop    %ebx
 271:	5e                   	pop    %esi
 272:	5f                   	pop    %edi
 273:	5d                   	pop    %ebp
 274:	c3                   	ret    
 275:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <stat>:

int
stat(const char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 285:	83 ec 08             	sub    $0x8,%esp
 288:	6a 00                	push   $0x0
 28a:	ff 75 08             	pushl  0x8(%ebp)
 28d:	e8 25 01 00 00       	call   3b7 <open>
  if(fd < 0)
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 27                	js     2c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	pushl  0xc(%ebp)
 29f:	89 c3                	mov    %eax,%ebx
 2a1:	50                   	push   %eax
 2a2:	e8 28 01 00 00       	call   3cf <fstat>
  close(fd);
 2a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2aa:	89 c6                	mov    %eax,%esi
  close(fd);
 2ac:	e8 ee 00 00 00       	call   39f <close>
  return r;
 2b1:	83 c4 10             	add    $0x10,%esp
}
 2b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b7:	89 f0                	mov    %esi,%eax
 2b9:	5b                   	pop    %ebx
 2ba:	5e                   	pop    %esi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb ed                	jmp    2b4 <stat+0x34>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 11             	movsbl (%ecx),%edx
 2da:	8d 42 d0             	lea    -0x30(%edx),%eax
 2dd:	3c 09                	cmp    $0x9,%al
  n = 0;
 2df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2e4:	77 1f                	ja     305 <atoi+0x35>
 2e6:	8d 76 00             	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 2f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2f3:	83 c1 01             	add    $0x1,%ecx
 2f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2fa:	0f be 11             	movsbl (%ecx),%edx
 2fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
  return n;
}
 305:	5b                   	pop    %ebx
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
 315:	8b 5d 10             	mov    0x10(%ebp),%ebx
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	85 db                	test   %ebx,%ebx
 320:	7e 14                	jle    336 <memmove+0x26>
 322:	31 d2                	xor    %edx,%edx
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 328:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 32c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 32f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 332:	39 d3                	cmp    %edx,%ebx
 334:	75 f2                	jne    328 <memmove+0x18>
  return vdst;
}
 336:	5b                   	pop    %ebx
 337:	5e                   	pop    %esi
 338:	5d                   	pop    %ebp
 339:	c3                   	ret    
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000340 <delay>:

void delay(int numberOfClocks)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	83 ec 04             	sub    $0x4,%esp
    int firstClock = uptime();
 347:	e8 c3 00 00 00       	call   40f <uptime>
 34c:	89 c3                	mov    %eax,%ebx
    int incClock = uptime();
 34e:	e8 bc 00 00 00       	call   40f <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 353:	03 5d 08             	add    0x8(%ebp),%ebx
 356:	39 d8                	cmp    %ebx,%eax
 358:	7c 0f                	jl     369 <delay+0x29>
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    {
        incClock = uptime();
 360:	e8 aa 00 00 00       	call   40f <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 365:	39 d8                	cmp    %ebx,%eax
 367:	7d f7                	jge    360 <delay+0x20>
    }
}
 369:	83 c4 04             	add    $0x4,%esp
 36c:	5b                   	pop    %ebx
 36d:	5d                   	pop    %ebp
 36e:	c3                   	ret    

0000036f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36f:	b8 01 00 00 00       	mov    $0x1,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <exit>:
SYSCALL(exit)
 377:	b8 02 00 00 00       	mov    $0x2,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <wait>:
SYSCALL(wait)
 37f:	b8 03 00 00 00       	mov    $0x3,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <pipe>:
SYSCALL(pipe)
 387:	b8 04 00 00 00       	mov    $0x4,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <read>:
SYSCALL(read)
 38f:	b8 05 00 00 00       	mov    $0x5,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <write>:
SYSCALL(write)
 397:	b8 10 00 00 00       	mov    $0x10,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <close>:
SYSCALL(close)
 39f:	b8 15 00 00 00       	mov    $0x15,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <kill>:
SYSCALL(kill)
 3a7:	b8 06 00 00 00       	mov    $0x6,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <exec>:
SYSCALL(exec)
 3af:	b8 07 00 00 00       	mov    $0x7,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <open>:
SYSCALL(open)
 3b7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <mknod>:
SYSCALL(mknod)
 3bf:	b8 11 00 00 00       	mov    $0x11,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <unlink>:
SYSCALL(unlink)
 3c7:	b8 12 00 00 00       	mov    $0x12,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <fstat>:
SYSCALL(fstat)
 3cf:	b8 08 00 00 00       	mov    $0x8,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <link>:
SYSCALL(link)
 3d7:	b8 13 00 00 00       	mov    $0x13,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <mkdir>:
SYSCALL(mkdir)
 3df:	b8 14 00 00 00       	mov    $0x14,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <chdir>:
SYSCALL(chdir)
 3e7:	b8 09 00 00 00       	mov    $0x9,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <dup>:
SYSCALL(dup)
 3ef:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret    

000003f7 <getpid>:
SYSCALL(getpid)
 3f7:	b8 0b 00 00 00       	mov    $0xb,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret    

000003ff <sbrk>:
SYSCALL(sbrk)
 3ff:	b8 0c 00 00 00       	mov    $0xc,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret    

00000407 <sleep>:
SYSCALL(sleep)
 407:	b8 0d 00 00 00       	mov    $0xd,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret    

0000040f <uptime>:
SYSCALL(uptime)
 40f:	b8 0e 00 00 00       	mov    $0xe,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret    

00000417 <incNum>:
SYSCALL(incNum)
 417:	b8 16 00 00 00       	mov    $0x16,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret    

0000041f <getprocs>:
SYSCALL(getprocs)
 41f:	b8 17 00 00 00       	mov    $0x17,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret    

00000427 <set_burst_time>:
SYSCALL(set_burst_time)
 427:	b8 18 00 00 00       	mov    $0x18,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret    

0000042f <set_priority>:
SYSCALL(set_priority)
 42f:	b8 19 00 00 00       	mov    $0x19,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret    

00000437 <set_lottery_ticket>:
SYSCALL(set_lottery_ticket)
 437:	b8 1a 00 00 00       	mov    $0x1a,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret    

0000043f <set_sched_queue>:
SYSCALL(set_sched_queue)
 43f:	b8 1b 00 00 00       	mov    $0x1b,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret    

00000447 <show_processes_scheduling>:
SYSCALL(show_processes_scheduling)
 447:	b8 1c 00 00 00       	mov    $0x1c,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret    

0000044f <getNumFreePages>:
 44f:	b8 1d 00 00 00       	mov    $0x1d,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret    
 457:	66 90                	xchg   %ax,%ax
 459:	66 90                	xchg   %ax,%ax
 45b:	66 90                	xchg   %ax,%ax
 45d:	66 90                	xchg   %ax,%ax
 45f:	90                   	nop

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 469:	85 d2                	test   %edx,%edx
{
 46b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 46e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 470:	79 76                	jns    4e8 <printint+0x88>
 472:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 476:	74 70                	je     4e8 <printint+0x88>
    x = -xx;
 478:	f7 d8                	neg    %eax
    neg = 1;
 47a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 481:	31 f6                	xor    %esi,%esi
 483:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 486:	eb 0a                	jmp    492 <printint+0x32>
 488:	90                   	nop
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 490:	89 fe                	mov    %edi,%esi
 492:	31 d2                	xor    %edx,%edx
 494:	8d 7e 01             	lea    0x1(%esi),%edi
 497:	f7 f1                	div    %ecx
 499:	0f b6 92 c4 08 00 00 	movzbl 0x8c4(%edx),%edx
  }while((x /= base) != 0);
 4a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4a2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 4a5:	75 e9                	jne    490 <printint+0x30>
  if(neg)
 4a7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4aa:	85 c0                	test   %eax,%eax
 4ac:	74 08                	je     4b6 <printint+0x56>
    buf[i++] = '-';
 4ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4b3:	8d 7e 02             	lea    0x2(%esi),%edi
 4b6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 4ba:	8b 7d c0             	mov    -0x40(%ebp),%edi
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 4c3:	83 ec 04             	sub    $0x4,%esp
 4c6:	83 ee 01             	sub    $0x1,%esi
 4c9:	6a 01                	push   $0x1
 4cb:	53                   	push   %ebx
 4cc:	57                   	push   %edi
 4cd:	88 45 d7             	mov    %al,-0x29(%ebp)
 4d0:	e8 c2 fe ff ff       	call   397 <write>

  while(--i >= 0)
 4d5:	83 c4 10             	add    $0x10,%esp
 4d8:	39 de                	cmp    %ebx,%esi
 4da:	75 e4                	jne    4c0 <printint+0x60>
    putc(fd, buf[i]);
}
 4dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4df:	5b                   	pop    %ebx
 4e0:	5e                   	pop    %esi
 4e1:	5f                   	pop    %edi
 4e2:	5d                   	pop    %ebp
 4e3:	c3                   	ret    
 4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4e8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4ef:	eb 90                	jmp    481 <printint+0x21>
 4f1:	eb 0d                	jmp    500 <printf>
 4f3:	90                   	nop
 4f4:	90                   	nop
 4f5:	90                   	nop
 4f6:	90                   	nop
 4f7:	90                   	nop
 4f8:	90                   	nop
 4f9:	90                   	nop
 4fa:	90                   	nop
 4fb:	90                   	nop
 4fc:	90                   	nop
 4fd:	90                   	nop
 4fe:	90                   	nop
 4ff:	90                   	nop

00000500 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 509:	8b 75 0c             	mov    0xc(%ebp),%esi
 50c:	0f b6 1e             	movzbl (%esi),%ebx
 50f:	84 db                	test   %bl,%bl
 511:	0f 84 b3 00 00 00    	je     5ca <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 517:	8d 45 10             	lea    0x10(%ebp),%eax
 51a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 51d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 51f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 522:	eb 2f                	jmp    553 <printf+0x53>
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 528:	83 f8 25             	cmp    $0x25,%eax
 52b:	0f 84 a7 00 00 00    	je     5d8 <printf+0xd8>
  write(fd, &c, 1);
 531:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 534:	83 ec 04             	sub    $0x4,%esp
 537:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 53a:	6a 01                	push   $0x1
 53c:	50                   	push   %eax
 53d:	ff 75 08             	pushl  0x8(%ebp)
 540:	e8 52 fe ff ff       	call   397 <write>
 545:	83 c4 10             	add    $0x10,%esp
 548:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 54b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 54f:	84 db                	test   %bl,%bl
 551:	74 77                	je     5ca <printf+0xca>
    if(state == 0){
 553:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 555:	0f be cb             	movsbl %bl,%ecx
 558:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 55b:	74 cb                	je     528 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 55d:	83 ff 25             	cmp    $0x25,%edi
 560:	75 e6                	jne    548 <printf+0x48>
      if(c == 'd'){
 562:	83 f8 64             	cmp    $0x64,%eax
 565:	0f 84 05 01 00 00    	je     670 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 56b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 571:	83 f9 70             	cmp    $0x70,%ecx
 574:	74 72                	je     5e8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 576:	83 f8 73             	cmp    $0x73,%eax
 579:	0f 84 99 00 00 00    	je     618 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 57f:	83 f8 63             	cmp    $0x63,%eax
 582:	0f 84 08 01 00 00    	je     690 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 588:	83 f8 25             	cmp    $0x25,%eax
 58b:	0f 84 ef 00 00 00    	je     680 <printf+0x180>
  write(fd, &c, 1);
 591:	8d 45 e7             	lea    -0x19(%ebp),%eax
 594:	83 ec 04             	sub    $0x4,%esp
 597:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 59b:	6a 01                	push   $0x1
 59d:	50                   	push   %eax
 59e:	ff 75 08             	pushl  0x8(%ebp)
 5a1:	e8 f1 fd ff ff       	call   397 <write>
 5a6:	83 c4 0c             	add    $0xc,%esp
 5a9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5ac:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5af:	6a 01                	push   $0x1
 5b1:	50                   	push   %eax
 5b2:	ff 75 08             	pushl  0x8(%ebp)
 5b5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5b8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5ba:	e8 d8 fd ff ff       	call   397 <write>
  for(i = 0; fmt[i]; i++){
 5bf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 5c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5c6:	84 db                	test   %bl,%bl
 5c8:	75 89                	jne    553 <printf+0x53>
    }
  }
}
 5ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5cd:	5b                   	pop    %ebx
 5ce:	5e                   	pop    %esi
 5cf:	5f                   	pop    %edi
 5d0:	5d                   	pop    %ebp
 5d1:	c3                   	ret    
 5d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 5d8:	bf 25 00 00 00       	mov    $0x25,%edi
 5dd:	e9 66 ff ff ff       	jmp    548 <printf+0x48>
 5e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5e8:	83 ec 0c             	sub    $0xc,%esp
 5eb:	b9 10 00 00 00       	mov    $0x10,%ecx
 5f0:	6a 00                	push   $0x0
 5f2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5f5:	8b 45 08             	mov    0x8(%ebp),%eax
 5f8:	8b 17                	mov    (%edi),%edx
 5fa:	e8 61 fe ff ff       	call   460 <printint>
        ap++;
 5ff:	89 f8                	mov    %edi,%eax
 601:	83 c4 10             	add    $0x10,%esp
      state = 0;
 604:	31 ff                	xor    %edi,%edi
        ap++;
 606:	83 c0 04             	add    $0x4,%eax
 609:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 60c:	e9 37 ff ff ff       	jmp    548 <printf+0x48>
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 618:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 61b:	8b 08                	mov    (%eax),%ecx
        ap++;
 61d:	83 c0 04             	add    $0x4,%eax
 620:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 623:	85 c9                	test   %ecx,%ecx
 625:	0f 84 8e 00 00 00    	je     6b9 <printf+0x1b9>
        while(*s != 0){
 62b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 62e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 630:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 632:	84 c0                	test   %al,%al
 634:	0f 84 0e ff ff ff    	je     548 <printf+0x48>
 63a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 63d:	89 de                	mov    %ebx,%esi
 63f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 642:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 645:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 648:	83 ec 04             	sub    $0x4,%esp
          s++;
 64b:	83 c6 01             	add    $0x1,%esi
 64e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 651:	6a 01                	push   $0x1
 653:	57                   	push   %edi
 654:	53                   	push   %ebx
 655:	e8 3d fd ff ff       	call   397 <write>
        while(*s != 0){
 65a:	0f b6 06             	movzbl (%esi),%eax
 65d:	83 c4 10             	add    $0x10,%esp
 660:	84 c0                	test   %al,%al
 662:	75 e4                	jne    648 <printf+0x148>
 664:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 667:	31 ff                	xor    %edi,%edi
 669:	e9 da fe ff ff       	jmp    548 <printf+0x48>
 66e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 670:	83 ec 0c             	sub    $0xc,%esp
 673:	b9 0a 00 00 00       	mov    $0xa,%ecx
 678:	6a 01                	push   $0x1
 67a:	e9 73 ff ff ff       	jmp    5f2 <printf+0xf2>
 67f:	90                   	nop
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 686:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 689:	6a 01                	push   $0x1
 68b:	e9 21 ff ff ff       	jmp    5b1 <printf+0xb1>
        putc(fd, *ap);
 690:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 693:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 696:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 698:	6a 01                	push   $0x1
        ap++;
 69a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 69d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6a3:	50                   	push   %eax
 6a4:	ff 75 08             	pushl  0x8(%ebp)
 6a7:	e8 eb fc ff ff       	call   397 <write>
        ap++;
 6ac:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 6af:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6b2:	31 ff                	xor    %edi,%edi
 6b4:	e9 8f fe ff ff       	jmp    548 <printf+0x48>
          s = "(null)";
 6b9:	bb bc 08 00 00       	mov    $0x8bc,%ebx
        while(*s != 0){
 6be:	b8 28 00 00 00       	mov    $0x28,%eax
 6c3:	e9 72 ff ff ff       	jmp    63a <printf+0x13a>
 6c8:	66 90                	xchg   %ax,%ax
 6ca:	66 90                	xchg   %ax,%ax
 6cc:	66 90                	xchg   %ax,%ax
 6ce:	66 90                	xchg   %ax,%ax

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	a1 98 0b 00 00       	mov    0xb98,%eax
{
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 6e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e8:	39 c8                	cmp    %ecx,%eax
 6ea:	8b 10                	mov    (%eax),%edx
 6ec:	73 32                	jae    720 <free+0x50>
 6ee:	39 d1                	cmp    %edx,%ecx
 6f0:	72 04                	jb     6f6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f2:	39 d0                	cmp    %edx,%eax
 6f4:	72 32                	jb     728 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6f9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6fc:	39 fa                	cmp    %edi,%edx
 6fe:	74 30                	je     730 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 700:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 703:	8b 50 04             	mov    0x4(%eax),%edx
 706:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 709:	39 f1                	cmp    %esi,%ecx
 70b:	74 3a                	je     747 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 70d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 70f:	a3 98 0b 00 00       	mov    %eax,0xb98
}
 714:	5b                   	pop    %ebx
 715:	5e                   	pop    %esi
 716:	5f                   	pop    %edi
 717:	5d                   	pop    %ebp
 718:	c3                   	ret    
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 720:	39 d0                	cmp    %edx,%eax
 722:	72 04                	jb     728 <free+0x58>
 724:	39 d1                	cmp    %edx,%ecx
 726:	72 ce                	jb     6f6 <free+0x26>
{
 728:	89 d0                	mov    %edx,%eax
 72a:	eb bc                	jmp    6e8 <free+0x18>
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 730:	03 72 04             	add    0x4(%edx),%esi
 733:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 736:	8b 10                	mov    (%eax),%edx
 738:	8b 12                	mov    (%edx),%edx
 73a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 73d:	8b 50 04             	mov    0x4(%eax),%edx
 740:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 743:	39 f1                	cmp    %esi,%ecx
 745:	75 c6                	jne    70d <free+0x3d>
    p->s.size += bp->s.size;
 747:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 74a:	a3 98 0b 00 00       	mov    %eax,0xb98
    p->s.size += bp->s.size;
 74f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 752:	8b 53 f8             	mov    -0x8(%ebx),%edx
 755:	89 10                	mov    %edx,(%eax)
}
 757:	5b                   	pop    %ebx
 758:	5e                   	pop    %esi
 759:	5f                   	pop    %edi
 75a:	5d                   	pop    %ebp
 75b:	c3                   	ret    
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 98 0b 00 00    	mov    0xb98,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 77b:	85 d2                	test   %edx,%edx
 77d:	0f 84 9d 00 00 00    	je     820 <malloc+0xc0>
 783:	8b 02                	mov    (%edx),%eax
 785:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 788:	39 cf                	cmp    %ecx,%edi
 78a:	76 6c                	jbe    7f8 <malloc+0x98>
 78c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 792:	bb 00 10 00 00       	mov    $0x1000,%ebx
 797:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 79a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7a1:	eb 0e                	jmp    7b1 <malloc+0x51>
 7a3:	90                   	nop
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7aa:	8b 48 04             	mov    0x4(%eax),%ecx
 7ad:	39 f9                	cmp    %edi,%ecx
 7af:	73 47                	jae    7f8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b1:	39 05 98 0b 00 00    	cmp    %eax,0xb98
 7b7:	89 c2                	mov    %eax,%edx
 7b9:	75 ed                	jne    7a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7bb:	83 ec 0c             	sub    $0xc,%esp
 7be:	56                   	push   %esi
 7bf:	e8 3b fc ff ff       	call   3ff <sbrk>
  if(p == (char*)-1)
 7c4:	83 c4 10             	add    $0x10,%esp
 7c7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ca:	74 1c                	je     7e8 <malloc+0x88>
  hp->s.size = nu;
 7cc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7cf:	83 ec 0c             	sub    $0xc,%esp
 7d2:	83 c0 08             	add    $0x8,%eax
 7d5:	50                   	push   %eax
 7d6:	e8 f5 fe ff ff       	call   6d0 <free>
  return freep;
 7db:	8b 15 98 0b 00 00    	mov    0xb98,%edx
      if((p = morecore(nunits)) == 0)
 7e1:	83 c4 10             	add    $0x10,%esp
 7e4:	85 d2                	test   %edx,%edx
 7e6:	75 c0                	jne    7a8 <malloc+0x48>
        return 0;
  }
}
 7e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7eb:	31 c0                	xor    %eax,%eax
}
 7ed:	5b                   	pop    %ebx
 7ee:	5e                   	pop    %esi
 7ef:	5f                   	pop    %edi
 7f0:	5d                   	pop    %ebp
 7f1:	c3                   	ret    
 7f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7f8:	39 cf                	cmp    %ecx,%edi
 7fa:	74 54                	je     850 <malloc+0xf0>
        p->s.size -= nunits;
 7fc:	29 f9                	sub    %edi,%ecx
 7fe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 801:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 804:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 807:	89 15 98 0b 00 00    	mov    %edx,0xb98
}
 80d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 810:	83 c0 08             	add    $0x8,%eax
}
 813:	5b                   	pop    %ebx
 814:	5e                   	pop    %esi
 815:	5f                   	pop    %edi
 816:	5d                   	pop    %ebp
 817:	c3                   	ret    
 818:	90                   	nop
 819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 820:	c7 05 98 0b 00 00 9c 	movl   $0xb9c,0xb98
 827:	0b 00 00 
 82a:	c7 05 9c 0b 00 00 9c 	movl   $0xb9c,0xb9c
 831:	0b 00 00 
    base.s.size = 0;
 834:	b8 9c 0b 00 00       	mov    $0xb9c,%eax
 839:	c7 05 a0 0b 00 00 00 	movl   $0x0,0xba0
 840:	00 00 00 
 843:	e9 44 ff ff ff       	jmp    78c <malloc+0x2c>
 848:	90                   	nop
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 850:	8b 08                	mov    (%eax),%ecx
 852:	89 0a                	mov    %ecx,(%edx)
 854:	eb b1                	jmp    807 <malloc+0xa7>
