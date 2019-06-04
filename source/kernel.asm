
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 00 c6 10 80       	mov    $0x8010c600,%esp
8010002d:	b8 90 32 10 80       	mov    $0x80103290,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 34 c6 10 80       	mov    $0x8010c634,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 80 10 80       	push   $0x80108000
80100051:	68 00 c6 10 80       	push   $0x8010c600
80100056:	e8 b5 4f 00 00       	call   80105010 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 4c 0d 11 80 fc 	movl   $0x80110cfc,0x80110d4c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 50 0d 11 80 fc 	movl   $0x80110cfc,0x80110d50
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba fc 0c 11 80       	mov    $0x80110cfc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 80 10 80       	push   $0x80108007
80100097:	50                   	push   %eax
80100098:	e8 43 4e 00 00       	call   80104ee0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 50 0d 11 80       	mov    0x80110d50,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d fc 0c 11 80       	cmp    $0x80110cfc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 00 c6 10 80       	push   $0x8010c600
801000e4:	e8 67 50 00 00       	call   80105150 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 50 0d 11 80    	mov    0x80110d50,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 4c 0d 11 80    	mov    0x80110d4c,%ebx
80100126:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 00 c6 10 80       	push   $0x8010c600
80100162:	e8 a9 50 00 00       	call   80105210 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ae 4d 00 00       	call   80104f20 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 0d 23 00 00       	call   80102490 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 0e 80 10 80       	push   $0x8010800e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 0d 4e 00 00       	call   80104fc0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 c7 22 00 00       	jmp    80102490 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 1f 80 10 80       	push   $0x8010801f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 cc 4d 00 00       	call   80104fc0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 7c 4d 00 00       	call   80104f80 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010020b:	e8 40 4f 00 00       	call   80105150 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 50 0d 11 80       	mov    0x80110d50,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 50 0d 11 80       	mov    0x80110d50,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 00 c6 10 80 	movl   $0x8010c600,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 af 4f 00 00       	jmp    80105210 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 80 10 80       	push   $0x80108026
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 4b 18 00 00       	call   80101ad0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010028c:	e8 bf 4e 00 00       	call   80105150 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 e0 0f 11 80    	mov    0x80110fe0,%edx
801002a7:	39 15 e4 0f 11 80    	cmp    %edx,0x80110fe4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 60 b5 10 80       	push   $0x8010b560
801002c0:	68 e0 0f 11 80       	push   $0x80110fe0
801002c5:	e8 56 3e 00 00       	call   80104120 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 e0 0f 11 80    	mov    0x80110fe0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 e4 0f 11 80    	cmp    0x80110fe4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 40 39 00 00       	call   80103c20 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 60 b5 10 80       	push   $0x8010b560
801002ef:	e8 1c 4f 00 00       	call   80105210 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 f4 16 00 00       	call   801019f0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 e0 0f 11 80       	mov    %eax,0x80110fe0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 60 0f 11 80 	movsbl -0x7feef0a0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 60 b5 10 80       	push   $0x8010b560
8010034d:	e8 be 4e 00 00       	call   80105210 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 96 16 00 00       	call   801019f0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 e0 0f 11 80    	mov    %edx,0x80110fe0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 94 b5 10 80 00 	movl   $0x0,0x8010b594
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 72 27 00 00       	call   80102b20 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 2d 80 10 80       	push   $0x8010802d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 da 8a 10 80 	movl   $0x80108ada,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 53 4c 00 00       	call   80105030 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 41 80 10 80       	push   $0x80108041
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 98 b5 10 80 01 	movl   $0x1,0x8010b598
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 98 b5 10 80    	mov    0x8010b598,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 b1 65 00 00       	call   801069f0 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 ff 64 00 00       	call   801069f0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 f3 64 00 00       	call   801069f0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 e7 64 00 00       	call   801069f0 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 e7 4d 00 00       	call   80105310 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 1a 4d 00 00       	call   80105260 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 45 80 10 80       	push   $0x80108045
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 70 80 10 80 	movzbl -0x7fef7f90(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 bc 14 00 00       	call   80101ad0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010061b:	e8 30 4b 00 00       	call   80105150 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 60 b5 10 80       	push   $0x8010b560
80100647:	e8 c4 4b 00 00       	call   80105210 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 9b 13 00 00       	call   801019f0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 94 b5 10 80       	mov    0x8010b594,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 60 b5 10 80       	push   $0x8010b560
8010071f:	e8 ec 4a 00 00       	call   80105210 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 58 80 10 80       	mov    $0x80108058,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 60 b5 10 80       	push   $0x8010b560
801007f0:	e8 5b 49 00 00       	call   80105150 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 5f 80 10 80       	push   $0x8010805f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <InsertNewCmd>:
{
80100810:	55                   	push   %ebp
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
80100811:	ba 67 66 66 66       	mov    $0x66666667,%edx
{
80100816:	89 e5                	mov    %esp,%ebp
80100818:	57                   	push   %edi
80100819:	56                   	push   %esi
8010081a:	53                   	push   %ebx
8010081b:	83 ec 10             	sub    $0x10,%esp
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
8010081e:	8b 3d 34 b5 10 80    	mov    0x8010b534,%edi
80100824:	8b 1d e4 0f 11 80    	mov    0x80110fe4,%ebx
    memset(temp_buf[temp_cur] ,'\0' ,INPUT_BUF * sizeof(char));
8010082a:	68 80 00 00 00       	push   $0x80
8010082f:	6a 00                	push   $0x0
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
80100831:	89 f8                	mov    %edi,%eax
80100833:	83 e3 7f             	and    $0x7f,%ebx
80100836:	f7 ea                	imul   %edx
80100838:	89 f8                	mov    %edi,%eax
8010083a:	c1 f8 1f             	sar    $0x1f,%eax
8010083d:	d1 fa                	sar    %edx
8010083f:	29 c2                	sub    %eax,%edx
80100841:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100844:	29 c7                	sub    %eax,%edi
80100846:	c1 e7 07             	shl    $0x7,%edi
    memset(temp_buf[temp_cur] ,'\0' ,INPUT_BUF * sizeof(char));
80100849:	8d b7 00 10 11 80    	lea    -0x7feef000(%edi),%esi
8010084f:	56                   	push   %esi
80100850:	e8 0b 4a 00 00       	call   80105260 <memset>
    while( i != ((input.e - 1)%INPUT_BUF)){
80100855:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
8010085a:	83 c4 10             	add    $0x10,%esp
    int j = 0;
8010085d:	31 d2                	xor    %edx,%edx
    while( i != ((input.e - 1)%INPUT_BUF)){
8010085f:	83 e8 01             	sub    $0x1,%eax
80100862:	83 e0 7f             	and    $0x7f,%eax
80100865:	39 d8                	cmp    %ebx,%eax
80100867:	74 22                	je     8010088b <InsertNewCmd+0x7b>
80100869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                  temp_buf[temp_cur][j] = input.buf[i];
80100870:	0f b6 8b 60 0f 11 80 	movzbl -0x7feef0a0(%ebx),%ecx
                  i = (i + 1) % INPUT_BUF;
80100877:	83 c3 01             	add    $0x1,%ebx
8010087a:	83 e3 7f             	and    $0x7f,%ebx
                  temp_buf[temp_cur][j] = input.buf[i];
8010087d:	88 8c 17 00 10 11 80 	mov    %cl,-0x7feef000(%edi,%edx,1)
                  j++;
80100884:	83 c2 01             	add    $0x1,%edx
    while( i != ((input.e - 1)%INPUT_BUF)){
80100887:	39 c3                	cmp    %eax,%ebx
80100889:	75 e5                	jne    80100870 <InsertNewCmd+0x60>
8010088b:	b8 20 b5 10 80       	mov    $0x8010b520,%eax
      history.PervCmd[i] = history.PervCmd[i-1];
80100890:	8b 48 0c             	mov    0xc(%eax),%ecx
80100893:	83 e8 04             	sub    $0x4,%eax
80100896:	89 48 14             	mov    %ecx,0x14(%eax)
      history.size[i] = history.size[i-1];
80100899:	8b 48 2c             	mov    0x2c(%eax),%ecx
8010089c:	89 48 30             	mov    %ecx,0x30(%eax)
    for(int i = 4 ; i > 0 ; i--){
8010089f:	3d 10 b5 10 80       	cmp    $0x8010b510,%eax
801008a4:	75 ea                	jne    80100890 <InsertNewCmd+0x80>
    history.PervCmd[0] = temp_buf[temp_cur];
801008a6:	89 35 20 b5 10 80    	mov    %esi,0x8010b520
    history.size[0] = j;
801008ac:	89 15 3c b5 10 80    	mov    %edx,0x8010b53c
}
801008b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801008b5:	5b                   	pop    %ebx
801008b6:	5e                   	pop    %esi
801008b7:	5f                   	pop    %edi
801008b8:	5d                   	pop    %ebp
801008b9:	c3                   	ret    
801008ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008c0 <killLine>:
  while(input.e != input.w &&
801008c0:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
801008c5:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801008cb:	74 53                	je     80100920 <killLine+0x60>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008cd:	83 e8 01             	sub    $0x1,%eax
801008d0:	89 c2                	mov    %eax,%edx
801008d2:	83 e2 7f             	and    $0x7f,%edx
  while(input.e != input.w &&
801008d5:	80 ba 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%edx)
801008dc:	74 42                	je     80100920 <killLine+0x60>
{
801008de:	55                   	push   %ebp
801008df:	89 e5                	mov    %esp,%ebp
801008e1:	83 ec 08             	sub    $0x8,%esp
801008e4:	eb 1b                	jmp    80100901 <killLine+0x41>
801008e6:	8d 76 00             	lea    0x0(%esi),%esi
801008e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008f0:	83 e8 01             	sub    $0x1,%eax
801008f3:	89 c2                	mov    %eax,%edx
801008f5:	83 e2 7f             	and    $0x7f,%edx
  while(input.e != input.w &&
801008f8:	80 ba 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%edx)
801008ff:	74 1c                	je     8010091d <killLine+0x5d>
        input.e--;
80100901:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
        consputc(BACKSPACE);
80100906:	b8 00 01 00 00       	mov    $0x100,%eax
8010090b:	e8 00 fb ff ff       	call   80100410 <consputc>
  while(input.e != input.w &&
80100910:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100915:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
8010091b:	75 d3                	jne    801008f0 <killLine+0x30>
}
8010091d:	c9                   	leave  
8010091e:	c3                   	ret    
8010091f:	90                   	nop
80100920:	f3 c3                	repz ret 
80100922:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100930 <fillBuf>:
{
80100930:	55                   	push   %ebp
80100931:	89 e5                	mov    %esp,%ebp
80100933:	56                   	push   %esi
80100934:	53                   	push   %ebx
  killLine();
80100935:	e8 86 ff ff ff       	call   801008c0 <killLine>
  for(int i = 0; i < history.size[history.cursor] ; i++)
8010093a:	a1 38 b5 10 80       	mov    0x8010b538,%eax
8010093f:	8b 1c 85 3c b5 10 80 	mov    -0x7fef4ac4(,%eax,4),%ebx
80100946:	85 db                	test   %ebx,%ebx
80100948:	7e 32                	jle    8010097c <fillBuf+0x4c>
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
8010094a:	8b 34 85 20 b5 10 80 	mov    -0x7fef4ae0(,%eax,4),%esi
80100951:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100956:	01 c3                	add    %eax,%ebx
80100958:	29 c6                	sub    %eax,%esi
8010095a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100960:	8d 50 01             	lea    0x1(%eax),%edx
80100963:	89 15 e8 0f 11 80    	mov    %edx,0x80110fe8
80100969:	0f b6 0c 30          	movzbl (%eax,%esi,1),%ecx
8010096d:	83 e0 7f             	and    $0x7f,%eax
  for(int i = 0; i < history.size[history.cursor] ; i++)
80100970:	39 da                	cmp    %ebx,%edx
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
80100972:	88 88 60 0f 11 80    	mov    %cl,-0x7feef0a0(%eax)
80100978:	89 d0                	mov    %edx,%eax
  for(int i = 0; i < history.size[history.cursor] ; i++)
8010097a:	75 e4                	jne    80100960 <fillBuf+0x30>
}
8010097c:	5b                   	pop    %ebx
8010097d:	5e                   	pop    %esi
8010097e:	5d                   	pop    %ebp
8010097f:	c3                   	ret    

80100980 <IncCursor>:
  if (history.cursor == 4)
80100980:	8b 0d 38 b5 10 80    	mov    0x8010b538,%ecx
{
80100986:	55                   	push   %ebp
80100987:	89 e5                	mov    %esp,%ebp
  if (history.cursor == 4)
80100989:	83 f9 04             	cmp    $0x4,%ecx
8010098c:	74 2a                	je     801009b8 <IncCursor+0x38>
  history.cursor = (history.cursor + 1) % 5;
8010098e:	83 c1 01             	add    $0x1,%ecx
80100991:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100996:	89 c8                	mov    %ecx,%eax
80100998:	f7 ea                	imul   %edx
8010099a:	89 c8                	mov    %ecx,%eax
8010099c:	c1 f8 1f             	sar    $0x1f,%eax
8010099f:	d1 fa                	sar    %edx
801009a1:	29 c2                	sub    %eax,%edx
801009a3:	8d 04 92             	lea    (%edx,%edx,4),%eax
801009a6:	29 c1                	sub    %eax,%ecx
      if ( history.cursor == history.cmd_count) 
801009a8:	3b 0d 34 b5 10 80    	cmp    0x8010b534,%ecx
  history.cursor = (history.cursor + 1) % 5;
801009ae:	89 ca                	mov    %ecx,%edx
801009b0:	89 0d 38 b5 10 80    	mov    %ecx,0x8010b538
      if ( history.cursor == history.cmd_count) 
801009b6:	74 08                	je     801009c0 <IncCursor+0x40>
}
801009b8:	5d                   	pop    %ebp
801009b9:	c3                   	ret    
801009ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        history.cursor = history.cmd_count - 1;
801009c0:	83 ea 01             	sub    $0x1,%edx
801009c3:	89 15 38 b5 10 80    	mov    %edx,0x8010b538
}
801009c9:	5d                   	pop    %ebp
801009ca:	c3                   	ret    
801009cb:	90                   	nop
801009cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009d0 <DecCursor>:
  if ( history.cursor < 0)
801009d0:	a1 38 b5 10 80       	mov    0x8010b538,%eax
{
801009d5:	55                   	push   %ebp
801009d6:	89 e5                	mov    %esp,%ebp
  if ( history.cursor < 0)
801009d8:	85 c0                	test   %eax,%eax
801009da:	78 08                	js     801009e4 <DecCursor+0x14>
  history.cursor = history.cursor - 1;
801009dc:	83 e8 01             	sub    $0x1,%eax
801009df:	a3 38 b5 10 80       	mov    %eax,0x8010b538
}
801009e4:	5d                   	pop    %ebp
801009e5:	c3                   	ret    
801009e6:	8d 76 00             	lea    0x0(%esi),%esi
801009e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009f0 <printInput>:
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	53                   	push   %ebx
801009f4:	83 ec 04             	sub    $0x4,%esp
  int i = input.w % INPUT_BUF;
801009f7:	8b 1d e4 0f 11 80    	mov    0x80110fe4,%ebx
801009fd:	eb 10                	jmp    80100a0f <printInput+0x1f>
801009ff:	90                   	nop
    consputc(input.buf[i]);
80100a00:	0f be 83 60 0f 11 80 	movsbl -0x7feef0a0(%ebx),%eax
    i = (i + 1) % INPUT_BUF;
80100a07:	83 c3 01             	add    $0x1,%ebx
    consputc(input.buf[i]);
80100a0a:	e8 01 fa ff ff       	call   80100410 <consputc>
  while( i != (input.e % INPUT_BUF)){ 
80100a0f:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
  int i = input.w % INPUT_BUF;
80100a14:	83 e3 7f             	and    $0x7f,%ebx
  while( i != (input.e % INPUT_BUF)){ 
80100a17:	83 e0 7f             	and    $0x7f,%eax
80100a1a:	39 d8                	cmp    %ebx,%eax
80100a1c:	75 e2                	jne    80100a00 <printInput+0x10>
}
80100a1e:	83 c4 04             	add    $0x4,%esp
80100a21:	5b                   	pop    %ebx
80100a22:	5d                   	pop    %ebp
80100a23:	c3                   	ret    
80100a24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100a2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100a30 <KeyDownPressed.part.0>:
if (history.cursor == -1){
80100a30:	a1 38 b5 10 80       	mov    0x8010b538,%eax
80100a35:	83 f8 ff             	cmp    $0xffffffff,%eax
80100a38:	74 1e                	je     80100a58 <KeyDownPressed.part.0+0x28>
KeyDownPressed()
80100a3a:	55                   	push   %ebp
80100a3b:	89 e5                	mov    %esp,%ebp
80100a3d:	83 ec 08             	sub    $0x8,%esp
  if ( history.cursor < 0)
80100a40:	85 c0                	test   %eax,%eax
80100a42:	78 08                	js     80100a4c <KeyDownPressed.part.0+0x1c>
  history.cursor = history.cursor - 1;
80100a44:	83 e8 01             	sub    $0x1,%eax
80100a47:	a3 38 b5 10 80       	mov    %eax,0x8010b538
  fillBuf();
80100a4c:	e8 df fe ff ff       	call   80100930 <fillBuf>
}
80100a51:	c9                   	leave  
  printInput();
80100a52:	eb 9c                	jmp    801009f0 <printInput>
80100a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  killLine();
80100a58:	e9 63 fe ff ff       	jmp    801008c0 <killLine>
80100a5d:	8d 76 00             	lea    0x0(%esi),%esi

80100a60 <KeyUpPressed>:
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	53                   	push   %ebx
80100a64:	83 ec 04             	sub    $0x4,%esp
  if ( history.cmd_count == 0) 
80100a67:	8b 1d 34 b5 10 80    	mov    0x8010b534,%ebx
80100a6d:	85 db                	test   %ebx,%ebx
80100a6f:	74 47                	je     80100ab8 <KeyUpPressed+0x58>
  if (history.cursor == 4)
80100a71:	8b 0d 38 b5 10 80    	mov    0x8010b538,%ecx
80100a77:	83 f9 04             	cmp    $0x4,%ecx
80100a7a:	74 2a                	je     80100aa6 <KeyUpPressed+0x46>
  history.cursor = (history.cursor + 1) % 5;
80100a7c:	83 c1 01             	add    $0x1,%ecx
80100a7f:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100a84:	89 c8                	mov    %ecx,%eax
80100a86:	f7 ea                	imul   %edx
80100a88:	89 c8                	mov    %ecx,%eax
80100a8a:	c1 f8 1f             	sar    $0x1f,%eax
80100a8d:	d1 fa                	sar    %edx
80100a8f:	29 c2                	sub    %eax,%edx
80100a91:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100a94:	29 c1                	sub    %eax,%ecx
80100a96:	8d 43 ff             	lea    -0x1(%ebx),%eax
80100a99:	89 ca                	mov    %ecx,%edx
80100a9b:	39 cb                	cmp    %ecx,%ebx
80100a9d:	0f 44 d0             	cmove  %eax,%edx
80100aa0:	89 15 38 b5 10 80    	mov    %edx,0x8010b538
  fillBuf();
80100aa6:	e8 85 fe ff ff       	call   80100930 <fillBuf>
}
80100aab:	83 c4 04             	add    $0x4,%esp
80100aae:	5b                   	pop    %ebx
80100aaf:	5d                   	pop    %ebp
  printInput();
80100ab0:	e9 3b ff ff ff       	jmp    801009f0 <printInput>
80100ab5:	8d 76 00             	lea    0x0(%esi),%esi
}
80100ab8:	83 c4 04             	add    $0x4,%esp
80100abb:	5b                   	pop    %ebx
80100abc:	5d                   	pop    %ebp
80100abd:	c3                   	ret    
80100abe:	66 90                	xchg   %ax,%ax

80100ac0 <KeyDownPressed>:
  if ( history.cmd_count == 0) 
80100ac0:	a1 34 b5 10 80       	mov    0x8010b534,%eax
{
80100ac5:	55                   	push   %ebp
80100ac6:	89 e5                	mov    %esp,%ebp
  if ( history.cmd_count == 0) 
80100ac8:	85 c0                	test   %eax,%eax
80100aca:	74 0c                	je     80100ad8 <KeyDownPressed+0x18>
}
80100acc:	5d                   	pop    %ebp
80100acd:	e9 5e ff ff ff       	jmp    80100a30 <KeyDownPressed.part.0>
80100ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ad8:	5d                   	pop    %ebp
80100ad9:	c3                   	ret    
80100ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ae0 <consoleintr>:
{
80100ae0:	55                   	push   %ebp
80100ae1:	89 e5                	mov    %esp,%ebp
80100ae3:	57                   	push   %edi
80100ae4:	56                   	push   %esi
80100ae5:	53                   	push   %ebx
  int c, doprocdump = 0;
80100ae6:	31 ff                	xor    %edi,%edi
{
80100ae8:	83 ec 18             	sub    $0x18,%esp
80100aeb:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
80100aee:	68 60 b5 10 80       	push   $0x8010b560
80100af3:	e8 58 46 00 00       	call   80105150 <acquire>
  while((c = getc()) >= 0){
80100af8:	83 c4 10             	add    $0x10,%esp
80100afb:	90                   	nop
80100afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b00:	ff d6                	call   *%esi
80100b02:	85 c0                	test   %eax,%eax
80100b04:	89 c3                	mov    %eax,%ebx
80100b06:	0f 88 b4 00 00 00    	js     80100bc0 <consoleintr+0xe0>
    switch(c){
80100b0c:	83 fb 15             	cmp    $0x15,%ebx
80100b0f:	0f 84 cb 00 00 00    	je     80100be0 <consoleintr+0x100>
80100b15:	0f 8e 85 00 00 00    	jle    80100ba0 <consoleintr+0xc0>
80100b1b:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100b21:	0f 84 19 01 00 00    	je     80100c40 <consoleintr+0x160>
80100b27:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100b2d:	0f 84 ed 00 00 00    	je     80100c20 <consoleintr+0x140>
80100b33:	83 fb 7f             	cmp    $0x7f,%ebx
80100b36:	0f 84 b4 00 00 00    	je     80100bf0 <consoleintr+0x110>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100b3c:	85 db                	test   %ebx,%ebx
80100b3e:	74 c0                	je     80100b00 <consoleintr+0x20>
80100b40:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100b45:	89 c2                	mov    %eax,%edx
80100b47:	2b 15 e0 0f 11 80    	sub    0x80110fe0,%edx
80100b4d:	83 fa 7f             	cmp    $0x7f,%edx
80100b50:	77 ae                	ja     80100b00 <consoleintr+0x20>
80100b52:	8d 50 01             	lea    0x1(%eax),%edx
80100b55:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100b58:	83 fb 0d             	cmp    $0xd,%ebx
        input.buf[input.e++ % INPUT_BUF] = c;
80100b5b:	89 15 e8 0f 11 80    	mov    %edx,0x80110fe8
        c = (c == '\r') ? '\n' : c;
80100b61:	0f 84 f9 00 00 00    	je     80100c60 <consoleintr+0x180>
        input.buf[input.e++ % INPUT_BUF] = c;
80100b67:	88 98 60 0f 11 80    	mov    %bl,-0x7feef0a0(%eax)
        consputc(c);
80100b6d:	89 d8                	mov    %ebx,%eax
80100b6f:	e8 9c f8 ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b74:	83 fb 0a             	cmp    $0xa,%ebx
80100b77:	0f 84 f4 00 00 00    	je     80100c71 <consoleintr+0x191>
80100b7d:	83 fb 04             	cmp    $0x4,%ebx
80100b80:	0f 84 eb 00 00 00    	je     80100c71 <consoleintr+0x191>
80100b86:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
80100b8b:	83 e8 80             	sub    $0xffffff80,%eax
80100b8e:	39 05 e8 0f 11 80    	cmp    %eax,0x80110fe8
80100b94:	0f 85 66 ff ff ff    	jne    80100b00 <consoleintr+0x20>
80100b9a:	e9 d7 00 00 00       	jmp    80100c76 <consoleintr+0x196>
80100b9f:	90                   	nop
    switch(c){
80100ba0:	83 fb 08             	cmp    $0x8,%ebx
80100ba3:	74 4b                	je     80100bf0 <consoleintr+0x110>
80100ba5:	83 fb 10             	cmp    $0x10,%ebx
80100ba8:	75 92                	jne    80100b3c <consoleintr+0x5c>
  while((c = getc()) >= 0){
80100baa:	ff d6                	call   *%esi
80100bac:	85 c0                	test   %eax,%eax
      doprocdump = 1;
80100bae:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
80100bb3:	89 c3                	mov    %eax,%ebx
80100bb5:	0f 89 51 ff ff ff    	jns    80100b0c <consoleintr+0x2c>
80100bbb:	90                   	nop
80100bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100bc0:	83 ec 0c             	sub    $0xc,%esp
80100bc3:	68 60 b5 10 80       	push   $0x8010b560
80100bc8:	e8 43 46 00 00       	call   80105210 <release>
  if(doprocdump) {
80100bcd:	83 c4 10             	add    $0x10,%esp
80100bd0:	85 ff                	test   %edi,%edi
80100bd2:	75 7c                	jne    80100c50 <consoleintr+0x170>
}
80100bd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100bd7:	5b                   	pop    %ebx
80100bd8:	5e                   	pop    %esi
80100bd9:	5f                   	pop    %edi
80100bda:	5d                   	pop    %ebp
80100bdb:	c3                   	ret    
80100bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      killLine();
80100be0:	e8 db fc ff ff       	call   801008c0 <killLine>
      break;
80100be5:	e9 16 ff ff ff       	jmp    80100b00 <consoleintr+0x20>
80100bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(input.e != input.w){
80100bf0:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100bf5:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
80100bfb:	0f 84 ff fe ff ff    	je     80100b00 <consoleintr+0x20>
        input.e--;
80100c01:	83 e8 01             	sub    $0x1,%eax
80100c04:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
        consputc(BACKSPACE);
80100c09:	b8 00 01 00 00       	mov    $0x100,%eax
80100c0e:	e8 fd f7 ff ff       	call   80100410 <consputc>
80100c13:	e9 e8 fe ff ff       	jmp    80100b00 <consoleintr+0x20>
80100c18:	90                   	nop
80100c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ( history.cmd_count == 0) 
80100c20:	a1 34 b5 10 80       	mov    0x8010b534,%eax
80100c25:	85 c0                	test   %eax,%eax
80100c27:	0f 84 d3 fe ff ff    	je     80100b00 <consoleintr+0x20>
80100c2d:	e8 fe fd ff ff       	call   80100a30 <KeyDownPressed.part.0>
80100c32:	e9 c9 fe ff ff       	jmp    80100b00 <consoleintr+0x20>
80100c37:	89 f6                	mov    %esi,%esi
80100c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      KeyUpPressed();
80100c40:	e8 1b fe ff ff       	call   80100a60 <KeyUpPressed>
      break;
80100c45:	e9 b6 fe ff ff       	jmp    80100b00 <consoleintr+0x20>
80100c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80100c50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c53:	5b                   	pop    %ebx
80100c54:	5e                   	pop    %esi
80100c55:	5f                   	pop    %edi
80100c56:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100c57:	e9 64 37 00 00       	jmp    801043c0 <procdump>
80100c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100c60:	c6 80 60 0f 11 80 0a 	movb   $0xa,-0x7feef0a0(%eax)
        consputc(c);
80100c67:	b8 0a 00 00 00       	mov    $0xa,%eax
80100c6c:	e8 9f f7 ff ff       	call   80100410 <consputc>
80100c71:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
          if ( (input.e - input.w) != 1) {
80100c76:	89 c2                	mov    %eax,%edx
80100c78:	2b 15 e4 0f 11 80    	sub    0x80110fe4,%edx
80100c7e:	83 fa 01             	cmp    $0x1,%edx
80100c81:	74 1b                	je     80100c9e <consoleintr+0x1be>
            InsertNewCmd();
80100c83:	e8 88 fb ff ff       	call   80100810 <InsertNewCmd>
            history.cmd_count++;
80100c88:	83 05 34 b5 10 80 01 	addl   $0x1,0x8010b534
80100c8f:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
            history.cursor = -1;
80100c94:	c7 05 38 b5 10 80 ff 	movl   $0xffffffff,0x8010b538
80100c9b:	ff ff ff 
          wakeup(&input.r);
80100c9e:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100ca1:	a3 e4 0f 11 80       	mov    %eax,0x80110fe4
          wakeup(&input.r);
80100ca6:	68 e0 0f 11 80       	push   $0x80110fe0
80100cab:	e8 30 36 00 00       	call   801042e0 <wakeup>
80100cb0:	83 c4 10             	add    $0x10,%esp
80100cb3:	e9 48 fe ff ff       	jmp    80100b00 <consoleintr+0x20>
80100cb8:	90                   	nop
80100cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100cc0 <consoleinit>:

void
consoleinit(void)
{
80100cc0:	55                   	push   %ebp
80100cc1:	89 e5                	mov    %esp,%ebp
80100cc3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100cc6:	68 68 80 10 80       	push   $0x80108068
80100ccb:	68 60 b5 10 80       	push   $0x8010b560
80100cd0:	e8 3b 43 00 00       	call   80105010 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100cd5:	58                   	pop    %eax
80100cd6:	5a                   	pop    %edx
80100cd7:	6a 00                	push   $0x0
80100cd9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100cdb:	c7 05 2c 1c 11 80 00 	movl   $0x80100600,0x80111c2c
80100ce2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100ce5:	c7 05 28 1c 11 80 70 	movl   $0x80100270,0x80111c28
80100cec:	02 10 80 
  cons.locking = 1;
80100cef:	c7 05 94 b5 10 80 01 	movl   $0x1,0x8010b594
80100cf6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100cf9:	e8 42 19 00 00       	call   80102640 <ioapicenable>
}
80100cfe:	83 c4 10             	add    $0x10,%esp
80100d01:	c9                   	leave  
80100d02:	c3                   	ret    
80100d03:	66 90                	xchg   %ax,%ax
80100d05:	66 90                	xchg   %ax,%ax
80100d07:	66 90                	xchg   %ax,%ax
80100d09:	66 90                	xchg   %ax,%ax
80100d0b:	66 90                	xchg   %ax,%ax
80100d0d:	66 90                	xchg   %ax,%ax
80100d0f:	90                   	nop

80100d10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100d10:	55                   	push   %ebp
80100d11:	89 e5                	mov    %esp,%ebp
80100d13:	57                   	push   %edi
80100d14:	56                   	push   %esi
80100d15:	53                   	push   %ebx
80100d16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100d1c:	e8 ff 2e 00 00       	call   80103c20 <myproc>
80100d21:	89 c6                	mov    %eax,%esi

  begin_op();
80100d23:	e8 68 22 00 00       	call   80102f90 <begin_op>
  //For testing priority

  find_and_set_sched_queue(LOTTERY, curproc->pid);
80100d28:	83 ec 08             	sub    $0x8,%esp
80100d2b:	ff 76 10             	pushl  0x10(%esi)
80100d2e:	6a 02                	push   $0x2
80100d30:	e8 7b 3a 00 00       	call   801047b0 <find_and_set_sched_queue>
  find_and_set_lottery_ticket(500, curproc->pid);
80100d35:	59                   	pop    %ecx
80100d36:	5b                   	pop    %ebx
80100d37:	ff 76 10             	pushl  0x10(%esi)
80100d3a:	68 f4 01 00 00       	push   $0x1f4
80100d3f:	e8 3c 3a 00 00       	call   80104780 <find_and_set_lottery_ticket>
  find_and_set_burst_time(0, curproc->pid);
80100d44:	5f                   	pop    %edi
80100d45:	58                   	pop    %eax
80100d46:	ff 76 10             	pushl  0x10(%esi)
80100d49:	6a 00                	push   $0x0
80100d4b:	e8 90 3a 00 00       	call   801047e0 <find_and_set_burst_time>

  if((ip = namei(path)) == 0){
80100d50:	58                   	pop    %eax
80100d51:	ff 75 08             	pushl  0x8(%ebp)
80100d54:	e8 f7 14 00 00       	call   80102250 <namei>
80100d59:	83 c4 10             	add    $0x10,%esp
80100d5c:	85 c0                	test   %eax,%eax
80100d5e:	0f 84 b8 01 00 00    	je     80100f1c <exec+0x20c>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100d64:	83 ec 0c             	sub    $0xc,%esp
80100d67:	89 c3                	mov    %eax,%ebx
80100d69:	50                   	push   %eax
80100d6a:	e8 81 0c 00 00       	call   801019f0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100d6f:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100d75:	6a 34                	push   $0x34
80100d77:	6a 00                	push   $0x0
80100d79:	50                   	push   %eax
80100d7a:	53                   	push   %ebx
80100d7b:	e8 50 0f 00 00       	call   80101cd0 <readi>
80100d80:	83 c4 20             	add    $0x20,%esp
80100d83:	83 f8 34             	cmp    $0x34,%eax
80100d86:	74 28                	je     80100db0 <exec+0xa0>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100d88:	83 ec 0c             	sub    $0xc,%esp
80100d8b:	53                   	push   %ebx
80100d8c:	e8 ef 0e 00 00       	call   80101c80 <iunlockput>
    end_op();
80100d91:	e8 6a 22 00 00       	call   80103000 <end_op>
80100d96:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100d99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100d9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100da1:	5b                   	pop    %ebx
80100da2:	5e                   	pop    %esi
80100da3:	5f                   	pop    %edi
80100da4:	5d                   	pop    %ebp
80100da5:	c3                   	ret    
80100da6:	8d 76 00             	lea    0x0(%esi),%esi
80100da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(elf.magic != ELF_MAGIC)
80100db0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100db7:	45 4c 46 
80100dba:	75 cc                	jne    80100d88 <exec+0x78>
  if((pgdir = setupkvm()) == 0)
80100dbc:	e8 df 6d 00 00       	call   80107ba0 <setupkvm>
80100dc1:	85 c0                	test   %eax,%eax
80100dc3:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100dc9:	74 bd                	je     80100d88 <exec+0x78>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dcb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100dd2:	00 
80100dd3:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100dd9:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ddf:	0f 84 b6 02 00 00    	je     8010109b <exec+0x38b>
  sz = 0;
80100de5:	31 c0                	xor    %eax,%eax
80100de7:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ded:	31 ff                	xor    %edi,%edi
80100def:	89 c6                	mov    %eax,%esi
80100df1:	eb 7f                	jmp    80100e72 <exec+0x162>
80100df3:	90                   	nop
80100df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100df8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100dff:	75 63                	jne    80100e64 <exec+0x154>
    if(ph.memsz < ph.filesz)
80100e01:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100e07:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100e0d:	0f 82 86 00 00 00    	jb     80100e99 <exec+0x189>
80100e13:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100e19:	72 7e                	jb     80100e99 <exec+0x189>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100e1b:	83 ec 04             	sub    $0x4,%esp
80100e1e:	50                   	push   %eax
80100e1f:	56                   	push   %esi
80100e20:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100e26:	e8 c5 6b 00 00       	call   801079f0 <allocuvm>
80100e2b:	83 c4 10             	add    $0x10,%esp
80100e2e:	85 c0                	test   %eax,%eax
80100e30:	89 c6                	mov    %eax,%esi
80100e32:	74 65                	je     80100e99 <exec+0x189>
    if(ph.vaddr % PGSIZE != 0)
80100e34:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100e3a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100e3f:	75 58                	jne    80100e99 <exec+0x189>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100e41:	83 ec 0c             	sub    $0xc,%esp
80100e44:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100e4a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100e50:	53                   	push   %ebx
80100e51:	50                   	push   %eax
80100e52:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100e58:	e8 d3 6a 00 00       	call   80107930 <loaduvm>
80100e5d:	83 c4 20             	add    $0x20,%esp
80100e60:	85 c0                	test   %eax,%eax
80100e62:	78 35                	js     80100e99 <exec+0x189>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e64:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100e6b:	83 c7 01             	add    $0x1,%edi
80100e6e:	39 f8                	cmp    %edi,%eax
80100e70:	7e 3d                	jle    80100eaf <exec+0x19f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100e72:	89 f8                	mov    %edi,%eax
80100e74:	6a 20                	push   $0x20
80100e76:	c1 e0 05             	shl    $0x5,%eax
80100e79:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100e7f:	50                   	push   %eax
80100e80:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100e86:	50                   	push   %eax
80100e87:	53                   	push   %ebx
80100e88:	e8 43 0e 00 00       	call   80101cd0 <readi>
80100e8d:	83 c4 10             	add    $0x10,%esp
80100e90:	83 f8 20             	cmp    $0x20,%eax
80100e93:	0f 84 5f ff ff ff    	je     80100df8 <exec+0xe8>
    freevm(pgdir);
80100e99:	83 ec 0c             	sub    $0xc,%esp
80100e9c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ea2:	e8 79 6c 00 00       	call   80107b20 <freevm>
80100ea7:	83 c4 10             	add    $0x10,%esp
80100eaa:	e9 d9 fe ff ff       	jmp    80100d88 <exec+0x78>
80100eaf:	89 f0                	mov    %esi,%eax
80100eb1:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100eb7:	05 ff 0f 00 00       	add    $0xfff,%eax
80100ebc:	89 c7                	mov    %eax,%edi
80100ebe:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100ec4:	8d 87 00 20 00 00    	lea    0x2000(%edi),%eax
  iunlockput(ip);
80100eca:	83 ec 0c             	sub    $0xc,%esp
80100ecd:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ed3:	53                   	push   %ebx
80100ed4:	e8 a7 0d 00 00       	call   80101c80 <iunlockput>
  end_op();
80100ed9:	e8 22 21 00 00       	call   80103000 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ede:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ee4:	83 c4 0c             	add    $0xc,%esp
80100ee7:	50                   	push   %eax
80100ee8:	57                   	push   %edi
80100ee9:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100eef:	e8 fc 6a 00 00       	call   801079f0 <allocuvm>
80100ef4:	83 c4 10             	add    $0x10,%esp
80100ef7:	85 c0                	test   %eax,%eax
80100ef9:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100eff:	75 3a                	jne    80100f3b <exec+0x22b>
    freevm(pgdir);
80100f01:	83 ec 0c             	sub    $0xc,%esp
80100f04:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f0a:	e8 11 6c 00 00       	call   80107b20 <freevm>
80100f0f:	83 c4 10             	add    $0x10,%esp
  return -1;
80100f12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f17:	e9 82 fe ff ff       	jmp    80100d9e <exec+0x8e>
    end_op();
80100f1c:	e8 df 20 00 00       	call   80103000 <end_op>
    cprintf("exec: fail\n");
80100f21:	83 ec 0c             	sub    $0xc,%esp
80100f24:	68 81 80 10 80       	push   $0x80108081
80100f29:	e8 32 f7 ff ff       	call   80100660 <cprintf>
    return -1;
80100f2e:	83 c4 10             	add    $0x10,%esp
80100f31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f36:	e9 63 fe ff ff       	jmp    80100d9e <exec+0x8e>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100f3b:	89 c3                	mov    %eax,%ebx
80100f3d:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100f43:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100f46:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100f48:	50                   	push   %eax
80100f49:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f4f:	e8 ec 6c 00 00       	call   80107c40 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100f54:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f57:	83 c4 10             	add    $0x10,%esp
80100f5a:	8b 00                	mov    (%eax),%eax
80100f5c:	85 c0                	test   %eax,%eax
80100f5e:	0f 84 43 01 00 00    	je     801010a7 <exec+0x397>
80100f64:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100f6a:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100f70:	eb 0b                	jmp    80100f7d <exec+0x26d>
80100f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
80100f78:	83 ff 20             	cmp    $0x20,%edi
80100f7b:	74 84                	je     80100f01 <exec+0x1f1>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f7d:	83 ec 0c             	sub    $0xc,%esp
80100f80:	50                   	push   %eax
80100f81:	e8 fa 44 00 00       	call   80105480 <strlen>
80100f86:	f7 d0                	not    %eax
80100f88:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f8d:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f8e:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f91:	ff 34 b8             	pushl  (%eax,%edi,4)
80100f94:	e8 e7 44 00 00       	call   80105480 <strlen>
80100f99:	83 c0 01             	add    $0x1,%eax
80100f9c:	50                   	push   %eax
80100f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fa0:	ff 34 b8             	pushl  (%eax,%edi,4)
80100fa3:	53                   	push   %ebx
80100fa4:	56                   	push   %esi
80100fa5:	e8 06 6e 00 00       	call   80107db0 <copyout>
80100faa:	83 c4 20             	add    $0x20,%esp
80100fad:	85 c0                	test   %eax,%eax
80100faf:	0f 88 4c ff ff ff    	js     80100f01 <exec+0x1f1>
  for(argc = 0; argv[argc]; argc++) {
80100fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100fb8:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100fbf:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100fc2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100fc8:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100fcb:	85 c0                	test   %eax,%eax
80100fcd:	75 a9                	jne    80100f78 <exec+0x268>
80100fcf:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100fd5:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100fdc:	89 da                	mov    %ebx,%edx
  ustack[3+argc] = 0;
80100fde:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100fe5:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100fe9:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ff0:	ff ff ff 
  ustack[1] = argc;
80100ff3:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ff9:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100ffb:	83 c0 0c             	add    $0xc,%eax
80100ffe:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101000:	50                   	push   %eax
80101001:	51                   	push   %ecx
80101002:	53                   	push   %ebx
80101003:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101009:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010100f:	e8 9c 6d 00 00       	call   80107db0 <copyout>
80101014:	83 c4 10             	add    $0x10,%esp
80101017:	85 c0                	test   %eax,%eax
80101019:	0f 88 e2 fe ff ff    	js     80100f01 <exec+0x1f1>
  for(last=s=path; *s; s++)
8010101f:	8b 45 08             	mov    0x8(%ebp),%eax
80101022:	0f b6 00             	movzbl (%eax),%eax
80101025:	84 c0                	test   %al,%al
80101027:	74 17                	je     80101040 <exec+0x330>
80101029:	8b 55 08             	mov    0x8(%ebp),%edx
8010102c:	89 d1                	mov    %edx,%ecx
8010102e:	83 c1 01             	add    $0x1,%ecx
80101031:	3c 2f                	cmp    $0x2f,%al
80101033:	0f b6 01             	movzbl (%ecx),%eax
80101036:	0f 44 d1             	cmove  %ecx,%edx
80101039:	84 c0                	test   %al,%al
8010103b:	75 f1                	jne    8010102e <exec+0x31e>
8010103d:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80101040:	50                   	push   %eax
80101041:	8d 46 6c             	lea    0x6c(%esi),%eax
80101044:	6a 10                	push   $0x10
80101046:	ff 75 08             	pushl  0x8(%ebp)
80101049:	50                   	push   %eax
8010104a:	e8 f1 43 00 00       	call   80105440 <safestrcpy>
  oldpgdir = curproc->pgdir;
8010104f:	8b 46 04             	mov    0x4(%esi),%eax
  curproc->tf->eip = elf.entry;  // main
80101052:	8b 56 18             	mov    0x18(%esi),%edx
  oldpgdir = curproc->pgdir;
80101055:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  curproc->pgdir = pgdir;
8010105b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80101061:	89 46 04             	mov    %eax,0x4(%esi)
  curproc->sz = sz;
80101064:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
8010106a:	89 06                	mov    %eax,(%esi)
  curproc->tf->eip = elf.entry;  // main
8010106c:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80101072:	89 4a 38             	mov    %ecx,0x38(%edx)
  curproc->tf->esp = sp;
80101075:	8b 56 18             	mov    0x18(%esi),%edx
80101078:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(curproc);
8010107b:	89 34 24             	mov    %esi,(%esp)
8010107e:	e8 ed 66 00 00       	call   80107770 <switchuvm>
  freevm(oldpgdir);
80101083:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80101089:	89 04 24             	mov    %eax,(%esp)
8010108c:	e8 8f 6a 00 00       	call   80107b20 <freevm>
  return 0;
80101091:	83 c4 10             	add    $0x10,%esp
80101094:	31 c0                	xor    %eax,%eax
80101096:	e9 03 fd ff ff       	jmp    80100d9e <exec+0x8e>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010109b:	31 ff                	xor    %edi,%edi
8010109d:	b8 00 20 00 00       	mov    $0x2000,%eax
801010a2:	e9 23 fe ff ff       	jmp    80100eca <exec+0x1ba>
  for(argc = 0; argv[argc]; argc++) {
801010a7:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
801010ad:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
801010b3:	e9 1d ff ff ff       	jmp    80100fd5 <exec+0x2c5>
801010b8:	66 90                	xchg   %ax,%ax
801010ba:	66 90                	xchg   %ax,%ax
801010bc:	66 90                	xchg   %ax,%ax
801010be:	66 90                	xchg   %ax,%ax

801010c0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801010c6:	68 8d 80 10 80       	push   $0x8010808d
801010cb:	68 80 12 11 80       	push   $0x80111280
801010d0:	e8 3b 3f 00 00       	call   80105010 <initlock>
}
801010d5:	83 c4 10             	add    $0x10,%esp
801010d8:	c9                   	leave  
801010d9:	c3                   	ret    
801010da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801010e0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801010e4:	bb b4 12 11 80       	mov    $0x801112b4,%ebx
{
801010e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801010ec:	68 80 12 11 80       	push   $0x80111280
801010f1:	e8 5a 40 00 00       	call   80105150 <acquire>
801010f6:	83 c4 10             	add    $0x10,%esp
801010f9:	eb 10                	jmp    8010110b <filealloc+0x2b>
801010fb:	90                   	nop
801010fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101100:	83 c3 18             	add    $0x18,%ebx
80101103:	81 fb 14 1c 11 80    	cmp    $0x80111c14,%ebx
80101109:	73 25                	jae    80101130 <filealloc+0x50>
    if(f->ref == 0){
8010110b:	8b 43 04             	mov    0x4(%ebx),%eax
8010110e:	85 c0                	test   %eax,%eax
80101110:	75 ee                	jne    80101100 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101112:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101115:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010111c:	68 80 12 11 80       	push   $0x80111280
80101121:	e8 ea 40 00 00       	call   80105210 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101126:	89 d8                	mov    %ebx,%eax
      return f;
80101128:	83 c4 10             	add    $0x10,%esp
}
8010112b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010112e:	c9                   	leave  
8010112f:	c3                   	ret    
  release(&ftable.lock);
80101130:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101133:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101135:	68 80 12 11 80       	push   $0x80111280
8010113a:	e8 d1 40 00 00       	call   80105210 <release>
}
8010113f:	89 d8                	mov    %ebx,%eax
  return 0;
80101141:	83 c4 10             	add    $0x10,%esp
}
80101144:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101147:	c9                   	leave  
80101148:	c3                   	ret    
80101149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101150 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	53                   	push   %ebx
80101154:	83 ec 10             	sub    $0x10,%esp
80101157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010115a:	68 80 12 11 80       	push   $0x80111280
8010115f:	e8 ec 3f 00 00       	call   80105150 <acquire>
  if(f->ref < 1)
80101164:	8b 43 04             	mov    0x4(%ebx),%eax
80101167:	83 c4 10             	add    $0x10,%esp
8010116a:	85 c0                	test   %eax,%eax
8010116c:	7e 1a                	jle    80101188 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010116e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101171:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101174:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101177:	68 80 12 11 80       	push   $0x80111280
8010117c:	e8 8f 40 00 00       	call   80105210 <release>
  return f;
}
80101181:	89 d8                	mov    %ebx,%eax
80101183:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101186:	c9                   	leave  
80101187:	c3                   	ret    
    panic("filedup");
80101188:	83 ec 0c             	sub    $0xc,%esp
8010118b:	68 94 80 10 80       	push   $0x80108094
80101190:	e8 fb f1 ff ff       	call   80100390 <panic>
80101195:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801011a0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	57                   	push   %edi
801011a4:	56                   	push   %esi
801011a5:	53                   	push   %ebx
801011a6:	83 ec 28             	sub    $0x28,%esp
801011a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801011ac:	68 80 12 11 80       	push   $0x80111280
801011b1:	e8 9a 3f 00 00       	call   80105150 <acquire>
  if(f->ref < 1)
801011b6:	8b 43 04             	mov    0x4(%ebx),%eax
801011b9:	83 c4 10             	add    $0x10,%esp
801011bc:	85 c0                	test   %eax,%eax
801011be:	0f 8e 9b 00 00 00    	jle    8010125f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
801011c4:	83 e8 01             	sub    $0x1,%eax
801011c7:	85 c0                	test   %eax,%eax
801011c9:	89 43 04             	mov    %eax,0x4(%ebx)
801011cc:	74 1a                	je     801011e8 <fileclose+0x48>
    release(&ftable.lock);
801011ce:	c7 45 08 80 12 11 80 	movl   $0x80111280,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801011d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011d8:	5b                   	pop    %ebx
801011d9:	5e                   	pop    %esi
801011da:	5f                   	pop    %edi
801011db:	5d                   	pop    %ebp
    release(&ftable.lock);
801011dc:	e9 2f 40 00 00       	jmp    80105210 <release>
801011e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
801011e8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
801011ec:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
801011ee:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801011f1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
801011f4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801011fa:	88 45 e7             	mov    %al,-0x19(%ebp)
801011fd:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101200:	68 80 12 11 80       	push   $0x80111280
  ff = *f;
80101205:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101208:	e8 03 40 00 00       	call   80105210 <release>
  if(ff.type == FD_PIPE)
8010120d:	83 c4 10             	add    $0x10,%esp
80101210:	83 ff 01             	cmp    $0x1,%edi
80101213:	74 13                	je     80101228 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80101215:	83 ff 02             	cmp    $0x2,%edi
80101218:	74 26                	je     80101240 <fileclose+0xa0>
}
8010121a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010121d:	5b                   	pop    %ebx
8010121e:	5e                   	pop    %esi
8010121f:	5f                   	pop    %edi
80101220:	5d                   	pop    %ebp
80101221:	c3                   	ret    
80101222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80101228:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
8010122c:	83 ec 08             	sub    $0x8,%esp
8010122f:	53                   	push   %ebx
80101230:	56                   	push   %esi
80101231:	e8 0a 25 00 00       	call   80103740 <pipeclose>
80101236:	83 c4 10             	add    $0x10,%esp
80101239:	eb df                	jmp    8010121a <fileclose+0x7a>
8010123b:	90                   	nop
8010123c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80101240:	e8 4b 1d 00 00       	call   80102f90 <begin_op>
    iput(ff.ip);
80101245:	83 ec 0c             	sub    $0xc,%esp
80101248:	ff 75 e0             	pushl  -0x20(%ebp)
8010124b:	e8 d0 08 00 00       	call   80101b20 <iput>
    end_op();
80101250:	83 c4 10             	add    $0x10,%esp
}
80101253:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101256:	5b                   	pop    %ebx
80101257:	5e                   	pop    %esi
80101258:	5f                   	pop    %edi
80101259:	5d                   	pop    %ebp
    end_op();
8010125a:	e9 a1 1d 00 00       	jmp    80103000 <end_op>
    panic("fileclose");
8010125f:	83 ec 0c             	sub    $0xc,%esp
80101262:	68 9c 80 10 80       	push   $0x8010809c
80101267:	e8 24 f1 ff ff       	call   80100390 <panic>
8010126c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101270 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101270:	55                   	push   %ebp
80101271:	89 e5                	mov    %esp,%ebp
80101273:	53                   	push   %ebx
80101274:	83 ec 04             	sub    $0x4,%esp
80101277:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010127a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010127d:	75 31                	jne    801012b0 <filestat+0x40>
    ilock(f->ip);
8010127f:	83 ec 0c             	sub    $0xc,%esp
80101282:	ff 73 10             	pushl  0x10(%ebx)
80101285:	e8 66 07 00 00       	call   801019f0 <ilock>
    stati(f->ip, st);
8010128a:	58                   	pop    %eax
8010128b:	5a                   	pop    %edx
8010128c:	ff 75 0c             	pushl  0xc(%ebp)
8010128f:	ff 73 10             	pushl  0x10(%ebx)
80101292:	e8 09 0a 00 00       	call   80101ca0 <stati>
    iunlock(f->ip);
80101297:	59                   	pop    %ecx
80101298:	ff 73 10             	pushl  0x10(%ebx)
8010129b:	e8 30 08 00 00       	call   80101ad0 <iunlock>
    return 0;
801012a0:	83 c4 10             	add    $0x10,%esp
801012a3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
801012a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801012a8:	c9                   	leave  
801012a9:	c3                   	ret    
801012aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
801012b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012b5:	eb ee                	jmp    801012a5 <filestat+0x35>
801012b7:	89 f6                	mov    %esi,%esi
801012b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801012c0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801012c0:	55                   	push   %ebp
801012c1:	89 e5                	mov    %esp,%ebp
801012c3:	57                   	push   %edi
801012c4:	56                   	push   %esi
801012c5:	53                   	push   %ebx
801012c6:	83 ec 0c             	sub    $0xc,%esp
801012c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801012cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801012cf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801012d2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801012d6:	74 60                	je     80101338 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801012d8:	8b 03                	mov    (%ebx),%eax
801012da:	83 f8 01             	cmp    $0x1,%eax
801012dd:	74 41                	je     80101320 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801012df:	83 f8 02             	cmp    $0x2,%eax
801012e2:	75 5b                	jne    8010133f <fileread+0x7f>
    ilock(f->ip);
801012e4:	83 ec 0c             	sub    $0xc,%esp
801012e7:	ff 73 10             	pushl  0x10(%ebx)
801012ea:	e8 01 07 00 00       	call   801019f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801012ef:	57                   	push   %edi
801012f0:	ff 73 14             	pushl  0x14(%ebx)
801012f3:	56                   	push   %esi
801012f4:	ff 73 10             	pushl  0x10(%ebx)
801012f7:	e8 d4 09 00 00       	call   80101cd0 <readi>
801012fc:	83 c4 20             	add    $0x20,%esp
801012ff:	85 c0                	test   %eax,%eax
80101301:	89 c6                	mov    %eax,%esi
80101303:	7e 03                	jle    80101308 <fileread+0x48>
      f->off += r;
80101305:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101308:	83 ec 0c             	sub    $0xc,%esp
8010130b:	ff 73 10             	pushl  0x10(%ebx)
8010130e:	e8 bd 07 00 00       	call   80101ad0 <iunlock>
    return r;
80101313:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101316:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101319:	89 f0                	mov    %esi,%eax
8010131b:	5b                   	pop    %ebx
8010131c:	5e                   	pop    %esi
8010131d:	5f                   	pop    %edi
8010131e:	5d                   	pop    %ebp
8010131f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101320:	8b 43 0c             	mov    0xc(%ebx),%eax
80101323:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101326:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101329:	5b                   	pop    %ebx
8010132a:	5e                   	pop    %esi
8010132b:	5f                   	pop    %edi
8010132c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010132d:	e9 be 25 00 00       	jmp    801038f0 <piperead>
80101332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101338:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010133d:	eb d7                	jmp    80101316 <fileread+0x56>
  panic("fileread");
8010133f:	83 ec 0c             	sub    $0xc,%esp
80101342:	68 a6 80 10 80       	push   $0x801080a6
80101347:	e8 44 f0 ff ff       	call   80100390 <panic>
8010134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101350 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	56                   	push   %esi
80101355:	53                   	push   %ebx
80101356:	83 ec 1c             	sub    $0x1c,%esp
80101359:	8b 75 08             	mov    0x8(%ebp),%esi
8010135c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010135f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101363:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101366:	8b 45 10             	mov    0x10(%ebp),%eax
80101369:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010136c:	0f 84 aa 00 00 00    	je     8010141c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101372:	8b 06                	mov    (%esi),%eax
80101374:	83 f8 01             	cmp    $0x1,%eax
80101377:	0f 84 c3 00 00 00    	je     80101440 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010137d:	83 f8 02             	cmp    $0x2,%eax
80101380:	0f 85 d9 00 00 00    	jne    8010145f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101386:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101389:	31 ff                	xor    %edi,%edi
    while(i < n){
8010138b:	85 c0                	test   %eax,%eax
8010138d:	7f 34                	jg     801013c3 <filewrite+0x73>
8010138f:	e9 9c 00 00 00       	jmp    80101430 <filewrite+0xe0>
80101394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101398:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010139b:	83 ec 0c             	sub    $0xc,%esp
8010139e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801013a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801013a4:	e8 27 07 00 00       	call   80101ad0 <iunlock>
      end_op();
801013a9:	e8 52 1c 00 00       	call   80103000 <end_op>
801013ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013b1:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801013b4:	39 c3                	cmp    %eax,%ebx
801013b6:	0f 85 96 00 00 00    	jne    80101452 <filewrite+0x102>
        panic("short filewrite");
      i += r;
801013bc:	01 df                	add    %ebx,%edi
    while(i < n){
801013be:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801013c1:	7e 6d                	jle    80101430 <filewrite+0xe0>
      int n1 = n - i;
801013c3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801013c6:	b8 00 06 00 00       	mov    $0x600,%eax
801013cb:	29 fb                	sub    %edi,%ebx
801013cd:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801013d3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801013d6:	e8 b5 1b 00 00       	call   80102f90 <begin_op>
      ilock(f->ip);
801013db:	83 ec 0c             	sub    $0xc,%esp
801013de:	ff 76 10             	pushl  0x10(%esi)
801013e1:	e8 0a 06 00 00       	call   801019f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801013e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801013e9:	53                   	push   %ebx
801013ea:	ff 76 14             	pushl  0x14(%esi)
801013ed:	01 f8                	add    %edi,%eax
801013ef:	50                   	push   %eax
801013f0:	ff 76 10             	pushl  0x10(%esi)
801013f3:	e8 d8 09 00 00       	call   80101dd0 <writei>
801013f8:	83 c4 20             	add    $0x20,%esp
801013fb:	85 c0                	test   %eax,%eax
801013fd:	7f 99                	jg     80101398 <filewrite+0x48>
      iunlock(f->ip);
801013ff:	83 ec 0c             	sub    $0xc,%esp
80101402:	ff 76 10             	pushl  0x10(%esi)
80101405:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101408:	e8 c3 06 00 00       	call   80101ad0 <iunlock>
      end_op();
8010140d:	e8 ee 1b 00 00       	call   80103000 <end_op>
      if(r < 0)
80101412:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101415:	83 c4 10             	add    $0x10,%esp
80101418:	85 c0                	test   %eax,%eax
8010141a:	74 98                	je     801013b4 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010141c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010141f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101424:	89 f8                	mov    %edi,%eax
80101426:	5b                   	pop    %ebx
80101427:	5e                   	pop    %esi
80101428:	5f                   	pop    %edi
80101429:	5d                   	pop    %ebp
8010142a:	c3                   	ret    
8010142b:	90                   	nop
8010142c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101430:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101433:	75 e7                	jne    8010141c <filewrite+0xcc>
}
80101435:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101438:	89 f8                	mov    %edi,%eax
8010143a:	5b                   	pop    %ebx
8010143b:	5e                   	pop    %esi
8010143c:	5f                   	pop    %edi
8010143d:	5d                   	pop    %ebp
8010143e:	c3                   	ret    
8010143f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101440:	8b 46 0c             	mov    0xc(%esi),%eax
80101443:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101446:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101449:	5b                   	pop    %ebx
8010144a:	5e                   	pop    %esi
8010144b:	5f                   	pop    %edi
8010144c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010144d:	e9 8e 23 00 00       	jmp    801037e0 <pipewrite>
        panic("short filewrite");
80101452:	83 ec 0c             	sub    $0xc,%esp
80101455:	68 af 80 10 80       	push   $0x801080af
8010145a:	e8 31 ef ff ff       	call   80100390 <panic>
  panic("filewrite");
8010145f:	83 ec 0c             	sub    $0xc,%esp
80101462:	68 b5 80 10 80       	push   $0x801080b5
80101467:	e8 24 ef ff ff       	call   80100390 <panic>
8010146c:	66 90                	xchg   %ax,%ax
8010146e:	66 90                	xchg   %ax,%ax

80101470 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	57                   	push   %edi
80101474:	56                   	push   %esi
80101475:	53                   	push   %ebx
80101476:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101479:	8b 0d 80 1c 11 80    	mov    0x80111c80,%ecx
{
8010147f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101482:	85 c9                	test   %ecx,%ecx
80101484:	0f 84 87 00 00 00    	je     80101511 <balloc+0xa1>
8010148a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101491:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101494:	83 ec 08             	sub    $0x8,%esp
80101497:	89 f0                	mov    %esi,%eax
80101499:	c1 f8 0c             	sar    $0xc,%eax
8010149c:	03 05 98 1c 11 80    	add    0x80111c98,%eax
801014a2:	50                   	push   %eax
801014a3:	ff 75 d8             	pushl  -0x28(%ebp)
801014a6:	e8 25 ec ff ff       	call   801000d0 <bread>
801014ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014ae:	a1 80 1c 11 80       	mov    0x80111c80,%eax
801014b3:	83 c4 10             	add    $0x10,%esp
801014b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801014b9:	31 c0                	xor    %eax,%eax
801014bb:	eb 2f                	jmp    801014ec <balloc+0x7c>
801014bd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801014c0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801014c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801014c5:	bb 01 00 00 00       	mov    $0x1,%ebx
801014ca:	83 e1 07             	and    $0x7,%ecx
801014cd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801014cf:	89 c1                	mov    %eax,%ecx
801014d1:	c1 f9 03             	sar    $0x3,%ecx
801014d4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801014d9:	85 df                	test   %ebx,%edi
801014db:	89 fa                	mov    %edi,%edx
801014dd:	74 41                	je     80101520 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014df:	83 c0 01             	add    $0x1,%eax
801014e2:	83 c6 01             	add    $0x1,%esi
801014e5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801014ea:	74 05                	je     801014f1 <balloc+0x81>
801014ec:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801014ef:	77 cf                	ja     801014c0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014f1:	83 ec 0c             	sub    $0xc,%esp
801014f4:	ff 75 e4             	pushl  -0x1c(%ebp)
801014f7:	e8 e4 ec ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801014fc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101503:	83 c4 10             	add    $0x10,%esp
80101506:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101509:	39 05 80 1c 11 80    	cmp    %eax,0x80111c80
8010150f:	77 80                	ja     80101491 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101511:	83 ec 0c             	sub    $0xc,%esp
80101514:	68 bf 80 10 80       	push   $0x801080bf
80101519:	e8 72 ee ff ff       	call   80100390 <panic>
8010151e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101520:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101523:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101526:	09 da                	or     %ebx,%edx
80101528:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010152c:	57                   	push   %edi
8010152d:	e8 2e 1c 00 00       	call   80103160 <log_write>
        brelse(bp);
80101532:	89 3c 24             	mov    %edi,(%esp)
80101535:	e8 a6 ec ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010153a:	58                   	pop    %eax
8010153b:	5a                   	pop    %edx
8010153c:	56                   	push   %esi
8010153d:	ff 75 d8             	pushl  -0x28(%ebp)
80101540:	e8 8b eb ff ff       	call   801000d0 <bread>
80101545:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101547:	8d 40 5c             	lea    0x5c(%eax),%eax
8010154a:	83 c4 0c             	add    $0xc,%esp
8010154d:	68 00 02 00 00       	push   $0x200
80101552:	6a 00                	push   $0x0
80101554:	50                   	push   %eax
80101555:	e8 06 3d 00 00       	call   80105260 <memset>
  log_write(bp);
8010155a:	89 1c 24             	mov    %ebx,(%esp)
8010155d:	e8 fe 1b 00 00       	call   80103160 <log_write>
  brelse(bp);
80101562:	89 1c 24             	mov    %ebx,(%esp)
80101565:	e8 76 ec ff ff       	call   801001e0 <brelse>
}
8010156a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010156d:	89 f0                	mov    %esi,%eax
8010156f:	5b                   	pop    %ebx
80101570:	5e                   	pop    %esi
80101571:	5f                   	pop    %edi
80101572:	5d                   	pop    %ebp
80101573:	c3                   	ret    
80101574:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010157a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101580 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101580:	55                   	push   %ebp
80101581:	89 e5                	mov    %esp,%ebp
80101583:	57                   	push   %edi
80101584:	56                   	push   %esi
80101585:	53                   	push   %ebx
80101586:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101588:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010158a:	bb d4 1c 11 80       	mov    $0x80111cd4,%ebx
{
8010158f:	83 ec 28             	sub    $0x28,%esp
80101592:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101595:	68 a0 1c 11 80       	push   $0x80111ca0
8010159a:	e8 b1 3b 00 00       	call   80105150 <acquire>
8010159f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801015a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015a5:	eb 17                	jmp    801015be <iget+0x3e>
801015a7:	89 f6                	mov    %esi,%esi
801015a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801015b0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015b6:	81 fb f4 38 11 80    	cmp    $0x801138f4,%ebx
801015bc:	73 22                	jae    801015e0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801015be:	8b 4b 08             	mov    0x8(%ebx),%ecx
801015c1:	85 c9                	test   %ecx,%ecx
801015c3:	7e 04                	jle    801015c9 <iget+0x49>
801015c5:	39 3b                	cmp    %edi,(%ebx)
801015c7:	74 4f                	je     80101618 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801015c9:	85 f6                	test   %esi,%esi
801015cb:	75 e3                	jne    801015b0 <iget+0x30>
801015cd:	85 c9                	test   %ecx,%ecx
801015cf:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801015d2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015d8:	81 fb f4 38 11 80    	cmp    $0x801138f4,%ebx
801015de:	72 de                	jb     801015be <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801015e0:	85 f6                	test   %esi,%esi
801015e2:	74 5b                	je     8010163f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801015e4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801015e7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801015e9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801015ec:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801015f3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801015fa:	68 a0 1c 11 80       	push   $0x80111ca0
801015ff:	e8 0c 3c 00 00       	call   80105210 <release>

  return ip;
80101604:	83 c4 10             	add    $0x10,%esp
}
80101607:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010160a:	89 f0                	mov    %esi,%eax
8010160c:	5b                   	pop    %ebx
8010160d:	5e                   	pop    %esi
8010160e:	5f                   	pop    %edi
8010160f:	5d                   	pop    %ebp
80101610:	c3                   	ret    
80101611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101618:	39 53 04             	cmp    %edx,0x4(%ebx)
8010161b:	75 ac                	jne    801015c9 <iget+0x49>
      release(&icache.lock);
8010161d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101620:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101623:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101625:	68 a0 1c 11 80       	push   $0x80111ca0
      ip->ref++;
8010162a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010162d:	e8 de 3b 00 00       	call   80105210 <release>
      return ip;
80101632:	83 c4 10             	add    $0x10,%esp
}
80101635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101638:	89 f0                	mov    %esi,%eax
8010163a:	5b                   	pop    %ebx
8010163b:	5e                   	pop    %esi
8010163c:	5f                   	pop    %edi
8010163d:	5d                   	pop    %ebp
8010163e:	c3                   	ret    
    panic("iget: no inodes");
8010163f:	83 ec 0c             	sub    $0xc,%esp
80101642:	68 d5 80 10 80       	push   $0x801080d5
80101647:	e8 44 ed ff ff       	call   80100390 <panic>
8010164c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101650 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	57                   	push   %edi
80101654:	56                   	push   %esi
80101655:	53                   	push   %ebx
80101656:	89 c6                	mov    %eax,%esi
80101658:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010165b:	83 fa 0b             	cmp    $0xb,%edx
8010165e:	77 18                	ja     80101678 <bmap+0x28>
80101660:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101663:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101666:	85 db                	test   %ebx,%ebx
80101668:	74 76                	je     801016e0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010166a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010166d:	89 d8                	mov    %ebx,%eax
8010166f:	5b                   	pop    %ebx
80101670:	5e                   	pop    %esi
80101671:	5f                   	pop    %edi
80101672:	5d                   	pop    %ebp
80101673:	c3                   	ret    
80101674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101678:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010167b:	83 fb 7f             	cmp    $0x7f,%ebx
8010167e:	0f 87 90 00 00 00    	ja     80101714 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101684:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010168a:	8b 00                	mov    (%eax),%eax
8010168c:	85 d2                	test   %edx,%edx
8010168e:	74 70                	je     80101700 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101690:	83 ec 08             	sub    $0x8,%esp
80101693:	52                   	push   %edx
80101694:	50                   	push   %eax
80101695:	e8 36 ea ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010169a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010169e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801016a1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801016a3:	8b 1a                	mov    (%edx),%ebx
801016a5:	85 db                	test   %ebx,%ebx
801016a7:	75 1d                	jne    801016c6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801016a9:	8b 06                	mov    (%esi),%eax
801016ab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801016ae:	e8 bd fd ff ff       	call   80101470 <balloc>
801016b3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801016b6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801016b9:	89 c3                	mov    %eax,%ebx
801016bb:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801016bd:	57                   	push   %edi
801016be:	e8 9d 1a 00 00       	call   80103160 <log_write>
801016c3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801016c6:	83 ec 0c             	sub    $0xc,%esp
801016c9:	57                   	push   %edi
801016ca:	e8 11 eb ff ff       	call   801001e0 <brelse>
801016cf:	83 c4 10             	add    $0x10,%esp
}
801016d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016d5:	89 d8                	mov    %ebx,%eax
801016d7:	5b                   	pop    %ebx
801016d8:	5e                   	pop    %esi
801016d9:	5f                   	pop    %edi
801016da:	5d                   	pop    %ebp
801016db:	c3                   	ret    
801016dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
801016e0:	8b 00                	mov    (%eax),%eax
801016e2:	e8 89 fd ff ff       	call   80101470 <balloc>
801016e7:	89 47 5c             	mov    %eax,0x5c(%edi)
}
801016ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
801016ed:	89 c3                	mov    %eax,%ebx
}
801016ef:	89 d8                	mov    %ebx,%eax
801016f1:	5b                   	pop    %ebx
801016f2:	5e                   	pop    %esi
801016f3:	5f                   	pop    %edi
801016f4:	5d                   	pop    %ebp
801016f5:	c3                   	ret    
801016f6:	8d 76 00             	lea    0x0(%esi),%esi
801016f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101700:	e8 6b fd ff ff       	call   80101470 <balloc>
80101705:	89 c2                	mov    %eax,%edx
80101707:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010170d:	8b 06                	mov    (%esi),%eax
8010170f:	e9 7c ff ff ff       	jmp    80101690 <bmap+0x40>
  panic("bmap: out of range");
80101714:	83 ec 0c             	sub    $0xc,%esp
80101717:	68 e5 80 10 80       	push   $0x801080e5
8010171c:	e8 6f ec ff ff       	call   80100390 <panic>
80101721:	eb 0d                	jmp    80101730 <readsb>
80101723:	90                   	nop
80101724:	90                   	nop
80101725:	90                   	nop
80101726:	90                   	nop
80101727:	90                   	nop
80101728:	90                   	nop
80101729:	90                   	nop
8010172a:	90                   	nop
8010172b:	90                   	nop
8010172c:	90                   	nop
8010172d:	90                   	nop
8010172e:	90                   	nop
8010172f:	90                   	nop

80101730 <readsb>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	56                   	push   %esi
80101734:	53                   	push   %ebx
80101735:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101738:	83 ec 08             	sub    $0x8,%esp
8010173b:	6a 01                	push   $0x1
8010173d:	ff 75 08             	pushl  0x8(%ebp)
80101740:	e8 8b e9 ff ff       	call   801000d0 <bread>
80101745:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101747:	8d 40 5c             	lea    0x5c(%eax),%eax
8010174a:	83 c4 0c             	add    $0xc,%esp
8010174d:	6a 1c                	push   $0x1c
8010174f:	50                   	push   %eax
80101750:	56                   	push   %esi
80101751:	e8 ba 3b 00 00       	call   80105310 <memmove>
  brelse(bp);
80101756:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101759:	83 c4 10             	add    $0x10,%esp
}
8010175c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010175f:	5b                   	pop    %ebx
80101760:	5e                   	pop    %esi
80101761:	5d                   	pop    %ebp
  brelse(bp);
80101762:	e9 79 ea ff ff       	jmp    801001e0 <brelse>
80101767:	89 f6                	mov    %esi,%esi
80101769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101770 <bfree>:
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	56                   	push   %esi
80101774:	53                   	push   %ebx
80101775:	89 d3                	mov    %edx,%ebx
80101777:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101779:	83 ec 08             	sub    $0x8,%esp
8010177c:	68 80 1c 11 80       	push   $0x80111c80
80101781:	50                   	push   %eax
80101782:	e8 a9 ff ff ff       	call   80101730 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101787:	58                   	pop    %eax
80101788:	5a                   	pop    %edx
80101789:	89 da                	mov    %ebx,%edx
8010178b:	c1 ea 0c             	shr    $0xc,%edx
8010178e:	03 15 98 1c 11 80    	add    0x80111c98,%edx
80101794:	52                   	push   %edx
80101795:	56                   	push   %esi
80101796:	e8 35 e9 ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010179b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010179d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801017a0:	ba 01 00 00 00       	mov    $0x1,%edx
801017a5:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801017a8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801017ae:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801017b1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801017b3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801017b8:	85 d1                	test   %edx,%ecx
801017ba:	74 25                	je     801017e1 <bfree+0x71>
  bp->data[bi/8] &= ~m;
801017bc:	f7 d2                	not    %edx
801017be:	89 c6                	mov    %eax,%esi
  log_write(bp);
801017c0:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801017c3:	21 ca                	and    %ecx,%edx
801017c5:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801017c9:	56                   	push   %esi
801017ca:	e8 91 19 00 00       	call   80103160 <log_write>
  brelse(bp);
801017cf:	89 34 24             	mov    %esi,(%esp)
801017d2:	e8 09 ea ff ff       	call   801001e0 <brelse>
}
801017d7:	83 c4 10             	add    $0x10,%esp
801017da:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017dd:	5b                   	pop    %ebx
801017de:	5e                   	pop    %esi
801017df:	5d                   	pop    %ebp
801017e0:	c3                   	ret    
    panic("freeing free block");
801017e1:	83 ec 0c             	sub    $0xc,%esp
801017e4:	68 f8 80 10 80       	push   $0x801080f8
801017e9:	e8 a2 eb ff ff       	call   80100390 <panic>
801017ee:	66 90                	xchg   %ax,%ax

801017f0 <iinit>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	53                   	push   %ebx
801017f4:	bb e0 1c 11 80       	mov    $0x80111ce0,%ebx
801017f9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801017fc:	68 0b 81 10 80       	push   $0x8010810b
80101801:	68 a0 1c 11 80       	push   $0x80111ca0
80101806:	e8 05 38 00 00       	call   80105010 <initlock>
8010180b:	83 c4 10             	add    $0x10,%esp
8010180e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101810:	83 ec 08             	sub    $0x8,%esp
80101813:	68 12 81 10 80       	push   $0x80108112
80101818:	53                   	push   %ebx
80101819:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010181f:	e8 bc 36 00 00       	call   80104ee0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101824:	83 c4 10             	add    $0x10,%esp
80101827:	81 fb 00 39 11 80    	cmp    $0x80113900,%ebx
8010182d:	75 e1                	jne    80101810 <iinit+0x20>
  readsb(dev, &sb);
8010182f:	83 ec 08             	sub    $0x8,%esp
80101832:	68 80 1c 11 80       	push   $0x80111c80
80101837:	ff 75 08             	pushl  0x8(%ebp)
8010183a:	e8 f1 fe ff ff       	call   80101730 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010183f:	ff 35 98 1c 11 80    	pushl  0x80111c98
80101845:	ff 35 94 1c 11 80    	pushl  0x80111c94
8010184b:	ff 35 90 1c 11 80    	pushl  0x80111c90
80101851:	ff 35 8c 1c 11 80    	pushl  0x80111c8c
80101857:	ff 35 88 1c 11 80    	pushl  0x80111c88
8010185d:	ff 35 84 1c 11 80    	pushl  0x80111c84
80101863:	ff 35 80 1c 11 80    	pushl  0x80111c80
80101869:	68 78 81 10 80       	push   $0x80108178
8010186e:	e8 ed ed ff ff       	call   80100660 <cprintf>
}
80101873:	83 c4 30             	add    $0x30,%esp
80101876:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101879:	c9                   	leave  
8010187a:	c3                   	ret    
8010187b:	90                   	nop
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101880 <ialloc>:
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	57                   	push   %edi
80101884:	56                   	push   %esi
80101885:	53                   	push   %ebx
80101886:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101889:	83 3d 88 1c 11 80 01 	cmpl   $0x1,0x80111c88
{
80101890:	8b 45 0c             	mov    0xc(%ebp),%eax
80101893:	8b 75 08             	mov    0x8(%ebp),%esi
80101896:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101899:	0f 86 91 00 00 00    	jbe    80101930 <ialloc+0xb0>
8010189f:	bb 01 00 00 00       	mov    $0x1,%ebx
801018a4:	eb 21                	jmp    801018c7 <ialloc+0x47>
801018a6:	8d 76 00             	lea    0x0(%esi),%esi
801018a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
801018b0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801018b3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
801018b6:	57                   	push   %edi
801018b7:	e8 24 e9 ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801018bc:	83 c4 10             	add    $0x10,%esp
801018bf:	39 1d 88 1c 11 80    	cmp    %ebx,0x80111c88
801018c5:	76 69                	jbe    80101930 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801018c7:	89 d8                	mov    %ebx,%eax
801018c9:	83 ec 08             	sub    $0x8,%esp
801018cc:	c1 e8 03             	shr    $0x3,%eax
801018cf:	03 05 94 1c 11 80    	add    0x80111c94,%eax
801018d5:	50                   	push   %eax
801018d6:	56                   	push   %esi
801018d7:	e8 f4 e7 ff ff       	call   801000d0 <bread>
801018dc:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801018de:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801018e0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801018e3:	83 e0 07             	and    $0x7,%eax
801018e6:	c1 e0 06             	shl    $0x6,%eax
801018e9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801018ed:	66 83 39 00          	cmpw   $0x0,(%ecx)
801018f1:	75 bd                	jne    801018b0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801018f3:	83 ec 04             	sub    $0x4,%esp
801018f6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801018f9:	6a 40                	push   $0x40
801018fb:	6a 00                	push   $0x0
801018fd:	51                   	push   %ecx
801018fe:	e8 5d 39 00 00       	call   80105260 <memset>
      dip->type = type;
80101903:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101907:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010190a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010190d:	89 3c 24             	mov    %edi,(%esp)
80101910:	e8 4b 18 00 00       	call   80103160 <log_write>
      brelse(bp);
80101915:	89 3c 24             	mov    %edi,(%esp)
80101918:	e8 c3 e8 ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010191d:	83 c4 10             	add    $0x10,%esp
}
80101920:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101923:	89 da                	mov    %ebx,%edx
80101925:	89 f0                	mov    %esi,%eax
}
80101927:	5b                   	pop    %ebx
80101928:	5e                   	pop    %esi
80101929:	5f                   	pop    %edi
8010192a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010192b:	e9 50 fc ff ff       	jmp    80101580 <iget>
  panic("ialloc: no inodes");
80101930:	83 ec 0c             	sub    $0xc,%esp
80101933:	68 18 81 10 80       	push   $0x80108118
80101938:	e8 53 ea ff ff       	call   80100390 <panic>
8010193d:	8d 76 00             	lea    0x0(%esi),%esi

80101940 <iupdate>:
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	56                   	push   %esi
80101944:	53                   	push   %ebx
80101945:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101948:	83 ec 08             	sub    $0x8,%esp
8010194b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010194e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101951:	c1 e8 03             	shr    $0x3,%eax
80101954:	03 05 94 1c 11 80    	add    0x80111c94,%eax
8010195a:	50                   	push   %eax
8010195b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010195e:	e8 6d e7 ff ff       	call   801000d0 <bread>
80101963:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101965:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101968:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010196c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010196f:	83 e0 07             	and    $0x7,%eax
80101972:	c1 e0 06             	shl    $0x6,%eax
80101975:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101979:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010197c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101980:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101983:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101987:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010198b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010198f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101993:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101997:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010199a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010199d:	6a 34                	push   $0x34
8010199f:	53                   	push   %ebx
801019a0:	50                   	push   %eax
801019a1:	e8 6a 39 00 00       	call   80105310 <memmove>
  log_write(bp);
801019a6:	89 34 24             	mov    %esi,(%esp)
801019a9:	e8 b2 17 00 00       	call   80103160 <log_write>
  brelse(bp);
801019ae:	89 75 08             	mov    %esi,0x8(%ebp)
801019b1:	83 c4 10             	add    $0x10,%esp
}
801019b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019b7:	5b                   	pop    %ebx
801019b8:	5e                   	pop    %esi
801019b9:	5d                   	pop    %ebp
  brelse(bp);
801019ba:	e9 21 e8 ff ff       	jmp    801001e0 <brelse>
801019bf:	90                   	nop

801019c0 <idup>:
{
801019c0:	55                   	push   %ebp
801019c1:	89 e5                	mov    %esp,%ebp
801019c3:	53                   	push   %ebx
801019c4:	83 ec 10             	sub    $0x10,%esp
801019c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801019ca:	68 a0 1c 11 80       	push   $0x80111ca0
801019cf:	e8 7c 37 00 00       	call   80105150 <acquire>
  ip->ref++;
801019d4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801019d8:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
801019df:	e8 2c 38 00 00       	call   80105210 <release>
}
801019e4:	89 d8                	mov    %ebx,%eax
801019e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019e9:	c9                   	leave  
801019ea:	c3                   	ret    
801019eb:	90                   	nop
801019ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019f0 <ilock>:
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	56                   	push   %esi
801019f4:	53                   	push   %ebx
801019f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801019f8:	85 db                	test   %ebx,%ebx
801019fa:	0f 84 b7 00 00 00    	je     80101ab7 <ilock+0xc7>
80101a00:	8b 53 08             	mov    0x8(%ebx),%edx
80101a03:	85 d2                	test   %edx,%edx
80101a05:	0f 8e ac 00 00 00    	jle    80101ab7 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101a0b:	8d 43 0c             	lea    0xc(%ebx),%eax
80101a0e:	83 ec 0c             	sub    $0xc,%esp
80101a11:	50                   	push   %eax
80101a12:	e8 09 35 00 00       	call   80104f20 <acquiresleep>
  if(ip->valid == 0){
80101a17:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	85 c0                	test   %eax,%eax
80101a1f:	74 0f                	je     80101a30 <ilock+0x40>
}
80101a21:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a24:	5b                   	pop    %ebx
80101a25:	5e                   	pop    %esi
80101a26:	5d                   	pop    %ebp
80101a27:	c3                   	ret    
80101a28:	90                   	nop
80101a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a30:	8b 43 04             	mov    0x4(%ebx),%eax
80101a33:	83 ec 08             	sub    $0x8,%esp
80101a36:	c1 e8 03             	shr    $0x3,%eax
80101a39:	03 05 94 1c 11 80    	add    0x80111c94,%eax
80101a3f:	50                   	push   %eax
80101a40:	ff 33                	pushl  (%ebx)
80101a42:	e8 89 e6 ff ff       	call   801000d0 <bread>
80101a47:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a49:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a4c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a4f:	83 e0 07             	and    $0x7,%eax
80101a52:	c1 e0 06             	shl    $0x6,%eax
80101a55:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101a59:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a5c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101a5f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101a63:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101a67:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101a6b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101a6f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101a73:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101a77:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101a7b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101a7e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a81:	6a 34                	push   $0x34
80101a83:	50                   	push   %eax
80101a84:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101a87:	50                   	push   %eax
80101a88:	e8 83 38 00 00       	call   80105310 <memmove>
    brelse(bp);
80101a8d:	89 34 24             	mov    %esi,(%esp)
80101a90:	e8 4b e7 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101a95:	83 c4 10             	add    $0x10,%esp
80101a98:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101a9d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101aa4:	0f 85 77 ff ff ff    	jne    80101a21 <ilock+0x31>
      panic("ilock: no type");
80101aaa:	83 ec 0c             	sub    $0xc,%esp
80101aad:	68 30 81 10 80       	push   $0x80108130
80101ab2:	e8 d9 e8 ff ff       	call   80100390 <panic>
    panic("ilock");
80101ab7:	83 ec 0c             	sub    $0xc,%esp
80101aba:	68 2a 81 10 80       	push   $0x8010812a
80101abf:	e8 cc e8 ff ff       	call   80100390 <panic>
80101ac4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101aca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101ad0 <iunlock>:
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	56                   	push   %esi
80101ad4:	53                   	push   %ebx
80101ad5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ad8:	85 db                	test   %ebx,%ebx
80101ada:	74 28                	je     80101b04 <iunlock+0x34>
80101adc:	8d 73 0c             	lea    0xc(%ebx),%esi
80101adf:	83 ec 0c             	sub    $0xc,%esp
80101ae2:	56                   	push   %esi
80101ae3:	e8 d8 34 00 00       	call   80104fc0 <holdingsleep>
80101ae8:	83 c4 10             	add    $0x10,%esp
80101aeb:	85 c0                	test   %eax,%eax
80101aed:	74 15                	je     80101b04 <iunlock+0x34>
80101aef:	8b 43 08             	mov    0x8(%ebx),%eax
80101af2:	85 c0                	test   %eax,%eax
80101af4:	7e 0e                	jle    80101b04 <iunlock+0x34>
  releasesleep(&ip->lock);
80101af6:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101af9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101afc:	5b                   	pop    %ebx
80101afd:	5e                   	pop    %esi
80101afe:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101aff:	e9 7c 34 00 00       	jmp    80104f80 <releasesleep>
    panic("iunlock");
80101b04:	83 ec 0c             	sub    $0xc,%esp
80101b07:	68 3f 81 10 80       	push   $0x8010813f
80101b0c:	e8 7f e8 ff ff       	call   80100390 <panic>
80101b11:	eb 0d                	jmp    80101b20 <iput>
80101b13:	90                   	nop
80101b14:	90                   	nop
80101b15:	90                   	nop
80101b16:	90                   	nop
80101b17:	90                   	nop
80101b18:	90                   	nop
80101b19:	90                   	nop
80101b1a:	90                   	nop
80101b1b:	90                   	nop
80101b1c:	90                   	nop
80101b1d:	90                   	nop
80101b1e:	90                   	nop
80101b1f:	90                   	nop

80101b20 <iput>:
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	57                   	push   %edi
80101b24:	56                   	push   %esi
80101b25:	53                   	push   %ebx
80101b26:	83 ec 28             	sub    $0x28,%esp
80101b29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101b2c:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101b2f:	57                   	push   %edi
80101b30:	e8 eb 33 00 00       	call   80104f20 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101b35:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101b38:	83 c4 10             	add    $0x10,%esp
80101b3b:	85 d2                	test   %edx,%edx
80101b3d:	74 07                	je     80101b46 <iput+0x26>
80101b3f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101b44:	74 32                	je     80101b78 <iput+0x58>
  releasesleep(&ip->lock);
80101b46:	83 ec 0c             	sub    $0xc,%esp
80101b49:	57                   	push   %edi
80101b4a:	e8 31 34 00 00       	call   80104f80 <releasesleep>
  acquire(&icache.lock);
80101b4f:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101b56:	e8 f5 35 00 00       	call   80105150 <acquire>
  ip->ref--;
80101b5b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101b5f:	83 c4 10             	add    $0x10,%esp
80101b62:	c7 45 08 a0 1c 11 80 	movl   $0x80111ca0,0x8(%ebp)
}
80101b69:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b6c:	5b                   	pop    %ebx
80101b6d:	5e                   	pop    %esi
80101b6e:	5f                   	pop    %edi
80101b6f:	5d                   	pop    %ebp
  release(&icache.lock);
80101b70:	e9 9b 36 00 00       	jmp    80105210 <release>
80101b75:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101b78:	83 ec 0c             	sub    $0xc,%esp
80101b7b:	68 a0 1c 11 80       	push   $0x80111ca0
80101b80:	e8 cb 35 00 00       	call   80105150 <acquire>
    int r = ip->ref;
80101b85:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101b88:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101b8f:	e8 7c 36 00 00       	call   80105210 <release>
    if(r == 1){
80101b94:	83 c4 10             	add    $0x10,%esp
80101b97:	83 fe 01             	cmp    $0x1,%esi
80101b9a:	75 aa                	jne    80101b46 <iput+0x26>
80101b9c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101ba2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101ba5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101ba8:	89 cf                	mov    %ecx,%edi
80101baa:	eb 0b                	jmp    80101bb7 <iput+0x97>
80101bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bb0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101bb3:	39 fe                	cmp    %edi,%esi
80101bb5:	74 19                	je     80101bd0 <iput+0xb0>
    if(ip->addrs[i]){
80101bb7:	8b 16                	mov    (%esi),%edx
80101bb9:	85 d2                	test   %edx,%edx
80101bbb:	74 f3                	je     80101bb0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101bbd:	8b 03                	mov    (%ebx),%eax
80101bbf:	e8 ac fb ff ff       	call   80101770 <bfree>
      ip->addrs[i] = 0;
80101bc4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101bca:	eb e4                	jmp    80101bb0 <iput+0x90>
80101bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101bd0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101bd6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101bd9:	85 c0                	test   %eax,%eax
80101bdb:	75 33                	jne    80101c10 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101bdd:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101be0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101be7:	53                   	push   %ebx
80101be8:	e8 53 fd ff ff       	call   80101940 <iupdate>
      ip->type = 0;
80101bed:	31 c0                	xor    %eax,%eax
80101bef:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101bf3:	89 1c 24             	mov    %ebx,(%esp)
80101bf6:	e8 45 fd ff ff       	call   80101940 <iupdate>
      ip->valid = 0;
80101bfb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101c02:	83 c4 10             	add    $0x10,%esp
80101c05:	e9 3c ff ff ff       	jmp    80101b46 <iput+0x26>
80101c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101c10:	83 ec 08             	sub    $0x8,%esp
80101c13:	50                   	push   %eax
80101c14:	ff 33                	pushl  (%ebx)
80101c16:	e8 b5 e4 ff ff       	call   801000d0 <bread>
80101c1b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101c21:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101c24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101c27:	8d 70 5c             	lea    0x5c(%eax),%esi
80101c2a:	83 c4 10             	add    $0x10,%esp
80101c2d:	89 cf                	mov    %ecx,%edi
80101c2f:	eb 0e                	jmp    80101c3f <iput+0x11f>
80101c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c38:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
80101c3b:	39 fe                	cmp    %edi,%esi
80101c3d:	74 0f                	je     80101c4e <iput+0x12e>
      if(a[j])
80101c3f:	8b 16                	mov    (%esi),%edx
80101c41:	85 d2                	test   %edx,%edx
80101c43:	74 f3                	je     80101c38 <iput+0x118>
        bfree(ip->dev, a[j]);
80101c45:	8b 03                	mov    (%ebx),%eax
80101c47:	e8 24 fb ff ff       	call   80101770 <bfree>
80101c4c:	eb ea                	jmp    80101c38 <iput+0x118>
    brelse(bp);
80101c4e:	83 ec 0c             	sub    $0xc,%esp
80101c51:	ff 75 e4             	pushl  -0x1c(%ebp)
80101c54:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c57:	e8 84 e5 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101c5c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101c62:	8b 03                	mov    (%ebx),%eax
80101c64:	e8 07 fb ff ff       	call   80101770 <bfree>
    ip->addrs[NDIRECT] = 0;
80101c69:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101c70:	00 00 00 
80101c73:	83 c4 10             	add    $0x10,%esp
80101c76:	e9 62 ff ff ff       	jmp    80101bdd <iput+0xbd>
80101c7b:	90                   	nop
80101c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c80 <iunlockput>:
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	53                   	push   %ebx
80101c84:	83 ec 10             	sub    $0x10,%esp
80101c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101c8a:	53                   	push   %ebx
80101c8b:	e8 40 fe ff ff       	call   80101ad0 <iunlock>
  iput(ip);
80101c90:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101c93:	83 c4 10             	add    $0x10,%esp
}
80101c96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c99:	c9                   	leave  
  iput(ip);
80101c9a:	e9 81 fe ff ff       	jmp    80101b20 <iput>
80101c9f:	90                   	nop

80101ca0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ca9:	8b 0a                	mov    (%edx),%ecx
80101cab:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101cae:	8b 4a 04             	mov    0x4(%edx),%ecx
80101cb1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101cb4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101cb8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101cbb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101cbf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101cc3:	8b 52 58             	mov    0x58(%edx),%edx
80101cc6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101cc9:	5d                   	pop    %ebp
80101cca:	c3                   	ret    
80101ccb:	90                   	nop
80101ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101cd0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101cd0:	55                   	push   %ebp
80101cd1:	89 e5                	mov    %esp,%ebp
80101cd3:	57                   	push   %edi
80101cd4:	56                   	push   %esi
80101cd5:	53                   	push   %ebx
80101cd6:	83 ec 1c             	sub    $0x1c,%esp
80101cd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cdc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101cdf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ce2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ce7:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101cea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ced:	8b 75 10             	mov    0x10(%ebp),%esi
80101cf0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101cf3:	0f 84 a7 00 00 00    	je     80101da0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101cf9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cfc:	8b 40 58             	mov    0x58(%eax),%eax
80101cff:	39 c6                	cmp    %eax,%esi
80101d01:	0f 87 ba 00 00 00    	ja     80101dc1 <readi+0xf1>
80101d07:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101d0a:	89 f9                	mov    %edi,%ecx
80101d0c:	01 f1                	add    %esi,%ecx
80101d0e:	0f 82 ad 00 00 00    	jb     80101dc1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101d14:	89 c2                	mov    %eax,%edx
80101d16:	29 f2                	sub    %esi,%edx
80101d18:	39 c8                	cmp    %ecx,%eax
80101d1a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d1d:	31 ff                	xor    %edi,%edi
80101d1f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101d21:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d24:	74 6c                	je     80101d92 <readi+0xc2>
80101d26:	8d 76 00             	lea    0x0(%esi),%esi
80101d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d30:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101d33:	89 f2                	mov    %esi,%edx
80101d35:	c1 ea 09             	shr    $0x9,%edx
80101d38:	89 d8                	mov    %ebx,%eax
80101d3a:	e8 11 f9 ff ff       	call   80101650 <bmap>
80101d3f:	83 ec 08             	sub    $0x8,%esp
80101d42:	50                   	push   %eax
80101d43:	ff 33                	pushl  (%ebx)
80101d45:	e8 86 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d4a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d4d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101d4f:	89 f0                	mov    %esi,%eax
80101d51:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d56:	b9 00 02 00 00       	mov    $0x200,%ecx
80101d5b:	83 c4 0c             	add    $0xc,%esp
80101d5e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101d60:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101d64:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101d67:	29 fb                	sub    %edi,%ebx
80101d69:	39 d9                	cmp    %ebx,%ecx
80101d6b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101d6e:	53                   	push   %ebx
80101d6f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d70:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101d72:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d75:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101d77:	e8 94 35 00 00       	call   80105310 <memmove>
    brelse(bp);
80101d7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d7f:	89 14 24             	mov    %edx,(%esp)
80101d82:	e8 59 e4 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d87:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101d8a:	83 c4 10             	add    $0x10,%esp
80101d8d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101d90:	77 9e                	ja     80101d30 <readi+0x60>
  }
  return n;
80101d92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101d95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d98:	5b                   	pop    %ebx
80101d99:	5e                   	pop    %esi
80101d9a:	5f                   	pop    %edi
80101d9b:	5d                   	pop    %ebp
80101d9c:	c3                   	ret    
80101d9d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101da0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101da4:	66 83 f8 09          	cmp    $0x9,%ax
80101da8:	77 17                	ja     80101dc1 <readi+0xf1>
80101daa:	8b 04 c5 20 1c 11 80 	mov    -0x7feee3e0(,%eax,8),%eax
80101db1:	85 c0                	test   %eax,%eax
80101db3:	74 0c                	je     80101dc1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101db5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101db8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dbb:	5b                   	pop    %ebx
80101dbc:	5e                   	pop    %esi
80101dbd:	5f                   	pop    %edi
80101dbe:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101dbf:	ff e0                	jmp    *%eax
      return -1;
80101dc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dc6:	eb cd                	jmp    80101d95 <readi+0xc5>
80101dc8:	90                   	nop
80101dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101dd0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101dd0:	55                   	push   %ebp
80101dd1:	89 e5                	mov    %esp,%ebp
80101dd3:	57                   	push   %edi
80101dd4:	56                   	push   %esi
80101dd5:	53                   	push   %ebx
80101dd6:	83 ec 1c             	sub    $0x1c,%esp
80101dd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101ddc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101ddf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101de2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101de7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101dea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ded:	8b 75 10             	mov    0x10(%ebp),%esi
80101df0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101df3:	0f 84 b7 00 00 00    	je     80101eb0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101df9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101dfc:	39 70 58             	cmp    %esi,0x58(%eax)
80101dff:	0f 82 eb 00 00 00    	jb     80101ef0 <writei+0x120>
80101e05:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101e08:	31 d2                	xor    %edx,%edx
80101e0a:	89 f8                	mov    %edi,%eax
80101e0c:	01 f0                	add    %esi,%eax
80101e0e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101e11:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101e16:	0f 87 d4 00 00 00    	ja     80101ef0 <writei+0x120>
80101e1c:	85 d2                	test   %edx,%edx
80101e1e:	0f 85 cc 00 00 00    	jne    80101ef0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e24:	85 ff                	test   %edi,%edi
80101e26:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101e2d:	74 72                	je     80101ea1 <writei+0xd1>
80101e2f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e30:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101e33:	89 f2                	mov    %esi,%edx
80101e35:	c1 ea 09             	shr    $0x9,%edx
80101e38:	89 f8                	mov    %edi,%eax
80101e3a:	e8 11 f8 ff ff       	call   80101650 <bmap>
80101e3f:	83 ec 08             	sub    $0x8,%esp
80101e42:	50                   	push   %eax
80101e43:	ff 37                	pushl  (%edi)
80101e45:	e8 86 e2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101e4a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101e4d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e50:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101e52:	89 f0                	mov    %esi,%eax
80101e54:	b9 00 02 00 00       	mov    $0x200,%ecx
80101e59:	83 c4 0c             	add    $0xc,%esp
80101e5c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e61:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101e63:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101e67:	39 d9                	cmp    %ebx,%ecx
80101e69:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101e6c:	53                   	push   %ebx
80101e6d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e70:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101e72:	50                   	push   %eax
80101e73:	e8 98 34 00 00       	call   80105310 <memmove>
    log_write(bp);
80101e78:	89 3c 24             	mov    %edi,(%esp)
80101e7b:	e8 e0 12 00 00       	call   80103160 <log_write>
    brelse(bp);
80101e80:	89 3c 24             	mov    %edi,(%esp)
80101e83:	e8 58 e3 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e88:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101e8b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101e8e:	83 c4 10             	add    $0x10,%esp
80101e91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e94:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101e97:	77 97                	ja     80101e30 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101e99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101e9c:	3b 70 58             	cmp    0x58(%eax),%esi
80101e9f:	77 37                	ja     80101ed8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101ea1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ea4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea7:	5b                   	pop    %ebx
80101ea8:	5e                   	pop    %esi
80101ea9:	5f                   	pop    %edi
80101eaa:	5d                   	pop    %ebp
80101eab:	c3                   	ret    
80101eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101eb0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101eb4:	66 83 f8 09          	cmp    $0x9,%ax
80101eb8:	77 36                	ja     80101ef0 <writei+0x120>
80101eba:	8b 04 c5 24 1c 11 80 	mov    -0x7feee3dc(,%eax,8),%eax
80101ec1:	85 c0                	test   %eax,%eax
80101ec3:	74 2b                	je     80101ef0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101ec5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ec8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ecb:	5b                   	pop    %ebx
80101ecc:	5e                   	pop    %esi
80101ecd:	5f                   	pop    %edi
80101ece:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101ecf:	ff e0                	jmp    *%eax
80101ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101ed8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101edb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101ede:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101ee1:	50                   	push   %eax
80101ee2:	e8 59 fa ff ff       	call   80101940 <iupdate>
80101ee7:	83 c4 10             	add    $0x10,%esp
80101eea:	eb b5                	jmp    80101ea1 <writei+0xd1>
80101eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101ef0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ef5:	eb ad                	jmp    80101ea4 <writei+0xd4>
80101ef7:	89 f6                	mov    %esi,%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101f06:	6a 0e                	push   $0xe
80101f08:	ff 75 0c             	pushl  0xc(%ebp)
80101f0b:	ff 75 08             	pushl  0x8(%ebp)
80101f0e:	e8 6d 34 00 00       	call   80105380 <strncmp>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	57                   	push   %edi
80101f24:	56                   	push   %esi
80101f25:	53                   	push   %ebx
80101f26:	83 ec 1c             	sub    $0x1c,%esp
80101f29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101f2c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101f31:	0f 85 85 00 00 00    	jne    80101fbc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101f37:	8b 53 58             	mov    0x58(%ebx),%edx
80101f3a:	31 ff                	xor    %edi,%edi
80101f3c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f3f:	85 d2                	test   %edx,%edx
80101f41:	74 3e                	je     80101f81 <dirlookup+0x61>
80101f43:	90                   	nop
80101f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f48:	6a 10                	push   $0x10
80101f4a:	57                   	push   %edi
80101f4b:	56                   	push   %esi
80101f4c:	53                   	push   %ebx
80101f4d:	e8 7e fd ff ff       	call   80101cd0 <readi>
80101f52:	83 c4 10             	add    $0x10,%esp
80101f55:	83 f8 10             	cmp    $0x10,%eax
80101f58:	75 55                	jne    80101faf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101f5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f5f:	74 18                	je     80101f79 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101f61:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f64:	83 ec 04             	sub    $0x4,%esp
80101f67:	6a 0e                	push   $0xe
80101f69:	50                   	push   %eax
80101f6a:	ff 75 0c             	pushl  0xc(%ebp)
80101f6d:	e8 0e 34 00 00       	call   80105380 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101f72:	83 c4 10             	add    $0x10,%esp
80101f75:	85 c0                	test   %eax,%eax
80101f77:	74 17                	je     80101f90 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f79:	83 c7 10             	add    $0x10,%edi
80101f7c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f7f:	72 c7                	jb     80101f48 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101f81:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101f84:	31 c0                	xor    %eax,%eax
}
80101f86:	5b                   	pop    %ebx
80101f87:	5e                   	pop    %esi
80101f88:	5f                   	pop    %edi
80101f89:	5d                   	pop    %ebp
80101f8a:	c3                   	ret    
80101f8b:	90                   	nop
80101f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101f90:	8b 45 10             	mov    0x10(%ebp),%eax
80101f93:	85 c0                	test   %eax,%eax
80101f95:	74 05                	je     80101f9c <dirlookup+0x7c>
        *poff = off;
80101f97:	8b 45 10             	mov    0x10(%ebp),%eax
80101f9a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101f9c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101fa0:	8b 03                	mov    (%ebx),%eax
80101fa2:	e8 d9 f5 ff ff       	call   80101580 <iget>
}
80101fa7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101faa:	5b                   	pop    %ebx
80101fab:	5e                   	pop    %esi
80101fac:	5f                   	pop    %edi
80101fad:	5d                   	pop    %ebp
80101fae:	c3                   	ret    
      panic("dirlookup read");
80101faf:	83 ec 0c             	sub    $0xc,%esp
80101fb2:	68 59 81 10 80       	push   $0x80108159
80101fb7:	e8 d4 e3 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101fbc:	83 ec 0c             	sub    $0xc,%esp
80101fbf:	68 47 81 10 80       	push   $0x80108147
80101fc4:	e8 c7 e3 ff ff       	call   80100390 <panic>
80101fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fd0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	57                   	push   %edi
80101fd4:	56                   	push   %esi
80101fd5:	53                   	push   %ebx
80101fd6:	89 cf                	mov    %ecx,%edi
80101fd8:	89 c3                	mov    %eax,%ebx
80101fda:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101fdd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101fe0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101fe3:	0f 84 67 01 00 00    	je     80102150 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101fe9:	e8 32 1c 00 00       	call   80103c20 <myproc>
  acquire(&icache.lock);
80101fee:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ff1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ff4:	68 a0 1c 11 80       	push   $0x80111ca0
80101ff9:	e8 52 31 00 00       	call   80105150 <acquire>
  ip->ref++;
80101ffe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102002:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80102009:	e8 02 32 00 00       	call   80105210 <release>
8010200e:	83 c4 10             	add    $0x10,%esp
80102011:	eb 08                	jmp    8010201b <namex+0x4b>
80102013:	90                   	nop
80102014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102018:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010201b:	0f b6 03             	movzbl (%ebx),%eax
8010201e:	3c 2f                	cmp    $0x2f,%al
80102020:	74 f6                	je     80102018 <namex+0x48>
  if(*path == 0)
80102022:	84 c0                	test   %al,%al
80102024:	0f 84 ee 00 00 00    	je     80102118 <namex+0x148>
  while(*path != '/' && *path != 0)
8010202a:	0f b6 03             	movzbl (%ebx),%eax
8010202d:	3c 2f                	cmp    $0x2f,%al
8010202f:	0f 84 b3 00 00 00    	je     801020e8 <namex+0x118>
80102035:	84 c0                	test   %al,%al
80102037:	89 da                	mov    %ebx,%edx
80102039:	75 09                	jne    80102044 <namex+0x74>
8010203b:	e9 a8 00 00 00       	jmp    801020e8 <namex+0x118>
80102040:	84 c0                	test   %al,%al
80102042:	74 0a                	je     8010204e <namex+0x7e>
    path++;
80102044:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80102047:	0f b6 02             	movzbl (%edx),%eax
8010204a:	3c 2f                	cmp    $0x2f,%al
8010204c:	75 f2                	jne    80102040 <namex+0x70>
8010204e:	89 d1                	mov    %edx,%ecx
80102050:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80102052:	83 f9 0d             	cmp    $0xd,%ecx
80102055:	0f 8e 91 00 00 00    	jle    801020ec <namex+0x11c>
    memmove(name, s, DIRSIZ);
8010205b:	83 ec 04             	sub    $0x4,%esp
8010205e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102061:	6a 0e                	push   $0xe
80102063:	53                   	push   %ebx
80102064:	57                   	push   %edi
80102065:	e8 a6 32 00 00       	call   80105310 <memmove>
    path++;
8010206a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
8010206d:	83 c4 10             	add    $0x10,%esp
    path++;
80102070:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80102072:	80 3a 2f             	cmpb   $0x2f,(%edx)
80102075:	75 11                	jne    80102088 <namex+0xb8>
80102077:	89 f6                	mov    %esi,%esi
80102079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80102080:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102083:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102086:	74 f8                	je     80102080 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102088:	83 ec 0c             	sub    $0xc,%esp
8010208b:	56                   	push   %esi
8010208c:	e8 5f f9 ff ff       	call   801019f0 <ilock>
    if(ip->type != T_DIR){
80102091:	83 c4 10             	add    $0x10,%esp
80102094:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102099:	0f 85 91 00 00 00    	jne    80102130 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
8010209f:	8b 55 e0             	mov    -0x20(%ebp),%edx
801020a2:	85 d2                	test   %edx,%edx
801020a4:	74 09                	je     801020af <namex+0xdf>
801020a6:	80 3b 00             	cmpb   $0x0,(%ebx)
801020a9:	0f 84 b7 00 00 00    	je     80102166 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801020af:	83 ec 04             	sub    $0x4,%esp
801020b2:	6a 00                	push   $0x0
801020b4:	57                   	push   %edi
801020b5:	56                   	push   %esi
801020b6:	e8 65 fe ff ff       	call   80101f20 <dirlookup>
801020bb:	83 c4 10             	add    $0x10,%esp
801020be:	85 c0                	test   %eax,%eax
801020c0:	74 6e                	je     80102130 <namex+0x160>
  iunlock(ip);
801020c2:	83 ec 0c             	sub    $0xc,%esp
801020c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801020c8:	56                   	push   %esi
801020c9:	e8 02 fa ff ff       	call   80101ad0 <iunlock>
  iput(ip);
801020ce:	89 34 24             	mov    %esi,(%esp)
801020d1:	e8 4a fa ff ff       	call   80101b20 <iput>
801020d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801020d9:	83 c4 10             	add    $0x10,%esp
801020dc:	89 c6                	mov    %eax,%esi
801020de:	e9 38 ff ff ff       	jmp    8010201b <namex+0x4b>
801020e3:	90                   	nop
801020e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
801020e8:	89 da                	mov    %ebx,%edx
801020ea:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
801020ec:	83 ec 04             	sub    $0x4,%esp
801020ef:	89 55 dc             	mov    %edx,-0x24(%ebp)
801020f2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801020f5:	51                   	push   %ecx
801020f6:	53                   	push   %ebx
801020f7:	57                   	push   %edi
801020f8:	e8 13 32 00 00       	call   80105310 <memmove>
    name[len] = 0;
801020fd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102100:	8b 55 dc             	mov    -0x24(%ebp),%edx
80102103:	83 c4 10             	add    $0x10,%esp
80102106:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
8010210a:	89 d3                	mov    %edx,%ebx
8010210c:	e9 61 ff ff ff       	jmp    80102072 <namex+0xa2>
80102111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102118:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010211b:	85 c0                	test   %eax,%eax
8010211d:	75 5d                	jne    8010217c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
8010211f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102122:	89 f0                	mov    %esi,%eax
80102124:	5b                   	pop    %ebx
80102125:	5e                   	pop    %esi
80102126:	5f                   	pop    %edi
80102127:	5d                   	pop    %ebp
80102128:	c3                   	ret    
80102129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102130:	83 ec 0c             	sub    $0xc,%esp
80102133:	56                   	push   %esi
80102134:	e8 97 f9 ff ff       	call   80101ad0 <iunlock>
  iput(ip);
80102139:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010213c:	31 f6                	xor    %esi,%esi
  iput(ip);
8010213e:	e8 dd f9 ff ff       	call   80101b20 <iput>
      return 0;
80102143:	83 c4 10             	add    $0x10,%esp
}
80102146:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102149:	89 f0                	mov    %esi,%eax
8010214b:	5b                   	pop    %ebx
8010214c:	5e                   	pop    %esi
8010214d:	5f                   	pop    %edi
8010214e:	5d                   	pop    %ebp
8010214f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80102150:	ba 01 00 00 00       	mov    $0x1,%edx
80102155:	b8 01 00 00 00       	mov    $0x1,%eax
8010215a:	e8 21 f4 ff ff       	call   80101580 <iget>
8010215f:	89 c6                	mov    %eax,%esi
80102161:	e9 b5 fe ff ff       	jmp    8010201b <namex+0x4b>
      iunlock(ip);
80102166:	83 ec 0c             	sub    $0xc,%esp
80102169:	56                   	push   %esi
8010216a:	e8 61 f9 ff ff       	call   80101ad0 <iunlock>
      return ip;
8010216f:	83 c4 10             	add    $0x10,%esp
}
80102172:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102175:	89 f0                	mov    %esi,%eax
80102177:	5b                   	pop    %ebx
80102178:	5e                   	pop    %esi
80102179:	5f                   	pop    %edi
8010217a:	5d                   	pop    %ebp
8010217b:	c3                   	ret    
    iput(ip);
8010217c:	83 ec 0c             	sub    $0xc,%esp
8010217f:	56                   	push   %esi
    return 0;
80102180:	31 f6                	xor    %esi,%esi
    iput(ip);
80102182:	e8 99 f9 ff ff       	call   80101b20 <iput>
    return 0;
80102187:	83 c4 10             	add    $0x10,%esp
8010218a:	eb 93                	jmp    8010211f <namex+0x14f>
8010218c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102190 <dirlink>:
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	57                   	push   %edi
80102194:	56                   	push   %esi
80102195:	53                   	push   %ebx
80102196:	83 ec 20             	sub    $0x20,%esp
80102199:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010219c:	6a 00                	push   $0x0
8010219e:	ff 75 0c             	pushl  0xc(%ebp)
801021a1:	53                   	push   %ebx
801021a2:	e8 79 fd ff ff       	call   80101f20 <dirlookup>
801021a7:	83 c4 10             	add    $0x10,%esp
801021aa:	85 c0                	test   %eax,%eax
801021ac:	75 67                	jne    80102215 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801021ae:	8b 7b 58             	mov    0x58(%ebx),%edi
801021b1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021b4:	85 ff                	test   %edi,%edi
801021b6:	74 29                	je     801021e1 <dirlink+0x51>
801021b8:	31 ff                	xor    %edi,%edi
801021ba:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021bd:	eb 09                	jmp    801021c8 <dirlink+0x38>
801021bf:	90                   	nop
801021c0:	83 c7 10             	add    $0x10,%edi
801021c3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801021c6:	73 19                	jae    801021e1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021c8:	6a 10                	push   $0x10
801021ca:	57                   	push   %edi
801021cb:	56                   	push   %esi
801021cc:	53                   	push   %ebx
801021cd:	e8 fe fa ff ff       	call   80101cd0 <readi>
801021d2:	83 c4 10             	add    $0x10,%esp
801021d5:	83 f8 10             	cmp    $0x10,%eax
801021d8:	75 4e                	jne    80102228 <dirlink+0x98>
    if(de.inum == 0)
801021da:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801021df:	75 df                	jne    801021c0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801021e1:	8d 45 da             	lea    -0x26(%ebp),%eax
801021e4:	83 ec 04             	sub    $0x4,%esp
801021e7:	6a 0e                	push   $0xe
801021e9:	ff 75 0c             	pushl  0xc(%ebp)
801021ec:	50                   	push   %eax
801021ed:	e8 ee 31 00 00       	call   801053e0 <strncpy>
  de.inum = inum;
801021f2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021f5:	6a 10                	push   $0x10
801021f7:	57                   	push   %edi
801021f8:	56                   	push   %esi
801021f9:	53                   	push   %ebx
  de.inum = inum;
801021fa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021fe:	e8 cd fb ff ff       	call   80101dd0 <writei>
80102203:	83 c4 20             	add    $0x20,%esp
80102206:	83 f8 10             	cmp    $0x10,%eax
80102209:	75 2a                	jne    80102235 <dirlink+0xa5>
  return 0;
8010220b:	31 c0                	xor    %eax,%eax
}
8010220d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102210:	5b                   	pop    %ebx
80102211:	5e                   	pop    %esi
80102212:	5f                   	pop    %edi
80102213:	5d                   	pop    %ebp
80102214:	c3                   	ret    
    iput(ip);
80102215:	83 ec 0c             	sub    $0xc,%esp
80102218:	50                   	push   %eax
80102219:	e8 02 f9 ff ff       	call   80101b20 <iput>
    return -1;
8010221e:	83 c4 10             	add    $0x10,%esp
80102221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102226:	eb e5                	jmp    8010220d <dirlink+0x7d>
      panic("dirlink read");
80102228:	83 ec 0c             	sub    $0xc,%esp
8010222b:	68 68 81 10 80       	push   $0x80108168
80102230:	e8 5b e1 ff ff       	call   80100390 <panic>
    panic("dirlink");
80102235:	83 ec 0c             	sub    $0xc,%esp
80102238:	68 fe 88 10 80       	push   $0x801088fe
8010223d:	e8 4e e1 ff ff       	call   80100390 <panic>
80102242:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102250 <namei>:

struct inode*
namei(char *path)
{
80102250:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102251:	31 d2                	xor    %edx,%edx
{
80102253:	89 e5                	mov    %esp,%ebp
80102255:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102258:	8b 45 08             	mov    0x8(%ebp),%eax
8010225b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010225e:	e8 6d fd ff ff       	call   80101fd0 <namex>
}
80102263:	c9                   	leave  
80102264:	c3                   	ret    
80102265:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102270 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102270:	55                   	push   %ebp
  return namex(path, 1, name);
80102271:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102276:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102278:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010227b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010227e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010227f:	e9 4c fd ff ff       	jmp    80101fd0 <namex>
80102284:	66 90                	xchg   %ax,%ax
80102286:	66 90                	xchg   %ax,%ax
80102288:	66 90                	xchg   %ax,%ax
8010228a:	66 90                	xchg   %ax,%ax
8010228c:	66 90                	xchg   %ax,%ax
8010228e:	66 90                	xchg   %ax,%ax

80102290 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	57                   	push   %edi
80102294:	56                   	push   %esi
80102295:	53                   	push   %ebx
80102296:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102299:	85 c0                	test   %eax,%eax
8010229b:	0f 84 b4 00 00 00    	je     80102355 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801022a1:	8b 58 08             	mov    0x8(%eax),%ebx
801022a4:	89 c6                	mov    %eax,%esi
801022a6:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
801022ac:	0f 87 96 00 00 00    	ja     80102348 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022b2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801022b7:	89 f6                	mov    %esi,%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801022c0:	89 ca                	mov    %ecx,%edx
801022c2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022c3:	83 e0 c0             	and    $0xffffffc0,%eax
801022c6:	3c 40                	cmp    $0x40,%al
801022c8:	75 f6                	jne    801022c0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022ca:	31 ff                	xor    %edi,%edi
801022cc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801022d1:	89 f8                	mov    %edi,%eax
801022d3:	ee                   	out    %al,(%dx)
801022d4:	b8 01 00 00 00       	mov    $0x1,%eax
801022d9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801022de:	ee                   	out    %al,(%dx)
801022df:	ba f3 01 00 00       	mov    $0x1f3,%edx
801022e4:	89 d8                	mov    %ebx,%eax
801022e6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801022e7:	89 d8                	mov    %ebx,%eax
801022e9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801022ee:	c1 f8 08             	sar    $0x8,%eax
801022f1:	ee                   	out    %al,(%dx)
801022f2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801022f7:	89 f8                	mov    %edi,%eax
801022f9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801022fa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
801022fe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102303:	c1 e0 04             	shl    $0x4,%eax
80102306:	83 e0 10             	and    $0x10,%eax
80102309:	83 c8 e0             	or     $0xffffffe0,%eax
8010230c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010230d:	f6 06 04             	testb  $0x4,(%esi)
80102310:	75 16                	jne    80102328 <idestart+0x98>
80102312:	b8 20 00 00 00       	mov    $0x20,%eax
80102317:	89 ca                	mov    %ecx,%edx
80102319:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010231a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010231d:	5b                   	pop    %ebx
8010231e:	5e                   	pop    %esi
8010231f:	5f                   	pop    %edi
80102320:	5d                   	pop    %ebp
80102321:	c3                   	ret    
80102322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102328:	b8 30 00 00 00       	mov    $0x30,%eax
8010232d:	89 ca                	mov    %ecx,%edx
8010232f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102330:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102335:	83 c6 5c             	add    $0x5c,%esi
80102338:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010233d:	fc                   	cld    
8010233e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102340:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102343:	5b                   	pop    %ebx
80102344:	5e                   	pop    %esi
80102345:	5f                   	pop    %edi
80102346:	5d                   	pop    %ebp
80102347:	c3                   	ret    
    panic("incorrect blockno");
80102348:	83 ec 0c             	sub    $0xc,%esp
8010234b:	68 d4 81 10 80       	push   $0x801081d4
80102350:	e8 3b e0 ff ff       	call   80100390 <panic>
    panic("idestart");
80102355:	83 ec 0c             	sub    $0xc,%esp
80102358:	68 cb 81 10 80       	push   $0x801081cb
8010235d:	e8 2e e0 ff ff       	call   80100390 <panic>
80102362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102370 <ideinit>:
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102376:	68 e6 81 10 80       	push   $0x801081e6
8010237b:	68 c0 b5 10 80       	push   $0x8010b5c0
80102380:	e8 8b 2c 00 00       	call   80105010 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102385:	58                   	pop    %eax
80102386:	a1 00 40 11 80       	mov    0x80114000,%eax
8010238b:	5a                   	pop    %edx
8010238c:	83 e8 01             	sub    $0x1,%eax
8010238f:	50                   	push   %eax
80102390:	6a 0e                	push   $0xe
80102392:	e8 a9 02 00 00       	call   80102640 <ioapicenable>
80102397:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010239a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010239f:	90                   	nop
801023a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023a1:	83 e0 c0             	and    $0xffffffc0,%eax
801023a4:	3c 40                	cmp    $0x40,%al
801023a6:	75 f8                	jne    801023a0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023a8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801023ad:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023b2:	ee                   	out    %al,(%dx)
801023b3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023b8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023bd:	eb 06                	jmp    801023c5 <ideinit+0x55>
801023bf:	90                   	nop
  for(i=0; i<1000; i++){
801023c0:	83 e9 01             	sub    $0x1,%ecx
801023c3:	74 0f                	je     801023d4 <ideinit+0x64>
801023c5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801023c6:	84 c0                	test   %al,%al
801023c8:	74 f6                	je     801023c0 <ideinit+0x50>
      havedisk1 = 1;
801023ca:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801023d1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023d4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801023d9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023de:	ee                   	out    %al,(%dx)
}
801023df:	c9                   	leave  
801023e0:	c3                   	ret    
801023e1:	eb 0d                	jmp    801023f0 <ideintr>
801023e3:	90                   	nop
801023e4:	90                   	nop
801023e5:	90                   	nop
801023e6:	90                   	nop
801023e7:	90                   	nop
801023e8:	90                   	nop
801023e9:	90                   	nop
801023ea:	90                   	nop
801023eb:	90                   	nop
801023ec:	90                   	nop
801023ed:	90                   	nop
801023ee:	90                   	nop
801023ef:	90                   	nop

801023f0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	57                   	push   %edi
801023f4:	56                   	push   %esi
801023f5:	53                   	push   %ebx
801023f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801023f9:	68 c0 b5 10 80       	push   $0x8010b5c0
801023fe:	e8 4d 2d 00 00       	call   80105150 <acquire>

  if((b = idequeue) == 0){
80102403:	8b 1d a4 b5 10 80    	mov    0x8010b5a4,%ebx
80102409:	83 c4 10             	add    $0x10,%esp
8010240c:	85 db                	test   %ebx,%ebx
8010240e:	74 67                	je     80102477 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102410:	8b 43 58             	mov    0x58(%ebx),%eax
80102413:	a3 a4 b5 10 80       	mov    %eax,0x8010b5a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102418:	8b 3b                	mov    (%ebx),%edi
8010241a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102420:	75 31                	jne    80102453 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102422:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102427:	89 f6                	mov    %esi,%esi
80102429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102430:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102431:	89 c6                	mov    %eax,%esi
80102433:	83 e6 c0             	and    $0xffffffc0,%esi
80102436:	89 f1                	mov    %esi,%ecx
80102438:	80 f9 40             	cmp    $0x40,%cl
8010243b:	75 f3                	jne    80102430 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010243d:	a8 21                	test   $0x21,%al
8010243f:	75 12                	jne    80102453 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102441:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102444:	b9 80 00 00 00       	mov    $0x80,%ecx
80102449:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010244e:	fc                   	cld    
8010244f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102451:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102453:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102456:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102459:	89 f9                	mov    %edi,%ecx
8010245b:	83 c9 02             	or     $0x2,%ecx
8010245e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102460:	53                   	push   %ebx
80102461:	e8 7a 1e 00 00       	call   801042e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102466:	a1 a4 b5 10 80       	mov    0x8010b5a4,%eax
8010246b:	83 c4 10             	add    $0x10,%esp
8010246e:	85 c0                	test   %eax,%eax
80102470:	74 05                	je     80102477 <ideintr+0x87>
    idestart(idequeue);
80102472:	e8 19 fe ff ff       	call   80102290 <idestart>
    release(&idelock);
80102477:	83 ec 0c             	sub    $0xc,%esp
8010247a:	68 c0 b5 10 80       	push   $0x8010b5c0
8010247f:	e8 8c 2d 00 00       	call   80105210 <release>

  release(&idelock);
}
80102484:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102487:	5b                   	pop    %ebx
80102488:	5e                   	pop    %esi
80102489:	5f                   	pop    %edi
8010248a:	5d                   	pop    %ebp
8010248b:	c3                   	ret    
8010248c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102490 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	53                   	push   %ebx
80102494:	83 ec 10             	sub    $0x10,%esp
80102497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010249a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010249d:	50                   	push   %eax
8010249e:	e8 1d 2b 00 00       	call   80104fc0 <holdingsleep>
801024a3:	83 c4 10             	add    $0x10,%esp
801024a6:	85 c0                	test   %eax,%eax
801024a8:	0f 84 c6 00 00 00    	je     80102574 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801024ae:	8b 03                	mov    (%ebx),%eax
801024b0:	83 e0 06             	and    $0x6,%eax
801024b3:	83 f8 02             	cmp    $0x2,%eax
801024b6:	0f 84 ab 00 00 00    	je     80102567 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801024bc:	8b 53 04             	mov    0x4(%ebx),%edx
801024bf:	85 d2                	test   %edx,%edx
801024c1:	74 0d                	je     801024d0 <iderw+0x40>
801024c3:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
801024c8:	85 c0                	test   %eax,%eax
801024ca:	0f 84 b1 00 00 00    	je     80102581 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 c0 b5 10 80       	push   $0x8010b5c0
801024d8:	e8 73 2c 00 00       	call   80105150 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024dd:	8b 15 a4 b5 10 80    	mov    0x8010b5a4,%edx
801024e3:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801024e6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024ed:	85 d2                	test   %edx,%edx
801024ef:	75 09                	jne    801024fa <iderw+0x6a>
801024f1:	eb 6d                	jmp    80102560 <iderw+0xd0>
801024f3:	90                   	nop
801024f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024f8:	89 c2                	mov    %eax,%edx
801024fa:	8b 42 58             	mov    0x58(%edx),%eax
801024fd:	85 c0                	test   %eax,%eax
801024ff:	75 f7                	jne    801024f8 <iderw+0x68>
80102501:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102504:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102506:	39 1d a4 b5 10 80    	cmp    %ebx,0x8010b5a4
8010250c:	74 42                	je     80102550 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010250e:	8b 03                	mov    (%ebx),%eax
80102510:	83 e0 06             	and    $0x6,%eax
80102513:	83 f8 02             	cmp    $0x2,%eax
80102516:	74 23                	je     8010253b <iderw+0xab>
80102518:	90                   	nop
80102519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102520:	83 ec 08             	sub    $0x8,%esp
80102523:	68 c0 b5 10 80       	push   $0x8010b5c0
80102528:	53                   	push   %ebx
80102529:	e8 f2 1b 00 00       	call   80104120 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010252e:	8b 03                	mov    (%ebx),%eax
80102530:	83 c4 10             	add    $0x10,%esp
80102533:	83 e0 06             	and    $0x6,%eax
80102536:	83 f8 02             	cmp    $0x2,%eax
80102539:	75 e5                	jne    80102520 <iderw+0x90>
  }


  release(&idelock);
8010253b:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80102542:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102545:	c9                   	leave  
  release(&idelock);
80102546:	e9 c5 2c 00 00       	jmp    80105210 <release>
8010254b:	90                   	nop
8010254c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102550:	89 d8                	mov    %ebx,%eax
80102552:	e8 39 fd ff ff       	call   80102290 <idestart>
80102557:	eb b5                	jmp    8010250e <iderw+0x7e>
80102559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102560:	ba a4 b5 10 80       	mov    $0x8010b5a4,%edx
80102565:	eb 9d                	jmp    80102504 <iderw+0x74>
    panic("iderw: nothing to do");
80102567:	83 ec 0c             	sub    $0xc,%esp
8010256a:	68 00 82 10 80       	push   $0x80108200
8010256f:	e8 1c de ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102574:	83 ec 0c             	sub    $0xc,%esp
80102577:	68 ea 81 10 80       	push   $0x801081ea
8010257c:	e8 0f de ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102581:	83 ec 0c             	sub    $0xc,%esp
80102584:	68 15 82 10 80       	push   $0x80108215
80102589:	e8 02 de ff ff       	call   80100390 <panic>
8010258e:	66 90                	xchg   %ax,%ax

80102590 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102590:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102591:	c7 05 f4 38 11 80 00 	movl   $0xfec00000,0x801138f4
80102598:	00 c0 fe 
{
8010259b:	89 e5                	mov    %esp,%ebp
8010259d:	56                   	push   %esi
8010259e:	53                   	push   %ebx
  ioapic->reg = reg;
8010259f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801025a6:	00 00 00 
  return ioapic->data;
801025a9:	a1 f4 38 11 80       	mov    0x801138f4,%eax
801025ae:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
801025b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
801025b7:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801025bd:	0f b6 15 40 3a 11 80 	movzbl 0x80113a40,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801025c4:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801025c7:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801025ca:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801025cd:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801025d0:	39 c2                	cmp    %eax,%edx
801025d2:	74 16                	je     801025ea <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801025d4:	83 ec 0c             	sub    $0xc,%esp
801025d7:	68 34 82 10 80       	push   $0x80108234
801025dc:	e8 7f e0 ff ff       	call   80100660 <cprintf>
801025e1:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
801025e7:	83 c4 10             	add    $0x10,%esp
801025ea:	83 c3 21             	add    $0x21,%ebx
{
801025ed:	ba 10 00 00 00       	mov    $0x10,%edx
801025f2:	b8 20 00 00 00       	mov    $0x20,%eax
801025f7:	89 f6                	mov    %esi,%esi
801025f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102600:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102602:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102608:	89 c6                	mov    %eax,%esi
8010260a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102610:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102613:	89 71 10             	mov    %esi,0x10(%ecx)
80102616:	8d 72 01             	lea    0x1(%edx),%esi
80102619:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010261c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010261e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102620:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
80102626:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010262d:	75 d1                	jne    80102600 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010262f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102632:	5b                   	pop    %ebx
80102633:	5e                   	pop    %esi
80102634:	5d                   	pop    %ebp
80102635:	c3                   	ret    
80102636:	8d 76 00             	lea    0x0(%esi),%esi
80102639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102640 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102640:	55                   	push   %ebp
  ioapic->reg = reg;
80102641:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
{
80102647:	89 e5                	mov    %esp,%ebp
80102649:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010264c:	8d 50 20             	lea    0x20(%eax),%edx
8010264f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102653:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102655:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010265b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010265e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102661:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102664:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102666:	a1 f4 38 11 80       	mov    0x801138f4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010266b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010266e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102671:	5d                   	pop    %ebp
80102672:	c3                   	ret    
80102673:	66 90                	xchg   %ax,%ax
80102675:	66 90                	xchg   %ax,%ax
80102677:	66 90                	xchg   %ax,%ax
80102679:	66 90                	xchg   %ax,%ax
8010267b:	66 90                	xchg   %ax,%ax
8010267d:	66 90                	xchg   %ax,%ax
8010267f:	90                   	nop

80102680 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102680:	55                   	push   %ebp
80102681:	89 e5                	mov    %esp,%ebp
80102683:	53                   	push   %ebx
80102684:	83 ec 04             	sub    $0x4,%esp
80102687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;
  kmem.numFreePages = kmem.numFreePages + 1; // A new node is added to freelist 
8010268a:	83 05 3c 39 11 80 01 	addl   $0x1,0x8011393c
                                            //so increase the number of free pages
  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102691:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102697:	75 79                	jne    80102712 <kfree+0x92>
80102699:	81 fb 18 4e 12 80    	cmp    $0x80124e18,%ebx
8010269f:	72 71                	jb     80102712 <kfree+0x92>
801026a1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801026a7:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801026ac:	77 64                	ja     80102712 <kfree+0x92>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801026ae:	83 ec 04             	sub    $0x4,%esp
801026b1:	68 00 10 00 00       	push   $0x1000
801026b6:	6a 01                	push   $0x1
801026b8:	53                   	push   %ebx
801026b9:	e8 a2 2b 00 00       	call   80105260 <memset>

  if(kmem.use_lock)
801026be:	8b 15 34 39 11 80    	mov    0x80113934,%edx
801026c4:	83 c4 10             	add    $0x10,%esp
801026c7:	85 d2                	test   %edx,%edx
801026c9:	75 35                	jne    80102700 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801026cb:	a1 38 39 11 80       	mov    0x80113938,%eax
801026d0:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801026d2:	a1 34 39 11 80       	mov    0x80113934,%eax
  kmem.freelist = r;
801026d7:	89 1d 38 39 11 80    	mov    %ebx,0x80113938
  if(kmem.use_lock)
801026dd:	85 c0                	test   %eax,%eax
801026df:	75 0f                	jne    801026f0 <kfree+0x70>
    release(&kmem.lock);
}
801026e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026e4:	c9                   	leave  
801026e5:	c3                   	ret    
801026e6:	8d 76 00             	lea    0x0(%esi),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    release(&kmem.lock);
801026f0:	c7 45 08 00 39 11 80 	movl   $0x80113900,0x8(%ebp)
}
801026f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026fa:	c9                   	leave  
    release(&kmem.lock);
801026fb:	e9 10 2b 00 00       	jmp    80105210 <release>
    acquire(&kmem.lock);
80102700:	83 ec 0c             	sub    $0xc,%esp
80102703:	68 00 39 11 80       	push   $0x80113900
80102708:	e8 43 2a 00 00       	call   80105150 <acquire>
8010270d:	83 c4 10             	add    $0x10,%esp
80102710:	eb b9                	jmp    801026cb <kfree+0x4b>
    panic("kfree");
80102712:	83 ec 0c             	sub    $0xc,%esp
80102715:	68 66 82 10 80       	push   $0x80108266
8010271a:	e8 71 dc ff ff       	call   80100390 <panic>
8010271f:	90                   	nop

80102720 <freerange>:
{
80102720:	55                   	push   %ebp
80102721:	89 e5                	mov    %esp,%ebp
80102723:	56                   	push   %esi
80102724:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102725:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102728:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010272b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102731:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102737:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010273d:	39 de                	cmp    %ebx,%esi
8010273f:	72 23                	jb     80102764 <freerange+0x44>
80102741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102748:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010274e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102751:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102757:	50                   	push   %eax
80102758:	e8 23 ff ff ff       	call   80102680 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010275d:	83 c4 10             	add    $0x10,%esp
80102760:	39 f3                	cmp    %esi,%ebx
80102762:	76 e4                	jbe    80102748 <freerange+0x28>
}
80102764:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102767:	5b                   	pop    %ebx
80102768:	5e                   	pop    %esi
80102769:	5d                   	pop    %ebp
8010276a:	c3                   	ret    
8010276b:	90                   	nop
8010276c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102770 <kinit1>:
{
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
80102773:	56                   	push   %esi
80102774:	53                   	push   %ebx
80102775:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102778:	83 ec 08             	sub    $0x8,%esp
8010277b:	68 6c 82 10 80       	push   $0x8010826c
80102780:	68 00 39 11 80       	push   $0x80113900
80102785:	e8 86 28 00 00       	call   80105010 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010278a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010278d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102790:	c7 05 34 39 11 80 00 	movl   $0x0,0x80113934
80102797:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010279a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027a0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027a6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027ac:	39 de                	cmp    %ebx,%esi
801027ae:	72 1c                	jb     801027cc <kinit1+0x5c>
    kfree(p);
801027b0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801027b6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027b9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027bf:	50                   	push   %eax
801027c0:	e8 bb fe ff ff       	call   80102680 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027c5:	83 c4 10             	add    $0x10,%esp
801027c8:	39 de                	cmp    %ebx,%esi
801027ca:	73 e4                	jae    801027b0 <kinit1+0x40>
  kmem.numFreePages = 0;
801027cc:	c7 05 3c 39 11 80 00 	movl   $0x0,0x8011393c
801027d3:	00 00 00 
}
801027d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027d9:	5b                   	pop    %ebx
801027da:	5e                   	pop    %esi
801027db:	5d                   	pop    %ebp
801027dc:	c3                   	ret    
801027dd:	8d 76 00             	lea    0x0(%esi),%esi

801027e0 <kinit2>:
{
801027e0:	55                   	push   %ebp
801027e1:	89 e5                	mov    %esp,%ebp
801027e3:	56                   	push   %esi
801027e4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801027e5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801027e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801027eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027fd:	39 de                	cmp    %ebx,%esi
801027ff:	72 23                	jb     80102824 <kinit2+0x44>
80102801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102808:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010280e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102811:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102817:	50                   	push   %eax
80102818:	e8 63 fe ff ff       	call   80102680 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010281d:	83 c4 10             	add    $0x10,%esp
80102820:	39 de                	cmp    %ebx,%esi
80102822:	73 e4                	jae    80102808 <kinit2+0x28>
  kmem.use_lock = 1;
80102824:	c7 05 34 39 11 80 01 	movl   $0x1,0x80113934
8010282b:	00 00 00 
}
8010282e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102831:	5b                   	pop    %ebx
80102832:	5e                   	pop    %esi
80102833:	5d                   	pop    %ebp
80102834:	c3                   	ret    
80102835:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102840 <kalloc>:
kalloc(void)
{
  struct run *r;
  kmem.numFreePages = kmem.numFreePages - 1 ; // A node is popped out from the freelist
                                              //so decrease the number of free pages.
  if(kmem.use_lock)
80102840:	a1 34 39 11 80       	mov    0x80113934,%eax
  kmem.numFreePages = kmem.numFreePages - 1 ; // A node is popped out from the freelist
80102845:	83 2d 3c 39 11 80 01 	subl   $0x1,0x8011393c
  if(kmem.use_lock)
8010284c:	85 c0                	test   %eax,%eax
8010284e:	75 20                	jne    80102870 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102850:	a1 38 39 11 80       	mov    0x80113938,%eax
  if(r)
80102855:	85 c0                	test   %eax,%eax
80102857:	74 0f                	je     80102868 <kalloc+0x28>
    kmem.freelist = r->next;
80102859:	8b 10                	mov    (%eax),%edx
8010285b:	89 15 38 39 11 80    	mov    %edx,0x80113938
80102861:	c3                   	ret    
80102862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102868:	f3 c3                	repz ret 
8010286a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
80102873:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102876:	68 00 39 11 80       	push   $0x80113900
8010287b:	e8 d0 28 00 00       	call   80105150 <acquire>
  r = kmem.freelist;
80102880:	a1 38 39 11 80       	mov    0x80113938,%eax
  if(r)
80102885:	83 c4 10             	add    $0x10,%esp
80102888:	8b 15 34 39 11 80    	mov    0x80113934,%edx
8010288e:	85 c0                	test   %eax,%eax
80102890:	74 08                	je     8010289a <kalloc+0x5a>
    kmem.freelist = r->next;
80102892:	8b 08                	mov    (%eax),%ecx
80102894:	89 0d 38 39 11 80    	mov    %ecx,0x80113938
  if(kmem.use_lock)
8010289a:	85 d2                	test   %edx,%edx
8010289c:	74 16                	je     801028b4 <kalloc+0x74>
    release(&kmem.lock);
8010289e:	83 ec 0c             	sub    $0xc,%esp
801028a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028a4:	68 00 39 11 80       	push   $0x80113900
801028a9:	e8 62 29 00 00       	call   80105210 <release>
  return (char*)r;
801028ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801028b1:	83 c4 10             	add    $0x10,%esp
}
801028b4:	c9                   	leave  
801028b5:	c3                   	ret    
801028b6:	8d 76 00             	lea    0x0(%esi),%esi
801028b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028c0 <getNumFreePages>:

// Returns the number of free pages.
int
getNumFreePages(void)
{
if(kmem.use_lock)
801028c0:	8b 0d 34 39 11 80    	mov    0x80113934,%ecx
acquire(&kmem.lock);
int r = kmem.numFreePages;
801028c6:	a1 3c 39 11 80       	mov    0x8011393c,%eax
if(kmem.use_lock)
801028cb:	85 c9                	test   %ecx,%ecx
801028cd:	75 09                	jne    801028d8 <getNumFreePages+0x18>
if(kmem.use_lock)
release(&kmem.lock);
return (r);
801028cf:	f3 c3                	repz ret 
801028d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801028d8:	55                   	push   %ebp
801028d9:	89 e5                	mov    %esp,%ebp
801028db:	83 ec 24             	sub    $0x24,%esp
acquire(&kmem.lock);
801028de:	68 00 39 11 80       	push   $0x80113900
801028e3:	e8 68 28 00 00       	call   80105150 <acquire>
if(kmem.use_lock)
801028e8:	8b 15 34 39 11 80    	mov    0x80113934,%edx
801028ee:	83 c4 10             	add    $0x10,%esp
int r = kmem.numFreePages;
801028f1:	a1 3c 39 11 80       	mov    0x8011393c,%eax
if(kmem.use_lock)
801028f6:	85 d2                	test   %edx,%edx
801028f8:	74 16                	je     80102910 <getNumFreePages+0x50>
release(&kmem.lock);
801028fa:	83 ec 0c             	sub    $0xc,%esp
801028fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102900:	68 00 39 11 80       	push   $0x80113900
80102905:	e8 06 29 00 00       	call   80105210 <release>
8010290a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010290d:	83 c4 10             	add    $0x10,%esp
80102910:	c9                   	leave  
80102911:	c3                   	ret    
80102912:	66 90                	xchg   %ax,%ax
80102914:	66 90                	xchg   %ax,%ax
80102916:	66 90                	xchg   %ax,%ax
80102918:	66 90                	xchg   %ax,%ax
8010291a:	66 90                	xchg   %ax,%ax
8010291c:	66 90                	xchg   %ax,%ax
8010291e:	66 90                	xchg   %ax,%ax

80102920 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102920:	ba 64 00 00 00       	mov    $0x64,%edx
80102925:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102926:	a8 01                	test   $0x1,%al
80102928:	0f 84 c2 00 00 00    	je     801029f0 <kbdgetc+0xd0>
8010292e:	ba 60 00 00 00       	mov    $0x60,%edx
80102933:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102934:	0f b6 d0             	movzbl %al,%edx
80102937:	8b 0d f4 b5 10 80    	mov    0x8010b5f4,%ecx

  if(data == 0xE0){
8010293d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102943:	0f 84 7f 00 00 00    	je     801029c8 <kbdgetc+0xa8>
{
80102949:	55                   	push   %ebp
8010294a:	89 e5                	mov    %esp,%ebp
8010294c:	53                   	push   %ebx
8010294d:	89 cb                	mov    %ecx,%ebx
8010294f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102952:	84 c0                	test   %al,%al
80102954:	78 4a                	js     801029a0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102956:	85 db                	test   %ebx,%ebx
80102958:	74 09                	je     80102963 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010295a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010295d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102960:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102963:	0f b6 82 a0 83 10 80 	movzbl -0x7fef7c60(%edx),%eax
8010296a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010296c:	0f b6 82 a0 82 10 80 	movzbl -0x7fef7d60(%edx),%eax
80102973:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102975:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102977:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
  c = charcode[shift & (CTL | SHIFT)][data];
8010297d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102980:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102983:	8b 04 85 80 82 10 80 	mov    -0x7fef7d80(,%eax,4),%eax
8010298a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010298e:	74 31                	je     801029c1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102990:	8d 50 9f             	lea    -0x61(%eax),%edx
80102993:	83 fa 19             	cmp    $0x19,%edx
80102996:	77 40                	ja     801029d8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102998:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010299b:	5b                   	pop    %ebx
8010299c:	5d                   	pop    %ebp
8010299d:	c3                   	ret    
8010299e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801029a0:	83 e0 7f             	and    $0x7f,%eax
801029a3:	85 db                	test   %ebx,%ebx
801029a5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801029a8:	0f b6 82 a0 83 10 80 	movzbl -0x7fef7c60(%edx),%eax
801029af:	83 c8 40             	or     $0x40,%eax
801029b2:	0f b6 c0             	movzbl %al,%eax
801029b5:	f7 d0                	not    %eax
801029b7:	21 c1                	and    %eax,%ecx
    return 0;
801029b9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801029bb:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
}
801029c1:	5b                   	pop    %ebx
801029c2:	5d                   	pop    %ebp
801029c3:	c3                   	ret    
801029c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801029c8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801029cb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801029cd:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
    return 0;
801029d3:	c3                   	ret    
801029d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801029d8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801029db:	8d 50 20             	lea    0x20(%eax),%edx
}
801029de:	5b                   	pop    %ebx
      c += 'a' - 'A';
801029df:	83 f9 1a             	cmp    $0x1a,%ecx
801029e2:	0f 42 c2             	cmovb  %edx,%eax
}
801029e5:	5d                   	pop    %ebp
801029e6:	c3                   	ret    
801029e7:	89 f6                	mov    %esi,%esi
801029e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801029f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801029f5:	c3                   	ret    
801029f6:	8d 76 00             	lea    0x0(%esi),%esi
801029f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a00 <kbdintr>:

void
kbdintr(void)
{
80102a00:	55                   	push   %ebp
80102a01:	89 e5                	mov    %esp,%ebp
80102a03:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102a06:	68 20 29 10 80       	push   $0x80102920
80102a0b:	e8 d0 e0 ff ff       	call   80100ae0 <consoleintr>
}
80102a10:	83 c4 10             	add    $0x10,%esp
80102a13:	c9                   	leave  
80102a14:	c3                   	ret    
80102a15:	66 90                	xchg   %ax,%ax
80102a17:	66 90                	xchg   %ax,%ax
80102a19:	66 90                	xchg   %ax,%ax
80102a1b:	66 90                	xchg   %ax,%ax
80102a1d:	66 90                	xchg   %ax,%ax
80102a1f:	90                   	nop

80102a20 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102a20:	a1 40 39 11 80       	mov    0x80113940,%eax
{
80102a25:	55                   	push   %ebp
80102a26:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102a28:	85 c0                	test   %eax,%eax
80102a2a:	0f 84 c8 00 00 00    	je     80102af8 <lapicinit+0xd8>
  lapic[index] = value;
80102a30:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102a37:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a3a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a3d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102a44:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a47:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a4a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102a51:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102a54:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a57:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102a5e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102a61:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a64:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102a6b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a6e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a71:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102a78:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a7b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102a7e:	8b 50 30             	mov    0x30(%eax),%edx
80102a81:	c1 ea 10             	shr    $0x10,%edx
80102a84:	80 fa 03             	cmp    $0x3,%dl
80102a87:	77 77                	ja     80102b00 <lapicinit+0xe0>
  lapic[index] = value;
80102a89:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102a90:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a93:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a96:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a9d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102aa0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aa3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102aaa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102aad:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ab0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ab7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102aba:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102abd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102ac4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ac7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aca:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102ad1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102ad4:	8b 50 20             	mov    0x20(%eax),%edx
80102ad7:	89 f6                	mov    %esi,%esi
80102ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102ae0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102ae6:	80 e6 10             	and    $0x10,%dh
80102ae9:	75 f5                	jne    80102ae0 <lapicinit+0xc0>
  lapic[index] = value;
80102aeb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102af2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102af5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102af8:	5d                   	pop    %ebp
80102af9:	c3                   	ret    
80102afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102b00:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102b07:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102b0a:	8b 50 20             	mov    0x20(%eax),%edx
80102b0d:	e9 77 ff ff ff       	jmp    80102a89 <lapicinit+0x69>
80102b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b20 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102b20:	8b 15 40 39 11 80    	mov    0x80113940,%edx
{
80102b26:	55                   	push   %ebp
80102b27:	31 c0                	xor    %eax,%eax
80102b29:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102b2b:	85 d2                	test   %edx,%edx
80102b2d:	74 06                	je     80102b35 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102b2f:	8b 42 20             	mov    0x20(%edx),%eax
80102b32:	c1 e8 18             	shr    $0x18,%eax
}
80102b35:	5d                   	pop    %ebp
80102b36:	c3                   	ret    
80102b37:	89 f6                	mov    %esi,%esi
80102b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b40 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102b40:	a1 40 39 11 80       	mov    0x80113940,%eax
{
80102b45:	55                   	push   %ebp
80102b46:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102b48:	85 c0                	test   %eax,%eax
80102b4a:	74 0d                	je     80102b59 <lapiceoi+0x19>
  lapic[index] = value;
80102b4c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102b53:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b56:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102b59:	5d                   	pop    %ebp
80102b5a:	c3                   	ret    
80102b5b:	90                   	nop
80102b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b60 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102b60:	55                   	push   %ebp
80102b61:	89 e5                	mov    %esp,%ebp
}
80102b63:	5d                   	pop    %ebp
80102b64:	c3                   	ret    
80102b65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b70 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102b70:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b71:	b8 0f 00 00 00       	mov    $0xf,%eax
80102b76:	ba 70 00 00 00       	mov    $0x70,%edx
80102b7b:	89 e5                	mov    %esp,%ebp
80102b7d:	53                   	push   %ebx
80102b7e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102b81:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b84:	ee                   	out    %al,(%dx)
80102b85:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b8a:	ba 71 00 00 00       	mov    $0x71,%edx
80102b8f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b90:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102b92:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102b95:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102b9b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b9d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102ba0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102ba3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102ba5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102ba8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102bae:	a1 40 39 11 80       	mov    0x80113940,%eax
80102bb3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bb9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bbc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102bc3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bc6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bc9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102bd0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bd3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bd6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bdc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bdf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102be5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102be8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bf1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bf7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102bfa:	5b                   	pop    %ebx
80102bfb:	5d                   	pop    %ebp
80102bfc:	c3                   	ret    
80102bfd:	8d 76 00             	lea    0x0(%esi),%esi

80102c00 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102c00:	55                   	push   %ebp
80102c01:	b8 0b 00 00 00       	mov    $0xb,%eax
80102c06:	ba 70 00 00 00       	mov    $0x70,%edx
80102c0b:	89 e5                	mov    %esp,%ebp
80102c0d:	57                   	push   %edi
80102c0e:	56                   	push   %esi
80102c0f:	53                   	push   %ebx
80102c10:	83 ec 4c             	sub    $0x4c,%esp
80102c13:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c14:	ba 71 00 00 00       	mov    $0x71,%edx
80102c19:	ec                   	in     (%dx),%al
80102c1a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c1d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102c22:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102c25:	8d 76 00             	lea    0x0(%esi),%esi
80102c28:	31 c0                	xor    %eax,%eax
80102c2a:	89 da                	mov    %ebx,%edx
80102c2c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c2d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102c32:	89 ca                	mov    %ecx,%edx
80102c34:	ec                   	in     (%dx),%al
80102c35:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c38:	89 da                	mov    %ebx,%edx
80102c3a:	b8 02 00 00 00       	mov    $0x2,%eax
80102c3f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c40:	89 ca                	mov    %ecx,%edx
80102c42:	ec                   	in     (%dx),%al
80102c43:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c46:	89 da                	mov    %ebx,%edx
80102c48:	b8 04 00 00 00       	mov    $0x4,%eax
80102c4d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c4e:	89 ca                	mov    %ecx,%edx
80102c50:	ec                   	in     (%dx),%al
80102c51:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c54:	89 da                	mov    %ebx,%edx
80102c56:	b8 07 00 00 00       	mov    $0x7,%eax
80102c5b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c5c:	89 ca                	mov    %ecx,%edx
80102c5e:	ec                   	in     (%dx),%al
80102c5f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c62:	89 da                	mov    %ebx,%edx
80102c64:	b8 08 00 00 00       	mov    $0x8,%eax
80102c69:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c6a:	89 ca                	mov    %ecx,%edx
80102c6c:	ec                   	in     (%dx),%al
80102c6d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c6f:	89 da                	mov    %ebx,%edx
80102c71:	b8 09 00 00 00       	mov    $0x9,%eax
80102c76:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c77:	89 ca                	mov    %ecx,%edx
80102c79:	ec                   	in     (%dx),%al
80102c7a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c7c:	89 da                	mov    %ebx,%edx
80102c7e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c83:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c84:	89 ca                	mov    %ecx,%edx
80102c86:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c87:	84 c0                	test   %al,%al
80102c89:	78 9d                	js     80102c28 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102c8b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102c8f:	89 fa                	mov    %edi,%edx
80102c91:	0f b6 fa             	movzbl %dl,%edi
80102c94:	89 f2                	mov    %esi,%edx
80102c96:	0f b6 f2             	movzbl %dl,%esi
80102c99:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c9c:	89 da                	mov    %ebx,%edx
80102c9e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102ca1:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102ca4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102ca8:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102cab:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102caf:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102cb2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102cb6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102cb9:	31 c0                	xor    %eax,%eax
80102cbb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cbc:	89 ca                	mov    %ecx,%edx
80102cbe:	ec                   	in     (%dx),%al
80102cbf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cc2:	89 da                	mov    %ebx,%edx
80102cc4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102cc7:	b8 02 00 00 00       	mov    $0x2,%eax
80102ccc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ccd:	89 ca                	mov    %ecx,%edx
80102ccf:	ec                   	in     (%dx),%al
80102cd0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cd3:	89 da                	mov    %ebx,%edx
80102cd5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102cd8:	b8 04 00 00 00       	mov    $0x4,%eax
80102cdd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cde:	89 ca                	mov    %ecx,%edx
80102ce0:	ec                   	in     (%dx),%al
80102ce1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ce4:	89 da                	mov    %ebx,%edx
80102ce6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ce9:	b8 07 00 00 00       	mov    $0x7,%eax
80102cee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cef:	89 ca                	mov    %ecx,%edx
80102cf1:	ec                   	in     (%dx),%al
80102cf2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cf5:	89 da                	mov    %ebx,%edx
80102cf7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102cfa:	b8 08 00 00 00       	mov    $0x8,%eax
80102cff:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d00:	89 ca                	mov    %ecx,%edx
80102d02:	ec                   	in     (%dx),%al
80102d03:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d06:	89 da                	mov    %ebx,%edx
80102d08:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102d0b:	b8 09 00 00 00       	mov    $0x9,%eax
80102d10:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d11:	89 ca                	mov    %ecx,%edx
80102d13:	ec                   	in     (%dx),%al
80102d14:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d17:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102d1a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d1d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102d20:	6a 18                	push   $0x18
80102d22:	50                   	push   %eax
80102d23:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102d26:	50                   	push   %eax
80102d27:	e8 84 25 00 00       	call   801052b0 <memcmp>
80102d2c:	83 c4 10             	add    $0x10,%esp
80102d2f:	85 c0                	test   %eax,%eax
80102d31:	0f 85 f1 fe ff ff    	jne    80102c28 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102d37:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102d3b:	75 78                	jne    80102db5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102d3d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d40:	89 c2                	mov    %eax,%edx
80102d42:	83 e0 0f             	and    $0xf,%eax
80102d45:	c1 ea 04             	shr    $0x4,%edx
80102d48:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d4b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d4e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102d51:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d54:	89 c2                	mov    %eax,%edx
80102d56:	83 e0 0f             	and    $0xf,%eax
80102d59:	c1 ea 04             	shr    $0x4,%edx
80102d5c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d5f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d62:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102d65:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d68:	89 c2                	mov    %eax,%edx
80102d6a:	83 e0 0f             	and    $0xf,%eax
80102d6d:	c1 ea 04             	shr    $0x4,%edx
80102d70:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d73:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d76:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102d79:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d7c:	89 c2                	mov    %eax,%edx
80102d7e:	83 e0 0f             	and    $0xf,%eax
80102d81:	c1 ea 04             	shr    $0x4,%edx
80102d84:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d87:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d8a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102d8d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d90:	89 c2                	mov    %eax,%edx
80102d92:	83 e0 0f             	and    $0xf,%eax
80102d95:	c1 ea 04             	shr    $0x4,%edx
80102d98:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d9b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d9e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102da1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102da4:	89 c2                	mov    %eax,%edx
80102da6:	83 e0 0f             	and    $0xf,%eax
80102da9:	c1 ea 04             	shr    $0x4,%edx
80102dac:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102daf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102db2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102db5:	8b 75 08             	mov    0x8(%ebp),%esi
80102db8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102dbb:	89 06                	mov    %eax,(%esi)
80102dbd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102dc0:	89 46 04             	mov    %eax,0x4(%esi)
80102dc3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102dc6:	89 46 08             	mov    %eax,0x8(%esi)
80102dc9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102dcc:	89 46 0c             	mov    %eax,0xc(%esi)
80102dcf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102dd2:	89 46 10             	mov    %eax,0x10(%esi)
80102dd5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102dd8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102ddb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102de2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102de5:	5b                   	pop    %ebx
80102de6:	5e                   	pop    %esi
80102de7:	5f                   	pop    %edi
80102de8:	5d                   	pop    %ebp
80102de9:	c3                   	ret    
80102dea:	66 90                	xchg   %ax,%ax
80102dec:	66 90                	xchg   %ax,%ax
80102dee:	66 90                	xchg   %ax,%ax

80102df0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102df0:	8b 0d a8 39 11 80    	mov    0x801139a8,%ecx
80102df6:	85 c9                	test   %ecx,%ecx
80102df8:	0f 8e 8a 00 00 00    	jle    80102e88 <install_trans+0x98>
{
80102dfe:	55                   	push   %ebp
80102dff:	89 e5                	mov    %esp,%ebp
80102e01:	57                   	push   %edi
80102e02:	56                   	push   %esi
80102e03:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102e04:	31 db                	xor    %ebx,%ebx
{
80102e06:	83 ec 0c             	sub    $0xc,%esp
80102e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102e10:	a1 94 39 11 80       	mov    0x80113994,%eax
80102e15:	83 ec 08             	sub    $0x8,%esp
80102e18:	01 d8                	add    %ebx,%eax
80102e1a:	83 c0 01             	add    $0x1,%eax
80102e1d:	50                   	push   %eax
80102e1e:	ff 35 a4 39 11 80    	pushl  0x801139a4
80102e24:	e8 a7 d2 ff ff       	call   801000d0 <bread>
80102e29:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e2b:	58                   	pop    %eax
80102e2c:	5a                   	pop    %edx
80102e2d:	ff 34 9d ac 39 11 80 	pushl  -0x7feec654(,%ebx,4)
80102e34:	ff 35 a4 39 11 80    	pushl  0x801139a4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e3a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e3d:	e8 8e d2 ff ff       	call   801000d0 <bread>
80102e42:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e44:	8d 47 5c             	lea    0x5c(%edi),%eax
80102e47:	83 c4 0c             	add    $0xc,%esp
80102e4a:	68 00 02 00 00       	push   $0x200
80102e4f:	50                   	push   %eax
80102e50:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e53:	50                   	push   %eax
80102e54:	e8 b7 24 00 00       	call   80105310 <memmove>
    bwrite(dbuf);  // write dst to disk
80102e59:	89 34 24             	mov    %esi,(%esp)
80102e5c:	e8 3f d3 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102e61:	89 3c 24             	mov    %edi,(%esp)
80102e64:	e8 77 d3 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102e69:	89 34 24             	mov    %esi,(%esp)
80102e6c:	e8 6f d3 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e71:	83 c4 10             	add    $0x10,%esp
80102e74:	39 1d a8 39 11 80    	cmp    %ebx,0x801139a8
80102e7a:	7f 94                	jg     80102e10 <install_trans+0x20>
  }
}
80102e7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e7f:	5b                   	pop    %ebx
80102e80:	5e                   	pop    %esi
80102e81:	5f                   	pop    %edi
80102e82:	5d                   	pop    %ebp
80102e83:	c3                   	ret    
80102e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e88:	f3 c3                	repz ret 
80102e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102e90 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	56                   	push   %esi
80102e94:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102e95:	83 ec 08             	sub    $0x8,%esp
80102e98:	ff 35 94 39 11 80    	pushl  0x80113994
80102e9e:	ff 35 a4 39 11 80    	pushl  0x801139a4
80102ea4:	e8 27 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ea9:	8b 1d a8 39 11 80    	mov    0x801139a8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102eaf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102eb2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102eb4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102eb6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102eb9:	7e 16                	jle    80102ed1 <write_head+0x41>
80102ebb:	c1 e3 02             	shl    $0x2,%ebx
80102ebe:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ec0:	8b 8a ac 39 11 80    	mov    -0x7feec654(%edx),%ecx
80102ec6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102eca:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102ecd:	39 da                	cmp    %ebx,%edx
80102ecf:	75 ef                	jne    80102ec0 <write_head+0x30>
  }
  bwrite(buf);
80102ed1:	83 ec 0c             	sub    $0xc,%esp
80102ed4:	56                   	push   %esi
80102ed5:	e8 c6 d2 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102eda:	89 34 24             	mov    %esi,(%esp)
80102edd:	e8 fe d2 ff ff       	call   801001e0 <brelse>
}
80102ee2:	83 c4 10             	add    $0x10,%esp
80102ee5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ee8:	5b                   	pop    %ebx
80102ee9:	5e                   	pop    %esi
80102eea:	5d                   	pop    %ebp
80102eeb:	c3                   	ret    
80102eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ef0 <initlog>:
{
80102ef0:	55                   	push   %ebp
80102ef1:	89 e5                	mov    %esp,%ebp
80102ef3:	53                   	push   %ebx
80102ef4:	83 ec 2c             	sub    $0x2c,%esp
80102ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102efa:	68 a0 84 10 80       	push   $0x801084a0
80102eff:	68 60 39 11 80       	push   $0x80113960
80102f04:	e8 07 21 00 00       	call   80105010 <initlock>
  readsb(dev, &sb);
80102f09:	58                   	pop    %eax
80102f0a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102f0d:	5a                   	pop    %edx
80102f0e:	50                   	push   %eax
80102f0f:	53                   	push   %ebx
80102f10:	e8 1b e8 ff ff       	call   80101730 <readsb>
  log.size = sb.nlog;
80102f15:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102f18:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102f1b:	59                   	pop    %ecx
  log.dev = dev;
80102f1c:	89 1d a4 39 11 80    	mov    %ebx,0x801139a4
  log.size = sb.nlog;
80102f22:	89 15 98 39 11 80    	mov    %edx,0x80113998
  log.start = sb.logstart;
80102f28:	a3 94 39 11 80       	mov    %eax,0x80113994
  struct buf *buf = bread(log.dev, log.start);
80102f2d:	5a                   	pop    %edx
80102f2e:	50                   	push   %eax
80102f2f:	53                   	push   %ebx
80102f30:	e8 9b d1 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102f35:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102f38:	83 c4 10             	add    $0x10,%esp
80102f3b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102f3d:	89 1d a8 39 11 80    	mov    %ebx,0x801139a8
  for (i = 0; i < log.lh.n; i++) {
80102f43:	7e 1c                	jle    80102f61 <initlog+0x71>
80102f45:	c1 e3 02             	shl    $0x2,%ebx
80102f48:	31 d2                	xor    %edx,%edx
80102f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102f50:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102f54:	83 c2 04             	add    $0x4,%edx
80102f57:	89 8a a8 39 11 80    	mov    %ecx,-0x7feec658(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102f5d:	39 d3                	cmp    %edx,%ebx
80102f5f:	75 ef                	jne    80102f50 <initlog+0x60>
  brelse(buf);
80102f61:	83 ec 0c             	sub    $0xc,%esp
80102f64:	50                   	push   %eax
80102f65:	e8 76 d2 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102f6a:	e8 81 fe ff ff       	call   80102df0 <install_trans>
  log.lh.n = 0;
80102f6f:	c7 05 a8 39 11 80 00 	movl   $0x0,0x801139a8
80102f76:	00 00 00 
  write_head(); // clear the log
80102f79:	e8 12 ff ff ff       	call   80102e90 <write_head>
}
80102f7e:	83 c4 10             	add    $0x10,%esp
80102f81:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f84:	c9                   	leave  
80102f85:	c3                   	ret    
80102f86:	8d 76 00             	lea    0x0(%esi),%esi
80102f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f90 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102f96:	68 60 39 11 80       	push   $0x80113960
80102f9b:	e8 b0 21 00 00       	call   80105150 <acquire>
80102fa0:	83 c4 10             	add    $0x10,%esp
80102fa3:	eb 18                	jmp    80102fbd <begin_op+0x2d>
80102fa5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102fa8:	83 ec 08             	sub    $0x8,%esp
80102fab:	68 60 39 11 80       	push   $0x80113960
80102fb0:	68 60 39 11 80       	push   $0x80113960
80102fb5:	e8 66 11 00 00       	call   80104120 <sleep>
80102fba:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102fbd:	a1 a0 39 11 80       	mov    0x801139a0,%eax
80102fc2:	85 c0                	test   %eax,%eax
80102fc4:	75 e2                	jne    80102fa8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102fc6:	a1 9c 39 11 80       	mov    0x8011399c,%eax
80102fcb:	8b 15 a8 39 11 80    	mov    0x801139a8,%edx
80102fd1:	83 c0 01             	add    $0x1,%eax
80102fd4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102fd7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102fda:	83 fa 1e             	cmp    $0x1e,%edx
80102fdd:	7f c9                	jg     80102fa8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102fdf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102fe2:	a3 9c 39 11 80       	mov    %eax,0x8011399c
      release(&log.lock);
80102fe7:	68 60 39 11 80       	push   $0x80113960
80102fec:	e8 1f 22 00 00       	call   80105210 <release>
      break;
    }
  }
}
80102ff1:	83 c4 10             	add    $0x10,%esp
80102ff4:	c9                   	leave  
80102ff5:	c3                   	ret    
80102ff6:	8d 76 00             	lea    0x0(%esi),%esi
80102ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103000 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	57                   	push   %edi
80103004:	56                   	push   %esi
80103005:	53                   	push   %ebx
80103006:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103009:	68 60 39 11 80       	push   $0x80113960
8010300e:	e8 3d 21 00 00       	call   80105150 <acquire>
  log.outstanding -= 1;
80103013:	a1 9c 39 11 80       	mov    0x8011399c,%eax
  if(log.committing)
80103018:	8b 35 a0 39 11 80    	mov    0x801139a0,%esi
8010301e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103021:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80103024:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80103026:	89 1d 9c 39 11 80    	mov    %ebx,0x8011399c
  if(log.committing)
8010302c:	0f 85 1a 01 00 00    	jne    8010314c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80103032:	85 db                	test   %ebx,%ebx
80103034:	0f 85 ee 00 00 00    	jne    80103128 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010303a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
8010303d:	c7 05 a0 39 11 80 01 	movl   $0x1,0x801139a0
80103044:	00 00 00 
  release(&log.lock);
80103047:	68 60 39 11 80       	push   $0x80113960
8010304c:	e8 bf 21 00 00       	call   80105210 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103051:	8b 0d a8 39 11 80    	mov    0x801139a8,%ecx
80103057:	83 c4 10             	add    $0x10,%esp
8010305a:	85 c9                	test   %ecx,%ecx
8010305c:	0f 8e 85 00 00 00    	jle    801030e7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103062:	a1 94 39 11 80       	mov    0x80113994,%eax
80103067:	83 ec 08             	sub    $0x8,%esp
8010306a:	01 d8                	add    %ebx,%eax
8010306c:	83 c0 01             	add    $0x1,%eax
8010306f:	50                   	push   %eax
80103070:	ff 35 a4 39 11 80    	pushl  0x801139a4
80103076:	e8 55 d0 ff ff       	call   801000d0 <bread>
8010307b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010307d:	58                   	pop    %eax
8010307e:	5a                   	pop    %edx
8010307f:	ff 34 9d ac 39 11 80 	pushl  -0x7feec654(,%ebx,4)
80103086:	ff 35 a4 39 11 80    	pushl  0x801139a4
  for (tail = 0; tail < log.lh.n; tail++) {
8010308c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010308f:	e8 3c d0 ff ff       	call   801000d0 <bread>
80103094:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103096:	8d 40 5c             	lea    0x5c(%eax),%eax
80103099:	83 c4 0c             	add    $0xc,%esp
8010309c:	68 00 02 00 00       	push   $0x200
801030a1:	50                   	push   %eax
801030a2:	8d 46 5c             	lea    0x5c(%esi),%eax
801030a5:	50                   	push   %eax
801030a6:	e8 65 22 00 00       	call   80105310 <memmove>
    bwrite(to);  // write the log
801030ab:	89 34 24             	mov    %esi,(%esp)
801030ae:	e8 ed d0 ff ff       	call   801001a0 <bwrite>
    brelse(from);
801030b3:	89 3c 24             	mov    %edi,(%esp)
801030b6:	e8 25 d1 ff ff       	call   801001e0 <brelse>
    brelse(to);
801030bb:	89 34 24             	mov    %esi,(%esp)
801030be:	e8 1d d1 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801030c3:	83 c4 10             	add    $0x10,%esp
801030c6:	3b 1d a8 39 11 80    	cmp    0x801139a8,%ebx
801030cc:	7c 94                	jl     80103062 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801030ce:	e8 bd fd ff ff       	call   80102e90 <write_head>
    install_trans(); // Now install writes to home locations
801030d3:	e8 18 fd ff ff       	call   80102df0 <install_trans>
    log.lh.n = 0;
801030d8:	c7 05 a8 39 11 80 00 	movl   $0x0,0x801139a8
801030df:	00 00 00 
    write_head();    // Erase the transaction from the log
801030e2:	e8 a9 fd ff ff       	call   80102e90 <write_head>
    acquire(&log.lock);
801030e7:	83 ec 0c             	sub    $0xc,%esp
801030ea:	68 60 39 11 80       	push   $0x80113960
801030ef:	e8 5c 20 00 00       	call   80105150 <acquire>
    wakeup(&log);
801030f4:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
    log.committing = 0;
801030fb:	c7 05 a0 39 11 80 00 	movl   $0x0,0x801139a0
80103102:	00 00 00 
    wakeup(&log);
80103105:	e8 d6 11 00 00       	call   801042e0 <wakeup>
    release(&log.lock);
8010310a:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
80103111:	e8 fa 20 00 00       	call   80105210 <release>
80103116:	83 c4 10             	add    $0x10,%esp
}
80103119:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010311c:	5b                   	pop    %ebx
8010311d:	5e                   	pop    %esi
8010311e:	5f                   	pop    %edi
8010311f:	5d                   	pop    %ebp
80103120:	c3                   	ret    
80103121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80103128:	83 ec 0c             	sub    $0xc,%esp
8010312b:	68 60 39 11 80       	push   $0x80113960
80103130:	e8 ab 11 00 00       	call   801042e0 <wakeup>
  release(&log.lock);
80103135:	c7 04 24 60 39 11 80 	movl   $0x80113960,(%esp)
8010313c:	e8 cf 20 00 00       	call   80105210 <release>
80103141:	83 c4 10             	add    $0x10,%esp
}
80103144:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103147:	5b                   	pop    %ebx
80103148:	5e                   	pop    %esi
80103149:	5f                   	pop    %edi
8010314a:	5d                   	pop    %ebp
8010314b:	c3                   	ret    
    panic("log.committing");
8010314c:	83 ec 0c             	sub    $0xc,%esp
8010314f:	68 a4 84 10 80       	push   $0x801084a4
80103154:	e8 37 d2 ff ff       	call   80100390 <panic>
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103160 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103160:	55                   	push   %ebp
80103161:	89 e5                	mov    %esp,%ebp
80103163:	53                   	push   %ebx
80103164:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103167:	8b 15 a8 39 11 80    	mov    0x801139a8,%edx
{
8010316d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103170:	83 fa 1d             	cmp    $0x1d,%edx
80103173:	0f 8f 9d 00 00 00    	jg     80103216 <log_write+0xb6>
80103179:	a1 98 39 11 80       	mov    0x80113998,%eax
8010317e:	83 e8 01             	sub    $0x1,%eax
80103181:	39 c2                	cmp    %eax,%edx
80103183:	0f 8d 8d 00 00 00    	jge    80103216 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103189:	a1 9c 39 11 80       	mov    0x8011399c,%eax
8010318e:	85 c0                	test   %eax,%eax
80103190:	0f 8e 8d 00 00 00    	jle    80103223 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103196:	83 ec 0c             	sub    $0xc,%esp
80103199:	68 60 39 11 80       	push   $0x80113960
8010319e:	e8 ad 1f 00 00       	call   80105150 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801031a3:	8b 0d a8 39 11 80    	mov    0x801139a8,%ecx
801031a9:	83 c4 10             	add    $0x10,%esp
801031ac:	83 f9 00             	cmp    $0x0,%ecx
801031af:	7e 57                	jle    80103208 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801031b1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
801031b4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801031b6:	3b 15 ac 39 11 80    	cmp    0x801139ac,%edx
801031bc:	75 0b                	jne    801031c9 <log_write+0x69>
801031be:	eb 38                	jmp    801031f8 <log_write+0x98>
801031c0:	39 14 85 ac 39 11 80 	cmp    %edx,-0x7feec654(,%eax,4)
801031c7:	74 2f                	je     801031f8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
801031c9:	83 c0 01             	add    $0x1,%eax
801031cc:	39 c1                	cmp    %eax,%ecx
801031ce:	75 f0                	jne    801031c0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801031d0:	89 14 85 ac 39 11 80 	mov    %edx,-0x7feec654(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801031d7:	83 c0 01             	add    $0x1,%eax
801031da:	a3 a8 39 11 80       	mov    %eax,0x801139a8
  b->flags |= B_DIRTY; // prevent eviction
801031df:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
801031e2:	c7 45 08 60 39 11 80 	movl   $0x80113960,0x8(%ebp)
}
801031e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031ec:	c9                   	leave  
  release(&log.lock);
801031ed:	e9 1e 20 00 00       	jmp    80105210 <release>
801031f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801031f8:	89 14 85 ac 39 11 80 	mov    %edx,-0x7feec654(,%eax,4)
801031ff:	eb de                	jmp    801031df <log_write+0x7f>
80103201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103208:	8b 43 08             	mov    0x8(%ebx),%eax
8010320b:	a3 ac 39 11 80       	mov    %eax,0x801139ac
  if (i == log.lh.n)
80103210:	75 cd                	jne    801031df <log_write+0x7f>
80103212:	31 c0                	xor    %eax,%eax
80103214:	eb c1                	jmp    801031d7 <log_write+0x77>
    panic("too big a transaction");
80103216:	83 ec 0c             	sub    $0xc,%esp
80103219:	68 b3 84 10 80       	push   $0x801084b3
8010321e:	e8 6d d1 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103223:	83 ec 0c             	sub    $0xc,%esp
80103226:	68 c9 84 10 80       	push   $0x801084c9
8010322b:	e8 60 d1 ff ff       	call   80100390 <panic>

80103230 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103230:	55                   	push   %ebp
80103231:	89 e5                	mov    %esp,%ebp
80103233:	53                   	push   %ebx
80103234:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103237:	e8 c4 09 00 00       	call   80103c00 <cpuid>
8010323c:	89 c3                	mov    %eax,%ebx
8010323e:	e8 bd 09 00 00       	call   80103c00 <cpuid>
80103243:	83 ec 04             	sub    $0x4,%esp
80103246:	53                   	push   %ebx
80103247:	50                   	push   %eax
80103248:	68 e4 84 10 80       	push   $0x801084e4
8010324d:	e8 0e d4 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103252:	e8 b9 33 00 00       	call   80106610 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103257:	e8 24 09 00 00       	call   80103b80 <mycpu>
8010325c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010325e:	b8 01 00 00 00       	mov    $0x1,%eax
80103263:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010326a:	e8 d1 1b 00 00       	call   80104e40 <scheduler>
8010326f:	90                   	nop

80103270 <mpenter>:
{
80103270:	55                   	push   %ebp
80103271:	89 e5                	mov    %esp,%ebp
80103273:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103276:	e8 d5 44 00 00       	call   80107750 <switchkvm>
  seginit();
8010327b:	e8 30 44 00 00       	call   801076b0 <seginit>
  lapicinit();
80103280:	e8 9b f7 ff ff       	call   80102a20 <lapicinit>
  mpmain();
80103285:	e8 a6 ff ff ff       	call   80103230 <mpmain>
8010328a:	66 90                	xchg   %ax,%ax
8010328c:	66 90                	xchg   %ax,%ax
8010328e:	66 90                	xchg   %ax,%ax

80103290 <main>:
{
80103290:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103294:	83 e4 f0             	and    $0xfffffff0,%esp
80103297:	ff 71 fc             	pushl  -0x4(%ecx)
8010329a:	55                   	push   %ebp
8010329b:	89 e5                	mov    %esp,%ebp
8010329d:	53                   	push   %ebx
8010329e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010329f:	83 ec 08             	sub    $0x8,%esp
801032a2:	68 00 00 40 80       	push   $0x80400000
801032a7:	68 18 4e 12 80       	push   $0x80124e18
801032ac:	e8 bf f4 ff ff       	call   80102770 <kinit1>
  kvmalloc();      // kernel page table
801032b1:	e8 6a 49 00 00       	call   80107c20 <kvmalloc>
  mpinit();        // detect other processors
801032b6:	e8 75 01 00 00       	call   80103430 <mpinit>
  lapicinit();     // interrupt controller
801032bb:	e8 60 f7 ff ff       	call   80102a20 <lapicinit>
  seginit();       // segment descriptors
801032c0:	e8 eb 43 00 00       	call   801076b0 <seginit>
  picinit();       // disable pic
801032c5:	e8 46 03 00 00       	call   80103610 <picinit>
  ioapicinit();    // another interrupt controller
801032ca:	e8 c1 f2 ff ff       	call   80102590 <ioapicinit>
  consoleinit();   // console hardware
801032cf:	e8 ec d9 ff ff       	call   80100cc0 <consoleinit>
  uartinit();      // serial port
801032d4:	e8 57 36 00 00       	call   80106930 <uartinit>
  pinit();         // process table
801032d9:	e8 82 08 00 00       	call   80103b60 <pinit>
  tvinit();        // trap vectors
801032de:	e8 ad 32 00 00       	call   80106590 <tvinit>
  binit();         // buffer cache
801032e3:	e8 58 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
801032e8:	e8 d3 dd ff ff       	call   801010c0 <fileinit>
  ideinit();       // disk 
801032ed:	e8 7e f0 ff ff       	call   80102370 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801032f2:	83 c4 0c             	add    $0xc,%esp
801032f5:	68 8a 00 00 00       	push   $0x8a
801032fa:	68 8c b4 10 80       	push   $0x8010b48c
801032ff:	68 00 70 00 80       	push   $0x80007000
80103304:	e8 07 20 00 00       	call   80105310 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103309:	69 05 00 40 11 80 b4 	imul   $0xb4,0x80114000,%eax
80103310:	00 00 00 
80103313:	83 c4 10             	add    $0x10,%esp
80103316:	05 60 3a 11 80       	add    $0x80113a60,%eax
8010331b:	3d 60 3a 11 80       	cmp    $0x80113a60,%eax
80103320:	76 71                	jbe    80103393 <main+0x103>
80103322:	bb 60 3a 11 80       	mov    $0x80113a60,%ebx
80103327:	89 f6                	mov    %esi,%esi
80103329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103330:	e8 4b 08 00 00       	call   80103b80 <mycpu>
80103335:	39 d8                	cmp    %ebx,%eax
80103337:	74 41                	je     8010337a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103339:	e8 02 f5 ff ff       	call   80102840 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010333e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103343:	c7 05 f8 6f 00 80 70 	movl   $0x80103270,0x80006ff8
8010334a:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010334d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103354:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103357:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010335c:	0f b6 03             	movzbl (%ebx),%eax
8010335f:	83 ec 08             	sub    $0x8,%esp
80103362:	68 00 70 00 00       	push   $0x7000
80103367:	50                   	push   %eax
80103368:	e8 03 f8 ff ff       	call   80102b70 <lapicstartap>
8010336d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103370:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103376:	85 c0                	test   %eax,%eax
80103378:	74 f6                	je     80103370 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010337a:	69 05 00 40 11 80 b4 	imul   $0xb4,0x80114000,%eax
80103381:	00 00 00 
80103384:	81 c3 b4 00 00 00    	add    $0xb4,%ebx
8010338a:	05 60 3a 11 80       	add    $0x80113a60,%eax
8010338f:	39 c3                	cmp    %eax,%ebx
80103391:	72 9d                	jb     80103330 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103393:	83 ec 08             	sub    $0x8,%esp
80103396:	68 00 00 00 8e       	push   $0x8e000000
8010339b:	68 00 00 40 80       	push   $0x80400000
801033a0:	e8 3b f4 ff ff       	call   801027e0 <kinit2>
  userinit();      // first user process
801033a5:	e8 a6 08 00 00       	call   80103c50 <userinit>
  mpmain();        // finish this processor's setup
801033aa:	e8 81 fe ff ff       	call   80103230 <mpmain>
801033af:	90                   	nop

801033b0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	57                   	push   %edi
801033b4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801033b5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801033bb:	53                   	push   %ebx
  e = addr+len;
801033bc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801033bf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801033c2:	39 de                	cmp    %ebx,%esi
801033c4:	72 10                	jb     801033d6 <mpsearch1+0x26>
801033c6:	eb 50                	jmp    80103418 <mpsearch1+0x68>
801033c8:	90                   	nop
801033c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033d0:	39 fb                	cmp    %edi,%ebx
801033d2:	89 fe                	mov    %edi,%esi
801033d4:	76 42                	jbe    80103418 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033d6:	83 ec 04             	sub    $0x4,%esp
801033d9:	8d 7e 10             	lea    0x10(%esi),%edi
801033dc:	6a 04                	push   $0x4
801033de:	68 f8 84 10 80       	push   $0x801084f8
801033e3:	56                   	push   %esi
801033e4:	e8 c7 1e 00 00       	call   801052b0 <memcmp>
801033e9:	83 c4 10             	add    $0x10,%esp
801033ec:	85 c0                	test   %eax,%eax
801033ee:	75 e0                	jne    801033d0 <mpsearch1+0x20>
801033f0:	89 f1                	mov    %esi,%ecx
801033f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801033f8:	0f b6 11             	movzbl (%ecx),%edx
801033fb:	83 c1 01             	add    $0x1,%ecx
801033fe:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103400:	39 f9                	cmp    %edi,%ecx
80103402:	75 f4                	jne    801033f8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103404:	84 c0                	test   %al,%al
80103406:	75 c8                	jne    801033d0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103408:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010340b:	89 f0                	mov    %esi,%eax
8010340d:	5b                   	pop    %ebx
8010340e:	5e                   	pop    %esi
8010340f:	5f                   	pop    %edi
80103410:	5d                   	pop    %ebp
80103411:	c3                   	ret    
80103412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103418:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010341b:	31 f6                	xor    %esi,%esi
}
8010341d:	89 f0                	mov    %esi,%eax
8010341f:	5b                   	pop    %ebx
80103420:	5e                   	pop    %esi
80103421:	5f                   	pop    %edi
80103422:	5d                   	pop    %ebp
80103423:	c3                   	ret    
80103424:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010342a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103430 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	57                   	push   %edi
80103434:	56                   	push   %esi
80103435:	53                   	push   %ebx
80103436:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103439:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103440:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103447:	c1 e0 08             	shl    $0x8,%eax
8010344a:	09 d0                	or     %edx,%eax
8010344c:	c1 e0 04             	shl    $0x4,%eax
8010344f:	85 c0                	test   %eax,%eax
80103451:	75 1b                	jne    8010346e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103453:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010345a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103461:	c1 e0 08             	shl    $0x8,%eax
80103464:	09 d0                	or     %edx,%eax
80103466:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103469:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010346e:	ba 00 04 00 00       	mov    $0x400,%edx
80103473:	e8 38 ff ff ff       	call   801033b0 <mpsearch1>
80103478:	85 c0                	test   %eax,%eax
8010347a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010347d:	0f 84 3d 01 00 00    	je     801035c0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103483:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103486:	8b 58 04             	mov    0x4(%eax),%ebx
80103489:	85 db                	test   %ebx,%ebx
8010348b:	0f 84 4f 01 00 00    	je     801035e0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103491:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103497:	83 ec 04             	sub    $0x4,%esp
8010349a:	6a 04                	push   $0x4
8010349c:	68 15 85 10 80       	push   $0x80108515
801034a1:	56                   	push   %esi
801034a2:	e8 09 1e 00 00       	call   801052b0 <memcmp>
801034a7:	83 c4 10             	add    $0x10,%esp
801034aa:	85 c0                	test   %eax,%eax
801034ac:	0f 85 2e 01 00 00    	jne    801035e0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801034b2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801034b9:	3c 01                	cmp    $0x1,%al
801034bb:	0f 95 c2             	setne  %dl
801034be:	3c 04                	cmp    $0x4,%al
801034c0:	0f 95 c0             	setne  %al
801034c3:	20 c2                	and    %al,%dl
801034c5:	0f 85 15 01 00 00    	jne    801035e0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801034cb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801034d2:	66 85 ff             	test   %di,%di
801034d5:	74 1a                	je     801034f1 <mpinit+0xc1>
801034d7:	89 f0                	mov    %esi,%eax
801034d9:	01 f7                	add    %esi,%edi
  sum = 0;
801034db:	31 d2                	xor    %edx,%edx
801034dd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801034e0:	0f b6 08             	movzbl (%eax),%ecx
801034e3:	83 c0 01             	add    $0x1,%eax
801034e6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801034e8:	39 c7                	cmp    %eax,%edi
801034ea:	75 f4                	jne    801034e0 <mpinit+0xb0>
801034ec:	84 d2                	test   %dl,%dl
801034ee:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801034f1:	85 f6                	test   %esi,%esi
801034f3:	0f 84 e7 00 00 00    	je     801035e0 <mpinit+0x1b0>
801034f9:	84 d2                	test   %dl,%dl
801034fb:	0f 85 df 00 00 00    	jne    801035e0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103501:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103507:	a3 40 39 11 80       	mov    %eax,0x80113940
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010350c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103513:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103519:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010351e:	01 d6                	add    %edx,%esi
80103520:	39 c6                	cmp    %eax,%esi
80103522:	76 23                	jbe    80103547 <mpinit+0x117>
    switch(*p){
80103524:	0f b6 10             	movzbl (%eax),%edx
80103527:	80 fa 04             	cmp    $0x4,%dl
8010352a:	0f 87 ca 00 00 00    	ja     801035fa <mpinit+0x1ca>
80103530:	ff 24 95 3c 85 10 80 	jmp    *-0x7fef7ac4(,%edx,4)
80103537:	89 f6                	mov    %esi,%esi
80103539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103540:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103543:	39 c6                	cmp    %eax,%esi
80103545:	77 dd                	ja     80103524 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103547:	85 db                	test   %ebx,%ebx
80103549:	0f 84 9e 00 00 00    	je     801035ed <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010354f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103552:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103556:	74 15                	je     8010356d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103558:	b8 70 00 00 00       	mov    $0x70,%eax
8010355d:	ba 22 00 00 00       	mov    $0x22,%edx
80103562:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103563:	ba 23 00 00 00       	mov    $0x23,%edx
80103568:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103569:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010356c:	ee                   	out    %al,(%dx)
  }
}
8010356d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103570:	5b                   	pop    %ebx
80103571:	5e                   	pop    %esi
80103572:	5f                   	pop    %edi
80103573:	5d                   	pop    %ebp
80103574:	c3                   	ret    
80103575:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103578:	8b 0d 00 40 11 80    	mov    0x80114000,%ecx
8010357e:	83 f9 07             	cmp    $0x7,%ecx
80103581:	7f 19                	jg     8010359c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103583:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103587:	69 f9 b4 00 00 00    	imul   $0xb4,%ecx,%edi
        ncpu++;
8010358d:	83 c1 01             	add    $0x1,%ecx
80103590:	89 0d 00 40 11 80    	mov    %ecx,0x80114000
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103596:	88 97 60 3a 11 80    	mov    %dl,-0x7feec5a0(%edi)
      p += sizeof(struct mpproc);
8010359c:	83 c0 14             	add    $0x14,%eax
      continue;
8010359f:	e9 7c ff ff ff       	jmp    80103520 <mpinit+0xf0>
801035a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801035a8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801035ac:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801035af:	88 15 40 3a 11 80    	mov    %dl,0x80113a40
      continue;
801035b5:	e9 66 ff ff ff       	jmp    80103520 <mpinit+0xf0>
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801035c0:	ba 00 00 01 00       	mov    $0x10000,%edx
801035c5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801035ca:	e8 e1 fd ff ff       	call   801033b0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035cf:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801035d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035d4:	0f 85 a9 fe ff ff    	jne    80103483 <mpinit+0x53>
801035da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801035e0:	83 ec 0c             	sub    $0xc,%esp
801035e3:	68 fd 84 10 80       	push   $0x801084fd
801035e8:	e8 a3 cd ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801035ed:	83 ec 0c             	sub    $0xc,%esp
801035f0:	68 1c 85 10 80       	push   $0x8010851c
801035f5:	e8 96 cd ff ff       	call   80100390 <panic>
      ismp = 0;
801035fa:	31 db                	xor    %ebx,%ebx
801035fc:	e9 26 ff ff ff       	jmp    80103527 <mpinit+0xf7>
80103601:	66 90                	xchg   %ax,%ax
80103603:	66 90                	xchg   %ax,%ax
80103605:	66 90                	xchg   %ax,%ax
80103607:	66 90                	xchg   %ax,%ax
80103609:	66 90                	xchg   %ax,%ax
8010360b:	66 90                	xchg   %ax,%ax
8010360d:	66 90                	xchg   %ax,%ax
8010360f:	90                   	nop

80103610 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103610:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103611:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103616:	ba 21 00 00 00       	mov    $0x21,%edx
8010361b:	89 e5                	mov    %esp,%ebp
8010361d:	ee                   	out    %al,(%dx)
8010361e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103623:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103624:	5d                   	pop    %ebp
80103625:	c3                   	ret    
80103626:	66 90                	xchg   %ax,%ax
80103628:	66 90                	xchg   %ax,%ax
8010362a:	66 90                	xchg   %ax,%ax
8010362c:	66 90                	xchg   %ax,%ax
8010362e:	66 90                	xchg   %ax,%ax

80103630 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	57                   	push   %edi
80103634:	56                   	push   %esi
80103635:	53                   	push   %ebx
80103636:	83 ec 0c             	sub    $0xc,%esp
80103639:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010363c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010363f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103645:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010364b:	e8 90 da ff ff       	call   801010e0 <filealloc>
80103650:	85 c0                	test   %eax,%eax
80103652:	89 03                	mov    %eax,(%ebx)
80103654:	74 22                	je     80103678 <pipealloc+0x48>
80103656:	e8 85 da ff ff       	call   801010e0 <filealloc>
8010365b:	85 c0                	test   %eax,%eax
8010365d:	89 06                	mov    %eax,(%esi)
8010365f:	74 3f                	je     801036a0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103661:	e8 da f1 ff ff       	call   80102840 <kalloc>
80103666:	85 c0                	test   %eax,%eax
80103668:	89 c7                	mov    %eax,%edi
8010366a:	75 54                	jne    801036c0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010366c:	8b 03                	mov    (%ebx),%eax
8010366e:	85 c0                	test   %eax,%eax
80103670:	75 34                	jne    801036a6 <pipealloc+0x76>
80103672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103678:	8b 06                	mov    (%esi),%eax
8010367a:	85 c0                	test   %eax,%eax
8010367c:	74 0c                	je     8010368a <pipealloc+0x5a>
    fileclose(*f1);
8010367e:	83 ec 0c             	sub    $0xc,%esp
80103681:	50                   	push   %eax
80103682:	e8 19 db ff ff       	call   801011a0 <fileclose>
80103687:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010368a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010368d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103692:	5b                   	pop    %ebx
80103693:	5e                   	pop    %esi
80103694:	5f                   	pop    %edi
80103695:	5d                   	pop    %ebp
80103696:	c3                   	ret    
80103697:	89 f6                	mov    %esi,%esi
80103699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801036a0:	8b 03                	mov    (%ebx),%eax
801036a2:	85 c0                	test   %eax,%eax
801036a4:	74 e4                	je     8010368a <pipealloc+0x5a>
    fileclose(*f0);
801036a6:	83 ec 0c             	sub    $0xc,%esp
801036a9:	50                   	push   %eax
801036aa:	e8 f1 da ff ff       	call   801011a0 <fileclose>
  if(*f1)
801036af:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801036b1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801036b4:	85 c0                	test   %eax,%eax
801036b6:	75 c6                	jne    8010367e <pipealloc+0x4e>
801036b8:	eb d0                	jmp    8010368a <pipealloc+0x5a>
801036ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801036c0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801036c3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801036ca:	00 00 00 
  p->writeopen = 1;
801036cd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801036d4:	00 00 00 
  p->nwrite = 0;
801036d7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801036de:	00 00 00 
  p->nread = 0;
801036e1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801036e8:	00 00 00 
  initlock(&p->lock, "pipe");
801036eb:	68 50 85 10 80       	push   $0x80108550
801036f0:	50                   	push   %eax
801036f1:	e8 1a 19 00 00       	call   80105010 <initlock>
  (*f0)->type = FD_PIPE;
801036f6:	8b 03                	mov    (%ebx),%eax
  return 0;
801036f8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801036fb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103701:	8b 03                	mov    (%ebx),%eax
80103703:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103707:	8b 03                	mov    (%ebx),%eax
80103709:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010370d:	8b 03                	mov    (%ebx),%eax
8010370f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103712:	8b 06                	mov    (%esi),%eax
80103714:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010371a:	8b 06                	mov    (%esi),%eax
8010371c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103720:	8b 06                	mov    (%esi),%eax
80103722:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103726:	8b 06                	mov    (%esi),%eax
80103728:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010372b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010372e:	31 c0                	xor    %eax,%eax
}
80103730:	5b                   	pop    %ebx
80103731:	5e                   	pop    %esi
80103732:	5f                   	pop    %edi
80103733:	5d                   	pop    %ebp
80103734:	c3                   	ret    
80103735:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103740 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	56                   	push   %esi
80103744:	53                   	push   %ebx
80103745:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103748:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010374b:	83 ec 0c             	sub    $0xc,%esp
8010374e:	53                   	push   %ebx
8010374f:	e8 fc 19 00 00       	call   80105150 <acquire>
  if(writable){
80103754:	83 c4 10             	add    $0x10,%esp
80103757:	85 f6                	test   %esi,%esi
80103759:	74 45                	je     801037a0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010375b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103761:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103764:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010376b:	00 00 00 
    wakeup(&p->nread);
8010376e:	50                   	push   %eax
8010376f:	e8 6c 0b 00 00       	call   801042e0 <wakeup>
80103774:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103777:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010377d:	85 d2                	test   %edx,%edx
8010377f:	75 0a                	jne    8010378b <pipeclose+0x4b>
80103781:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103787:	85 c0                	test   %eax,%eax
80103789:	74 35                	je     801037c0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010378b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010378e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103791:	5b                   	pop    %ebx
80103792:	5e                   	pop    %esi
80103793:	5d                   	pop    %ebp
    release(&p->lock);
80103794:	e9 77 1a 00 00       	jmp    80105210 <release>
80103799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801037a0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801037a6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801037a9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801037b0:	00 00 00 
    wakeup(&p->nwrite);
801037b3:	50                   	push   %eax
801037b4:	e8 27 0b 00 00       	call   801042e0 <wakeup>
801037b9:	83 c4 10             	add    $0x10,%esp
801037bc:	eb b9                	jmp    80103777 <pipeclose+0x37>
801037be:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801037c0:	83 ec 0c             	sub    $0xc,%esp
801037c3:	53                   	push   %ebx
801037c4:	e8 47 1a 00 00       	call   80105210 <release>
    kfree((char*)p);
801037c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801037cc:	83 c4 10             	add    $0x10,%esp
}
801037cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037d2:	5b                   	pop    %ebx
801037d3:	5e                   	pop    %esi
801037d4:	5d                   	pop    %ebp
    kfree((char*)p);
801037d5:	e9 a6 ee ff ff       	jmp    80102680 <kfree>
801037da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801037e0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	57                   	push   %edi
801037e4:	56                   	push   %esi
801037e5:	53                   	push   %ebx
801037e6:	83 ec 28             	sub    $0x28,%esp
801037e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801037ec:	53                   	push   %ebx
801037ed:	e8 5e 19 00 00       	call   80105150 <acquire>
  for(i = 0; i < n; i++){
801037f2:	8b 45 10             	mov    0x10(%ebp),%eax
801037f5:	83 c4 10             	add    $0x10,%esp
801037f8:	85 c0                	test   %eax,%eax
801037fa:	0f 8e c9 00 00 00    	jle    801038c9 <pipewrite+0xe9>
80103800:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103803:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103809:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010380f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103812:	03 4d 10             	add    0x10(%ebp),%ecx
80103815:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103818:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010381e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103824:	39 d0                	cmp    %edx,%eax
80103826:	75 71                	jne    80103899 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103828:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010382e:	85 c0                	test   %eax,%eax
80103830:	74 4e                	je     80103880 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103832:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103838:	eb 3a                	jmp    80103874 <pipewrite+0x94>
8010383a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103840:	83 ec 0c             	sub    $0xc,%esp
80103843:	57                   	push   %edi
80103844:	e8 97 0a 00 00       	call   801042e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103849:	5a                   	pop    %edx
8010384a:	59                   	pop    %ecx
8010384b:	53                   	push   %ebx
8010384c:	56                   	push   %esi
8010384d:	e8 ce 08 00 00       	call   80104120 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103852:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103858:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010385e:	83 c4 10             	add    $0x10,%esp
80103861:	05 00 02 00 00       	add    $0x200,%eax
80103866:	39 c2                	cmp    %eax,%edx
80103868:	75 36                	jne    801038a0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010386a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103870:	85 c0                	test   %eax,%eax
80103872:	74 0c                	je     80103880 <pipewrite+0xa0>
80103874:	e8 a7 03 00 00       	call   80103c20 <myproc>
80103879:	8b 40 24             	mov    0x24(%eax),%eax
8010387c:	85 c0                	test   %eax,%eax
8010387e:	74 c0                	je     80103840 <pipewrite+0x60>
        release(&p->lock);
80103880:	83 ec 0c             	sub    $0xc,%esp
80103883:	53                   	push   %ebx
80103884:	e8 87 19 00 00       	call   80105210 <release>
        return -1;
80103889:	83 c4 10             	add    $0x10,%esp
8010388c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103891:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103894:	5b                   	pop    %ebx
80103895:	5e                   	pop    %esi
80103896:	5f                   	pop    %edi
80103897:	5d                   	pop    %ebp
80103898:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103899:	89 c2                	mov    %eax,%edx
8010389b:	90                   	nop
8010389c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038a0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801038a3:	8d 42 01             	lea    0x1(%edx),%eax
801038a6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801038ac:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801038b2:	83 c6 01             	add    $0x1,%esi
801038b5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801038b9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801038bc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038bf:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801038c3:	0f 85 4f ff ff ff    	jne    80103818 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801038c9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801038cf:	83 ec 0c             	sub    $0xc,%esp
801038d2:	50                   	push   %eax
801038d3:	e8 08 0a 00 00       	call   801042e0 <wakeup>
  release(&p->lock);
801038d8:	89 1c 24             	mov    %ebx,(%esp)
801038db:	e8 30 19 00 00       	call   80105210 <release>
  return n;
801038e0:	83 c4 10             	add    $0x10,%esp
801038e3:	8b 45 10             	mov    0x10(%ebp),%eax
801038e6:	eb a9                	jmp    80103891 <pipewrite+0xb1>
801038e8:	90                   	nop
801038e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801038f0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	57                   	push   %edi
801038f4:	56                   	push   %esi
801038f5:	53                   	push   %ebx
801038f6:	83 ec 18             	sub    $0x18,%esp
801038f9:	8b 75 08             	mov    0x8(%ebp),%esi
801038fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801038ff:	56                   	push   %esi
80103900:	e8 4b 18 00 00       	call   80105150 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103905:	83 c4 10             	add    $0x10,%esp
80103908:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010390e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103914:	75 6a                	jne    80103980 <piperead+0x90>
80103916:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010391c:	85 db                	test   %ebx,%ebx
8010391e:	0f 84 c4 00 00 00    	je     801039e8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103924:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010392a:	eb 2d                	jmp    80103959 <piperead+0x69>
8010392c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103930:	83 ec 08             	sub    $0x8,%esp
80103933:	56                   	push   %esi
80103934:	53                   	push   %ebx
80103935:	e8 e6 07 00 00       	call   80104120 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010393a:	83 c4 10             	add    $0x10,%esp
8010393d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103943:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103949:	75 35                	jne    80103980 <piperead+0x90>
8010394b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103951:	85 d2                	test   %edx,%edx
80103953:	0f 84 8f 00 00 00    	je     801039e8 <piperead+0xf8>
    if(myproc()->killed){
80103959:	e8 c2 02 00 00       	call   80103c20 <myproc>
8010395e:	8b 48 24             	mov    0x24(%eax),%ecx
80103961:	85 c9                	test   %ecx,%ecx
80103963:	74 cb                	je     80103930 <piperead+0x40>
      release(&p->lock);
80103965:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103968:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010396d:	56                   	push   %esi
8010396e:	e8 9d 18 00 00       	call   80105210 <release>
      return -1;
80103973:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103976:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103979:	89 d8                	mov    %ebx,%eax
8010397b:	5b                   	pop    %ebx
8010397c:	5e                   	pop    %esi
8010397d:	5f                   	pop    %edi
8010397e:	5d                   	pop    %ebp
8010397f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103980:	8b 45 10             	mov    0x10(%ebp),%eax
80103983:	85 c0                	test   %eax,%eax
80103985:	7e 61                	jle    801039e8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103987:	31 db                	xor    %ebx,%ebx
80103989:	eb 13                	jmp    8010399e <piperead+0xae>
8010398b:	90                   	nop
8010398c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103990:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103996:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010399c:	74 1f                	je     801039bd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010399e:	8d 41 01             	lea    0x1(%ecx),%eax
801039a1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801039a7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801039ad:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801039b2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039b5:	83 c3 01             	add    $0x1,%ebx
801039b8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801039bb:	75 d3                	jne    80103990 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801039bd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801039c3:	83 ec 0c             	sub    $0xc,%esp
801039c6:	50                   	push   %eax
801039c7:	e8 14 09 00 00       	call   801042e0 <wakeup>
  release(&p->lock);
801039cc:	89 34 24             	mov    %esi,(%esp)
801039cf:	e8 3c 18 00 00       	call   80105210 <release>
  return i;
801039d4:	83 c4 10             	add    $0x10,%esp
}
801039d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039da:	89 d8                	mov    %ebx,%eax
801039dc:	5b                   	pop    %ebx
801039dd:	5e                   	pop    %esi
801039de:	5f                   	pop    %edi
801039df:	5d                   	pop    %ebp
801039e0:	c3                   	ret    
801039e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039e8:	31 db                	xor    %ebx,%ebx
801039ea:	eb d1                	jmp    801039bd <piperead+0xcd>
801039ec:	66 90                	xchg   %ax,%ax
801039ee:	66 90                	xchg   %ax,%ax

801039f0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039f4:	bb 74 40 11 80       	mov    $0x80114074,%ebx
{
801039f9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801039fc:	68 40 40 11 80       	push   $0x80114040
80103a01:	e8 4a 17 00 00       	call   80105150 <acquire>
80103a06:	83 c4 10             	add    $0x10,%esp
80103a09:	eb 17                	jmp    80103a22 <allocproc+0x32>
80103a0b:	90                   	nop
80103a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a10:	81 c3 94 00 00 00    	add    $0x94,%ebx
80103a16:	81 fb 74 65 11 80    	cmp    $0x80116574,%ebx
80103a1c:	0f 83 c6 00 00 00    	jae    80103ae8 <allocproc+0xf8>
    if(p->state == UNUSED)
80103a22:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a25:	85 c0                	test   %eax,%eax
80103a27:	75 e7                	jne    80103a10 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103a29:	a1 08 b0 10 80       	mov    0x8010b008,%eax

  release(&ptable.lock);
80103a2e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103a31:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103a38:	8d 50 01             	lea    0x1(%eax),%edx
80103a3b:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103a3e:	68 40 40 11 80       	push   $0x80114040
  p->pid = nextpid++;
80103a43:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  release(&ptable.lock);
80103a49:	e8 c2 17 00 00       	call   80105210 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103a4e:	e8 ed ed ff ff       	call   80102840 <kalloc>
80103a53:	83 c4 10             	add    $0x10,%esp
80103a56:	85 c0                	test   %eax,%eax
80103a58:	89 43 08             	mov    %eax,0x8(%ebx)
80103a5b:	0f 84 a0 00 00 00    	je     80103b01 <allocproc+0x111>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103a61:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103a67:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103a6a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103a6f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103a72:	c7 40 14 81 65 10 80 	movl   $0x80106581,0x14(%eax)
  p->context = (struct context*)sp;
80103a79:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103a7c:	6a 14                	push   $0x14
80103a7e:	6a 00                	push   $0x0
80103a80:	50                   	push   %eax
80103a81:	e8 da 17 00 00       	call   80105260 <memset>
  p->context->eip = (uint)forkret;
80103a86:	8b 43 1c             	mov    0x1c(%ebx),%eax
  p->process_count = process_number;
  process_number++;
  p->lottery_ticket = 50;
  p->burst_time = 0;
  p->schedQueue = LOTTERY;
  return p;
80103a89:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103a8c:	c7 40 10 10 3b 10 80 	movl   $0x80103b10,0x10(%eax)
  p->creation_time = ticks + createdProcess++;
80103a93:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->lottery_ticket = 50;
80103a98:	c7 43 7c 32 00 00 00 	movl   $0x32,0x7c(%ebx)
  p->burst_time = 0;
80103a9f:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103aa6:	00 00 00 
  p->schedQueue = LOTTERY;
80103aa9:	c7 83 80 00 00 00 02 	movl   $0x2,0x80(%ebx)
80103ab0:	00 00 00 
  p->creation_time = ticks + createdProcess++;
80103ab3:	8d 50 01             	lea    0x1(%eax),%edx
80103ab6:	03 05 c0 6d 11 80    	add    0x80116dc0,%eax
80103abc:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80103ac2:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
  p->process_count = process_number;
80103ac8:	a1 20 40 11 80       	mov    0x80114020,%eax
80103acd:	89 83 90 00 00 00    	mov    %eax,0x90(%ebx)
  process_number++;
80103ad3:	83 c0 01             	add    $0x1,%eax
80103ad6:	a3 20 40 11 80       	mov    %eax,0x80114020
}
80103adb:	89 d8                	mov    %ebx,%eax
80103add:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ae0:	c9                   	leave  
80103ae1:	c3                   	ret    
80103ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103ae8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103aeb:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103aed:	68 40 40 11 80       	push   $0x80114040
80103af2:	e8 19 17 00 00       	call   80105210 <release>
}
80103af7:	89 d8                	mov    %ebx,%eax
  return 0;
80103af9:	83 c4 10             	add    $0x10,%esp
}
80103afc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103aff:	c9                   	leave  
80103b00:	c3                   	ret    
    p->state = UNUSED;
80103b01:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103b08:	31 db                	xor    %ebx,%ebx
80103b0a:	eb cf                	jmp    80103adb <allocproc+0xeb>
80103b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b10 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103b16:	68 40 40 11 80       	push   $0x80114040
80103b1b:	e8 f0 16 00 00       	call   80105210 <release>

  if (first) {
80103b20:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103b25:	83 c4 10             	add    $0x10,%esp
80103b28:	85 c0                	test   %eax,%eax
80103b2a:	75 04                	jne    80103b30 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103b2c:	c9                   	leave  
80103b2d:	c3                   	ret    
80103b2e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103b30:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103b33:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103b3a:	00 00 00 
    iinit(ROOTDEV);
80103b3d:	6a 01                	push   $0x1
80103b3f:	e8 ac dc ff ff       	call   801017f0 <iinit>
    initlog(ROOTDEV);
80103b44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103b4b:	e8 a0 f3 ff ff       	call   80102ef0 <initlog>
80103b50:	83 c4 10             	add    $0x10,%esp
}
80103b53:	c9                   	leave  
80103b54:	c3                   	ret    
80103b55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b60 <pinit>:
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103b66:	68 55 85 10 80       	push   $0x80108555
80103b6b:	68 40 40 11 80       	push   $0x80114040
80103b70:	e8 9b 14 00 00       	call   80105010 <initlock>
}
80103b75:	83 c4 10             	add    $0x10,%esp
80103b78:	c9                   	leave  
80103b79:	c3                   	ret    
80103b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b80 <mycpu>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	56                   	push   %esi
80103b84:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b85:	9c                   	pushf  
80103b86:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b87:	f6 c4 02             	test   $0x2,%ah
80103b8a:	75 5e                	jne    80103bea <mycpu+0x6a>
  apicid = lapicid();
80103b8c:	e8 8f ef ff ff       	call   80102b20 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103b91:	8b 35 00 40 11 80    	mov    0x80114000,%esi
80103b97:	85 f6                	test   %esi,%esi
80103b99:	7e 42                	jle    80103bdd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103b9b:	0f b6 15 60 3a 11 80 	movzbl 0x80113a60,%edx
80103ba2:	39 d0                	cmp    %edx,%eax
80103ba4:	74 30                	je     80103bd6 <mycpu+0x56>
80103ba6:	b9 14 3b 11 80       	mov    $0x80113b14,%ecx
  for (i = 0; i < ncpu; ++i) {
80103bab:	31 d2                	xor    %edx,%edx
80103bad:	8d 76 00             	lea    0x0(%esi),%esi
80103bb0:	83 c2 01             	add    $0x1,%edx
80103bb3:	39 f2                	cmp    %esi,%edx
80103bb5:	74 26                	je     80103bdd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103bb7:	0f b6 19             	movzbl (%ecx),%ebx
80103bba:	81 c1 b4 00 00 00    	add    $0xb4,%ecx
80103bc0:	39 c3                	cmp    %eax,%ebx
80103bc2:	75 ec                	jne    80103bb0 <mycpu+0x30>
80103bc4:	69 c2 b4 00 00 00    	imul   $0xb4,%edx,%eax
80103bca:	05 60 3a 11 80       	add    $0x80113a60,%eax
}
80103bcf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bd2:	5b                   	pop    %ebx
80103bd3:	5e                   	pop    %esi
80103bd4:	5d                   	pop    %ebp
80103bd5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103bd6:	b8 60 3a 11 80       	mov    $0x80113a60,%eax
      return &cpus[i];
80103bdb:	eb f2                	jmp    80103bcf <mycpu+0x4f>
  panic("unknown apicid\n");
80103bdd:	83 ec 0c             	sub    $0xc,%esp
80103be0:	68 5c 85 10 80       	push   $0x8010855c
80103be5:	e8 a6 c7 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103bea:	83 ec 0c             	sub    $0xc,%esp
80103bed:	68 48 87 10 80       	push   $0x80108748
80103bf2:	e8 99 c7 ff ff       	call   80100390 <panic>
80103bf7:	89 f6                	mov    %esi,%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c00 <cpuid>:
cpuid() {
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103c06:	e8 75 ff ff ff       	call   80103b80 <mycpu>
80103c0b:	2d 60 3a 11 80       	sub    $0x80113a60,%eax
}
80103c10:	c9                   	leave  
  return mycpu()-cpus;
80103c11:	c1 f8 02             	sar    $0x2,%eax
80103c14:	69 c0 a5 4f fa a4    	imul   $0xa4fa4fa5,%eax,%eax
}
80103c1a:	c3                   	ret    
80103c1b:	90                   	nop
80103c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103c20 <myproc>:
myproc(void) {
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	53                   	push   %ebx
80103c24:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103c27:	e8 54 14 00 00       	call   80105080 <pushcli>
  c = mycpu();
80103c2c:	e8 4f ff ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80103c31:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c37:	e8 84 14 00 00       	call   801050c0 <popcli>
}
80103c3c:	83 c4 04             	add    $0x4,%esp
80103c3f:	89 d8                	mov    %ebx,%eax
80103c41:	5b                   	pop    %ebx
80103c42:	5d                   	pop    %ebp
80103c43:	c3                   	ret    
80103c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103c50 <userinit>:
{
80103c50:	55                   	push   %ebp
80103c51:	89 e5                	mov    %esp,%ebp
80103c53:	53                   	push   %ebx
80103c54:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103c57:	e8 94 fd ff ff       	call   801039f0 <allocproc>
80103c5c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103c5e:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
  if((p->pgdir = setupkvm()) == 0)
80103c63:	e8 38 3f 00 00       	call   80107ba0 <setupkvm>
80103c68:	85 c0                	test   %eax,%eax
80103c6a:	89 43 04             	mov    %eax,0x4(%ebx)
80103c6d:	0f 84 bd 00 00 00    	je     80103d30 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103c73:	83 ec 04             	sub    $0x4,%esp
80103c76:	68 2c 00 00 00       	push   $0x2c
80103c7b:	68 60 b4 10 80       	push   $0x8010b460
80103c80:	50                   	push   %eax
80103c81:	e8 fa 3b 00 00       	call   80107880 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103c86:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103c89:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103c8f:	6a 4c                	push   $0x4c
80103c91:	6a 00                	push   $0x0
80103c93:	ff 73 18             	pushl  0x18(%ebx)
80103c96:	e8 c5 15 00 00       	call   80105260 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c9b:	8b 43 18             	mov    0x18(%ebx),%eax
80103c9e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103ca3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103ca8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103cab:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103caf:	8b 43 18             	mov    0x18(%ebx),%eax
80103cb2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103cb6:	8b 43 18             	mov    0x18(%ebx),%eax
80103cb9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103cbd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103cc1:	8b 43 18             	mov    0x18(%ebx),%eax
80103cc4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103cc8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103ccc:	8b 43 18             	mov    0x18(%ebx),%eax
80103ccf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103cd6:	8b 43 18             	mov    0x18(%ebx),%eax
80103cd9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103ce0:	8b 43 18             	mov    0x18(%ebx),%eax
80103ce3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103cea:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ced:	6a 10                	push   $0x10
80103cef:	68 85 85 10 80       	push   $0x80108585
80103cf4:	50                   	push   %eax
80103cf5:	e8 46 17 00 00       	call   80105440 <safestrcpy>
  p->cwd = namei("/");
80103cfa:	c7 04 24 8e 85 10 80 	movl   $0x8010858e,(%esp)
80103d01:	e8 4a e5 ff ff       	call   80102250 <namei>
80103d06:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103d09:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)
80103d10:	e8 3b 14 00 00       	call   80105150 <acquire>
  p->state = RUNNABLE;
80103d15:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103d1c:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)
80103d23:	e8 e8 14 00 00       	call   80105210 <release>
}
80103d28:	83 c4 10             	add    $0x10,%esp
80103d2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d2e:	c9                   	leave  
80103d2f:	c3                   	ret    
    panic("userinit: out of memory?");
80103d30:	83 ec 0c             	sub    $0xc,%esp
80103d33:	68 6c 85 10 80       	push   $0x8010856c
80103d38:	e8 53 c6 ff ff       	call   80100390 <panic>
80103d3d:	8d 76 00             	lea    0x0(%esi),%esi

80103d40 <growproc>:
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	56                   	push   %esi
80103d44:	53                   	push   %ebx
80103d45:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103d48:	e8 33 13 00 00       	call   80105080 <pushcli>
  c = mycpu();
80103d4d:	e8 2e fe ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80103d52:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d58:	e8 63 13 00 00       	call   801050c0 <popcli>
  if(n > 0){
80103d5d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103d60:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103d62:	7f 1c                	jg     80103d80 <growproc+0x40>
  } else if(n < 0){
80103d64:	75 3a                	jne    80103da0 <growproc+0x60>
  switchuvm(curproc);
80103d66:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103d69:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103d6b:	53                   	push   %ebx
80103d6c:	e8 ff 39 00 00       	call   80107770 <switchuvm>
  return 0;
80103d71:	83 c4 10             	add    $0x10,%esp
80103d74:	31 c0                	xor    %eax,%eax
}
80103d76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d79:	5b                   	pop    %ebx
80103d7a:	5e                   	pop    %esi
80103d7b:	5d                   	pop    %ebp
80103d7c:	c3                   	ret    
80103d7d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d80:	83 ec 04             	sub    $0x4,%esp
80103d83:	01 c6                	add    %eax,%esi
80103d85:	56                   	push   %esi
80103d86:	50                   	push   %eax
80103d87:	ff 73 04             	pushl  0x4(%ebx)
80103d8a:	e8 61 3c 00 00       	call   801079f0 <allocuvm>
80103d8f:	83 c4 10             	add    $0x10,%esp
80103d92:	85 c0                	test   %eax,%eax
80103d94:	75 d0                	jne    80103d66 <growproc+0x26>
      return -1;
80103d96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d9b:	eb d9                	jmp    80103d76 <growproc+0x36>
80103d9d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103da0:	83 ec 04             	sub    $0x4,%esp
80103da3:	01 c6                	add    %eax,%esi
80103da5:	56                   	push   %esi
80103da6:	50                   	push   %eax
80103da7:	ff 73 04             	pushl  0x4(%ebx)
80103daa:	e8 41 3d 00 00       	call   80107af0 <deallocuvm>
80103daf:	83 c4 10             	add    $0x10,%esp
80103db2:	85 c0                	test   %eax,%eax
80103db4:	75 b0                	jne    80103d66 <growproc+0x26>
80103db6:	eb de                	jmp    80103d96 <growproc+0x56>
80103db8:	90                   	nop
80103db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103dc0 <fork>:
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
80103dc5:	53                   	push   %ebx
80103dc6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103dc9:	e8 b2 12 00 00       	call   80105080 <pushcli>
  c = mycpu();
80103dce:	e8 ad fd ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80103dd3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dd9:	e8 e2 12 00 00       	call   801050c0 <popcli>
  if((np = allocproc()) == 0){
80103dde:	e8 0d fc ff ff       	call   801039f0 <allocproc>
80103de3:	85 c0                	test   %eax,%eax
80103de5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103de8:	0f 84 c1 00 00 00    	je     80103eaf <fork+0xef>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103dee:	83 ec 08             	sub    $0x8,%esp
80103df1:	ff 33                	pushl  (%ebx)
80103df3:	ff 73 04             	pushl  0x4(%ebx)
80103df6:	89 c7                	mov    %eax,%edi
80103df8:	e8 73 3e 00 00       	call   80107c70 <copyuvm>
80103dfd:	83 c4 10             	add    $0x10,%esp
80103e00:	85 c0                	test   %eax,%eax
80103e02:	89 47 04             	mov    %eax,0x4(%edi)
80103e05:	0f 84 ab 00 00 00    	je     80103eb6 <fork+0xf6>
  np->sz = curproc->sz;
80103e0b:	8b 03                	mov    (%ebx),%eax
80103e0d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103e10:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103e12:	89 59 14             	mov    %ebx,0x14(%ecx)
80103e15:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103e17:	8b 79 18             	mov    0x18(%ecx),%edi
80103e1a:	8b 73 18             	mov    0x18(%ebx),%esi
80103e1d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103e22:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103e24:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103e26:	8b 40 18             	mov    0x18(%eax),%eax
80103e29:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103e30:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103e34:	85 c0                	test   %eax,%eax
80103e36:	74 13                	je     80103e4b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103e38:	83 ec 0c             	sub    $0xc,%esp
80103e3b:	50                   	push   %eax
80103e3c:	e8 0f d3 ff ff       	call   80101150 <filedup>
80103e41:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103e44:	83 c4 10             	add    $0x10,%esp
80103e47:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103e4b:	83 c6 01             	add    $0x1,%esi
80103e4e:	83 fe 10             	cmp    $0x10,%esi
80103e51:	75 dd                	jne    80103e30 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103e53:	83 ec 0c             	sub    $0xc,%esp
80103e56:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e59:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103e5c:	e8 5f db ff ff       	call   801019c0 <idup>
80103e61:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e64:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103e67:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e6a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103e6d:	6a 10                	push   $0x10
80103e6f:	53                   	push   %ebx
80103e70:	50                   	push   %eax
80103e71:	e8 ca 15 00 00       	call   80105440 <safestrcpy>
  pid = np->pid;
80103e76:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103e79:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)
80103e80:	e8 cb 12 00 00       	call   80105150 <acquire>
  np->priority = 1000;
80103e85:	c7 87 84 00 00 00 e8 	movl   $0x3e8,0x84(%edi)
80103e8c:	03 00 00 
  np->state = RUNNABLE;
80103e8f:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103e96:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)
80103e9d:	e8 6e 13 00 00       	call   80105210 <release>
  return pid;
80103ea2:	83 c4 10             	add    $0x10,%esp
}
80103ea5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ea8:	89 d8                	mov    %ebx,%eax
80103eaa:	5b                   	pop    %ebx
80103eab:	5e                   	pop    %esi
80103eac:	5f                   	pop    %edi
80103ead:	5d                   	pop    %ebp
80103eae:	c3                   	ret    
    return -1;
80103eaf:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103eb4:	eb ef                	jmp    80103ea5 <fork+0xe5>
    kfree(np->kstack);
80103eb6:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103eb9:	83 ec 0c             	sub    $0xc,%esp
80103ebc:	ff 73 08             	pushl  0x8(%ebx)
80103ebf:	e8 bc e7 ff ff       	call   80102680 <kfree>
    np->kstack = 0;
80103ec4:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103ecb:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103ed2:	83 c4 10             	add    $0x10,%esp
80103ed5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103eda:	eb c9                	jmp    80103ea5 <fork+0xe5>
80103edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ee0 <sched>:
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	56                   	push   %esi
80103ee4:	53                   	push   %ebx
  pushcli();
80103ee5:	e8 96 11 00 00       	call   80105080 <pushcli>
  c = mycpu();
80103eea:	e8 91 fc ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80103eef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ef5:	e8 c6 11 00 00       	call   801050c0 <popcli>
  if(!holding(&ptable.lock))
80103efa:	83 ec 0c             	sub    $0xc,%esp
80103efd:	68 40 40 11 80       	push   $0x80114040
80103f02:	e8 19 12 00 00       	call   80105120 <holding>
80103f07:	83 c4 10             	add    $0x10,%esp
80103f0a:	85 c0                	test   %eax,%eax
80103f0c:	74 4f                	je     80103f5d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103f0e:	e8 6d fc ff ff       	call   80103b80 <mycpu>
80103f13:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103f1a:	75 68                	jne    80103f84 <sched+0xa4>
  if(p->state == RUNNING)
80103f1c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103f20:	74 55                	je     80103f77 <sched+0x97>
80103f22:	9c                   	pushf  
80103f23:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103f24:	f6 c4 02             	test   $0x2,%ah
80103f27:	75 41                	jne    80103f6a <sched+0x8a>
  intena = mycpu()->intena;
80103f29:	e8 52 fc ff ff       	call   80103b80 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103f2e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103f31:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103f37:	e8 44 fc ff ff       	call   80103b80 <mycpu>
80103f3c:	83 ec 08             	sub    $0x8,%esp
80103f3f:	ff 70 04             	pushl  0x4(%eax)
80103f42:	53                   	push   %ebx
80103f43:	e8 53 15 00 00       	call   8010549b <swtch>
  mycpu()->intena = intena;
80103f48:	e8 33 fc ff ff       	call   80103b80 <mycpu>
}
80103f4d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103f50:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103f56:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f59:	5b                   	pop    %ebx
80103f5a:	5e                   	pop    %esi
80103f5b:	5d                   	pop    %ebp
80103f5c:	c3                   	ret    
    panic("sched ptable.lock");
80103f5d:	83 ec 0c             	sub    $0xc,%esp
80103f60:	68 90 85 10 80       	push   $0x80108590
80103f65:	e8 26 c4 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103f6a:	83 ec 0c             	sub    $0xc,%esp
80103f6d:	68 bc 85 10 80       	push   $0x801085bc
80103f72:	e8 19 c4 ff ff       	call   80100390 <panic>
    panic("sched running");
80103f77:	83 ec 0c             	sub    $0xc,%esp
80103f7a:	68 ae 85 10 80       	push   $0x801085ae
80103f7f:	e8 0c c4 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103f84:	83 ec 0c             	sub    $0xc,%esp
80103f87:	68 a2 85 10 80       	push   $0x801085a2
80103f8c:	e8 ff c3 ff ff       	call   80100390 <panic>
80103f91:	eb 0d                	jmp    80103fa0 <exit>
80103f93:	90                   	nop
80103f94:	90                   	nop
80103f95:	90                   	nop
80103f96:	90                   	nop
80103f97:	90                   	nop
80103f98:	90                   	nop
80103f99:	90                   	nop
80103f9a:	90                   	nop
80103f9b:	90                   	nop
80103f9c:	90                   	nop
80103f9d:	90                   	nop
80103f9e:	90                   	nop
80103f9f:	90                   	nop

80103fa0 <exit>:
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	57                   	push   %edi
80103fa4:	56                   	push   %esi
80103fa5:	53                   	push   %ebx
80103fa6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103fa9:	e8 d2 10 00 00       	call   80105080 <pushcli>
  c = mycpu();
80103fae:	e8 cd fb ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80103fb3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fb9:	e8 02 11 00 00       	call   801050c0 <popcli>
  if(curproc == initproc)
80103fbe:	39 35 f8 b5 10 80    	cmp    %esi,0x8010b5f8
80103fc4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103fc7:	8d 7e 68             	lea    0x68(%esi),%edi
80103fca:	0f 84 f1 00 00 00    	je     801040c1 <exit+0x121>
    if(curproc->ofile[fd]){
80103fd0:	8b 03                	mov    (%ebx),%eax
80103fd2:	85 c0                	test   %eax,%eax
80103fd4:	74 12                	je     80103fe8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103fd6:	83 ec 0c             	sub    $0xc,%esp
80103fd9:	50                   	push   %eax
80103fda:	e8 c1 d1 ff ff       	call   801011a0 <fileclose>
      curproc->ofile[fd] = 0;
80103fdf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103fe5:	83 c4 10             	add    $0x10,%esp
80103fe8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103feb:	39 fb                	cmp    %edi,%ebx
80103fed:	75 e1                	jne    80103fd0 <exit+0x30>
  begin_op();
80103fef:	e8 9c ef ff ff       	call   80102f90 <begin_op>
  iput(curproc->cwd);
80103ff4:	83 ec 0c             	sub    $0xc,%esp
80103ff7:	ff 76 68             	pushl  0x68(%esi)
80103ffa:	e8 21 db ff ff       	call   80101b20 <iput>
  end_op();
80103fff:	e8 fc ef ff ff       	call   80103000 <end_op>
  curproc->cwd = 0;
80104004:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010400b:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)
80104012:	e8 39 11 00 00       	call   80105150 <acquire>
  wakeup1(curproc->parent);
80104017:	8b 56 14             	mov    0x14(%esi),%edx
8010401a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010401d:	b8 74 40 11 80       	mov    $0x80114074,%eax
80104022:	eb 10                	jmp    80104034 <exit+0x94>
80104024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104028:	05 94 00 00 00       	add    $0x94,%eax
8010402d:	3d 74 65 11 80       	cmp    $0x80116574,%eax
80104032:	73 1e                	jae    80104052 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80104034:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104038:	75 ee                	jne    80104028 <exit+0x88>
8010403a:	3b 50 20             	cmp    0x20(%eax),%edx
8010403d:	75 e9                	jne    80104028 <exit+0x88>
      p->state = RUNNABLE;
8010403f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104046:	05 94 00 00 00       	add    $0x94,%eax
8010404b:	3d 74 65 11 80       	cmp    $0x80116574,%eax
80104050:	72 e2                	jb     80104034 <exit+0x94>
      p->parent = initproc;
80104052:	8b 0d f8 b5 10 80    	mov    0x8010b5f8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104058:	ba 74 40 11 80       	mov    $0x80114074,%edx
8010405d:	eb 0f                	jmp    8010406e <exit+0xce>
8010405f:	90                   	nop
80104060:	81 c2 94 00 00 00    	add    $0x94,%edx
80104066:	81 fa 74 65 11 80    	cmp    $0x80116574,%edx
8010406c:	73 3a                	jae    801040a8 <exit+0x108>
    if(p->parent == curproc){
8010406e:	39 72 14             	cmp    %esi,0x14(%edx)
80104071:	75 ed                	jne    80104060 <exit+0xc0>
      if(p->state == ZOMBIE)
80104073:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104077:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010407a:	75 e4                	jne    80104060 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010407c:	b8 74 40 11 80       	mov    $0x80114074,%eax
80104081:	eb 11                	jmp    80104094 <exit+0xf4>
80104083:	90                   	nop
80104084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104088:	05 94 00 00 00       	add    $0x94,%eax
8010408d:	3d 74 65 11 80       	cmp    $0x80116574,%eax
80104092:	73 cc                	jae    80104060 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104094:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104098:	75 ee                	jne    80104088 <exit+0xe8>
8010409a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010409d:	75 e9                	jne    80104088 <exit+0xe8>
      p->state = RUNNABLE;
8010409f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040a6:	eb e0                	jmp    80104088 <exit+0xe8>
  curproc->state = ZOMBIE;
801040a8:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801040af:	e8 2c fe ff ff       	call   80103ee0 <sched>
  panic("zombie exit");
801040b4:	83 ec 0c             	sub    $0xc,%esp
801040b7:	68 dd 85 10 80       	push   $0x801085dd
801040bc:	e8 cf c2 ff ff       	call   80100390 <panic>
    panic("init exiting");
801040c1:	83 ec 0c             	sub    $0xc,%esp
801040c4:	68 d0 85 10 80       	push   $0x801085d0
801040c9:	e8 c2 c2 ff ff       	call   80100390 <panic>
801040ce:	66 90                	xchg   %ax,%ax

801040d0 <yield>:
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	53                   	push   %ebx
801040d4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801040d7:	68 40 40 11 80       	push   $0x80114040
801040dc:	e8 6f 10 00 00       	call   80105150 <acquire>
  pushcli();
801040e1:	e8 9a 0f 00 00       	call   80105080 <pushcli>
  c = mycpu();
801040e6:	e8 95 fa ff ff       	call   80103b80 <mycpu>
  p = c->proc;
801040eb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040f1:	e8 ca 0f 00 00       	call   801050c0 <popcli>
  myproc()->state = RUNNABLE;
801040f6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801040fd:	e8 de fd ff ff       	call   80103ee0 <sched>
  release(&ptable.lock);
80104102:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)
80104109:	e8 02 11 00 00       	call   80105210 <release>
}
8010410e:	83 c4 10             	add    $0x10,%esp
80104111:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104114:	c9                   	leave  
80104115:	c3                   	ret    
80104116:	8d 76 00             	lea    0x0(%esi),%esi
80104119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104120 <sleep>:
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	57                   	push   %edi
80104124:	56                   	push   %esi
80104125:	53                   	push   %ebx
80104126:	83 ec 0c             	sub    $0xc,%esp
80104129:	8b 7d 08             	mov    0x8(%ebp),%edi
8010412c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010412f:	e8 4c 0f 00 00       	call   80105080 <pushcli>
  c = mycpu();
80104134:	e8 47 fa ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80104139:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010413f:	e8 7c 0f 00 00       	call   801050c0 <popcli>
  if(p == 0)
80104144:	85 db                	test   %ebx,%ebx
80104146:	0f 84 87 00 00 00    	je     801041d3 <sleep+0xb3>
  if(lk == 0)
8010414c:	85 f6                	test   %esi,%esi
8010414e:	74 76                	je     801041c6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104150:	81 fe 40 40 11 80    	cmp    $0x80114040,%esi
80104156:	74 50                	je     801041a8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104158:	83 ec 0c             	sub    $0xc,%esp
8010415b:	68 40 40 11 80       	push   $0x80114040
80104160:	e8 eb 0f 00 00       	call   80105150 <acquire>
    release(lk);
80104165:	89 34 24             	mov    %esi,(%esp)
80104168:	e8 a3 10 00 00       	call   80105210 <release>
  p->chan = chan;
8010416d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104170:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104177:	e8 64 fd ff ff       	call   80103ee0 <sched>
  p->chan = 0;
8010417c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104183:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)
8010418a:	e8 81 10 00 00       	call   80105210 <release>
    acquire(lk);
8010418f:	89 75 08             	mov    %esi,0x8(%ebp)
80104192:	83 c4 10             	add    $0x10,%esp
}
80104195:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104198:	5b                   	pop    %ebx
80104199:	5e                   	pop    %esi
8010419a:	5f                   	pop    %edi
8010419b:	5d                   	pop    %ebp
    acquire(lk);
8010419c:	e9 af 0f 00 00       	jmp    80105150 <acquire>
801041a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801041a8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801041ab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801041b2:	e8 29 fd ff ff       	call   80103ee0 <sched>
  p->chan = 0;
801041b7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801041be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041c1:	5b                   	pop    %ebx
801041c2:	5e                   	pop    %esi
801041c3:	5f                   	pop    %edi
801041c4:	5d                   	pop    %ebp
801041c5:	c3                   	ret    
    panic("sleep without lk");
801041c6:	83 ec 0c             	sub    $0xc,%esp
801041c9:	68 ef 85 10 80       	push   $0x801085ef
801041ce:	e8 bd c1 ff ff       	call   80100390 <panic>
    panic("sleep");
801041d3:	83 ec 0c             	sub    $0xc,%esp
801041d6:	68 e9 85 10 80       	push   $0x801085e9
801041db:	e8 b0 c1 ff ff       	call   80100390 <panic>

801041e0 <wait>:
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	56                   	push   %esi
801041e4:	53                   	push   %ebx
  pushcli();
801041e5:	e8 96 0e 00 00       	call   80105080 <pushcli>
  c = mycpu();
801041ea:	e8 91 f9 ff ff       	call   80103b80 <mycpu>
  p = c->proc;
801041ef:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801041f5:	e8 c6 0e 00 00       	call   801050c0 <popcli>
  acquire(&ptable.lock);
801041fa:	83 ec 0c             	sub    $0xc,%esp
801041fd:	68 40 40 11 80       	push   $0x80114040
80104202:	e8 49 0f 00 00       	call   80105150 <acquire>
80104207:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010420a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010420c:	bb 74 40 11 80       	mov    $0x80114074,%ebx
80104211:	eb 13                	jmp    80104226 <wait+0x46>
80104213:	90                   	nop
80104214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104218:	81 c3 94 00 00 00    	add    $0x94,%ebx
8010421e:	81 fb 74 65 11 80    	cmp    $0x80116574,%ebx
80104224:	73 1e                	jae    80104244 <wait+0x64>
      if(p->parent != curproc)
80104226:	39 73 14             	cmp    %esi,0x14(%ebx)
80104229:	75 ed                	jne    80104218 <wait+0x38>
      if(p->state == ZOMBIE){
8010422b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010422f:	74 37                	je     80104268 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104231:	81 c3 94 00 00 00    	add    $0x94,%ebx
      havekids = 1;
80104237:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010423c:	81 fb 74 65 11 80    	cmp    $0x80116574,%ebx
80104242:	72 e2                	jb     80104226 <wait+0x46>
    if(!havekids || curproc->killed){
80104244:	85 c0                	test   %eax,%eax
80104246:	74 76                	je     801042be <wait+0xde>
80104248:	8b 46 24             	mov    0x24(%esi),%eax
8010424b:	85 c0                	test   %eax,%eax
8010424d:	75 6f                	jne    801042be <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010424f:	83 ec 08             	sub    $0x8,%esp
80104252:	68 40 40 11 80       	push   $0x80114040
80104257:	56                   	push   %esi
80104258:	e8 c3 fe ff ff       	call   80104120 <sleep>
    havekids = 0;
8010425d:	83 c4 10             	add    $0x10,%esp
80104260:	eb a8                	jmp    8010420a <wait+0x2a>
80104262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104268:	83 ec 0c             	sub    $0xc,%esp
8010426b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010426e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104271:	e8 0a e4 ff ff       	call   80102680 <kfree>
        freevm(p->pgdir);
80104276:	5a                   	pop    %edx
80104277:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010427a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104281:	e8 9a 38 00 00       	call   80107b20 <freevm>
        release(&ptable.lock);
80104286:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)
        p->pid = 0;
8010428d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104294:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010429b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010429f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801042a6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801042ad:	e8 5e 0f 00 00       	call   80105210 <release>
        return pid;
801042b2:	83 c4 10             	add    $0x10,%esp
}
801042b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042b8:	89 f0                	mov    %esi,%eax
801042ba:	5b                   	pop    %ebx
801042bb:	5e                   	pop    %esi
801042bc:	5d                   	pop    %ebp
801042bd:	c3                   	ret    
      release(&ptable.lock);
801042be:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801042c1:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801042c6:	68 40 40 11 80       	push   $0x80114040
801042cb:	e8 40 0f 00 00       	call   80105210 <release>
      return -1;
801042d0:	83 c4 10             	add    $0x10,%esp
801042d3:	eb e0                	jmp    801042b5 <wait+0xd5>
801042d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	53                   	push   %ebx
801042e4:	83 ec 10             	sub    $0x10,%esp
801042e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801042ea:	68 40 40 11 80       	push   $0x80114040
801042ef:	e8 5c 0e 00 00       	call   80105150 <acquire>
801042f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042f7:	b8 74 40 11 80       	mov    $0x80114074,%eax
801042fc:	eb 0e                	jmp    8010430c <wakeup+0x2c>
801042fe:	66 90                	xchg   %ax,%ax
80104300:	05 94 00 00 00       	add    $0x94,%eax
80104305:	3d 74 65 11 80       	cmp    $0x80116574,%eax
8010430a:	73 1e                	jae    8010432a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010430c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104310:	75 ee                	jne    80104300 <wakeup+0x20>
80104312:	3b 58 20             	cmp    0x20(%eax),%ebx
80104315:	75 e9                	jne    80104300 <wakeup+0x20>
      p->state = RUNNABLE;
80104317:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010431e:	05 94 00 00 00       	add    $0x94,%eax
80104323:	3d 74 65 11 80       	cmp    $0x80116574,%eax
80104328:	72 e2                	jb     8010430c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010432a:	c7 45 08 40 40 11 80 	movl   $0x80114040,0x8(%ebp)
}
80104331:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104334:	c9                   	leave  
  release(&ptable.lock);
80104335:	e9 d6 0e 00 00       	jmp    80105210 <release>
8010433a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104340 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	53                   	push   %ebx
80104344:	83 ec 10             	sub    $0x10,%esp
80104347:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010434a:	68 40 40 11 80       	push   $0x80114040
8010434f:	e8 fc 0d 00 00       	call   80105150 <acquire>
80104354:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104357:	b8 74 40 11 80       	mov    $0x80114074,%eax
8010435c:	eb 0e                	jmp    8010436c <kill+0x2c>
8010435e:	66 90                	xchg   %ax,%ax
80104360:	05 94 00 00 00       	add    $0x94,%eax
80104365:	3d 74 65 11 80       	cmp    $0x80116574,%eax
8010436a:	73 34                	jae    801043a0 <kill+0x60>
    if(p->pid == pid){
8010436c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010436f:	75 ef                	jne    80104360 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104371:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104375:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010437c:	75 07                	jne    80104385 <kill+0x45>
        p->state = RUNNABLE;
8010437e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104385:	83 ec 0c             	sub    $0xc,%esp
80104388:	68 40 40 11 80       	push   $0x80114040
8010438d:	e8 7e 0e 00 00       	call   80105210 <release>
      return 0;
80104392:	83 c4 10             	add    $0x10,%esp
80104395:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010439a:	c9                   	leave  
8010439b:	c3                   	ret    
8010439c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801043a0:	83 ec 0c             	sub    $0xc,%esp
801043a3:	68 40 40 11 80       	push   $0x80114040
801043a8:	e8 63 0e 00 00       	call   80105210 <release>
  return -1;
801043ad:	83 c4 10             	add    $0x10,%esp
801043b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801043b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043b8:	c9                   	leave  
801043b9:	c3                   	ret    
801043ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043c0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	57                   	push   %edi
801043c4:	56                   	push   %esi
801043c5:	53                   	push   %ebx
801043c6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043c9:	bb 74 40 11 80       	mov    $0x80114074,%ebx
{
801043ce:	83 ec 3c             	sub    $0x3c,%esp
801043d1:	eb 27                	jmp    801043fa <procdump+0x3a>
801043d3:	90                   	nop
801043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801043d8:	83 ec 0c             	sub    $0xc,%esp
801043db:	68 da 8a 10 80       	push   $0x80108ada
801043e0:	e8 7b c2 ff ff       	call   80100660 <cprintf>
801043e5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043e8:	81 c3 94 00 00 00    	add    $0x94,%ebx
801043ee:	81 fb 74 65 11 80    	cmp    $0x80116574,%ebx
801043f4:	0f 83 86 00 00 00    	jae    80104480 <procdump+0xc0>
    if(p->state == UNUSED)
801043fa:	8b 43 0c             	mov    0xc(%ebx),%eax
801043fd:	85 c0                	test   %eax,%eax
801043ff:	74 e7                	je     801043e8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104401:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104404:	ba 00 86 10 80       	mov    $0x80108600,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104409:	77 11                	ja     8010441c <procdump+0x5c>
8010440b:	8b 14 85 fc 87 10 80 	mov    -0x7fef7804(,%eax,4),%edx
      state = "???";
80104412:	b8 00 86 10 80       	mov    $0x80108600,%eax
80104417:	85 d2                	test   %edx,%edx
80104419:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010441c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010441f:	50                   	push   %eax
80104420:	52                   	push   %edx
80104421:	ff 73 10             	pushl  0x10(%ebx)
80104424:	68 04 86 10 80       	push   $0x80108604
80104429:	e8 32 c2 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010442e:	83 c4 10             	add    $0x10,%esp
80104431:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104435:	75 a1                	jne    801043d8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104437:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010443a:	83 ec 08             	sub    $0x8,%esp
8010443d:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104440:	50                   	push   %eax
80104441:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104444:	8b 40 0c             	mov    0xc(%eax),%eax
80104447:	83 c0 08             	add    $0x8,%eax
8010444a:	50                   	push   %eax
8010444b:	e8 e0 0b 00 00       	call   80105030 <getcallerpcs>
80104450:	83 c4 10             	add    $0x10,%esp
80104453:	90                   	nop
80104454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104458:	8b 17                	mov    (%edi),%edx
8010445a:	85 d2                	test   %edx,%edx
8010445c:	0f 84 76 ff ff ff    	je     801043d8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104462:	83 ec 08             	sub    $0x8,%esp
80104465:	83 c7 04             	add    $0x4,%edi
80104468:	52                   	push   %edx
80104469:	68 41 80 10 80       	push   $0x80108041
8010446e:	e8 ed c1 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104473:	83 c4 10             	add    $0x10,%esp
80104476:	39 fe                	cmp    %edi,%esi
80104478:	75 de                	jne    80104458 <procdump+0x98>
8010447a:	e9 59 ff ff ff       	jmp    801043d8 <procdump+0x18>
8010447f:	90                   	nop
  }
}
80104480:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104483:	5b                   	pop    %ebx
80104484:	5e                   	pop    %esi
80104485:	5f                   	pop    %edi
80104486:	5d                   	pop    %ebp
80104487:	c3                   	ret    
80104488:	90                   	nop
80104489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104490 <printProcess>:

void
printProcess(struct proc* p)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 0c             	sub    $0xc,%esp
80104497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  cprintf("name : %s\n", p->name);
8010449a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010449d:	50                   	push   %eax
8010449e:	68 0d 86 10 80       	push   $0x8010860d
801044a3:	e8 b8 c1 ff ff       	call   80100660 <cprintf>
  cprintf("PID : %d\n",p->pid);
801044a8:	58                   	pop    %eax
801044a9:	5a                   	pop    %edx
801044aa:	ff 73 10             	pushl  0x10(%ebx)
801044ad:	68 19 86 10 80       	push   $0x80108619
801044b2:	e8 a9 c1 ff ff       	call   80100660 <cprintf>
  cprintf("PPID : %d\n",p->parent->pid);
801044b7:	59                   	pop    %ecx
801044b8:	58                   	pop    %eax
801044b9:	8b 43 14             	mov    0x14(%ebx),%eax
801044bc:	ff 70 10             	pushl  0x10(%eax)
801044bf:	68 18 86 10 80       	push   $0x80108618
801044c4:	e8 97 c1 ff ff       	call   80100660 <cprintf>
  switch (p->state)
801044c9:	83 c4 10             	add    $0x10,%esp
801044cc:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801044d0:	77 6e                	ja     80104540 <printProcess+0xb0>
801044d2:	8b 43 0c             	mov    0xc(%ebx),%eax
801044d5:	ff 24 85 e4 87 10 80 	jmp    *-0x7fef781c(,%eax,4)
801044dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    case 3:
      cprintf("state : RUNNABLE\n");
      break;
    case 4:
      cprintf("state : RUNNING\n");
801044e0:	c7 45 08 67 86 10 80 	movl   $0x80108667,0x8(%ebp)
      break;
    case 5:
      cprintf("state : ZOMBIE\n");
      break;
  }
}
801044e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044ea:	c9                   	leave  
      cprintf("state : RUNNING\n");
801044eb:	e9 70 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : ZOMBIE\n");
801044f0:	c7 45 08 78 86 10 80 	movl   $0x80108678,0x8(%ebp)
}
801044f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044fa:	c9                   	leave  
      cprintf("state : ZOMBIE\n");
801044fb:	e9 60 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : UNUSED\n");
80104500:	c7 45 08 23 86 10 80 	movl   $0x80108623,0x8(%ebp)
}
80104507:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010450a:	c9                   	leave  
      cprintf("state : UNUSED\n");
8010450b:	e9 50 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : EMBRYO\n");
80104510:	c7 45 08 33 86 10 80 	movl   $0x80108633,0x8(%ebp)
}
80104517:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010451a:	c9                   	leave  
      cprintf("state : EMBRYO\n");
8010451b:	e9 40 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : SLEEPING\n");
80104520:	c7 45 08 43 86 10 80 	movl   $0x80108643,0x8(%ebp)
}
80104527:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010452a:	c9                   	leave  
      cprintf("state : SLEEPING\n");
8010452b:	e9 30 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : RUNNABLE\n");
80104530:	c7 45 08 55 86 10 80 	movl   $0x80108655,0x8(%ebp)
}
80104537:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010453a:	c9                   	leave  
      cprintf("state : RUNNABLE\n");
8010453b:	e9 20 c1 ff ff       	jmp    80100660 <cprintf>
}
80104540:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104543:	c9                   	leave  
80104544:	c3                   	ret    
80104545:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104550 <getprocs>:

int
getprocs(void)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	53                   	push   %ebx
  struct proc* p;
  cprintf("\n-----------------------------\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104554:	bb 74 40 11 80       	mov    $0x80114074,%ebx
{
80104559:	83 ec 10             	sub    $0x10,%esp
  cprintf("\n-----------------------------\n");
8010455c:	68 70 87 10 80       	push   $0x80108770
80104561:	e8 fa c0 ff ff       	call   80100660 <cprintf>
80104566:	83 c4 10             	add    $0x10,%esp
80104569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  { if (p->pid == 0)
80104570:	8b 43 10             	mov    0x10(%ebx),%eax
80104573:	85 c0                	test   %eax,%eax
80104575:	74 18                	je     8010458f <getprocs+0x3f>
        continue;    
    printProcess(p);
80104577:	83 ec 0c             	sub    $0xc,%esp
8010457a:	53                   	push   %ebx
8010457b:	e8 10 ff ff ff       	call   80104490 <printProcess>
    cprintf("\n-----------------------------\n");
80104580:	c7 04 24 70 87 10 80 	movl   $0x80108770,(%esp)
80104587:	e8 d4 c0 ff ff       	call   80100660 <cprintf>
8010458c:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010458f:	81 c3 94 00 00 00    	add    $0x94,%ebx
80104595:	81 fb 74 65 11 80    	cmp    $0x80116574,%ebx
8010459b:	72 d3                	jb     80104570 <getprocs+0x20>
  }
  return 23;
}
8010459d:	b8 17 00 00 00       	mov    $0x17,%eax
801045a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045a5:	c9                   	leave  
801045a6:	c3                   	ret    
801045a7:	89 f6                	mov    %esi,%esi
801045a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045b0 <generate_random>:

int generate_random(int toMod)
{
  int random;
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
801045b0:	a1 c0 6d 11 80       	mov    0x80116dc0,%eax
{
801045b5:	55                   	push   %ebp
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
801045b6:	31 d2                	xor    %edx,%edx
{
801045b8:	89 e5                	mov    %esp,%ebp
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
801045ba:	0f af c0             	imul   %eax,%eax
801045bd:	0f af c0             	imul   %eax,%eax
801045c0:	05 4e 61 bc 00       	add    $0xbc614e,%eax
801045c5:	f7 75 08             	divl   0x8(%ebp)
  return random;
}
801045c8:	5d                   	pop    %ebp
801045c9:	89 d0                	mov    %edx,%eax
801045cb:	c3                   	ret    
801045cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045d0 <lotterySched>:

struct proc*
lotterySched(void){
801045d0:	55                   	push   %ebp
  int sum_lotteries = 1;
  int random_ticket = 0;
  int isLotterySelected = 0;
  struct proc *highLottery_ticket = 0; //process with highest lottery ticket
  
  sum_lotteries = 1;
801045d1:	b9 01 00 00 00       	mov    $0x1,%ecx
  isLotterySelected = 0;
  // Loop over process table looking for process to run.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045d6:	b8 74 40 11 80       	mov    $0x80114074,%eax
lotterySched(void){
801045db:	89 e5                	mov    %esp,%ebp
801045dd:	57                   	push   %edi
801045de:	56                   	push   %esi
801045df:	53                   	push   %ebx
    if(p->state != RUNNABLE || p->schedQueue != LOTTERY)
801045e0:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801045e4:	75 0c                	jne    801045f2 <lotterySched+0x22>
801045e6:	83 b8 80 00 00 00 02 	cmpl   $0x2,0x80(%eax)
801045ed:	75 03                	jne    801045f2 <lotterySched+0x22>
      continue;
    sum_lotteries += p->lottery_ticket;
801045ef:	03 48 7c             	add    0x7c(%eax),%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045f2:	05 94 00 00 00       	add    $0x94,%eax
801045f7:	3d 74 65 11 80       	cmp    $0x80116574,%eax
801045fc:	72 e2                	jb     801045e0 <lotterySched+0x10>
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
801045fe:	a1 c0 6d 11 80       	mov    0x80116dc0,%eax
80104603:	31 d2                	xor    %edx,%edx
  struct proc *highLottery_ticket = 0; //process with highest lottery ticket
80104605:	31 f6                	xor    %esi,%esi
  isLotterySelected = 0;
80104607:	31 db                	xor    %ebx,%ebx
80104609:	bf 02 00 00 00       	mov    $0x2,%edi
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
8010460e:	0f af c0             	imul   %eax,%eax
80104611:	0f af c0             	imul   %eax,%eax
80104614:	05 4e 61 bc 00       	add    $0xbc614e,%eax
80104619:	f7 f1                	div    %ecx
  }

  random_ticket = generate_random(sum_lotteries);
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010461b:	b9 74 40 11 80       	mov    $0x80114074,%ecx
80104620:	eb 2c                	jmp    8010464e <lotterySched+0x7e>
80104622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104628:	83 fb 01             	cmp    $0x1,%ebx
8010462b:	0f 94 c0             	sete   %al
      highLottery_ticket = p;
      isLotterySelected = 1;
      
    }

    if(random_ticket <= 0 && isLotterySelected == 1)
8010462e:	85 d2                	test   %edx,%edx
80104630:	7f 0e                	jg     80104640 <lotterySched+0x70>
80104632:	84 c0                	test   %al,%al
80104634:	0f 45 f1             	cmovne %ecx,%esi
80104637:	0f 45 df             	cmovne %edi,%ebx
8010463a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104640:	81 c1 94 00 00 00    	add    $0x94,%ecx
80104646:	81 f9 74 65 11 80    	cmp    $0x80116574,%ecx
8010464c:	73 2a                	jae    80104678 <lotterySched+0xa8>
    if(p->state != RUNNABLE || p->schedQueue != LOTTERY)
8010464e:	83 79 0c 03          	cmpl   $0x3,0xc(%ecx)
80104652:	75 ec                	jne    80104640 <lotterySched+0x70>
80104654:	83 b9 80 00 00 00 02 	cmpl   $0x2,0x80(%ecx)
8010465b:	75 e3                	jne    80104640 <lotterySched+0x70>
    random_ticket -= p->lottery_ticket;
8010465d:	2b 51 7c             	sub    0x7c(%ecx),%edx
    if(!isLotterySelected) {
80104660:	85 db                	test   %ebx,%ebx
80104662:	75 c4                	jne    80104628 <lotterySched+0x58>
80104664:	89 ce                	mov    %ecx,%esi
80104666:	b8 01 00 00 00       	mov    $0x1,%eax
      isLotterySelected = 1;
8010466b:	bb 01 00 00 00       	mov    $0x1,%ebx
80104670:	eb bc                	jmp    8010462e <lotterySched+0x5e>
80104672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }
    if(isLotterySelected != 0) {
      return highLottery_ticket;
    }
    return 0;  
80104678:	85 db                	test   %ebx,%ebx
8010467a:	b8 00 00 00 00       	mov    $0x0,%eax
8010467f:	0f 44 f0             	cmove  %eax,%esi
}
80104682:	5b                   	pop    %ebx
80104683:	89 f0                	mov    %esi,%eax
80104685:	5e                   	pop    %esi
80104686:	5f                   	pop    %edi
80104687:	5d                   	pop    %ebp
80104688:	c3                   	ret    
80104689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104690 <prioritySched>:


struct proc*
prioritySched(void)
{
80104690:	55                   	push   %ebp
  struct proc *p;
  
 
  int priorityProcessSelected = 0;
  struct proc *highPriority = 0; //process with highest priority
80104691:	31 c0                	xor    %eax,%eax
  // Enable interrupts on this processor.
  priorityProcessSelected = 0;
80104693:	31 c9                	xor    %ecx,%ecx

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104695:	ba 74 40 11 80       	mov    $0x80114074,%edx
{
8010469a:	89 e5                	mov    %esp,%ebp
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state != RUNNABLE || p->schedQueue != PRIORITY)
801046a0:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
801046a4:	75 22                	jne    801046c8 <prioritySched+0x38>
801046a6:	83 ba 80 00 00 00 00 	cmpl   $0x0,0x80(%edx)
801046ad:	75 19                	jne    801046c8 <prioritySched+0x38>
      continue;

    if(!priorityProcessSelected)
801046af:	85 c9                	test   %ecx,%ecx
    {
      highPriority = p;
      priorityProcessSelected = 1;
    }
    if(highPriority->priority > p->priority )
801046b1:	8b 8a 84 00 00 00    	mov    0x84(%edx),%ecx
    if(!priorityProcessSelected)
801046b7:	0f 44 c2             	cmove  %edx,%eax
    if(highPriority->priority > p->priority )
801046ba:	39 88 84 00 00 00    	cmp    %ecx,0x84(%eax)
801046c0:	b9 01 00 00 00       	mov    $0x1,%ecx
801046c5:	0f 4f c2             	cmovg  %edx,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046c8:	81 c2 94 00 00 00    	add    $0x94,%edx
801046ce:	81 fa 74 65 11 80    	cmp    $0x80116574,%edx
801046d4:	72 ca                	jb     801046a0 <prioritySched+0x10>
  {
    
    return highPriority;
  }
  
  return 0;
801046d6:	85 c9                	test   %ecx,%ecx
801046d8:	ba 00 00 00 00       	mov    $0x0,%edx
801046dd:	0f 44 c2             	cmove  %edx,%eax

}
801046e0:	5d                   	pop    %ebp
801046e1:	c3                   	ret    
801046e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046f0 <SJFSched>:

// scheduling algorithm
struct proc*
SJFSched(void)
{
801046f0:	55                   	push   %ebp
  struct proc *p;
 
  int shortestProcessSelected = 0;
  struct proc *shortestTime = 0; //process that finish earlier
801046f1:	31 c0                	xor    %eax,%eax
  
  
    shortestProcessSelected = 0;
801046f3:	31 c9                	xor    %ecx,%ecx

      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046f5:	ba 74 40 11 80       	mov    $0x80114074,%edx
{
801046fa:	89 e5                	mov    %esp,%ebp
801046fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(p->state != RUNNABLE || p->schedQueue != SJF)
80104700:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80104704:	75 22                	jne    80104728 <SJFSched+0x38>
80104706:	83 ba 80 00 00 00 01 	cmpl   $0x1,0x80(%edx)
8010470d:	75 19                	jne    80104728 <SJFSched+0x38>
          continue;
        if(!shortestProcessSelected){
8010470f:	85 c9                	test   %ecx,%ecx
          shortestTime = p;
          shortestProcessSelected = 1;
        }
        if(shortestTime->burst_time > p->burst_time)
80104711:	8b 8a 88 00 00 00    	mov    0x88(%edx),%ecx
        if(!shortestProcessSelected){
80104717:	0f 44 c2             	cmove  %edx,%eax
        if(shortestTime->burst_time > p->burst_time)
8010471a:	39 88 88 00 00 00    	cmp    %ecx,0x88(%eax)
80104720:	b9 01 00 00 00       	mov    $0x1,%ecx
80104725:	0f 4f c2             	cmovg  %edx,%eax
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104728:	81 c2 94 00 00 00    	add    $0x94,%edx
8010472e:	81 fa 74 65 11 80    	cmp    $0x80116574,%edx
80104734:	72 ca                	jb     80104700 <SJFSched+0x10>
    }
    if(shortestProcessSelected)
    {
      return shortestTime;
    }
  return 0;
80104736:	85 c9                	test   %ecx,%ecx
80104738:	ba 00 00 00 00       	mov    $0x0,%edx
8010473d:	0f 44 c2             	cmove  %edx,%eax
}
80104740:	5d                   	pop    %ebp
80104741:	c3                   	ret    
80104742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104750 <find_and_set_priority>:

void find_and_set_priority(int priority , int pid)
{
80104750:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104751:	b8 74 40 11 80       	mov    $0x80114074,%eax
{
80104756:	89 e5                	mov    %esp,%ebp
80104758:	8b 55 0c             	mov    0xc(%ebp),%edx
8010475b:	eb 0f                	jmp    8010476c <find_and_set_priority+0x1c>
8010475d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104760:	05 94 00 00 00       	add    $0x94,%eax
80104765:	3d 74 65 11 80       	cmp    $0x80116574,%eax
8010476a:	73 0e                	jae    8010477a <find_and_set_priority+0x2a>
    if(pid == p->pid)
8010476c:	39 50 10             	cmp    %edx,0x10(%eax)
8010476f:	75 ef                	jne    80104760 <find_and_set_priority+0x10>
    {
      p -> priority = priority;
80104771:	8b 55 08             	mov    0x8(%ebp),%edx
80104774:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
      break;
    }
  }
}
8010477a:	5d                   	pop    %ebp
8010477b:	c3                   	ret    
8010477c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104780 <find_and_set_lottery_ticket>:

void find_and_set_lottery_ticket(int lottery_ticket , int pid){
80104780:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104781:	b8 74 40 11 80       	mov    $0x80114074,%eax
void find_and_set_lottery_ticket(int lottery_ticket , int pid){
80104786:	89 e5                	mov    %esp,%ebp
80104788:	8b 55 0c             	mov    0xc(%ebp),%edx
8010478b:	eb 0f                	jmp    8010479c <find_and_set_lottery_ticket+0x1c>
8010478d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104790:	05 94 00 00 00       	add    $0x94,%eax
80104795:	3d 74 65 11 80       	cmp    $0x80116574,%eax
8010479a:	73 0b                	jae    801047a7 <find_and_set_lottery_ticket+0x27>
    if(pid == p->pid)
8010479c:	39 50 10             	cmp    %edx,0x10(%eax)
8010479f:	75 ef                	jne    80104790 <find_and_set_lottery_ticket+0x10>
    {
      p -> lottery_ticket = lottery_ticket;
801047a1:	8b 55 08             	mov    0x8(%ebp),%edx
801047a4:	89 50 7c             	mov    %edx,0x7c(%eax)
      break;
    }
  }
}
801047a7:	5d                   	pop    %ebp
801047a8:	c3                   	ret    
801047a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047b0 <find_and_set_sched_queue>:

void 
find_and_set_sched_queue(int qeue_number, int pid)
{
801047b0:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047b1:	b8 74 40 11 80       	mov    $0x80114074,%eax
{
801047b6:	89 e5                	mov    %esp,%ebp
801047b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801047bb:	eb 0f                	jmp    801047cc <find_and_set_sched_queue+0x1c>
801047bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047c0:	05 94 00 00 00       	add    $0x94,%eax
801047c5:	3d 74 65 11 80       	cmp    $0x80116574,%eax
801047ca:	73 0e                	jae    801047da <find_and_set_sched_queue+0x2a>
    if(pid == p->pid)
801047cc:	39 50 10             	cmp    %edx,0x10(%eax)
801047cf:	75 ef                	jne    801047c0 <find_and_set_sched_queue+0x10>
    {
      p -> schedQueue = qeue_number;
801047d1:	8b 55 08             	mov    0x8(%ebp),%edx
801047d4:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
      break;
    }
  }
}
801047da:	5d                   	pop    %ebp
801047db:	c3                   	ret    
801047dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047e0 <find_and_set_burst_time>:

void 
find_and_set_burst_time(int burst_time, int pid)
{
801047e0:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047e1:	b8 74 40 11 80       	mov    $0x80114074,%eax
{
801047e6:	89 e5                	mov    %esp,%ebp
801047e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801047eb:	eb 0f                	jmp    801047fc <find_and_set_burst_time+0x1c>
801047ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047f0:	05 94 00 00 00       	add    $0x94,%eax
801047f5:	3d 74 65 11 80       	cmp    $0x80116574,%eax
801047fa:	73 0e                	jae    8010480a <find_and_set_burst_time+0x2a>
    if(pid == p->pid)
801047fc:	39 50 10             	cmp    %edx,0x10(%eax)
801047ff:	75 ef                	jne    801047f0 <find_and_set_burst_time+0x10>
    {
      p -> burst_time = burst_time;
80104801:	8b 55 08             	mov    0x8(%ebp),%edx
80104804:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
      break;
    }
  }
}
8010480a:	5d                   	pop    %ebp
8010480b:	c3                   	ret    
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104810 <print_state>:

char* print_state(int state){
80104810:	55                   	push   %ebp
  if(state == 0){
    return "UNUSED";
80104811:	b8 88 86 10 80       	mov    $0x80108688,%eax
char* print_state(int state){
80104816:	89 e5                	mov    %esp,%ebp
80104818:	8b 55 08             	mov    0x8(%ebp),%edx
  if(state == 0){
8010481b:	85 d2                	test   %edx,%edx
8010481d:	74 38                	je     80104857 <print_state+0x47>
  }else if(state == 1){
8010481f:	83 fa 01             	cmp    $0x1,%edx
    return "EMBRYO";
80104822:	b8 8f 86 10 80       	mov    $0x8010868f,%eax
  }else if(state == 1){
80104827:	74 2e                	je     80104857 <print_state+0x47>
  }else if(state == 2){
80104829:	83 fa 02             	cmp    $0x2,%edx
    return "SLEEPING";
8010482c:	b8 96 86 10 80       	mov    $0x80108696,%eax
  }else if(state == 2){
80104831:	74 24                	je     80104857 <print_state+0x47>
  }else if(state == 3){
80104833:	83 fa 03             	cmp    $0x3,%edx
    return "RUNNABLE";
80104836:	b8 9f 86 10 80       	mov    $0x8010869f,%eax
  }else if(state == 3){
8010483b:	74 1a                	je     80104857 <print_state+0x47>
  }else if(state == 4){
8010483d:	83 fa 04             	cmp    $0x4,%edx
    return "RUNNING";
80104840:	b8 af 86 10 80       	mov    $0x801086af,%eax
  }else if(state == 4){
80104845:	74 10                	je     80104857 <print_state+0x47>
  }else if(state == 5){
    return "ZOMBIE";
  }else{
    return "";
80104847:	83 fa 05             	cmp    $0x5,%edx
8010484a:	b8 a8 86 10 80       	mov    $0x801086a8,%eax
8010484f:	ba db 8a 10 80       	mov    $0x80108adb,%edx
80104854:	0f 45 c2             	cmovne %edx,%eax
  }
}
80104857:	5d                   	pop    %ebp
80104858:	c3                   	ret    
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104860 <int_size>:

int int_size(int i){
80104860:	55                   	push   %ebp
    if( i >= 1000000000) return 10;
80104861:	b8 0a 00 00 00       	mov    $0xa,%eax
int int_size(int i){
80104866:	89 e5                	mov    %esp,%ebp
80104868:	8b 55 08             	mov    0x8(%ebp),%edx
    if( i >= 1000000000) return 10;
8010486b:	81 fa ff c9 9a 3b    	cmp    $0x3b9ac9ff,%edx
80104871:	7f 63                	jg     801048d6 <int_size+0x76>
    if( i >= 100000000)  return 9;
80104873:	81 fa ff e0 f5 05    	cmp    $0x5f5e0ff,%edx
80104879:	b8 09 00 00 00       	mov    $0x9,%eax
8010487e:	7f 56                	jg     801048d6 <int_size+0x76>
    if( i >= 10000000)   return 8;
80104880:	81 fa 7f 96 98 00    	cmp    $0x98967f,%edx
80104886:	b8 08 00 00 00       	mov    $0x8,%eax
8010488b:	7f 49                	jg     801048d6 <int_size+0x76>
    if( i >= 1000000)    return 7;
8010488d:	81 fa 3f 42 0f 00    	cmp    $0xf423f,%edx
80104893:	b8 07 00 00 00       	mov    $0x7,%eax
80104898:	7f 3c                	jg     801048d6 <int_size+0x76>
    if( i >= 100000)     return 6;
8010489a:	81 fa 9f 86 01 00    	cmp    $0x1869f,%edx
801048a0:	b8 06 00 00 00       	mov    $0x6,%eax
801048a5:	7f 2f                	jg     801048d6 <int_size+0x76>
    if( i >= 10000)      return 5;
801048a7:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
801048ad:	b8 05 00 00 00       	mov    $0x5,%eax
801048b2:	7f 22                	jg     801048d6 <int_size+0x76>
    if( i >= 1000)       return 4;
801048b4:	81 fa e7 03 00 00    	cmp    $0x3e7,%edx
801048ba:	b8 04 00 00 00       	mov    $0x4,%eax
801048bf:	7f 15                	jg     801048d6 <int_size+0x76>
    if( i >= 100)        return 3;
801048c1:	83 fa 63             	cmp    $0x63,%edx
801048c4:	b8 03 00 00 00       	mov    $0x3,%eax
801048c9:	7f 0b                	jg     801048d6 <int_size+0x76>
    if( i >= 10)         return 2;
                        return 1;
801048cb:	31 c0                	xor    %eax,%eax
801048cd:	83 fa 09             	cmp    $0x9,%edx
801048d0:	0f 9f c0             	setg   %al
801048d3:	83 c0 01             	add    $0x1,%eax
}
801048d6:	5d                   	pop    %ebp
801048d7:	c3                   	ret    
801048d8:	90                   	nop
801048d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801048e0 <find_queue_name>:

char* find_queue_name(int queue){
801048e0:	55                   	push   %ebp
  if(queue == 1){
    return "PRIORITY";
801048e1:	b8 b7 86 10 80       	mov    $0x801086b7,%eax
char* find_queue_name(int queue){
801048e6:	89 e5                	mov    %esp,%ebp
801048e8:	8b 55 08             	mov    0x8(%ebp),%edx
  if(queue == 1){
801048eb:	83 fa 01             	cmp    $0x1,%edx
801048ee:	74 1a                	je     8010490a <find_queue_name+0x2a>
  }else if(queue == 2){
801048f0:	83 fa 02             	cmp    $0x2,%edx
    return "SJF";
801048f3:	b8 c8 86 10 80       	mov    $0x801086c8,%eax
  }else if(queue == 2){
801048f8:	74 10                	je     8010490a <find_queue_name+0x2a>
  }else if(queue == 3){
    return "LOTTERY";
  }else{
    return "";
801048fa:	83 fa 03             	cmp    $0x3,%edx
801048fd:	b8 c0 86 10 80       	mov    $0x801086c0,%eax
80104902:	ba db 8a 10 80       	mov    $0x80108adb,%edx
80104907:	0f 45 c2             	cmovne %edx,%eax
  }
}
8010490a:	5d                   	pop    %ebp
8010490b:	c3                   	ret    
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <show_all_processes_scheduling>:

void
show_all_processes_scheduling()
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	57                   	push   %edi
80104914:	56                   	push   %esi
80104915:	53                   	push   %ebx
  struct proc *p;
  int name_spaces = 0;
80104916:	31 ff                	xor    %edi,%edi
  int i = 0 ;
  char* state;
  char* queue_name;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104918:	bb 74 40 11 80       	mov    $0x80114074,%ebx
{
8010491d:	83 ec 1c             	sub    $0x1c,%esp
80104920:	eb 14                	jmp    80104936 <show_all_processes_scheduling+0x26>
80104922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104928:	81 c3 94 00 00 00    	add    $0x94,%ebx
8010492e:	81 fb 74 65 11 80    	cmp    $0x80116574,%ebx
80104934:	73 36                	jae    8010496c <show_all_processes_scheduling+0x5c>
    if(p->pid == 0)
80104936:	8b 73 10             	mov    0x10(%ebx),%esi
80104939:	85 f6                	test   %esi,%esi
8010493b:	74 eb                	je     80104928 <show_all_processes_scheduling+0x18>
8010493d:	8d 73 6c             	lea    0x6c(%ebx),%esi
      continue;
    if( name_spaces < strlen(p->name))
80104940:	83 ec 0c             	sub    $0xc,%esp
80104943:	56                   	push   %esi
80104944:	e8 37 0b 00 00       	call   80105480 <strlen>
80104949:	83 c4 10             	add    $0x10,%esp
8010494c:	39 f8                	cmp    %edi,%eax
8010494e:	7e d8                	jle    80104928 <show_all_processes_scheduling+0x18>
      name_spaces = strlen(p->name);
80104950:	83 ec 0c             	sub    $0xc,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104953:	81 c3 94 00 00 00    	add    $0x94,%ebx
      name_spaces = strlen(p->name);
80104959:	56                   	push   %esi
8010495a:	e8 21 0b 00 00       	call   80105480 <strlen>
8010495f:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104962:	81 fb 74 65 11 80    	cmp    $0x80116574,%ebx
      name_spaces = strlen(p->name);
80104968:	89 c7                	mov    %eax,%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010496a:	72 ca                	jb     80104936 <show_all_processes_scheduling+0x26>
  }

  cprintf("name");
8010496c:	83 ec 0c             	sub    $0xc,%esp
8010496f:	89 7d e0             	mov    %edi,-0x20(%ebp)
80104972:	89 fe                	mov    %edi,%esi
80104974:	68 cc 86 10 80       	push   $0x801086cc
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
80104979:	31 db                	xor    %ebx,%ebx
  cprintf("name");
8010497b:	e8 e0 bc ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
80104980:	83 c4 10             	add    $0x10,%esp
80104983:	eb 16                	jmp    8010499b <show_all_processes_scheduling+0x8b>
80104985:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf(" ");
80104988:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
8010498b:	83 c3 01             	add    $0x1,%ebx
    cprintf(" ");
8010498e:	68 3c 87 10 80       	push   $0x8010873c
80104993:	e8 c8 bc ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
80104998:	83 c4 10             	add    $0x10,%esp
8010499b:	83 ec 0c             	sub    $0xc,%esp
8010499e:	68 cc 86 10 80       	push   $0x801086cc
801049a3:	e8 d8 0a 00 00       	call   80105480 <strlen>
801049a8:	89 f2                	mov    %esi,%edx
801049aa:	83 c4 10             	add    $0x10,%esp
801049ad:	29 c2                	sub    %eax,%edx
801049af:	89 d0                	mov    %edx,%eax
801049b1:	83 c0 02             	add    $0x2,%eax
801049b4:	39 d8                	cmp    %ebx,%eax
801049b6:	7d d0                	jge    80104988 <show_all_processes_scheduling+0x78>
  
  cprintf("pid");
801049b8:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0 ; i < 4; i++)
    cprintf(" ");
  cprintf("state");
801049bb:	bb 06 00 00 00       	mov    $0x6,%ebx
  cprintf("pid");
801049c0:	68 d1 86 10 80       	push   $0x801086d1
801049c5:	e8 96 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
801049ca:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
801049d1:	e8 8a bc ff ff       	call   80100660 <cprintf>
801049d6:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
801049dd:	e8 7e bc ff ff       	call   80100660 <cprintf>
801049e2:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
801049e9:	e8 72 bc ff ff       	call   80100660 <cprintf>
801049ee:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
801049f5:	e8 66 bc ff ff       	call   80100660 <cprintf>
  cprintf("state");
801049fa:	c7 04 24 d5 86 10 80 	movl   $0x801086d5,(%esp)
80104a01:	e8 5a bc ff ff       	call   80100660 <cprintf>
80104a06:	83 c4 10             	add    $0x10,%esp
80104a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0 ; i < 6; i++)
    cprintf(" ");
80104a10:	83 ec 0c             	sub    $0xc,%esp
80104a13:	68 3c 87 10 80       	push   $0x8010873c
80104a18:	e8 43 bc ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < 6; i++)
80104a1d:	83 c4 10             	add    $0x10,%esp
80104a20:	83 eb 01             	sub    $0x1,%ebx
80104a23:	75 eb                	jne    80104a10 <show_all_processes_scheduling+0x100>
  cprintf("queue");
80104a25:	83 ec 0c             	sub    $0xc,%esp
  cprintf("createTime");
  for(i = 0 ; i < 2; i++)
    cprintf(" ");
  cprintf("number\n");
  cprintf("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a28:	bf 74 40 11 80       	mov    $0x80114074,%edi
  cprintf("queue");
80104a2d:	68 db 86 10 80       	push   $0x801086db
80104a32:	e8 29 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104a37:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104a3e:	e8 1d bc ff ff       	call   80100660 <cprintf>
80104a43:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104a4a:	e8 11 bc ff ff       	call   80100660 <cprintf>
80104a4f:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104a56:	e8 05 bc ff ff       	call   80100660 <cprintf>
80104a5b:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104a62:	e8 f9 bb ff ff       	call   80100660 <cprintf>
80104a67:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104a6e:	e8 ed bb ff ff       	call   80100660 <cprintf>
  cprintf("priority");
80104a73:	c7 04 24 e1 86 10 80 	movl   $0x801086e1,(%esp)
80104a7a:	e8 e1 bb ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104a7f:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104a86:	e8 d5 bb ff ff       	call   80100660 <cprintf>
80104a8b:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104a92:	e8 c9 bb ff ff       	call   80100660 <cprintf>
80104a97:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104a9e:	e8 bd bb ff ff       	call   80100660 <cprintf>
  cprintf("lottery");
80104aa3:	c7 04 24 ea 86 10 80 	movl   $0x801086ea,(%esp)
80104aaa:	e8 b1 bb ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104aaf:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104ab6:	e8 a5 bb ff ff       	call   80100660 <cprintf>
80104abb:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104ac2:	e8 99 bb ff ff       	call   80100660 <cprintf>
80104ac7:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104ace:	e8 8d bb ff ff       	call   80100660 <cprintf>
  cprintf("burstTime");
80104ad3:	c7 04 24 f2 86 10 80 	movl   $0x801086f2,(%esp)
80104ada:	e8 81 bb ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104adf:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104ae6:	e8 75 bb ff ff       	call   80100660 <cprintf>
80104aeb:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104af2:	e8 69 bb ff ff       	call   80100660 <cprintf>
80104af7:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104afe:	e8 5d bb ff ff       	call   80100660 <cprintf>
  cprintf("createTime");
80104b03:	c7 04 24 fc 86 10 80 	movl   $0x801086fc,(%esp)
80104b0a:	e8 51 bb ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104b0f:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104b16:	e8 45 bb ff ff       	call   80100660 <cprintf>
80104b1b:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
80104b22:	e8 39 bb ff ff       	call   80100660 <cprintf>
  cprintf("number\n");
80104b27:	c7 04 24 07 87 10 80 	movl   $0x80108707,(%esp)
80104b2e:	e8 2d bb ff ff       	call   80100660 <cprintf>
  cprintf("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n");
80104b33:	c7 04 24 90 87 10 80 	movl   $0x80108790,(%esp)
80104b3a:	e8 21 bb ff ff       	call   80100660 <cprintf>
80104b3f:	83 c4 10             	add    $0x10,%esp
80104b42:	eb 16                	jmp    80104b5a <show_all_processes_scheduling+0x24a>
80104b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b48:	81 c7 94 00 00 00    	add    $0x94,%edi
80104b4e:	81 ff 74 65 11 80    	cmp    $0x80116574,%edi
80104b54:	0f 83 d6 02 00 00    	jae    80104e30 <show_all_processes_scheduling+0x520>
    if(p->pid == 0)
80104b5a:	8b 5f 10             	mov    0x10(%edi),%ebx
80104b5d:	85 db                	test   %ebx,%ebx
80104b5f:	74 e7                	je     80104b48 <show_all_processes_scheduling+0x238>
80104b61:	8d 77 6c             	lea    0x6c(%edi),%esi
      continue;
    cprintf("%s", p->name);
80104b64:	83 ec 08             	sub    $0x8,%esp
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104b67:	31 db                	xor    %ebx,%ebx
    cprintf("%s", p->name);
80104b69:	56                   	push   %esi
80104b6a:	68 0a 86 10 80       	push   $0x8010860a
80104b6f:	e8 ec ba ff ff       	call   80100660 <cprintf>
80104b74:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104b77:	83 c4 10             	add    $0x10,%esp
80104b7a:	8b 7d e0             	mov    -0x20(%ebp),%edi
80104b7d:	eb 14                	jmp    80104b93 <show_all_processes_scheduling+0x283>
80104b7f:	90                   	nop
      cprintf(" ");
80104b80:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104b83:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104b86:	68 3c 87 10 80       	push   $0x8010873c
80104b8b:	e8 d0 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104b90:	83 c4 10             	add    $0x10,%esp
80104b93:	83 ec 0c             	sub    $0xc,%esp
80104b96:	56                   	push   %esi
80104b97:	e8 e4 08 00 00       	call   80105480 <strlen>
80104b9c:	89 fa                	mov    %edi,%edx
80104b9e:	83 c4 10             	add    $0x10,%esp
80104ba1:	29 c2                	sub    %eax,%edx
80104ba3:	89 d0                	mov    %edx,%eax
80104ba5:	83 c0 03             	add    $0x3,%eax
80104ba8:	39 d8                	cmp    %ebx,%eax
80104baa:	7d d4                	jge    80104b80 <show_all_processes_scheduling+0x270>
80104bac:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    cprintf("%d", p->pid);
80104baf:	83 ec 08             	sub    $0x8,%esp
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104bb2:	31 db                	xor    %ebx,%ebx
    cprintf("%d", p->pid);
80104bb4:	ff 77 10             	pushl  0x10(%edi)
80104bb7:	68 0f 87 10 80       	push   $0x8010870f
80104bbc:	e8 9f ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104bc1:	83 c4 10             	add    $0x10,%esp
80104bc4:	eb 1d                	jmp    80104be3 <show_all_processes_scheduling+0x2d3>
80104bc6:	8d 76 00             	lea    0x0(%esi),%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      cprintf(" ");
80104bd0:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104bd3:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104bd6:	68 3c 87 10 80       	push   $0x8010873c
80104bdb:	e8 80 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104be0:	83 c4 10             	add    $0x10,%esp
80104be3:	83 ec 0c             	sub    $0xc,%esp
80104be6:	ff 77 10             	pushl  0x10(%edi)
80104be9:	e8 72 fc ff ff       	call   80104860 <int_size>
80104bee:	b9 06 00 00 00       	mov    $0x6,%ecx
80104bf3:	83 c4 10             	add    $0x10,%esp
80104bf6:	29 c1                	sub    %eax,%ecx
80104bf8:	39 d9                	cmp    %ebx,%ecx
80104bfa:	7f d4                	jg     80104bd0 <show_all_processes_scheduling+0x2c0>
    state = print_state(p->state);
80104bfc:	83 ec 0c             	sub    $0xc,%esp
80104bff:	ff 77 0c             	pushl  0xc(%edi)
    cprintf("%s" , state);
    for(i = 0 ; i < 11 - strlen(state); i++)
80104c02:	31 db                	xor    %ebx,%ebx
    state = print_state(p->state);
80104c04:	e8 07 fc ff ff       	call   80104810 <print_state>
80104c09:	5a                   	pop    %edx
80104c0a:	59                   	pop    %ecx
    cprintf("%s" , state);
80104c0b:	50                   	push   %eax
80104c0c:	68 0a 86 10 80       	push   $0x8010860a
    state = print_state(p->state);
80104c11:	89 c6                	mov    %eax,%esi
    cprintf("%s" , state);
80104c13:	e8 48 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 11 - strlen(state); i++)
80104c18:	83 c4 10             	add    $0x10,%esp
80104c1b:	eb 16                	jmp    80104c33 <show_all_processes_scheduling+0x323>
80104c1d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf(" ");
80104c20:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 11 - strlen(state); i++)
80104c23:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104c26:	68 3c 87 10 80       	push   $0x8010873c
80104c2b:	e8 30 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 11 - strlen(state); i++)
80104c30:	83 c4 10             	add    $0x10,%esp
80104c33:	83 ec 0c             	sub    $0xc,%esp
80104c36:	56                   	push   %esi
80104c37:	e8 44 08 00 00       	call   80105480 <strlen>
80104c3c:	ba 0b 00 00 00       	mov    $0xb,%edx
80104c41:	83 c4 10             	add    $0x10,%esp
80104c44:	29 c2                	sub    %eax,%edx
80104c46:	39 da                	cmp    %ebx,%edx
80104c48:	7f d6                	jg     80104c20 <show_all_processes_scheduling+0x310>
    queue_name =  find_queue_name(p->schedQueue);
80104c4a:	8b 87 80 00 00 00    	mov    0x80(%edi),%eax
    return "PRIORITY";
80104c50:	be b7 86 10 80       	mov    $0x801086b7,%esi
  if(queue == 1){
80104c55:	83 f8 01             	cmp    $0x1,%eax
80104c58:	74 1a                	je     80104c74 <show_all_processes_scheduling+0x364>
  }else if(queue == 2){
80104c5a:	83 f8 02             	cmp    $0x2,%eax
    return "SJF";
80104c5d:	be c8 86 10 80       	mov    $0x801086c8,%esi
  }else if(queue == 2){
80104c62:	74 10                	je     80104c74 <show_all_processes_scheduling+0x364>
    return "";
80104c64:	83 f8 03             	cmp    $0x3,%eax
80104c67:	be c0 86 10 80       	mov    $0x801086c0,%esi
80104c6c:	b8 db 8a 10 80       	mov    $0x80108adb,%eax
80104c71:	0f 45 f0             	cmovne %eax,%esi
    cprintf("%s ", queue_name);
80104c74:	83 ec 08             	sub    $0x8,%esp
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104c77:	31 db                	xor    %ebx,%ebx
    cprintf("%s ", queue_name);
80104c79:	56                   	push   %esi
80104c7a:	68 12 87 10 80       	push   $0x80108712
80104c7f:	e8 dc b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104c84:	83 c4 10             	add    $0x10,%esp
80104c87:	eb 1a                	jmp    80104ca3 <show_all_processes_scheduling+0x393>
80104c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104c90:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104c93:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104c96:	68 3c 87 10 80       	push   $0x8010873c
80104c9b:	e8 c0 b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104ca0:	83 c4 10             	add    $0x10,%esp
80104ca3:	83 ec 0c             	sub    $0xc,%esp
80104ca6:	56                   	push   %esi
80104ca7:	e8 d4 07 00 00       	call   80105480 <strlen>
80104cac:	b9 0c 00 00 00       	mov    $0xc,%ecx
80104cb1:	83 c4 10             	add    $0x10,%esp
80104cb4:	29 c1                	sub    %eax,%ecx
80104cb6:	39 d9                	cmp    %ebx,%ecx
80104cb8:	7f d6                	jg     80104c90 <show_all_processes_scheduling+0x380>
    cprintf("%d  ", p->priority);
80104cba:	83 ec 08             	sub    $0x8,%esp
80104cbd:	ff b7 84 00 00 00    	pushl  0x84(%edi)
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104cc3:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->priority);
80104cc5:	68 16 87 10 80       	push   $0x80108716
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104cca:	be 08 00 00 00       	mov    $0x8,%esi
    cprintf("%d  ", p->priority);
80104ccf:	e8 8c b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104cd4:	83 c4 10             	add    $0x10,%esp
80104cd7:	eb 1a                	jmp    80104cf3 <show_all_processes_scheduling+0x3e3>
80104cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104ce0:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104ce3:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104ce6:	68 3c 87 10 80       	push   $0x8010873c
80104ceb:	e8 70 b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104cf0:	83 c4 10             	add    $0x10,%esp
80104cf3:	83 ec 0c             	sub    $0xc,%esp
80104cf6:	ff b7 84 00 00 00    	pushl  0x84(%edi)
80104cfc:	e8 5f fb ff ff       	call   80104860 <int_size>
80104d01:	89 f2                	mov    %esi,%edx
80104d03:	83 c4 10             	add    $0x10,%esp
80104d06:	29 c2                	sub    %eax,%edx
80104d08:	39 da                	cmp    %ebx,%edx
80104d0a:	7f d4                	jg     80104ce0 <show_all_processes_scheduling+0x3d0>
    cprintf("%d  ", p->lottery_ticket);
80104d0c:	83 ec 08             	sub    $0x8,%esp
80104d0f:	ff 77 7c             	pushl  0x7c(%edi)
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104d12:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->lottery_ticket);
80104d14:	68 16 87 10 80       	push   $0x80108716
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104d19:	be 0a 00 00 00       	mov    $0xa,%esi
    cprintf("%d  ", p->lottery_ticket);
80104d1e:	e8 3d b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104d23:	83 c4 10             	add    $0x10,%esp
80104d26:	eb 1b                	jmp    80104d43 <show_all_processes_scheduling+0x433>
80104d28:	90                   	nop
80104d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104d30:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104d33:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104d36:	68 3c 87 10 80       	push   $0x8010873c
80104d3b:	e8 20 b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104d40:	83 c4 10             	add    $0x10,%esp
80104d43:	83 ec 0c             	sub    $0xc,%esp
80104d46:	ff 77 7c             	pushl  0x7c(%edi)
80104d49:	e8 12 fb ff ff       	call   80104860 <int_size>
80104d4e:	89 f1                	mov    %esi,%ecx
80104d50:	83 c4 10             	add    $0x10,%esp
80104d53:	29 c1                	sub    %eax,%ecx
80104d55:	39 d9                	cmp    %ebx,%ecx
80104d57:	7f d7                	jg     80104d30 <show_all_processes_scheduling+0x420>
    cprintf("%d  ", p->burst_time);
80104d59:	83 ec 08             	sub    $0x8,%esp
80104d5c:	ff b7 88 00 00 00    	pushl  0x88(%edi)
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104d62:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->burst_time);
80104d64:	68 16 87 10 80       	push   $0x80108716
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104d69:	be 0a 00 00 00       	mov    $0xa,%esi
    cprintf("%d  ", p->burst_time);
80104d6e:	e8 ed b8 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104d73:	83 c4 10             	add    $0x10,%esp
80104d76:	eb 1b                	jmp    80104d93 <show_all_processes_scheduling+0x483>
80104d78:	90                   	nop
80104d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104d80:	83 ec 0c             	sub    $0xc,%esp
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104d83:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104d86:	68 3c 87 10 80       	push   $0x8010873c
80104d8b:	e8 d0 b8 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104d90:	83 c4 10             	add    $0x10,%esp
80104d93:	83 ec 0c             	sub    $0xc,%esp
80104d96:	ff b7 88 00 00 00    	pushl  0x88(%edi)
80104d9c:	e8 bf fa ff ff       	call   80104860 <int_size>
80104da1:	89 f2                	mov    %esi,%edx
80104da3:	83 c4 10             	add    $0x10,%esp
80104da6:	29 c2                	sub    %eax,%edx
80104da8:	39 da                	cmp    %ebx,%edx
80104daa:	7f d4                	jg     80104d80 <show_all_processes_scheduling+0x470>
    cprintf("%d  ", p->creation_time);
80104dac:	83 ec 08             	sub    $0x8,%esp
80104daf:	ff b7 8c 00 00 00    	pushl  0x8c(%edi)
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104db5:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->creation_time);
80104db7:	68 16 87 10 80       	push   $0x80108716
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104dbc:	be 0a 00 00 00       	mov    $0xa,%esi
    cprintf("%d  ", p->creation_time);
80104dc1:	e8 9a b8 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104dc6:	83 c4 10             	add    $0x10,%esp
80104dc9:	eb 18                	jmp    80104de3 <show_all_processes_scheduling+0x4d3>
80104dcb:	90                   	nop
80104dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104dd0:	83 ec 0c             	sub    $0xc,%esp
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104dd3:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104dd6:	68 3c 87 10 80       	push   $0x8010873c
80104ddb:	e8 80 b8 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104de0:	83 c4 10             	add    $0x10,%esp
80104de3:	83 ec 0c             	sub    $0xc,%esp
80104de6:	ff b7 8c 00 00 00    	pushl  0x8c(%edi)
80104dec:	e8 6f fa ff ff       	call   80104860 <int_size>
80104df1:	89 f1                	mov    %esi,%ecx
80104df3:	83 c4 10             	add    $0x10,%esp
80104df6:	29 c1                	sub    %eax,%ecx
80104df8:	39 d9                	cmp    %ebx,%ecx
80104dfa:	7f d4                	jg     80104dd0 <show_all_processes_scheduling+0x4c0>
    cprintf("%d  " , p->process_count);
80104dfc:	83 ec 08             	sub    $0x8,%esp
80104dff:	ff b7 90 00 00 00    	pushl  0x90(%edi)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e05:	81 c7 94 00 00 00    	add    $0x94,%edi
    cprintf("%d  " , p->process_count);
80104e0b:	68 16 87 10 80       	push   $0x80108716
80104e10:	e8 4b b8 ff ff       	call   80100660 <cprintf>
    cprintf("\n");
80104e15:	c7 04 24 da 8a 10 80 	movl   $0x80108ada,(%esp)
80104e1c:	e8 3f b8 ff ff       	call   80100660 <cprintf>
80104e21:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e24:	81 ff 74 65 11 80    	cmp    $0x80116574,%edi
80104e2a:	0f 82 2a fd ff ff    	jb     80104b5a <show_all_processes_scheduling+0x24a>
  }
}
80104e30:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e33:	5b                   	pop    %ebx
80104e34:	5e                   	pop    %esi
80104e35:	5f                   	pop    %edi
80104e36:	5d                   	pop    %ebp
80104e37:	c3                   	ret    
80104e38:	90                   	nop
80104e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e40 <scheduler>:

void
scheduler(void)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	56                   	push   %esi
80104e44:	53                   	push   %ebx
80104e45:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;  
  struct cpu *c = mycpu();
80104e48:	e8 33 ed ff ff       	call   80103b80 <mycpu>
80104e4d:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80104e4f:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104e56:	00 00 00 
80104e59:	8d 70 04             	lea    0x4(%eax),%esi
80104e5c:	eb 4b                	jmp    80104ea9 <scheduler+0x69>
80104e5e:	66 90                	xchg   %ax,%ax
    if(p !=0 ) {
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80104e60:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104e63:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
      switchuvm(p);
80104e69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104e6c:	50                   	push   %eax
80104e6d:	e8 fe 28 00 00       	call   80107770 <switchuvm>
      p->state = RUNNING;
80104e72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e75:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)

      swtch(&(c->scheduler), p->context);
80104e7c:	5a                   	pop    %edx
80104e7d:	59                   	pop    %ecx
80104e7e:	ff 70 1c             	pushl  0x1c(%eax)
80104e81:	56                   	push   %esi
80104e82:	e8 14 06 00 00       	call   8010549b <swtch>
      switchkvm();
80104e87:	e8 c4 28 00 00       	call   80107750 <switchkvm>
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80104e8c:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80104e93:	00 00 00 
80104e96:	83 c4 10             	add    $0x10,%esp
    }

    release(&ptable.lock);
80104e99:	83 ec 0c             	sub    $0xc,%esp
80104e9c:	68 40 40 11 80       	push   $0x80114040
80104ea1:	e8 6a 03 00 00       	call   80105210 <release>
    sti();
80104ea6:	83 c4 10             	add    $0x10,%esp
  asm volatile("sti");
80104ea9:	fb                   	sti    
    acquire(&ptable.lock);
80104eaa:	83 ec 0c             	sub    $0xc,%esp
80104ead:	68 40 40 11 80       	push   $0x80114040
80104eb2:	e8 99 02 00 00       	call   80105150 <acquire>
    p = lotterySched();
80104eb7:	e8 14 f7 ff ff       	call   801045d0 <lotterySched>
    if(p == 0)
80104ebc:	83 c4 10             	add    $0x10,%esp
80104ebf:	85 c0                	test   %eax,%eax
80104ec1:	75 9d                	jne    80104e60 <scheduler+0x20>
      p = SJFSched();
80104ec3:	e8 28 f8 ff ff       	call   801046f0 <SJFSched>
    if(p == 0)
80104ec8:	85 c0                	test   %eax,%eax
80104eca:	75 94                	jne    80104e60 <scheduler+0x20>
      p = prioritySched();
80104ecc:	e8 bf f7 ff ff       	call   80104690 <prioritySched>
    if(p !=0 ) {
80104ed1:	85 c0                	test   %eax,%eax
80104ed3:	74 c4                	je     80104e99 <scheduler+0x59>
80104ed5:	eb 89                	jmp    80104e60 <scheduler+0x20>
80104ed7:	66 90                	xchg   %ax,%ax
80104ed9:	66 90                	xchg   %ax,%ax
80104edb:	66 90                	xchg   %ax,%ax
80104edd:	66 90                	xchg   %ax,%ax
80104edf:	90                   	nop

80104ee0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	53                   	push   %ebx
80104ee4:	83 ec 0c             	sub    $0xc,%esp
80104ee7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104eea:	68 14 88 10 80       	push   $0x80108814
80104eef:	8d 43 04             	lea    0x4(%ebx),%eax
80104ef2:	50                   	push   %eax
80104ef3:	e8 18 01 00 00       	call   80105010 <initlock>
  lk->name = name;
80104ef8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104efb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104f01:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104f04:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104f0b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104f0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f11:	c9                   	leave  
80104f12:	c3                   	ret    
80104f13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f20 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	56                   	push   %esi
80104f24:	53                   	push   %ebx
80104f25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104f28:	83 ec 0c             	sub    $0xc,%esp
80104f2b:	8d 73 04             	lea    0x4(%ebx),%esi
80104f2e:	56                   	push   %esi
80104f2f:	e8 1c 02 00 00       	call   80105150 <acquire>
  while (lk->locked) {
80104f34:	8b 13                	mov    (%ebx),%edx
80104f36:	83 c4 10             	add    $0x10,%esp
80104f39:	85 d2                	test   %edx,%edx
80104f3b:	74 16                	je     80104f53 <acquiresleep+0x33>
80104f3d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104f40:	83 ec 08             	sub    $0x8,%esp
80104f43:	56                   	push   %esi
80104f44:	53                   	push   %ebx
80104f45:	e8 d6 f1 ff ff       	call   80104120 <sleep>
  while (lk->locked) {
80104f4a:	8b 03                	mov    (%ebx),%eax
80104f4c:	83 c4 10             	add    $0x10,%esp
80104f4f:	85 c0                	test   %eax,%eax
80104f51:	75 ed                	jne    80104f40 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104f53:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104f59:	e8 c2 ec ff ff       	call   80103c20 <myproc>
80104f5e:	8b 40 10             	mov    0x10(%eax),%eax
80104f61:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104f64:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104f67:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f6a:	5b                   	pop    %ebx
80104f6b:	5e                   	pop    %esi
80104f6c:	5d                   	pop    %ebp
  release(&lk->lk);
80104f6d:	e9 9e 02 00 00       	jmp    80105210 <release>
80104f72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f80 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	56                   	push   %esi
80104f84:	53                   	push   %ebx
80104f85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104f88:	83 ec 0c             	sub    $0xc,%esp
80104f8b:	8d 73 04             	lea    0x4(%ebx),%esi
80104f8e:	56                   	push   %esi
80104f8f:	e8 bc 01 00 00       	call   80105150 <acquire>
  lk->locked = 0;
80104f94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104f9a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104fa1:	89 1c 24             	mov    %ebx,(%esp)
80104fa4:	e8 37 f3 ff ff       	call   801042e0 <wakeup>
  release(&lk->lk);
80104fa9:	89 75 08             	mov    %esi,0x8(%ebp)
80104fac:	83 c4 10             	add    $0x10,%esp
}
80104faf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fb2:	5b                   	pop    %ebx
80104fb3:	5e                   	pop    %esi
80104fb4:	5d                   	pop    %ebp
  release(&lk->lk);
80104fb5:	e9 56 02 00 00       	jmp    80105210 <release>
80104fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fc0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	57                   	push   %edi
80104fc4:	56                   	push   %esi
80104fc5:	53                   	push   %ebx
80104fc6:	31 ff                	xor    %edi,%edi
80104fc8:	83 ec 18             	sub    $0x18,%esp
80104fcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104fce:	8d 73 04             	lea    0x4(%ebx),%esi
80104fd1:	56                   	push   %esi
80104fd2:	e8 79 01 00 00       	call   80105150 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104fd7:	8b 03                	mov    (%ebx),%eax
80104fd9:	83 c4 10             	add    $0x10,%esp
80104fdc:	85 c0                	test   %eax,%eax
80104fde:	74 13                	je     80104ff3 <holdingsleep+0x33>
80104fe0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104fe3:	e8 38 ec ff ff       	call   80103c20 <myproc>
80104fe8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104feb:	0f 94 c0             	sete   %al
80104fee:	0f b6 c0             	movzbl %al,%eax
80104ff1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104ff3:	83 ec 0c             	sub    $0xc,%esp
80104ff6:	56                   	push   %esi
80104ff7:	e8 14 02 00 00       	call   80105210 <release>
  return r;
}
80104ffc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fff:	89 f8                	mov    %edi,%eax
80105001:	5b                   	pop    %ebx
80105002:	5e                   	pop    %esi
80105003:	5f                   	pop    %edi
80105004:	5d                   	pop    %ebp
80105005:	c3                   	ret    
80105006:	66 90                	xchg   %ax,%ax
80105008:	66 90                	xchg   %ax,%ax
8010500a:	66 90                	xchg   %ax,%ax
8010500c:	66 90                	xchg   %ax,%ax
8010500e:	66 90                	xchg   %ax,%ax

80105010 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105010:	55                   	push   %ebp
80105011:	89 e5                	mov    %esp,%ebp
80105013:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105016:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105019:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010501f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105022:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105029:	5d                   	pop    %ebp
8010502a:	c3                   	ret    
8010502b:	90                   	nop
8010502c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105030 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105030:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105031:	31 d2                	xor    %edx,%edx
{
80105033:	89 e5                	mov    %esp,%ebp
80105035:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105036:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105039:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010503c:	83 e8 08             	sub    $0x8,%eax
8010503f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105040:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105046:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010504c:	77 1a                	ja     80105068 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010504e:	8b 58 04             	mov    0x4(%eax),%ebx
80105051:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105054:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105057:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105059:	83 fa 0a             	cmp    $0xa,%edx
8010505c:	75 e2                	jne    80105040 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010505e:	5b                   	pop    %ebx
8010505f:	5d                   	pop    %ebp
80105060:	c3                   	ret    
80105061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105068:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010506b:	83 c1 28             	add    $0x28,%ecx
8010506e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105070:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105076:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105079:	39 c1                	cmp    %eax,%ecx
8010507b:	75 f3                	jne    80105070 <getcallerpcs+0x40>
}
8010507d:	5b                   	pop    %ebx
8010507e:	5d                   	pop    %ebp
8010507f:	c3                   	ret    

80105080 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	53                   	push   %ebx
80105084:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105087:	9c                   	pushf  
80105088:	5b                   	pop    %ebx
  asm volatile("cli");
80105089:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010508a:	e8 f1 ea ff ff       	call   80103b80 <mycpu>
8010508f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105095:	85 c0                	test   %eax,%eax
80105097:	75 11                	jne    801050aa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105099:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010509f:	e8 dc ea ff ff       	call   80103b80 <mycpu>
801050a4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801050aa:	e8 d1 ea ff ff       	call   80103b80 <mycpu>
801050af:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801050b6:	83 c4 04             	add    $0x4,%esp
801050b9:	5b                   	pop    %ebx
801050ba:	5d                   	pop    %ebp
801050bb:	c3                   	ret    
801050bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050c0 <popcli>:

void
popcli(void)
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801050c6:	9c                   	pushf  
801050c7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801050c8:	f6 c4 02             	test   $0x2,%ah
801050cb:	75 35                	jne    80105102 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801050cd:	e8 ae ea ff ff       	call   80103b80 <mycpu>
801050d2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801050d9:	78 34                	js     8010510f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801050db:	e8 a0 ea ff ff       	call   80103b80 <mycpu>
801050e0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801050e6:	85 d2                	test   %edx,%edx
801050e8:	74 06                	je     801050f0 <popcli+0x30>
    sti();
}
801050ea:	c9                   	leave  
801050eb:	c3                   	ret    
801050ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801050f0:	e8 8b ea ff ff       	call   80103b80 <mycpu>
801050f5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801050fb:	85 c0                	test   %eax,%eax
801050fd:	74 eb                	je     801050ea <popcli+0x2a>
  asm volatile("sti");
801050ff:	fb                   	sti    
}
80105100:	c9                   	leave  
80105101:	c3                   	ret    
    panic("popcli - interruptible");
80105102:	83 ec 0c             	sub    $0xc,%esp
80105105:	68 1f 88 10 80       	push   $0x8010881f
8010510a:	e8 81 b2 ff ff       	call   80100390 <panic>
    panic("popcli");
8010510f:	83 ec 0c             	sub    $0xc,%esp
80105112:	68 36 88 10 80       	push   $0x80108836
80105117:	e8 74 b2 ff ff       	call   80100390 <panic>
8010511c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105120 <holding>:
{
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	56                   	push   %esi
80105124:	53                   	push   %ebx
80105125:	8b 75 08             	mov    0x8(%ebp),%esi
80105128:	31 db                	xor    %ebx,%ebx
  pushcli();
8010512a:	e8 51 ff ff ff       	call   80105080 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010512f:	8b 06                	mov    (%esi),%eax
80105131:	85 c0                	test   %eax,%eax
80105133:	74 10                	je     80105145 <holding+0x25>
80105135:	8b 5e 08             	mov    0x8(%esi),%ebx
80105138:	e8 43 ea ff ff       	call   80103b80 <mycpu>
8010513d:	39 c3                	cmp    %eax,%ebx
8010513f:	0f 94 c3             	sete   %bl
80105142:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105145:	e8 76 ff ff ff       	call   801050c0 <popcli>
}
8010514a:	89 d8                	mov    %ebx,%eax
8010514c:	5b                   	pop    %ebx
8010514d:	5e                   	pop    %esi
8010514e:	5d                   	pop    %ebp
8010514f:	c3                   	ret    

80105150 <acquire>:
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	56                   	push   %esi
80105154:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105155:	e8 26 ff ff ff       	call   80105080 <pushcli>
  if(holding(lk))
8010515a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010515d:	83 ec 0c             	sub    $0xc,%esp
80105160:	53                   	push   %ebx
80105161:	e8 ba ff ff ff       	call   80105120 <holding>
80105166:	83 c4 10             	add    $0x10,%esp
80105169:	85 c0                	test   %eax,%eax
8010516b:	0f 85 83 00 00 00    	jne    801051f4 <acquire+0xa4>
80105171:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105173:	ba 01 00 00 00       	mov    $0x1,%edx
80105178:	eb 09                	jmp    80105183 <acquire+0x33>
8010517a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105180:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105183:	89 d0                	mov    %edx,%eax
80105185:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105188:	85 c0                	test   %eax,%eax
8010518a:	75 f4                	jne    80105180 <acquire+0x30>
  __sync_synchronize();
8010518c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105191:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105194:	e8 e7 e9 ff ff       	call   80103b80 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105199:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010519c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010519f:	89 e8                	mov    %ebp,%eax
801051a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051a8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801051ae:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801051b4:	77 1a                	ja     801051d0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801051b6:	8b 48 04             	mov    0x4(%eax),%ecx
801051b9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801051bc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801051bf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801051c1:	83 fe 0a             	cmp    $0xa,%esi
801051c4:	75 e2                	jne    801051a8 <acquire+0x58>
}
801051c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051c9:	5b                   	pop    %ebx
801051ca:	5e                   	pop    %esi
801051cb:	5d                   	pop    %ebp
801051cc:	c3                   	ret    
801051cd:	8d 76 00             	lea    0x0(%esi),%esi
801051d0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801051d3:	83 c2 28             	add    $0x28,%edx
801051d6:	8d 76 00             	lea    0x0(%esi),%esi
801051d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801051e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801051e6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801051e9:	39 d0                	cmp    %edx,%eax
801051eb:	75 f3                	jne    801051e0 <acquire+0x90>
}
801051ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051f0:	5b                   	pop    %ebx
801051f1:	5e                   	pop    %esi
801051f2:	5d                   	pop    %ebp
801051f3:	c3                   	ret    
    panic("acquire");
801051f4:	83 ec 0c             	sub    $0xc,%esp
801051f7:	68 3d 88 10 80       	push   $0x8010883d
801051fc:	e8 8f b1 ff ff       	call   80100390 <panic>
80105201:	eb 0d                	jmp    80105210 <release>
80105203:	90                   	nop
80105204:	90                   	nop
80105205:	90                   	nop
80105206:	90                   	nop
80105207:	90                   	nop
80105208:	90                   	nop
80105209:	90                   	nop
8010520a:	90                   	nop
8010520b:	90                   	nop
8010520c:	90                   	nop
8010520d:	90                   	nop
8010520e:	90                   	nop
8010520f:	90                   	nop

80105210 <release>:
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	53                   	push   %ebx
80105214:	83 ec 10             	sub    $0x10,%esp
80105217:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010521a:	53                   	push   %ebx
8010521b:	e8 00 ff ff ff       	call   80105120 <holding>
80105220:	83 c4 10             	add    $0x10,%esp
80105223:	85 c0                	test   %eax,%eax
80105225:	74 22                	je     80105249 <release+0x39>
  lk->pcs[0] = 0;
80105227:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010522e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105235:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010523a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105240:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105243:	c9                   	leave  
  popcli();
80105244:	e9 77 fe ff ff       	jmp    801050c0 <popcli>
    panic("release");
80105249:	83 ec 0c             	sub    $0xc,%esp
8010524c:	68 45 88 10 80       	push   $0x80108845
80105251:	e8 3a b1 ff ff       	call   80100390 <panic>
80105256:	66 90                	xchg   %ax,%ax
80105258:	66 90                	xchg   %ax,%ax
8010525a:	66 90                	xchg   %ax,%ax
8010525c:	66 90                	xchg   %ax,%ax
8010525e:	66 90                	xchg   %ax,%ax

80105260 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	57                   	push   %edi
80105264:	53                   	push   %ebx
80105265:	8b 55 08             	mov    0x8(%ebp),%edx
80105268:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010526b:	f6 c2 03             	test   $0x3,%dl
8010526e:	75 05                	jne    80105275 <memset+0x15>
80105270:	f6 c1 03             	test   $0x3,%cl
80105273:	74 13                	je     80105288 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80105275:	89 d7                	mov    %edx,%edi
80105277:	8b 45 0c             	mov    0xc(%ebp),%eax
8010527a:	fc                   	cld    
8010527b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010527d:	5b                   	pop    %ebx
8010527e:	89 d0                	mov    %edx,%eax
80105280:	5f                   	pop    %edi
80105281:	5d                   	pop    %ebp
80105282:	c3                   	ret    
80105283:	90                   	nop
80105284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80105288:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010528c:	c1 e9 02             	shr    $0x2,%ecx
8010528f:	89 f8                	mov    %edi,%eax
80105291:	89 fb                	mov    %edi,%ebx
80105293:	c1 e0 18             	shl    $0x18,%eax
80105296:	c1 e3 10             	shl    $0x10,%ebx
80105299:	09 d8                	or     %ebx,%eax
8010529b:	09 f8                	or     %edi,%eax
8010529d:	c1 e7 08             	shl    $0x8,%edi
801052a0:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801052a2:	89 d7                	mov    %edx,%edi
801052a4:	fc                   	cld    
801052a5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801052a7:	5b                   	pop    %ebx
801052a8:	89 d0                	mov    %edx,%eax
801052aa:	5f                   	pop    %edi
801052ab:	5d                   	pop    %ebp
801052ac:	c3                   	ret    
801052ad:	8d 76 00             	lea    0x0(%esi),%esi

801052b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	57                   	push   %edi
801052b4:	56                   	push   %esi
801052b5:	53                   	push   %ebx
801052b6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801052b9:	8b 75 08             	mov    0x8(%ebp),%esi
801052bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801052bf:	85 db                	test   %ebx,%ebx
801052c1:	74 29                	je     801052ec <memcmp+0x3c>
    if(*s1 != *s2)
801052c3:	0f b6 16             	movzbl (%esi),%edx
801052c6:	0f b6 0f             	movzbl (%edi),%ecx
801052c9:	38 d1                	cmp    %dl,%cl
801052cb:	75 2b                	jne    801052f8 <memcmp+0x48>
801052cd:	b8 01 00 00 00       	mov    $0x1,%eax
801052d2:	eb 14                	jmp    801052e8 <memcmp+0x38>
801052d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052d8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801052dc:	83 c0 01             	add    $0x1,%eax
801052df:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801052e4:	38 ca                	cmp    %cl,%dl
801052e6:	75 10                	jne    801052f8 <memcmp+0x48>
  while(n-- > 0){
801052e8:	39 d8                	cmp    %ebx,%eax
801052ea:	75 ec                	jne    801052d8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801052ec:	5b                   	pop    %ebx
  return 0;
801052ed:	31 c0                	xor    %eax,%eax
}
801052ef:	5e                   	pop    %esi
801052f0:	5f                   	pop    %edi
801052f1:	5d                   	pop    %ebp
801052f2:	c3                   	ret    
801052f3:	90                   	nop
801052f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801052f8:	0f b6 c2             	movzbl %dl,%eax
}
801052fb:	5b                   	pop    %ebx
      return *s1 - *s2;
801052fc:	29 c8                	sub    %ecx,%eax
}
801052fe:	5e                   	pop    %esi
801052ff:	5f                   	pop    %edi
80105300:	5d                   	pop    %ebp
80105301:	c3                   	ret    
80105302:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105310 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105310:	55                   	push   %ebp
80105311:	89 e5                	mov    %esp,%ebp
80105313:	56                   	push   %esi
80105314:	53                   	push   %ebx
80105315:	8b 45 08             	mov    0x8(%ebp),%eax
80105318:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010531b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010531e:	39 c3                	cmp    %eax,%ebx
80105320:	73 26                	jae    80105348 <memmove+0x38>
80105322:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105325:	39 c8                	cmp    %ecx,%eax
80105327:	73 1f                	jae    80105348 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105329:	85 f6                	test   %esi,%esi
8010532b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010532e:	74 0f                	je     8010533f <memmove+0x2f>
      *--d = *--s;
80105330:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105334:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105337:	83 ea 01             	sub    $0x1,%edx
8010533a:	83 fa ff             	cmp    $0xffffffff,%edx
8010533d:	75 f1                	jne    80105330 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010533f:	5b                   	pop    %ebx
80105340:	5e                   	pop    %esi
80105341:	5d                   	pop    %ebp
80105342:	c3                   	ret    
80105343:	90                   	nop
80105344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105348:	31 d2                	xor    %edx,%edx
8010534a:	85 f6                	test   %esi,%esi
8010534c:	74 f1                	je     8010533f <memmove+0x2f>
8010534e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105350:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105354:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105357:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010535a:	39 d6                	cmp    %edx,%esi
8010535c:	75 f2                	jne    80105350 <memmove+0x40>
}
8010535e:	5b                   	pop    %ebx
8010535f:	5e                   	pop    %esi
80105360:	5d                   	pop    %ebp
80105361:	c3                   	ret    
80105362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105370 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105373:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105374:	eb 9a                	jmp    80105310 <memmove>
80105376:	8d 76 00             	lea    0x0(%esi),%esi
80105379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105380 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	57                   	push   %edi
80105384:	56                   	push   %esi
80105385:	8b 7d 10             	mov    0x10(%ebp),%edi
80105388:	53                   	push   %ebx
80105389:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010538c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010538f:	85 ff                	test   %edi,%edi
80105391:	74 2f                	je     801053c2 <strncmp+0x42>
80105393:	0f b6 01             	movzbl (%ecx),%eax
80105396:	0f b6 1e             	movzbl (%esi),%ebx
80105399:	84 c0                	test   %al,%al
8010539b:	74 37                	je     801053d4 <strncmp+0x54>
8010539d:	38 c3                	cmp    %al,%bl
8010539f:	75 33                	jne    801053d4 <strncmp+0x54>
801053a1:	01 f7                	add    %esi,%edi
801053a3:	eb 13                	jmp    801053b8 <strncmp+0x38>
801053a5:	8d 76 00             	lea    0x0(%esi),%esi
801053a8:	0f b6 01             	movzbl (%ecx),%eax
801053ab:	84 c0                	test   %al,%al
801053ad:	74 21                	je     801053d0 <strncmp+0x50>
801053af:	0f b6 1a             	movzbl (%edx),%ebx
801053b2:	89 d6                	mov    %edx,%esi
801053b4:	38 d8                	cmp    %bl,%al
801053b6:	75 1c                	jne    801053d4 <strncmp+0x54>
    n--, p++, q++;
801053b8:	8d 56 01             	lea    0x1(%esi),%edx
801053bb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801053be:	39 fa                	cmp    %edi,%edx
801053c0:	75 e6                	jne    801053a8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801053c2:	5b                   	pop    %ebx
    return 0;
801053c3:	31 c0                	xor    %eax,%eax
}
801053c5:	5e                   	pop    %esi
801053c6:	5f                   	pop    %edi
801053c7:	5d                   	pop    %ebp
801053c8:	c3                   	ret    
801053c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053d0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801053d4:	29 d8                	sub    %ebx,%eax
}
801053d6:	5b                   	pop    %ebx
801053d7:	5e                   	pop    %esi
801053d8:	5f                   	pop    %edi
801053d9:	5d                   	pop    %ebp
801053da:	c3                   	ret    
801053db:	90                   	nop
801053dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053e0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	56                   	push   %esi
801053e4:	53                   	push   %ebx
801053e5:	8b 45 08             	mov    0x8(%ebp),%eax
801053e8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801053eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801053ee:	89 c2                	mov    %eax,%edx
801053f0:	eb 19                	jmp    8010540b <strncpy+0x2b>
801053f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801053f8:	83 c3 01             	add    $0x1,%ebx
801053fb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801053ff:	83 c2 01             	add    $0x1,%edx
80105402:	84 c9                	test   %cl,%cl
80105404:	88 4a ff             	mov    %cl,-0x1(%edx)
80105407:	74 09                	je     80105412 <strncpy+0x32>
80105409:	89 f1                	mov    %esi,%ecx
8010540b:	85 c9                	test   %ecx,%ecx
8010540d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80105410:	7f e6                	jg     801053f8 <strncpy+0x18>
    ;
  while(n-- > 0)
80105412:	31 c9                	xor    %ecx,%ecx
80105414:	85 f6                	test   %esi,%esi
80105416:	7e 17                	jle    8010542f <strncpy+0x4f>
80105418:	90                   	nop
80105419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105420:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105424:	89 f3                	mov    %esi,%ebx
80105426:	83 c1 01             	add    $0x1,%ecx
80105429:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010542b:	85 db                	test   %ebx,%ebx
8010542d:	7f f1                	jg     80105420 <strncpy+0x40>
  return os;
}
8010542f:	5b                   	pop    %ebx
80105430:	5e                   	pop    %esi
80105431:	5d                   	pop    %ebp
80105432:	c3                   	ret    
80105433:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105440 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	56                   	push   %esi
80105444:	53                   	push   %ebx
80105445:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105448:	8b 45 08             	mov    0x8(%ebp),%eax
8010544b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010544e:	85 c9                	test   %ecx,%ecx
80105450:	7e 26                	jle    80105478 <safestrcpy+0x38>
80105452:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105456:	89 c1                	mov    %eax,%ecx
80105458:	eb 17                	jmp    80105471 <safestrcpy+0x31>
8010545a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105460:	83 c2 01             	add    $0x1,%edx
80105463:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105467:	83 c1 01             	add    $0x1,%ecx
8010546a:	84 db                	test   %bl,%bl
8010546c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010546f:	74 04                	je     80105475 <safestrcpy+0x35>
80105471:	39 f2                	cmp    %esi,%edx
80105473:	75 eb                	jne    80105460 <safestrcpy+0x20>
    ;
  *s = 0;
80105475:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105478:	5b                   	pop    %ebx
80105479:	5e                   	pop    %esi
8010547a:	5d                   	pop    %ebp
8010547b:	c3                   	ret    
8010547c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105480 <strlen>:

int
strlen(const char *s)
{
80105480:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105481:	31 c0                	xor    %eax,%eax
{
80105483:	89 e5                	mov    %esp,%ebp
80105485:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105488:	80 3a 00             	cmpb   $0x0,(%edx)
8010548b:	74 0c                	je     80105499 <strlen+0x19>
8010548d:	8d 76 00             	lea    0x0(%esi),%esi
80105490:	83 c0 01             	add    $0x1,%eax
80105493:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105497:	75 f7                	jne    80105490 <strlen+0x10>
    ;
  return n;
}
80105499:	5d                   	pop    %ebp
8010549a:	c3                   	ret    

8010549b <swtch>:
8010549b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010549f:	8b 54 24 08          	mov    0x8(%esp),%edx
801054a3:	55                   	push   %ebp
801054a4:	53                   	push   %ebx
801054a5:	56                   	push   %esi
801054a6:	57                   	push   %edi
801054a7:	89 20                	mov    %esp,(%eax)
801054a9:	89 d4                	mov    %edx,%esp
801054ab:	5f                   	pop    %edi
801054ac:	5e                   	pop    %esi
801054ad:	5b                   	pop    %ebx
801054ae:	5d                   	pop    %ebp
801054af:	c3                   	ret    

801054b0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	53                   	push   %ebx
801054b4:	83 ec 04             	sub    $0x4,%esp
801054b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801054ba:	e8 61 e7 ff ff       	call   80103c20 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054bf:	8b 00                	mov    (%eax),%eax
801054c1:	39 d8                	cmp    %ebx,%eax
801054c3:	76 1b                	jbe    801054e0 <fetchint+0x30>
801054c5:	8d 53 04             	lea    0x4(%ebx),%edx
801054c8:	39 d0                	cmp    %edx,%eax
801054ca:	72 14                	jb     801054e0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801054cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801054cf:	8b 13                	mov    (%ebx),%edx
801054d1:	89 10                	mov    %edx,(%eax)
  return 0;
801054d3:	31 c0                	xor    %eax,%eax
}
801054d5:	83 c4 04             	add    $0x4,%esp
801054d8:	5b                   	pop    %ebx
801054d9:	5d                   	pop    %ebp
801054da:	c3                   	ret    
801054db:	90                   	nop
801054dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801054e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054e5:	eb ee                	jmp    801054d5 <fetchint+0x25>
801054e7:	89 f6                	mov    %esi,%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054f0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	53                   	push   %ebx
801054f4:	83 ec 04             	sub    $0x4,%esp
801054f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801054fa:	e8 21 e7 ff ff       	call   80103c20 <myproc>

  if(addr >= curproc->sz)
801054ff:	39 18                	cmp    %ebx,(%eax)
80105501:	76 29                	jbe    8010552c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105503:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105506:	89 da                	mov    %ebx,%edx
80105508:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010550a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010550c:	39 c3                	cmp    %eax,%ebx
8010550e:	73 1c                	jae    8010552c <fetchstr+0x3c>
    if(*s == 0)
80105510:	80 3b 00             	cmpb   $0x0,(%ebx)
80105513:	75 10                	jne    80105525 <fetchstr+0x35>
80105515:	eb 39                	jmp    80105550 <fetchstr+0x60>
80105517:	89 f6                	mov    %esi,%esi
80105519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105520:	80 3a 00             	cmpb   $0x0,(%edx)
80105523:	74 1b                	je     80105540 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105525:	83 c2 01             	add    $0x1,%edx
80105528:	39 d0                	cmp    %edx,%eax
8010552a:	77 f4                	ja     80105520 <fetchstr+0x30>
    return -1;
8010552c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105531:	83 c4 04             	add    $0x4,%esp
80105534:	5b                   	pop    %ebx
80105535:	5d                   	pop    %ebp
80105536:	c3                   	ret    
80105537:	89 f6                	mov    %esi,%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105540:	83 c4 04             	add    $0x4,%esp
80105543:	89 d0                	mov    %edx,%eax
80105545:	29 d8                	sub    %ebx,%eax
80105547:	5b                   	pop    %ebx
80105548:	5d                   	pop    %ebp
80105549:	c3                   	ret    
8010554a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80105550:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105552:	eb dd                	jmp    80105531 <fetchstr+0x41>
80105554:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010555a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105560 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	56                   	push   %esi
80105564:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105565:	e8 b6 e6 ff ff       	call   80103c20 <myproc>
8010556a:	8b 40 18             	mov    0x18(%eax),%eax
8010556d:	8b 55 08             	mov    0x8(%ebp),%edx
80105570:	8b 40 44             	mov    0x44(%eax),%eax
80105573:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105576:	e8 a5 e6 ff ff       	call   80103c20 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010557b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010557d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105580:	39 c6                	cmp    %eax,%esi
80105582:	73 1c                	jae    801055a0 <argint+0x40>
80105584:	8d 53 08             	lea    0x8(%ebx),%edx
80105587:	39 d0                	cmp    %edx,%eax
80105589:	72 15                	jb     801055a0 <argint+0x40>
  *ip = *(int*)(addr);
8010558b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010558e:	8b 53 04             	mov    0x4(%ebx),%edx
80105591:	89 10                	mov    %edx,(%eax)
  return 0;
80105593:	31 c0                	xor    %eax,%eax
}
80105595:	5b                   	pop    %ebx
80105596:	5e                   	pop    %esi
80105597:	5d                   	pop    %ebp
80105598:	c3                   	ret    
80105599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801055a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801055a5:	eb ee                	jmp    80105595 <argint+0x35>
801055a7:	89 f6                	mov    %esi,%esi
801055a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055b0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	56                   	push   %esi
801055b4:	53                   	push   %ebx
801055b5:	83 ec 10             	sub    $0x10,%esp
801055b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801055bb:	e8 60 e6 ff ff       	call   80103c20 <myproc>
801055c0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801055c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055c5:	83 ec 08             	sub    $0x8,%esp
801055c8:	50                   	push   %eax
801055c9:	ff 75 08             	pushl  0x8(%ebp)
801055cc:	e8 8f ff ff ff       	call   80105560 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801055d1:	83 c4 10             	add    $0x10,%esp
801055d4:	85 c0                	test   %eax,%eax
801055d6:	78 28                	js     80105600 <argptr+0x50>
801055d8:	85 db                	test   %ebx,%ebx
801055da:	78 24                	js     80105600 <argptr+0x50>
801055dc:	8b 16                	mov    (%esi),%edx
801055de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e1:	39 c2                	cmp    %eax,%edx
801055e3:	76 1b                	jbe    80105600 <argptr+0x50>
801055e5:	01 c3                	add    %eax,%ebx
801055e7:	39 da                	cmp    %ebx,%edx
801055e9:	72 15                	jb     80105600 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801055eb:	8b 55 0c             	mov    0xc(%ebp),%edx
801055ee:	89 02                	mov    %eax,(%edx)
  return 0;
801055f0:	31 c0                	xor    %eax,%eax
}
801055f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055f5:	5b                   	pop    %ebx
801055f6:	5e                   	pop    %esi
801055f7:	5d                   	pop    %ebp
801055f8:	c3                   	ret    
801055f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105600:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105605:	eb eb                	jmp    801055f2 <argptr+0x42>
80105607:	89 f6                	mov    %esi,%esi
80105609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105610 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105616:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105619:	50                   	push   %eax
8010561a:	ff 75 08             	pushl  0x8(%ebp)
8010561d:	e8 3e ff ff ff       	call   80105560 <argint>
80105622:	83 c4 10             	add    $0x10,%esp
80105625:	85 c0                	test   %eax,%eax
80105627:	78 17                	js     80105640 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105629:	83 ec 08             	sub    $0x8,%esp
8010562c:	ff 75 0c             	pushl  0xc(%ebp)
8010562f:	ff 75 f4             	pushl  -0xc(%ebp)
80105632:	e8 b9 fe ff ff       	call   801054f0 <fetchstr>
80105637:	83 c4 10             	add    $0x10,%esp
}
8010563a:	c9                   	leave  
8010563b:	c3                   	ret    
8010563c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105640:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105645:	c9                   	leave  
80105646:	c3                   	ret    
80105647:	89 f6                	mov    %esi,%esi
80105649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105650 <syscall>:
[SYS_getNumFreePages] sys_getNumFreePages,
};

void
syscall(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	53                   	push   %ebx
80105654:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80105657:	e8 c4 e5 ff ff       	call   80103c20 <myproc>
  num = curproc->tf->eax;
8010565c:	8b 50 18             	mov    0x18(%eax),%edx
  struct proc *curproc = myproc();
8010565f:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80105661:	8b 42 1c             	mov    0x1c(%edx),%eax
  if (num == 22) {
80105664:	83 f8 16             	cmp    $0x16,%eax
80105667:	74 37                	je     801056a0 <syscall+0x50>
    int arg = 0;
    argint(0 ,&arg);    
    curproc->tf->eax = sys_incNum(arg);    
  }
  else if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105669:	8d 48 ff             	lea    -0x1(%eax),%ecx
8010566c:	83 f9 1c             	cmp    $0x1c,%ecx
8010566f:	77 1f                	ja     80105690 <syscall+0x40>
80105671:	8b 04 85 60 88 10 80 	mov    -0x7fef77a0(,%eax,4),%eax
80105678:	85 c0                	test   %eax,%eax
8010567a:	74 14                	je     80105690 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
8010567c:	ff d0                	call   *%eax
8010567e:	8b 53 18             	mov    0x18(%ebx),%edx
80105681:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    curproc->tf->eax = -1;
  }
}
80105684:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105687:	c9                   	leave  
80105688:	c3                   	ret    
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curproc->tf->eax = -1;
80105690:	c7 42 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%edx)
}
80105697:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010569a:	c9                   	leave  
8010569b:	c3                   	ret    
8010569c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    argint(0 ,&arg);    
801056a0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056a3:	83 ec 08             	sub    $0x8,%esp
    int arg = 0;
801056a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    argint(0 ,&arg);    
801056ad:	50                   	push   %eax
801056ae:	6a 00                	push   $0x0
801056b0:	e8 ab fe ff ff       	call   80105560 <argint>
    curproc->tf->eax = sys_incNum(arg);    
801056b5:	58                   	pop    %eax
801056b6:	ff 75 f4             	pushl  -0xc(%ebp)
801056b9:	e8 a2 0d 00 00       	call   80106460 <sys_incNum>
801056be:	8b 53 18             	mov    0x18(%ebx),%edx
801056c1:	83 c4 10             	add    $0x10,%esp
801056c4:	89 42 1c             	mov    %eax,0x1c(%edx)
}
801056c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056ca:	c9                   	leave  
801056cb:	c3                   	ret    
801056cc:	66 90                	xchg   %ax,%ax
801056ce:	66 90                	xchg   %ax,%ax

801056d0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	57                   	push   %edi
801056d4:	56                   	push   %esi
801056d5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801056d6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
801056d9:	83 ec 44             	sub    $0x44,%esp
801056dc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
801056df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801056e2:	56                   	push   %esi
801056e3:	50                   	push   %eax
{
801056e4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801056e7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801056ea:	e8 81 cb ff ff       	call   80102270 <nameiparent>
801056ef:	83 c4 10             	add    $0x10,%esp
801056f2:	85 c0                	test   %eax,%eax
801056f4:	0f 84 46 01 00 00    	je     80105840 <create+0x170>
    return 0;
  ilock(dp);
801056fa:	83 ec 0c             	sub    $0xc,%esp
801056fd:	89 c3                	mov    %eax,%ebx
801056ff:	50                   	push   %eax
80105700:	e8 eb c2 ff ff       	call   801019f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105705:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105708:	83 c4 0c             	add    $0xc,%esp
8010570b:	50                   	push   %eax
8010570c:	56                   	push   %esi
8010570d:	53                   	push   %ebx
8010570e:	e8 0d c8 ff ff       	call   80101f20 <dirlookup>
80105713:	83 c4 10             	add    $0x10,%esp
80105716:	85 c0                	test   %eax,%eax
80105718:	89 c7                	mov    %eax,%edi
8010571a:	74 34                	je     80105750 <create+0x80>
    iunlockput(dp);
8010571c:	83 ec 0c             	sub    $0xc,%esp
8010571f:	53                   	push   %ebx
80105720:	e8 5b c5 ff ff       	call   80101c80 <iunlockput>
    ilock(ip);
80105725:	89 3c 24             	mov    %edi,(%esp)
80105728:	e8 c3 c2 ff ff       	call   801019f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010572d:	83 c4 10             	add    $0x10,%esp
80105730:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105735:	0f 85 95 00 00 00    	jne    801057d0 <create+0x100>
8010573b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105740:	0f 85 8a 00 00 00    	jne    801057d0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105746:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105749:	89 f8                	mov    %edi,%eax
8010574b:	5b                   	pop    %ebx
8010574c:	5e                   	pop    %esi
8010574d:	5f                   	pop    %edi
8010574e:	5d                   	pop    %ebp
8010574f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105750:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105754:	83 ec 08             	sub    $0x8,%esp
80105757:	50                   	push   %eax
80105758:	ff 33                	pushl  (%ebx)
8010575a:	e8 21 c1 ff ff       	call   80101880 <ialloc>
8010575f:	83 c4 10             	add    $0x10,%esp
80105762:	85 c0                	test   %eax,%eax
80105764:	89 c7                	mov    %eax,%edi
80105766:	0f 84 e8 00 00 00    	je     80105854 <create+0x184>
  ilock(ip);
8010576c:	83 ec 0c             	sub    $0xc,%esp
8010576f:	50                   	push   %eax
80105770:	e8 7b c2 ff ff       	call   801019f0 <ilock>
  ip->major = major;
80105775:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105779:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010577d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105781:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105785:	b8 01 00 00 00       	mov    $0x1,%eax
8010578a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010578e:	89 3c 24             	mov    %edi,(%esp)
80105791:	e8 aa c1 ff ff       	call   80101940 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105796:	83 c4 10             	add    $0x10,%esp
80105799:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010579e:	74 50                	je     801057f0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801057a0:	83 ec 04             	sub    $0x4,%esp
801057a3:	ff 77 04             	pushl  0x4(%edi)
801057a6:	56                   	push   %esi
801057a7:	53                   	push   %ebx
801057a8:	e8 e3 c9 ff ff       	call   80102190 <dirlink>
801057ad:	83 c4 10             	add    $0x10,%esp
801057b0:	85 c0                	test   %eax,%eax
801057b2:	0f 88 8f 00 00 00    	js     80105847 <create+0x177>
  iunlockput(dp);
801057b8:	83 ec 0c             	sub    $0xc,%esp
801057bb:	53                   	push   %ebx
801057bc:	e8 bf c4 ff ff       	call   80101c80 <iunlockput>
  return ip;
801057c1:	83 c4 10             	add    $0x10,%esp
}
801057c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057c7:	89 f8                	mov    %edi,%eax
801057c9:	5b                   	pop    %ebx
801057ca:	5e                   	pop    %esi
801057cb:	5f                   	pop    %edi
801057cc:	5d                   	pop    %ebp
801057cd:	c3                   	ret    
801057ce:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801057d0:	83 ec 0c             	sub    $0xc,%esp
801057d3:	57                   	push   %edi
    return 0;
801057d4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
801057d6:	e8 a5 c4 ff ff       	call   80101c80 <iunlockput>
    return 0;
801057db:	83 c4 10             	add    $0x10,%esp
}
801057de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057e1:	89 f8                	mov    %edi,%eax
801057e3:	5b                   	pop    %ebx
801057e4:	5e                   	pop    %esi
801057e5:	5f                   	pop    %edi
801057e6:	5d                   	pop    %ebp
801057e7:	c3                   	ret    
801057e8:	90                   	nop
801057e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801057f0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801057f5:	83 ec 0c             	sub    $0xc,%esp
801057f8:	53                   	push   %ebx
801057f9:	e8 42 c1 ff ff       	call   80101940 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801057fe:	83 c4 0c             	add    $0xc,%esp
80105801:	ff 77 04             	pushl  0x4(%edi)
80105804:	68 f4 88 10 80       	push   $0x801088f4
80105809:	57                   	push   %edi
8010580a:	e8 81 c9 ff ff       	call   80102190 <dirlink>
8010580f:	83 c4 10             	add    $0x10,%esp
80105812:	85 c0                	test   %eax,%eax
80105814:	78 1c                	js     80105832 <create+0x162>
80105816:	83 ec 04             	sub    $0x4,%esp
80105819:	ff 73 04             	pushl  0x4(%ebx)
8010581c:	68 f3 88 10 80       	push   $0x801088f3
80105821:	57                   	push   %edi
80105822:	e8 69 c9 ff ff       	call   80102190 <dirlink>
80105827:	83 c4 10             	add    $0x10,%esp
8010582a:	85 c0                	test   %eax,%eax
8010582c:	0f 89 6e ff ff ff    	jns    801057a0 <create+0xd0>
      panic("create dots");
80105832:	83 ec 0c             	sub    $0xc,%esp
80105835:	68 e7 88 10 80       	push   $0x801088e7
8010583a:	e8 51 ab ff ff       	call   80100390 <panic>
8010583f:	90                   	nop
    return 0;
80105840:	31 ff                	xor    %edi,%edi
80105842:	e9 ff fe ff ff       	jmp    80105746 <create+0x76>
    panic("create: dirlink");
80105847:	83 ec 0c             	sub    $0xc,%esp
8010584a:	68 f6 88 10 80       	push   $0x801088f6
8010584f:	e8 3c ab ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105854:	83 ec 0c             	sub    $0xc,%esp
80105857:	68 d8 88 10 80       	push   $0x801088d8
8010585c:	e8 2f ab ff ff       	call   80100390 <panic>
80105861:	eb 0d                	jmp    80105870 <argfd.constprop.0>
80105863:	90                   	nop
80105864:	90                   	nop
80105865:	90                   	nop
80105866:	90                   	nop
80105867:	90                   	nop
80105868:	90                   	nop
80105869:	90                   	nop
8010586a:	90                   	nop
8010586b:	90                   	nop
8010586c:	90                   	nop
8010586d:	90                   	nop
8010586e:	90                   	nop
8010586f:	90                   	nop

80105870 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	56                   	push   %esi
80105874:	53                   	push   %ebx
80105875:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105877:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010587a:	89 d6                	mov    %edx,%esi
8010587c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010587f:	50                   	push   %eax
80105880:	6a 00                	push   $0x0
80105882:	e8 d9 fc ff ff       	call   80105560 <argint>
80105887:	83 c4 10             	add    $0x10,%esp
8010588a:	85 c0                	test   %eax,%eax
8010588c:	78 2a                	js     801058b8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010588e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105892:	77 24                	ja     801058b8 <argfd.constprop.0+0x48>
80105894:	e8 87 e3 ff ff       	call   80103c20 <myproc>
80105899:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010589c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801058a0:	85 c0                	test   %eax,%eax
801058a2:	74 14                	je     801058b8 <argfd.constprop.0+0x48>
  if(pfd)
801058a4:	85 db                	test   %ebx,%ebx
801058a6:	74 02                	je     801058aa <argfd.constprop.0+0x3a>
    *pfd = fd;
801058a8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801058aa:	89 06                	mov    %eax,(%esi)
  return 0;
801058ac:	31 c0                	xor    %eax,%eax
}
801058ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801058b1:	5b                   	pop    %ebx
801058b2:	5e                   	pop    %esi
801058b3:	5d                   	pop    %ebp
801058b4:	c3                   	ret    
801058b5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801058b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058bd:	eb ef                	jmp    801058ae <argfd.constprop.0+0x3e>
801058bf:	90                   	nop

801058c0 <sys_dup>:
{
801058c0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801058c1:	31 c0                	xor    %eax,%eax
{
801058c3:	89 e5                	mov    %esp,%ebp
801058c5:	56                   	push   %esi
801058c6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801058c7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801058ca:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801058cd:	e8 9e ff ff ff       	call   80105870 <argfd.constprop.0>
801058d2:	85 c0                	test   %eax,%eax
801058d4:	78 42                	js     80105918 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
801058d6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801058d9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801058db:	e8 40 e3 ff ff       	call   80103c20 <myproc>
801058e0:	eb 0e                	jmp    801058f0 <sys_dup+0x30>
801058e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801058e8:	83 c3 01             	add    $0x1,%ebx
801058eb:	83 fb 10             	cmp    $0x10,%ebx
801058ee:	74 28                	je     80105918 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
801058f0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801058f4:	85 d2                	test   %edx,%edx
801058f6:	75 f0                	jne    801058e8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
801058f8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801058fc:	83 ec 0c             	sub    $0xc,%esp
801058ff:	ff 75 f4             	pushl  -0xc(%ebp)
80105902:	e8 49 b8 ff ff       	call   80101150 <filedup>
  return fd;
80105907:	83 c4 10             	add    $0x10,%esp
}
8010590a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010590d:	89 d8                	mov    %ebx,%eax
8010590f:	5b                   	pop    %ebx
80105910:	5e                   	pop    %esi
80105911:	5d                   	pop    %ebp
80105912:	c3                   	ret    
80105913:	90                   	nop
80105914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105918:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010591b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105920:	89 d8                	mov    %ebx,%eax
80105922:	5b                   	pop    %ebx
80105923:	5e                   	pop    %esi
80105924:	5d                   	pop    %ebp
80105925:	c3                   	ret    
80105926:	8d 76 00             	lea    0x0(%esi),%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105930 <sys_read>:
{
80105930:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105931:	31 c0                	xor    %eax,%eax
{
80105933:	89 e5                	mov    %esp,%ebp
80105935:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105938:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010593b:	e8 30 ff ff ff       	call   80105870 <argfd.constprop.0>
80105940:	85 c0                	test   %eax,%eax
80105942:	78 4c                	js     80105990 <sys_read+0x60>
80105944:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105947:	83 ec 08             	sub    $0x8,%esp
8010594a:	50                   	push   %eax
8010594b:	6a 02                	push   $0x2
8010594d:	e8 0e fc ff ff       	call   80105560 <argint>
80105952:	83 c4 10             	add    $0x10,%esp
80105955:	85 c0                	test   %eax,%eax
80105957:	78 37                	js     80105990 <sys_read+0x60>
80105959:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010595c:	83 ec 04             	sub    $0x4,%esp
8010595f:	ff 75 f0             	pushl  -0x10(%ebp)
80105962:	50                   	push   %eax
80105963:	6a 01                	push   $0x1
80105965:	e8 46 fc ff ff       	call   801055b0 <argptr>
8010596a:	83 c4 10             	add    $0x10,%esp
8010596d:	85 c0                	test   %eax,%eax
8010596f:	78 1f                	js     80105990 <sys_read+0x60>
  return fileread(f, p, n);
80105971:	83 ec 04             	sub    $0x4,%esp
80105974:	ff 75 f0             	pushl  -0x10(%ebp)
80105977:	ff 75 f4             	pushl  -0xc(%ebp)
8010597a:	ff 75 ec             	pushl  -0x14(%ebp)
8010597d:	e8 3e b9 ff ff       	call   801012c0 <fileread>
80105982:	83 c4 10             	add    $0x10,%esp
}
80105985:	c9                   	leave  
80105986:	c3                   	ret    
80105987:	89 f6                	mov    %esi,%esi
80105989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105990:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105995:	c9                   	leave  
80105996:	c3                   	ret    
80105997:	89 f6                	mov    %esi,%esi
80105999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059a0 <sys_write>:
{
801059a0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801059a1:	31 c0                	xor    %eax,%eax
{
801059a3:	89 e5                	mov    %esp,%ebp
801059a5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801059a8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801059ab:	e8 c0 fe ff ff       	call   80105870 <argfd.constprop.0>
801059b0:	85 c0                	test   %eax,%eax
801059b2:	78 4c                	js     80105a00 <sys_write+0x60>
801059b4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059b7:	83 ec 08             	sub    $0x8,%esp
801059ba:	50                   	push   %eax
801059bb:	6a 02                	push   $0x2
801059bd:	e8 9e fb ff ff       	call   80105560 <argint>
801059c2:	83 c4 10             	add    $0x10,%esp
801059c5:	85 c0                	test   %eax,%eax
801059c7:	78 37                	js     80105a00 <sys_write+0x60>
801059c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059cc:	83 ec 04             	sub    $0x4,%esp
801059cf:	ff 75 f0             	pushl  -0x10(%ebp)
801059d2:	50                   	push   %eax
801059d3:	6a 01                	push   $0x1
801059d5:	e8 d6 fb ff ff       	call   801055b0 <argptr>
801059da:	83 c4 10             	add    $0x10,%esp
801059dd:	85 c0                	test   %eax,%eax
801059df:	78 1f                	js     80105a00 <sys_write+0x60>
  return filewrite(f, p, n);
801059e1:	83 ec 04             	sub    $0x4,%esp
801059e4:	ff 75 f0             	pushl  -0x10(%ebp)
801059e7:	ff 75 f4             	pushl  -0xc(%ebp)
801059ea:	ff 75 ec             	pushl  -0x14(%ebp)
801059ed:	e8 5e b9 ff ff       	call   80101350 <filewrite>
801059f2:	83 c4 10             	add    $0x10,%esp
}
801059f5:	c9                   	leave  
801059f6:	c3                   	ret    
801059f7:	89 f6                	mov    %esi,%esi
801059f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105a00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a05:	c9                   	leave  
80105a06:	c3                   	ret    
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a10 <sys_close>:
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105a16:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105a19:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a1c:	e8 4f fe ff ff       	call   80105870 <argfd.constprop.0>
80105a21:	85 c0                	test   %eax,%eax
80105a23:	78 2b                	js     80105a50 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105a25:	e8 f6 e1 ff ff       	call   80103c20 <myproc>
80105a2a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105a2d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105a30:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105a37:	00 
  fileclose(f);
80105a38:	ff 75 f4             	pushl  -0xc(%ebp)
80105a3b:	e8 60 b7 ff ff       	call   801011a0 <fileclose>
  return 0;
80105a40:	83 c4 10             	add    $0x10,%esp
80105a43:	31 c0                	xor    %eax,%eax
}
80105a45:	c9                   	leave  
80105a46:	c3                   	ret    
80105a47:	89 f6                	mov    %esi,%esi
80105a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a55:	c9                   	leave  
80105a56:	c3                   	ret    
80105a57:	89 f6                	mov    %esi,%esi
80105a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a60 <sys_fstat>:
{
80105a60:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a61:	31 c0                	xor    %eax,%eax
{
80105a63:	89 e5                	mov    %esp,%ebp
80105a65:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a68:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105a6b:	e8 00 fe ff ff       	call   80105870 <argfd.constprop.0>
80105a70:	85 c0                	test   %eax,%eax
80105a72:	78 2c                	js     80105aa0 <sys_fstat+0x40>
80105a74:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a77:	83 ec 04             	sub    $0x4,%esp
80105a7a:	6a 14                	push   $0x14
80105a7c:	50                   	push   %eax
80105a7d:	6a 01                	push   $0x1
80105a7f:	e8 2c fb ff ff       	call   801055b0 <argptr>
80105a84:	83 c4 10             	add    $0x10,%esp
80105a87:	85 c0                	test   %eax,%eax
80105a89:	78 15                	js     80105aa0 <sys_fstat+0x40>
  return filestat(f, st);
80105a8b:	83 ec 08             	sub    $0x8,%esp
80105a8e:	ff 75 f4             	pushl  -0xc(%ebp)
80105a91:	ff 75 f0             	pushl  -0x10(%ebp)
80105a94:	e8 d7 b7 ff ff       	call   80101270 <filestat>
80105a99:	83 c4 10             	add    $0x10,%esp
}
80105a9c:	c9                   	leave  
80105a9d:	c3                   	ret    
80105a9e:	66 90                	xchg   %ax,%ax
    return -1;
80105aa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105aa5:	c9                   	leave  
80105aa6:	c3                   	ret    
80105aa7:	89 f6                	mov    %esi,%esi
80105aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ab0 <sys_link>:
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	57                   	push   %edi
80105ab4:	56                   	push   %esi
80105ab5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105ab6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105ab9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105abc:	50                   	push   %eax
80105abd:	6a 00                	push   $0x0
80105abf:	e8 4c fb ff ff       	call   80105610 <argstr>
80105ac4:	83 c4 10             	add    $0x10,%esp
80105ac7:	85 c0                	test   %eax,%eax
80105ac9:	0f 88 fb 00 00 00    	js     80105bca <sys_link+0x11a>
80105acf:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105ad2:	83 ec 08             	sub    $0x8,%esp
80105ad5:	50                   	push   %eax
80105ad6:	6a 01                	push   $0x1
80105ad8:	e8 33 fb ff ff       	call   80105610 <argstr>
80105add:	83 c4 10             	add    $0x10,%esp
80105ae0:	85 c0                	test   %eax,%eax
80105ae2:	0f 88 e2 00 00 00    	js     80105bca <sys_link+0x11a>
  begin_op();
80105ae8:	e8 a3 d4 ff ff       	call   80102f90 <begin_op>
  if((ip = namei(old)) == 0){
80105aed:	83 ec 0c             	sub    $0xc,%esp
80105af0:	ff 75 d4             	pushl  -0x2c(%ebp)
80105af3:	e8 58 c7 ff ff       	call   80102250 <namei>
80105af8:	83 c4 10             	add    $0x10,%esp
80105afb:	85 c0                	test   %eax,%eax
80105afd:	89 c3                	mov    %eax,%ebx
80105aff:	0f 84 ea 00 00 00    	je     80105bef <sys_link+0x13f>
  ilock(ip);
80105b05:	83 ec 0c             	sub    $0xc,%esp
80105b08:	50                   	push   %eax
80105b09:	e8 e2 be ff ff       	call   801019f0 <ilock>
  if(ip->type == T_DIR){
80105b0e:	83 c4 10             	add    $0x10,%esp
80105b11:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b16:	0f 84 bb 00 00 00    	je     80105bd7 <sys_link+0x127>
  ip->nlink++;
80105b1c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105b21:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105b24:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105b27:	53                   	push   %ebx
80105b28:	e8 13 be ff ff       	call   80101940 <iupdate>
  iunlock(ip);
80105b2d:	89 1c 24             	mov    %ebx,(%esp)
80105b30:	e8 9b bf ff ff       	call   80101ad0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105b35:	58                   	pop    %eax
80105b36:	5a                   	pop    %edx
80105b37:	57                   	push   %edi
80105b38:	ff 75 d0             	pushl  -0x30(%ebp)
80105b3b:	e8 30 c7 ff ff       	call   80102270 <nameiparent>
80105b40:	83 c4 10             	add    $0x10,%esp
80105b43:	85 c0                	test   %eax,%eax
80105b45:	89 c6                	mov    %eax,%esi
80105b47:	74 5b                	je     80105ba4 <sys_link+0xf4>
  ilock(dp);
80105b49:	83 ec 0c             	sub    $0xc,%esp
80105b4c:	50                   	push   %eax
80105b4d:	e8 9e be ff ff       	call   801019f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105b52:	83 c4 10             	add    $0x10,%esp
80105b55:	8b 03                	mov    (%ebx),%eax
80105b57:	39 06                	cmp    %eax,(%esi)
80105b59:	75 3d                	jne    80105b98 <sys_link+0xe8>
80105b5b:	83 ec 04             	sub    $0x4,%esp
80105b5e:	ff 73 04             	pushl  0x4(%ebx)
80105b61:	57                   	push   %edi
80105b62:	56                   	push   %esi
80105b63:	e8 28 c6 ff ff       	call   80102190 <dirlink>
80105b68:	83 c4 10             	add    $0x10,%esp
80105b6b:	85 c0                	test   %eax,%eax
80105b6d:	78 29                	js     80105b98 <sys_link+0xe8>
  iunlockput(dp);
80105b6f:	83 ec 0c             	sub    $0xc,%esp
80105b72:	56                   	push   %esi
80105b73:	e8 08 c1 ff ff       	call   80101c80 <iunlockput>
  iput(ip);
80105b78:	89 1c 24             	mov    %ebx,(%esp)
80105b7b:	e8 a0 bf ff ff       	call   80101b20 <iput>
  end_op();
80105b80:	e8 7b d4 ff ff       	call   80103000 <end_op>
  return 0;
80105b85:	83 c4 10             	add    $0x10,%esp
80105b88:	31 c0                	xor    %eax,%eax
}
80105b8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b8d:	5b                   	pop    %ebx
80105b8e:	5e                   	pop    %esi
80105b8f:	5f                   	pop    %edi
80105b90:	5d                   	pop    %ebp
80105b91:	c3                   	ret    
80105b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105b98:	83 ec 0c             	sub    $0xc,%esp
80105b9b:	56                   	push   %esi
80105b9c:	e8 df c0 ff ff       	call   80101c80 <iunlockput>
    goto bad;
80105ba1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105ba4:	83 ec 0c             	sub    $0xc,%esp
80105ba7:	53                   	push   %ebx
80105ba8:	e8 43 be ff ff       	call   801019f0 <ilock>
  ip->nlink--;
80105bad:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105bb2:	89 1c 24             	mov    %ebx,(%esp)
80105bb5:	e8 86 bd ff ff       	call   80101940 <iupdate>
  iunlockput(ip);
80105bba:	89 1c 24             	mov    %ebx,(%esp)
80105bbd:	e8 be c0 ff ff       	call   80101c80 <iunlockput>
  end_op();
80105bc2:	e8 39 d4 ff ff       	call   80103000 <end_op>
  return -1;
80105bc7:	83 c4 10             	add    $0x10,%esp
}
80105bca:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80105bcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bd2:	5b                   	pop    %ebx
80105bd3:	5e                   	pop    %esi
80105bd4:	5f                   	pop    %edi
80105bd5:	5d                   	pop    %ebp
80105bd6:	c3                   	ret    
    iunlockput(ip);
80105bd7:	83 ec 0c             	sub    $0xc,%esp
80105bda:	53                   	push   %ebx
80105bdb:	e8 a0 c0 ff ff       	call   80101c80 <iunlockput>
    end_op();
80105be0:	e8 1b d4 ff ff       	call   80103000 <end_op>
    return -1;
80105be5:	83 c4 10             	add    $0x10,%esp
80105be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bed:	eb 9b                	jmp    80105b8a <sys_link+0xda>
    end_op();
80105bef:	e8 0c d4 ff ff       	call   80103000 <end_op>
    return -1;
80105bf4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bf9:	eb 8f                	jmp    80105b8a <sys_link+0xda>
80105bfb:	90                   	nop
80105bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c00 <sys_unlink>:
{
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	57                   	push   %edi
80105c04:	56                   	push   %esi
80105c05:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105c06:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105c09:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80105c0c:	50                   	push   %eax
80105c0d:	6a 00                	push   $0x0
80105c0f:	e8 fc f9 ff ff       	call   80105610 <argstr>
80105c14:	83 c4 10             	add    $0x10,%esp
80105c17:	85 c0                	test   %eax,%eax
80105c19:	0f 88 77 01 00 00    	js     80105d96 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80105c1f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105c22:	e8 69 d3 ff ff       	call   80102f90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105c27:	83 ec 08             	sub    $0x8,%esp
80105c2a:	53                   	push   %ebx
80105c2b:	ff 75 c0             	pushl  -0x40(%ebp)
80105c2e:	e8 3d c6 ff ff       	call   80102270 <nameiparent>
80105c33:	83 c4 10             	add    $0x10,%esp
80105c36:	85 c0                	test   %eax,%eax
80105c38:	89 c6                	mov    %eax,%esi
80105c3a:	0f 84 60 01 00 00    	je     80105da0 <sys_unlink+0x1a0>
  ilock(dp);
80105c40:	83 ec 0c             	sub    $0xc,%esp
80105c43:	50                   	push   %eax
80105c44:	e8 a7 bd ff ff       	call   801019f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105c49:	58                   	pop    %eax
80105c4a:	5a                   	pop    %edx
80105c4b:	68 f4 88 10 80       	push   $0x801088f4
80105c50:	53                   	push   %ebx
80105c51:	e8 aa c2 ff ff       	call   80101f00 <namecmp>
80105c56:	83 c4 10             	add    $0x10,%esp
80105c59:	85 c0                	test   %eax,%eax
80105c5b:	0f 84 03 01 00 00    	je     80105d64 <sys_unlink+0x164>
80105c61:	83 ec 08             	sub    $0x8,%esp
80105c64:	68 f3 88 10 80       	push   $0x801088f3
80105c69:	53                   	push   %ebx
80105c6a:	e8 91 c2 ff ff       	call   80101f00 <namecmp>
80105c6f:	83 c4 10             	add    $0x10,%esp
80105c72:	85 c0                	test   %eax,%eax
80105c74:	0f 84 ea 00 00 00    	je     80105d64 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105c7a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105c7d:	83 ec 04             	sub    $0x4,%esp
80105c80:	50                   	push   %eax
80105c81:	53                   	push   %ebx
80105c82:	56                   	push   %esi
80105c83:	e8 98 c2 ff ff       	call   80101f20 <dirlookup>
80105c88:	83 c4 10             	add    $0x10,%esp
80105c8b:	85 c0                	test   %eax,%eax
80105c8d:	89 c3                	mov    %eax,%ebx
80105c8f:	0f 84 cf 00 00 00    	je     80105d64 <sys_unlink+0x164>
  ilock(ip);
80105c95:	83 ec 0c             	sub    $0xc,%esp
80105c98:	50                   	push   %eax
80105c99:	e8 52 bd ff ff       	call   801019f0 <ilock>
  if(ip->nlink < 1)
80105c9e:	83 c4 10             	add    $0x10,%esp
80105ca1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105ca6:	0f 8e 10 01 00 00    	jle    80105dbc <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105cac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105cb1:	74 6d                	je     80105d20 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105cb3:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105cb6:	83 ec 04             	sub    $0x4,%esp
80105cb9:	6a 10                	push   $0x10
80105cbb:	6a 00                	push   $0x0
80105cbd:	50                   	push   %eax
80105cbe:	e8 9d f5 ff ff       	call   80105260 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105cc3:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105cc6:	6a 10                	push   $0x10
80105cc8:	ff 75 c4             	pushl  -0x3c(%ebp)
80105ccb:	50                   	push   %eax
80105ccc:	56                   	push   %esi
80105ccd:	e8 fe c0 ff ff       	call   80101dd0 <writei>
80105cd2:	83 c4 20             	add    $0x20,%esp
80105cd5:	83 f8 10             	cmp    $0x10,%eax
80105cd8:	0f 85 eb 00 00 00    	jne    80105dc9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80105cde:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ce3:	0f 84 97 00 00 00    	je     80105d80 <sys_unlink+0x180>
  iunlockput(dp);
80105ce9:	83 ec 0c             	sub    $0xc,%esp
80105cec:	56                   	push   %esi
80105ced:	e8 8e bf ff ff       	call   80101c80 <iunlockput>
  ip->nlink--;
80105cf2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105cf7:	89 1c 24             	mov    %ebx,(%esp)
80105cfa:	e8 41 bc ff ff       	call   80101940 <iupdate>
  iunlockput(ip);
80105cff:	89 1c 24             	mov    %ebx,(%esp)
80105d02:	e8 79 bf ff ff       	call   80101c80 <iunlockput>
  end_op();
80105d07:	e8 f4 d2 ff ff       	call   80103000 <end_op>
  return 0;
80105d0c:	83 c4 10             	add    $0x10,%esp
80105d0f:	31 c0                	xor    %eax,%eax
}
80105d11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d14:	5b                   	pop    %ebx
80105d15:	5e                   	pop    %esi
80105d16:	5f                   	pop    %edi
80105d17:	5d                   	pop    %ebp
80105d18:	c3                   	ret    
80105d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105d20:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105d24:	76 8d                	jbe    80105cb3 <sys_unlink+0xb3>
80105d26:	bf 20 00 00 00       	mov    $0x20,%edi
80105d2b:	eb 0f                	jmp    80105d3c <sys_unlink+0x13c>
80105d2d:	8d 76 00             	lea    0x0(%esi),%esi
80105d30:	83 c7 10             	add    $0x10,%edi
80105d33:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105d36:	0f 83 77 ff ff ff    	jae    80105cb3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d3c:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105d3f:	6a 10                	push   $0x10
80105d41:	57                   	push   %edi
80105d42:	50                   	push   %eax
80105d43:	53                   	push   %ebx
80105d44:	e8 87 bf ff ff       	call   80101cd0 <readi>
80105d49:	83 c4 10             	add    $0x10,%esp
80105d4c:	83 f8 10             	cmp    $0x10,%eax
80105d4f:	75 5e                	jne    80105daf <sys_unlink+0x1af>
    if(de.inum != 0)
80105d51:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105d56:	74 d8                	je     80105d30 <sys_unlink+0x130>
    iunlockput(ip);
80105d58:	83 ec 0c             	sub    $0xc,%esp
80105d5b:	53                   	push   %ebx
80105d5c:	e8 1f bf ff ff       	call   80101c80 <iunlockput>
    goto bad;
80105d61:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105d64:	83 ec 0c             	sub    $0xc,%esp
80105d67:	56                   	push   %esi
80105d68:	e8 13 bf ff ff       	call   80101c80 <iunlockput>
  end_op();
80105d6d:	e8 8e d2 ff ff       	call   80103000 <end_op>
  return -1;
80105d72:	83 c4 10             	add    $0x10,%esp
80105d75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d7a:	eb 95                	jmp    80105d11 <sys_unlink+0x111>
80105d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105d80:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105d85:	83 ec 0c             	sub    $0xc,%esp
80105d88:	56                   	push   %esi
80105d89:	e8 b2 bb ff ff       	call   80101940 <iupdate>
80105d8e:	83 c4 10             	add    $0x10,%esp
80105d91:	e9 53 ff ff ff       	jmp    80105ce9 <sys_unlink+0xe9>
    return -1;
80105d96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d9b:	e9 71 ff ff ff       	jmp    80105d11 <sys_unlink+0x111>
    end_op();
80105da0:	e8 5b d2 ff ff       	call   80103000 <end_op>
    return -1;
80105da5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105daa:	e9 62 ff ff ff       	jmp    80105d11 <sys_unlink+0x111>
      panic("isdirempty: readi");
80105daf:	83 ec 0c             	sub    $0xc,%esp
80105db2:	68 18 89 10 80       	push   $0x80108918
80105db7:	e8 d4 a5 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105dbc:	83 ec 0c             	sub    $0xc,%esp
80105dbf:	68 06 89 10 80       	push   $0x80108906
80105dc4:	e8 c7 a5 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105dc9:	83 ec 0c             	sub    $0xc,%esp
80105dcc:	68 2a 89 10 80       	push   $0x8010892a
80105dd1:	e8 ba a5 ff ff       	call   80100390 <panic>
80105dd6:	8d 76 00             	lea    0x0(%esi),%esi
80105dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105de0 <sys_open>:

int
sys_open(void)
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
80105de3:	57                   	push   %edi
80105de4:	56                   	push   %esi
80105de5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105de6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105de9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105dec:	50                   	push   %eax
80105ded:	6a 00                	push   $0x0
80105def:	e8 1c f8 ff ff       	call   80105610 <argstr>
80105df4:	83 c4 10             	add    $0x10,%esp
80105df7:	85 c0                	test   %eax,%eax
80105df9:	0f 88 1d 01 00 00    	js     80105f1c <sys_open+0x13c>
80105dff:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e02:	83 ec 08             	sub    $0x8,%esp
80105e05:	50                   	push   %eax
80105e06:	6a 01                	push   $0x1
80105e08:	e8 53 f7 ff ff       	call   80105560 <argint>
80105e0d:	83 c4 10             	add    $0x10,%esp
80105e10:	85 c0                	test   %eax,%eax
80105e12:	0f 88 04 01 00 00    	js     80105f1c <sys_open+0x13c>
    return -1;

  begin_op();
80105e18:	e8 73 d1 ff ff       	call   80102f90 <begin_op>

  if(omode & O_CREATE){
80105e1d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105e21:	0f 85 a9 00 00 00    	jne    80105ed0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105e27:	83 ec 0c             	sub    $0xc,%esp
80105e2a:	ff 75 e0             	pushl  -0x20(%ebp)
80105e2d:	e8 1e c4 ff ff       	call   80102250 <namei>
80105e32:	83 c4 10             	add    $0x10,%esp
80105e35:	85 c0                	test   %eax,%eax
80105e37:	89 c6                	mov    %eax,%esi
80105e39:	0f 84 b2 00 00 00    	je     80105ef1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
80105e3f:	83 ec 0c             	sub    $0xc,%esp
80105e42:	50                   	push   %eax
80105e43:	e8 a8 bb ff ff       	call   801019f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e48:	83 c4 10             	add    $0x10,%esp
80105e4b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105e50:	0f 84 aa 00 00 00    	je     80105f00 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e56:	e8 85 b2 ff ff       	call   801010e0 <filealloc>
80105e5b:	85 c0                	test   %eax,%eax
80105e5d:	89 c7                	mov    %eax,%edi
80105e5f:	0f 84 a6 00 00 00    	je     80105f0b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105e65:	e8 b6 dd ff ff       	call   80103c20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105e6a:	31 db                	xor    %ebx,%ebx
80105e6c:	eb 0e                	jmp    80105e7c <sys_open+0x9c>
80105e6e:	66 90                	xchg   %ax,%ax
80105e70:	83 c3 01             	add    $0x1,%ebx
80105e73:	83 fb 10             	cmp    $0x10,%ebx
80105e76:	0f 84 ac 00 00 00    	je     80105f28 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
80105e7c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105e80:	85 d2                	test   %edx,%edx
80105e82:	75 ec                	jne    80105e70 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105e84:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105e87:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105e8b:	56                   	push   %esi
80105e8c:	e8 3f bc ff ff       	call   80101ad0 <iunlock>
  end_op();
80105e91:	e8 6a d1 ff ff       	call   80103000 <end_op>

  f->type = FD_INODE;
80105e96:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105e9c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e9f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105ea2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105ea5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105eac:	89 d0                	mov    %edx,%eax
80105eae:	f7 d0                	not    %eax
80105eb0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105eb3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105eb6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105eb9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105ebd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ec0:	89 d8                	mov    %ebx,%eax
80105ec2:	5b                   	pop    %ebx
80105ec3:	5e                   	pop    %esi
80105ec4:	5f                   	pop    %edi
80105ec5:	5d                   	pop    %ebp
80105ec6:	c3                   	ret    
80105ec7:	89 f6                	mov    %esi,%esi
80105ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105ed0:	83 ec 0c             	sub    $0xc,%esp
80105ed3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105ed6:	31 c9                	xor    %ecx,%ecx
80105ed8:	6a 00                	push   $0x0
80105eda:	ba 02 00 00 00       	mov    $0x2,%edx
80105edf:	e8 ec f7 ff ff       	call   801056d0 <create>
    if(ip == 0){
80105ee4:	83 c4 10             	add    $0x10,%esp
80105ee7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105ee9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105eeb:	0f 85 65 ff ff ff    	jne    80105e56 <sys_open+0x76>
      end_op();
80105ef1:	e8 0a d1 ff ff       	call   80103000 <end_op>
      return -1;
80105ef6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105efb:	eb c0                	jmp    80105ebd <sys_open+0xdd>
80105efd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105f00:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105f03:	85 c9                	test   %ecx,%ecx
80105f05:	0f 84 4b ff ff ff    	je     80105e56 <sys_open+0x76>
    iunlockput(ip);
80105f0b:	83 ec 0c             	sub    $0xc,%esp
80105f0e:	56                   	push   %esi
80105f0f:	e8 6c bd ff ff       	call   80101c80 <iunlockput>
    end_op();
80105f14:	e8 e7 d0 ff ff       	call   80103000 <end_op>
    return -1;
80105f19:	83 c4 10             	add    $0x10,%esp
80105f1c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105f21:	eb 9a                	jmp    80105ebd <sys_open+0xdd>
80105f23:	90                   	nop
80105f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105f28:	83 ec 0c             	sub    $0xc,%esp
80105f2b:	57                   	push   %edi
80105f2c:	e8 6f b2 ff ff       	call   801011a0 <fileclose>
80105f31:	83 c4 10             	add    $0x10,%esp
80105f34:	eb d5                	jmp    80105f0b <sys_open+0x12b>
80105f36:	8d 76 00             	lea    0x0(%esi),%esi
80105f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f40 <sys_mkdir>:

int
sys_mkdir(void)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105f46:	e8 45 d0 ff ff       	call   80102f90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105f4b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f4e:	83 ec 08             	sub    $0x8,%esp
80105f51:	50                   	push   %eax
80105f52:	6a 00                	push   $0x0
80105f54:	e8 b7 f6 ff ff       	call   80105610 <argstr>
80105f59:	83 c4 10             	add    $0x10,%esp
80105f5c:	85 c0                	test   %eax,%eax
80105f5e:	78 30                	js     80105f90 <sys_mkdir+0x50>
80105f60:	83 ec 0c             	sub    $0xc,%esp
80105f63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f66:	31 c9                	xor    %ecx,%ecx
80105f68:	6a 00                	push   $0x0
80105f6a:	ba 01 00 00 00       	mov    $0x1,%edx
80105f6f:	e8 5c f7 ff ff       	call   801056d0 <create>
80105f74:	83 c4 10             	add    $0x10,%esp
80105f77:	85 c0                	test   %eax,%eax
80105f79:	74 15                	je     80105f90 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f7b:	83 ec 0c             	sub    $0xc,%esp
80105f7e:	50                   	push   %eax
80105f7f:	e8 fc bc ff ff       	call   80101c80 <iunlockput>
  end_op();
80105f84:	e8 77 d0 ff ff       	call   80103000 <end_op>
  return 0;
80105f89:	83 c4 10             	add    $0x10,%esp
80105f8c:	31 c0                	xor    %eax,%eax
}
80105f8e:	c9                   	leave  
80105f8f:	c3                   	ret    
    end_op();
80105f90:	e8 6b d0 ff ff       	call   80103000 <end_op>
    return -1;
80105f95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f9a:	c9                   	leave  
80105f9b:	c3                   	ret    
80105f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fa0 <sys_mknod>:

int
sys_mknod(void)
{
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
80105fa3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105fa6:	e8 e5 cf ff ff       	call   80102f90 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105fab:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105fae:	83 ec 08             	sub    $0x8,%esp
80105fb1:	50                   	push   %eax
80105fb2:	6a 00                	push   $0x0
80105fb4:	e8 57 f6 ff ff       	call   80105610 <argstr>
80105fb9:	83 c4 10             	add    $0x10,%esp
80105fbc:	85 c0                	test   %eax,%eax
80105fbe:	78 60                	js     80106020 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105fc0:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105fc3:	83 ec 08             	sub    $0x8,%esp
80105fc6:	50                   	push   %eax
80105fc7:	6a 01                	push   $0x1
80105fc9:	e8 92 f5 ff ff       	call   80105560 <argint>
  if((argstr(0, &path)) < 0 ||
80105fce:	83 c4 10             	add    $0x10,%esp
80105fd1:	85 c0                	test   %eax,%eax
80105fd3:	78 4b                	js     80106020 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105fd5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fd8:	83 ec 08             	sub    $0x8,%esp
80105fdb:	50                   	push   %eax
80105fdc:	6a 02                	push   $0x2
80105fde:	e8 7d f5 ff ff       	call   80105560 <argint>
     argint(1, &major) < 0 ||
80105fe3:	83 c4 10             	add    $0x10,%esp
80105fe6:	85 c0                	test   %eax,%eax
80105fe8:	78 36                	js     80106020 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105fea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105fee:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105ff1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105ff5:	ba 03 00 00 00       	mov    $0x3,%edx
80105ffa:	50                   	push   %eax
80105ffb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105ffe:	e8 cd f6 ff ff       	call   801056d0 <create>
80106003:	83 c4 10             	add    $0x10,%esp
80106006:	85 c0                	test   %eax,%eax
80106008:	74 16                	je     80106020 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010600a:	83 ec 0c             	sub    $0xc,%esp
8010600d:	50                   	push   %eax
8010600e:	e8 6d bc ff ff       	call   80101c80 <iunlockput>
  end_op();
80106013:	e8 e8 cf ff ff       	call   80103000 <end_op>
  return 0;
80106018:	83 c4 10             	add    $0x10,%esp
8010601b:	31 c0                	xor    %eax,%eax
}
8010601d:	c9                   	leave  
8010601e:	c3                   	ret    
8010601f:	90                   	nop
    end_op();
80106020:	e8 db cf ff ff       	call   80103000 <end_op>
    return -1;
80106025:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010602a:	c9                   	leave  
8010602b:	c3                   	ret    
8010602c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106030 <sys_chdir>:

int
sys_chdir(void)
{
80106030:	55                   	push   %ebp
80106031:	89 e5                	mov    %esp,%ebp
80106033:	56                   	push   %esi
80106034:	53                   	push   %ebx
80106035:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106038:	e8 e3 db ff ff       	call   80103c20 <myproc>
8010603d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010603f:	e8 4c cf ff ff       	call   80102f90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106044:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106047:	83 ec 08             	sub    $0x8,%esp
8010604a:	50                   	push   %eax
8010604b:	6a 00                	push   $0x0
8010604d:	e8 be f5 ff ff       	call   80105610 <argstr>
80106052:	83 c4 10             	add    $0x10,%esp
80106055:	85 c0                	test   %eax,%eax
80106057:	78 77                	js     801060d0 <sys_chdir+0xa0>
80106059:	83 ec 0c             	sub    $0xc,%esp
8010605c:	ff 75 f4             	pushl  -0xc(%ebp)
8010605f:	e8 ec c1 ff ff       	call   80102250 <namei>
80106064:	83 c4 10             	add    $0x10,%esp
80106067:	85 c0                	test   %eax,%eax
80106069:	89 c3                	mov    %eax,%ebx
8010606b:	74 63                	je     801060d0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010606d:	83 ec 0c             	sub    $0xc,%esp
80106070:	50                   	push   %eax
80106071:	e8 7a b9 ff ff       	call   801019f0 <ilock>
  if(ip->type != T_DIR){
80106076:	83 c4 10             	add    $0x10,%esp
80106079:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010607e:	75 30                	jne    801060b0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106080:	83 ec 0c             	sub    $0xc,%esp
80106083:	53                   	push   %ebx
80106084:	e8 47 ba ff ff       	call   80101ad0 <iunlock>
  iput(curproc->cwd);
80106089:	58                   	pop    %eax
8010608a:	ff 76 68             	pushl  0x68(%esi)
8010608d:	e8 8e ba ff ff       	call   80101b20 <iput>
  end_op();
80106092:	e8 69 cf ff ff       	call   80103000 <end_op>
  curproc->cwd = ip;
80106097:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010609a:	83 c4 10             	add    $0x10,%esp
8010609d:	31 c0                	xor    %eax,%eax
}
8010609f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801060a2:	5b                   	pop    %ebx
801060a3:	5e                   	pop    %esi
801060a4:	5d                   	pop    %ebp
801060a5:	c3                   	ret    
801060a6:	8d 76 00             	lea    0x0(%esi),%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801060b0:	83 ec 0c             	sub    $0xc,%esp
801060b3:	53                   	push   %ebx
801060b4:	e8 c7 bb ff ff       	call   80101c80 <iunlockput>
    end_op();
801060b9:	e8 42 cf ff ff       	call   80103000 <end_op>
    return -1;
801060be:	83 c4 10             	add    $0x10,%esp
801060c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060c6:	eb d7                	jmp    8010609f <sys_chdir+0x6f>
801060c8:	90                   	nop
801060c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801060d0:	e8 2b cf ff ff       	call   80103000 <end_op>
    return -1;
801060d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060da:	eb c3                	jmp    8010609f <sys_chdir+0x6f>
801060dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801060e0 <sys_exec>:

int
sys_exec(void)
{
801060e0:	55                   	push   %ebp
801060e1:	89 e5                	mov    %esp,%ebp
801060e3:	57                   	push   %edi
801060e4:	56                   	push   %esi
801060e5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801060e6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801060ec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801060f2:	50                   	push   %eax
801060f3:	6a 00                	push   $0x0
801060f5:	e8 16 f5 ff ff       	call   80105610 <argstr>
801060fa:	83 c4 10             	add    $0x10,%esp
801060fd:	85 c0                	test   %eax,%eax
801060ff:	0f 88 87 00 00 00    	js     8010618c <sys_exec+0xac>
80106105:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010610b:	83 ec 08             	sub    $0x8,%esp
8010610e:	50                   	push   %eax
8010610f:	6a 01                	push   $0x1
80106111:	e8 4a f4 ff ff       	call   80105560 <argint>
80106116:	83 c4 10             	add    $0x10,%esp
80106119:	85 c0                	test   %eax,%eax
8010611b:	78 6f                	js     8010618c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010611d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106123:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80106126:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106128:	68 80 00 00 00       	push   $0x80
8010612d:	6a 00                	push   $0x0
8010612f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106135:	50                   	push   %eax
80106136:	e8 25 f1 ff ff       	call   80105260 <memset>
8010613b:	83 c4 10             	add    $0x10,%esp
8010613e:	eb 2c                	jmp    8010616c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106140:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106146:	85 c0                	test   %eax,%eax
80106148:	74 56                	je     801061a0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010614a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106150:	83 ec 08             	sub    $0x8,%esp
80106153:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106156:	52                   	push   %edx
80106157:	50                   	push   %eax
80106158:	e8 93 f3 ff ff       	call   801054f0 <fetchstr>
8010615d:	83 c4 10             	add    $0x10,%esp
80106160:	85 c0                	test   %eax,%eax
80106162:	78 28                	js     8010618c <sys_exec+0xac>
  for(i=0;; i++){
80106164:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106167:	83 fb 20             	cmp    $0x20,%ebx
8010616a:	74 20                	je     8010618c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010616c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106172:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106179:	83 ec 08             	sub    $0x8,%esp
8010617c:	57                   	push   %edi
8010617d:	01 f0                	add    %esi,%eax
8010617f:	50                   	push   %eax
80106180:	e8 2b f3 ff ff       	call   801054b0 <fetchint>
80106185:	83 c4 10             	add    $0x10,%esp
80106188:	85 c0                	test   %eax,%eax
8010618a:	79 b4                	jns    80106140 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010618c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010618f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106194:	5b                   	pop    %ebx
80106195:	5e                   	pop    %esi
80106196:	5f                   	pop    %edi
80106197:	5d                   	pop    %ebp
80106198:	c3                   	ret    
80106199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801061a0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801061a6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801061a9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801061b0:	00 00 00 00 
  return exec(path, argv);
801061b4:	50                   	push   %eax
801061b5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801061bb:	e8 50 ab ff ff       	call   80100d10 <exec>
801061c0:	83 c4 10             	add    $0x10,%esp
}
801061c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061c6:	5b                   	pop    %ebx
801061c7:	5e                   	pop    %esi
801061c8:	5f                   	pop    %edi
801061c9:	5d                   	pop    %ebp
801061ca:	c3                   	ret    
801061cb:	90                   	nop
801061cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801061d0 <sys_pipe>:

int
sys_pipe(void)
{
801061d0:	55                   	push   %ebp
801061d1:	89 e5                	mov    %esp,%ebp
801061d3:	57                   	push   %edi
801061d4:	56                   	push   %esi
801061d5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801061d6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801061d9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801061dc:	6a 08                	push   $0x8
801061de:	50                   	push   %eax
801061df:	6a 00                	push   $0x0
801061e1:	e8 ca f3 ff ff       	call   801055b0 <argptr>
801061e6:	83 c4 10             	add    $0x10,%esp
801061e9:	85 c0                	test   %eax,%eax
801061eb:	0f 88 ae 00 00 00    	js     8010629f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801061f1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801061f4:	83 ec 08             	sub    $0x8,%esp
801061f7:	50                   	push   %eax
801061f8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801061fb:	50                   	push   %eax
801061fc:	e8 2f d4 ff ff       	call   80103630 <pipealloc>
80106201:	83 c4 10             	add    $0x10,%esp
80106204:	85 c0                	test   %eax,%eax
80106206:	0f 88 93 00 00 00    	js     8010629f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010620c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010620f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106211:	e8 0a da ff ff       	call   80103c20 <myproc>
80106216:	eb 10                	jmp    80106228 <sys_pipe+0x58>
80106218:	90                   	nop
80106219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106220:	83 c3 01             	add    $0x1,%ebx
80106223:	83 fb 10             	cmp    $0x10,%ebx
80106226:	74 60                	je     80106288 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80106228:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010622c:	85 f6                	test   %esi,%esi
8010622e:	75 f0                	jne    80106220 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106230:	8d 73 08             	lea    0x8(%ebx),%esi
80106233:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106237:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010623a:	e8 e1 d9 ff ff       	call   80103c20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010623f:	31 d2                	xor    %edx,%edx
80106241:	eb 0d                	jmp    80106250 <sys_pipe+0x80>
80106243:	90                   	nop
80106244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106248:	83 c2 01             	add    $0x1,%edx
8010624b:	83 fa 10             	cmp    $0x10,%edx
8010624e:	74 28                	je     80106278 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80106250:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106254:	85 c9                	test   %ecx,%ecx
80106256:	75 f0                	jne    80106248 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80106258:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010625c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010625f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106261:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106264:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106267:	31 c0                	xor    %eax,%eax
}
80106269:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010626c:	5b                   	pop    %ebx
8010626d:	5e                   	pop    %esi
8010626e:	5f                   	pop    %edi
8010626f:	5d                   	pop    %ebp
80106270:	c3                   	ret    
80106271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80106278:	e8 a3 d9 ff ff       	call   80103c20 <myproc>
8010627d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106284:	00 
80106285:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80106288:	83 ec 0c             	sub    $0xc,%esp
8010628b:	ff 75 e0             	pushl  -0x20(%ebp)
8010628e:	e8 0d af ff ff       	call   801011a0 <fileclose>
    fileclose(wf);
80106293:	58                   	pop    %eax
80106294:	ff 75 e4             	pushl  -0x1c(%ebp)
80106297:	e8 04 af ff ff       	call   801011a0 <fileclose>
    return -1;
8010629c:	83 c4 10             	add    $0x10,%esp
8010629f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062a4:	eb c3                	jmp    80106269 <sys_pipe+0x99>
801062a6:	66 90                	xchg   %ax,%ax
801062a8:	66 90                	xchg   %ax,%ax
801062aa:	66 90                	xchg   %ax,%ax
801062ac:	66 90                	xchg   %ax,%ax
801062ae:	66 90                	xchg   %ax,%ax

801062b0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801062b3:	5d                   	pop    %ebp
  return fork();
801062b4:	e9 07 db ff ff       	jmp    80103dc0 <fork>
801062b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801062c0 <sys_exit>:

int
sys_exit(void)
{
801062c0:	55                   	push   %ebp
801062c1:	89 e5                	mov    %esp,%ebp
801062c3:	83 ec 08             	sub    $0x8,%esp
  exit();
801062c6:	e8 d5 dc ff ff       	call   80103fa0 <exit>
  return 0;  // not reached
}
801062cb:	31 c0                	xor    %eax,%eax
801062cd:	c9                   	leave  
801062ce:	c3                   	ret    
801062cf:	90                   	nop

801062d0 <sys_wait>:

int
sys_wait(void)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801062d3:	5d                   	pop    %ebp
  return wait();
801062d4:	e9 07 df ff ff       	jmp    801041e0 <wait>
801062d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801062e0 <sys_kill>:

int
sys_kill(void)
{
801062e0:	55                   	push   %ebp
801062e1:	89 e5                	mov    %esp,%ebp
801062e3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801062e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062e9:	50                   	push   %eax
801062ea:	6a 00                	push   $0x0
801062ec:	e8 6f f2 ff ff       	call   80105560 <argint>
801062f1:	83 c4 10             	add    $0x10,%esp
801062f4:	85 c0                	test   %eax,%eax
801062f6:	78 18                	js     80106310 <sys_kill+0x30>
    return -1;
  return kill(pid);
801062f8:	83 ec 0c             	sub    $0xc,%esp
801062fb:	ff 75 f4             	pushl  -0xc(%ebp)
801062fe:	e8 3d e0 ff ff       	call   80104340 <kill>
80106303:	83 c4 10             	add    $0x10,%esp
}
80106306:	c9                   	leave  
80106307:	c3                   	ret    
80106308:	90                   	nop
80106309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106315:	c9                   	leave  
80106316:	c3                   	ret    
80106317:	89 f6                	mov    %esi,%esi
80106319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106320 <sys_getpid>:

int
sys_getpid(void)
{
80106320:	55                   	push   %ebp
80106321:	89 e5                	mov    %esp,%ebp
80106323:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106326:	e8 f5 d8 ff ff       	call   80103c20 <myproc>
8010632b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010632e:	c9                   	leave  
8010632f:	c3                   	ret    

80106330 <sys_sbrk>:

int
sys_sbrk(void)
{
80106330:	55                   	push   %ebp
80106331:	89 e5                	mov    %esp,%ebp
80106333:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106334:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106337:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010633a:	50                   	push   %eax
8010633b:	6a 00                	push   $0x0
8010633d:	e8 1e f2 ff ff       	call   80105560 <argint>
80106342:	83 c4 10             	add    $0x10,%esp
80106345:	85 c0                	test   %eax,%eax
80106347:	78 27                	js     80106370 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106349:	e8 d2 d8 ff ff       	call   80103c20 <myproc>
  if(growproc(n) < 0)
8010634e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106351:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106353:	ff 75 f4             	pushl  -0xc(%ebp)
80106356:	e8 e5 d9 ff ff       	call   80103d40 <growproc>
8010635b:	83 c4 10             	add    $0x10,%esp
8010635e:	85 c0                	test   %eax,%eax
80106360:	78 0e                	js     80106370 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106362:	89 d8                	mov    %ebx,%eax
80106364:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106367:	c9                   	leave  
80106368:	c3                   	ret    
80106369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106370:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106375:	eb eb                	jmp    80106362 <sys_sbrk+0x32>
80106377:	89 f6                	mov    %esi,%esi
80106379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106380 <sys_sleep>:

int
sys_sleep(void)
{
80106380:	55                   	push   %ebp
80106381:	89 e5                	mov    %esp,%ebp
80106383:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106384:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106387:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010638a:	50                   	push   %eax
8010638b:	6a 00                	push   $0x0
8010638d:	e8 ce f1 ff ff       	call   80105560 <argint>
80106392:	83 c4 10             	add    $0x10,%esp
80106395:	85 c0                	test   %eax,%eax
80106397:	0f 88 8a 00 00 00    	js     80106427 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010639d:	83 ec 0c             	sub    $0xc,%esp
801063a0:	68 80 65 11 80       	push   $0x80116580
801063a5:	e8 a6 ed ff ff       	call   80105150 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801063aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063ad:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801063b0:	8b 1d c0 6d 11 80    	mov    0x80116dc0,%ebx
  while(ticks - ticks0 < n){
801063b6:	85 d2                	test   %edx,%edx
801063b8:	75 27                	jne    801063e1 <sys_sleep+0x61>
801063ba:	eb 54                	jmp    80106410 <sys_sleep+0x90>
801063bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801063c0:	83 ec 08             	sub    $0x8,%esp
801063c3:	68 80 65 11 80       	push   $0x80116580
801063c8:	68 c0 6d 11 80       	push   $0x80116dc0
801063cd:	e8 4e dd ff ff       	call   80104120 <sleep>
  while(ticks - ticks0 < n){
801063d2:	a1 c0 6d 11 80       	mov    0x80116dc0,%eax
801063d7:	83 c4 10             	add    $0x10,%esp
801063da:	29 d8                	sub    %ebx,%eax
801063dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801063df:	73 2f                	jae    80106410 <sys_sleep+0x90>
    if(myproc()->killed){
801063e1:	e8 3a d8 ff ff       	call   80103c20 <myproc>
801063e6:	8b 40 24             	mov    0x24(%eax),%eax
801063e9:	85 c0                	test   %eax,%eax
801063eb:	74 d3                	je     801063c0 <sys_sleep+0x40>
      release(&tickslock);
801063ed:	83 ec 0c             	sub    $0xc,%esp
801063f0:	68 80 65 11 80       	push   $0x80116580
801063f5:	e8 16 ee ff ff       	call   80105210 <release>
      return -1;
801063fa:	83 c4 10             	add    $0x10,%esp
801063fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106402:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106405:	c9                   	leave  
80106406:	c3                   	ret    
80106407:	89 f6                	mov    %esi,%esi
80106409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106410:	83 ec 0c             	sub    $0xc,%esp
80106413:	68 80 65 11 80       	push   $0x80116580
80106418:	e8 f3 ed ff ff       	call   80105210 <release>
  return 0;
8010641d:	83 c4 10             	add    $0x10,%esp
80106420:	31 c0                	xor    %eax,%eax
}
80106422:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106425:	c9                   	leave  
80106426:	c3                   	ret    
    return -1;
80106427:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010642c:	eb f4                	jmp    80106422 <sys_sleep+0xa2>
8010642e:	66 90                	xchg   %ax,%ax

80106430 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106430:	55                   	push   %ebp
80106431:	89 e5                	mov    %esp,%ebp
80106433:	53                   	push   %ebx
80106434:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106437:	68 80 65 11 80       	push   $0x80116580
8010643c:	e8 0f ed ff ff       	call   80105150 <acquire>
  xticks = ticks;
80106441:	8b 1d c0 6d 11 80    	mov    0x80116dc0,%ebx
  release(&tickslock);
80106447:	c7 04 24 80 65 11 80 	movl   $0x80116580,(%esp)
8010644e:	e8 bd ed ff ff       	call   80105210 <release>
  return xticks;
}
80106453:	89 d8                	mov    %ebx,%eax
80106455:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106458:	c9                   	leave  
80106459:	c3                   	ret    
8010645a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106460 <sys_incNum>:

int
sys_incNum(int num)
{
80106460:	55                   	push   %ebp
80106461:	89 e5                	mov    %esp,%ebp
80106463:	83 ec 10             	sub    $0x10,%esp
  num++;
80106466:	8b 45 08             	mov    0x8(%ebp),%eax
80106469:	83 c0 01             	add    $0x1,%eax
  cprintf("increased and print in kernel surface %d\n",num);
8010646c:	50                   	push   %eax
8010646d:	68 3c 89 10 80       	push   $0x8010893c
80106472:	e8 e9 a1 ff ff       	call   80100660 <cprintf>
  return 22;
}
80106477:	b8 16 00 00 00       	mov    $0x16,%eax
8010647c:	c9                   	leave  
8010647d:	c3                   	ret    
8010647e:	66 90                	xchg   %ax,%ax

80106480 <sys_getprocs>:

int
sys_getprocs()
{
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
  return getprocs();
}
80106483:	5d                   	pop    %ebp
  return getprocs();
80106484:	e9 c7 e0 ff ff       	jmp    80104550 <getprocs>
80106489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106490 <sys_set_burst_time>:

void sys_set_burst_time()
{
80106490:	55                   	push   %ebp
80106491:	89 e5                	mov    %esp,%ebp
80106493:	83 ec 20             	sub    $0x20,%esp
  int burst_time;
  argint(0, &burst_time);
80106496:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106499:	50                   	push   %eax
8010649a:	6a 00                	push   $0x0
8010649c:	e8 bf f0 ff ff       	call   80105560 <argint>
  int pid;
  argint(1, &pid);
801064a1:	58                   	pop    %eax
801064a2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064a5:	5a                   	pop    %edx
801064a6:	50                   	push   %eax
801064a7:	6a 01                	push   $0x1
801064a9:	e8 b2 f0 ff ff       	call   80105560 <argint>
  find_and_set_burst_time(burst_time , pid);
801064ae:	59                   	pop    %ecx
801064af:	58                   	pop    %eax
801064b0:	ff 75 f4             	pushl  -0xc(%ebp)
801064b3:	ff 75 f0             	pushl  -0x10(%ebp)
801064b6:	e8 25 e3 ff ff       	call   801047e0 <find_and_set_burst_time>
}
801064bb:	83 c4 10             	add    $0x10,%esp
801064be:	c9                   	leave  
801064bf:	c3                   	ret    

801064c0 <sys_set_priority>:
void sys_set_priority()
{
801064c0:	55                   	push   %ebp
801064c1:	89 e5                	mov    %esp,%ebp
801064c3:	83 ec 20             	sub    $0x20,%esp
  int priority;
  argint(0, &priority);
801064c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064c9:	50                   	push   %eax
801064ca:	6a 00                	push   $0x0
801064cc:	e8 8f f0 ff ff       	call   80105560 <argint>
  int pid;
  argint(1, &pid);
801064d1:	58                   	pop    %eax
801064d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064d5:	5a                   	pop    %edx
801064d6:	50                   	push   %eax
801064d7:	6a 01                	push   $0x1
801064d9:	e8 82 f0 ff ff       	call   80105560 <argint>
  find_and_set_priority(priority, pid);
801064de:	59                   	pop    %ecx
801064df:	58                   	pop    %eax
801064e0:	ff 75 f4             	pushl  -0xc(%ebp)
801064e3:	ff 75 f0             	pushl  -0x10(%ebp)
801064e6:	e8 65 e2 ff ff       	call   80104750 <find_and_set_priority>
}
801064eb:	83 c4 10             	add    $0x10,%esp
801064ee:	c9                   	leave  
801064ef:	c3                   	ret    

801064f0 <sys_set_lottery_ticket>:

void sys_set_lottery_ticket(){
801064f0:	55                   	push   %ebp
801064f1:	89 e5                	mov    %esp,%ebp
801064f3:	83 ec 20             	sub    $0x20,%esp
  int lottery_ticket;
  argint(0, &lottery_ticket);
801064f6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064f9:	50                   	push   %eax
801064fa:	6a 00                	push   $0x0
801064fc:	e8 5f f0 ff ff       	call   80105560 <argint>
  int pid;
  argint(1, &pid);
80106501:	58                   	pop    %eax
80106502:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106505:	5a                   	pop    %edx
80106506:	50                   	push   %eax
80106507:	6a 01                	push   $0x1
80106509:	e8 52 f0 ff ff       	call   80105560 <argint>
  find_and_set_lottery_ticket(lottery_ticket , pid);
8010650e:	59                   	pop    %ecx
8010650f:	58                   	pop    %eax
80106510:	ff 75 f4             	pushl  -0xc(%ebp)
80106513:	ff 75 f0             	pushl  -0x10(%ebp)
80106516:	e8 65 e2 ff ff       	call   80104780 <find_and_set_lottery_ticket>
}
8010651b:	83 c4 10             	add    $0x10,%esp
8010651e:	c9                   	leave  
8010651f:	c3                   	ret    

80106520 <sys_set_sched_queue>:

void sys_set_sched_queue()
{
80106520:	55                   	push   %ebp
80106521:	89 e5                	mov    %esp,%ebp
80106523:	83 ec 20             	sub    $0x20,%esp
  int qeue_number;
  argint(0, &qeue_number);
80106526:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106529:	50                   	push   %eax
8010652a:	6a 00                	push   $0x0
8010652c:	e8 2f f0 ff ff       	call   80105560 <argint>
  int pid;
  argint(1, &pid);
80106531:	58                   	pop    %eax
80106532:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106535:	5a                   	pop    %edx
80106536:	50                   	push   %eax
80106537:	6a 01                	push   $0x1
80106539:	e8 22 f0 ff ff       	call   80105560 <argint>
  find_and_set_sched_queue(qeue_number, pid);
8010653e:	59                   	pop    %ecx
8010653f:	58                   	pop    %eax
80106540:	ff 75 f4             	pushl  -0xc(%ebp)
80106543:	ff 75 f0             	pushl  -0x10(%ebp)
80106546:	e8 65 e2 ff ff       	call   801047b0 <find_and_set_sched_queue>
}
8010654b:	83 c4 10             	add    $0x10,%esp
8010654e:	c9                   	leave  
8010654f:	c3                   	ret    

80106550 <sys_show_processes_scheduling>:

void sys_show_processes_scheduling()
{
80106550:	55                   	push   %ebp
80106551:	89 e5                	mov    %esp,%ebp
  show_all_processes_scheduling();
}
80106553:	5d                   	pop    %ebp
  show_all_processes_scheduling();
80106554:	e9 b7 e3 ff ff       	jmp    80104910 <show_all_processes_scheduling>
80106559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106560 <sys_getNumFreePages>:

// Part 5
int
sys_getNumFreePages()
{
80106560:	55                   	push   %ebp
80106561:	89 e5                	mov    %esp,%ebp
  return getNumFreePages();
80106563:	5d                   	pop    %ebp
  return getNumFreePages();
80106564:	e9 57 c3 ff ff       	jmp    801028c0 <getNumFreePages>

80106569 <alltraps>:
80106569:	1e                   	push   %ds
8010656a:	06                   	push   %es
8010656b:	0f a0                	push   %fs
8010656d:	0f a8                	push   %gs
8010656f:	60                   	pusha  
80106570:	66 b8 10 00          	mov    $0x10,%ax
80106574:	8e d8                	mov    %eax,%ds
80106576:	8e c0                	mov    %eax,%es
80106578:	54                   	push   %esp
80106579:	e8 c2 00 00 00       	call   80106640 <trap>
8010657e:	83 c4 04             	add    $0x4,%esp

80106581 <trapret>:
80106581:	61                   	popa   
80106582:	0f a9                	pop    %gs
80106584:	0f a1                	pop    %fs
80106586:	07                   	pop    %es
80106587:	1f                   	pop    %ds
80106588:	83 c4 08             	add    $0x8,%esp
8010658b:	cf                   	iret   
8010658c:	66 90                	xchg   %ax,%ax
8010658e:	66 90                	xchg   %ax,%ax

80106590 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106590:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106591:	31 c0                	xor    %eax,%eax
{
80106593:	89 e5                	mov    %esp,%ebp
80106595:	83 ec 08             	sub    $0x8,%esp
80106598:	90                   	nop
80106599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801065a0:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
801065a7:	c7 04 c5 c2 65 11 80 	movl   $0x8e000008,-0x7fee9a3e(,%eax,8)
801065ae:	08 00 00 8e 
801065b2:	66 89 14 c5 c0 65 11 	mov    %dx,-0x7fee9a40(,%eax,8)
801065b9:	80 
801065ba:	c1 ea 10             	shr    $0x10,%edx
801065bd:	66 89 14 c5 c6 65 11 	mov    %dx,-0x7fee9a3a(,%eax,8)
801065c4:	80 
  for(i = 0; i < 256; i++)
801065c5:	83 c0 01             	add    $0x1,%eax
801065c8:	3d 00 01 00 00       	cmp    $0x100,%eax
801065cd:	75 d1                	jne    801065a0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065cf:	a1 0c b1 10 80       	mov    0x8010b10c,%eax

  initlock(&tickslock, "time");
801065d4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065d7:	c7 05 c2 67 11 80 08 	movl   $0xef000008,0x801167c2
801065de:	00 00 ef 
  initlock(&tickslock, "time");
801065e1:	68 66 89 10 80       	push   $0x80108966
801065e6:	68 80 65 11 80       	push   $0x80116580
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065eb:	66 a3 c0 67 11 80    	mov    %ax,0x801167c0
801065f1:	c1 e8 10             	shr    $0x10,%eax
801065f4:	66 a3 c6 67 11 80    	mov    %ax,0x801167c6
  initlock(&tickslock, "time");
801065fa:	e8 11 ea ff ff       	call   80105010 <initlock>
}
801065ff:	83 c4 10             	add    $0x10,%esp
80106602:	c9                   	leave  
80106603:	c3                   	ret    
80106604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010660a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106610 <idtinit>:

void
idtinit(void)
{
80106610:	55                   	push   %ebp
  pd[0] = size-1;
80106611:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106616:	89 e5                	mov    %esp,%ebp
80106618:	83 ec 10             	sub    $0x10,%esp
8010661b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010661f:	b8 c0 65 11 80       	mov    $0x801165c0,%eax
80106624:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106628:	c1 e8 10             	shr    $0x10,%eax
8010662b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010662f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106632:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106635:	c9                   	leave  
80106636:	c3                   	ret    
80106637:	89 f6                	mov    %esi,%esi
80106639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106640 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106640:	55                   	push   %ebp
80106641:	89 e5                	mov    %esp,%ebp
80106643:	57                   	push   %edi
80106644:	56                   	push   %esi
80106645:	53                   	push   %ebx
80106646:	83 ec 1c             	sub    $0x1c,%esp
80106649:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
8010664c:	8b 47 30             	mov    0x30(%edi),%eax
8010664f:	83 f8 40             	cmp    $0x40,%eax
80106652:	0f 84 f0 00 00 00    	je     80106748 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106658:	83 e8 0e             	sub    $0xe,%eax
8010665b:	83 f8 31             	cmp    $0x31,%eax
8010665e:	77 10                	ja     80106670 <trap+0x30>
80106660:	ff 24 85 0c 8a 10 80 	jmp    *-0x7fef75f4(,%eax,4)
80106667:	89 f6                	mov    %esi,%esi
80106669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106670:	e8 ab d5 ff ff       	call   80103c20 <myproc>
80106675:	85 c0                	test   %eax,%eax
80106677:	8b 5f 38             	mov    0x38(%edi),%ebx
8010667a:	0f 84 04 02 00 00    	je     80106884 <trap+0x244>
80106680:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106684:	0f 84 fa 01 00 00    	je     80106884 <trap+0x244>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010668a:	0f 20 d1             	mov    %cr2,%ecx
8010668d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106690:	e8 6b d5 ff ff       	call   80103c00 <cpuid>
80106695:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106698:	8b 47 34             	mov    0x34(%edi),%eax
8010669b:	8b 77 30             	mov    0x30(%edi),%esi
8010669e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801066a1:	e8 7a d5 ff ff       	call   80103c20 <myproc>
801066a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801066a9:	e8 72 d5 ff ff       	call   80103c20 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066ae:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801066b1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801066b4:	51                   	push   %ecx
801066b5:	53                   	push   %ebx
801066b6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
801066b7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066ba:	ff 75 e4             	pushl  -0x1c(%ebp)
801066bd:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801066be:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066c1:	52                   	push   %edx
801066c2:	ff 70 10             	pushl  0x10(%eax)
801066c5:	68 c8 89 10 80       	push   $0x801089c8
801066ca:	e8 91 9f ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801066cf:	83 c4 20             	add    $0x20,%esp
801066d2:	e8 49 d5 ff ff       	call   80103c20 <myproc>
801066d7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801066de:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066e0:	e8 3b d5 ff ff       	call   80103c20 <myproc>
801066e5:	85 c0                	test   %eax,%eax
801066e7:	74 1d                	je     80106706 <trap+0xc6>
801066e9:	e8 32 d5 ff ff       	call   80103c20 <myproc>
801066ee:	8b 50 24             	mov    0x24(%eax),%edx
801066f1:	85 d2                	test   %edx,%edx
801066f3:	74 11                	je     80106706 <trap+0xc6>
801066f5:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801066f9:	83 e0 03             	and    $0x3,%eax
801066fc:	66 83 f8 03          	cmp    $0x3,%ax
80106700:	0f 84 3a 01 00 00    	je     80106840 <trap+0x200>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106706:	e8 15 d5 ff ff       	call   80103c20 <myproc>
8010670b:	85 c0                	test   %eax,%eax
8010670d:	74 0b                	je     8010671a <trap+0xda>
8010670f:	e8 0c d5 ff ff       	call   80103c20 <myproc>
80106714:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106718:	74 66                	je     80106780 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010671a:	e8 01 d5 ff ff       	call   80103c20 <myproc>
8010671f:	85 c0                	test   %eax,%eax
80106721:	74 19                	je     8010673c <trap+0xfc>
80106723:	e8 f8 d4 ff ff       	call   80103c20 <myproc>
80106728:	8b 40 24             	mov    0x24(%eax),%eax
8010672b:	85 c0                	test   %eax,%eax
8010672d:	74 0d                	je     8010673c <trap+0xfc>
8010672f:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106733:	83 e0 03             	and    $0x3,%eax
80106736:	66 83 f8 03          	cmp    $0x3,%ax
8010673a:	74 35                	je     80106771 <trap+0x131>
    exit();
}
8010673c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010673f:	5b                   	pop    %ebx
80106740:	5e                   	pop    %esi
80106741:	5f                   	pop    %edi
80106742:	5d                   	pop    %ebp
80106743:	c3                   	ret    
80106744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106748:	e8 d3 d4 ff ff       	call   80103c20 <myproc>
8010674d:	8b 58 24             	mov    0x24(%eax),%ebx
80106750:	85 db                	test   %ebx,%ebx
80106752:	0f 85 d8 00 00 00    	jne    80106830 <trap+0x1f0>
    myproc()->tf = tf;
80106758:	e8 c3 d4 ff ff       	call   80103c20 <myproc>
8010675d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106760:	e8 eb ee ff ff       	call   80105650 <syscall>
    if(myproc()->killed)
80106765:	e8 b6 d4 ff ff       	call   80103c20 <myproc>
8010676a:	8b 48 24             	mov    0x24(%eax),%ecx
8010676d:	85 c9                	test   %ecx,%ecx
8010676f:	74 cb                	je     8010673c <trap+0xfc>
}
80106771:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106774:	5b                   	pop    %ebx
80106775:	5e                   	pop    %esi
80106776:	5f                   	pop    %edi
80106777:	5d                   	pop    %ebp
      exit();
80106778:	e9 23 d8 ff ff       	jmp    80103fa0 <exit>
8010677d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106780:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80106784:	75 94                	jne    8010671a <trap+0xda>
    yield();
80106786:	e8 45 d9 ff ff       	call   801040d0 <yield>
8010678b:	eb 8d                	jmp    8010671a <trap+0xda>
8010678d:	8d 76 00             	lea    0x0(%esi),%esi
    pagefault(tf->err);
80106790:	83 ec 0c             	sub    $0xc,%esp
80106793:	ff 77 34             	pushl  0x34(%edi)
80106796:	e8 b5 16 00 00       	call   80107e50 <pagefault>
    break;
8010679b:	83 c4 10             	add    $0x10,%esp
8010679e:	e9 3d ff ff ff       	jmp    801066e0 <trap+0xa0>
801067a3:	90                   	nop
801067a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801067a8:	e8 53 d4 ff ff       	call   80103c00 <cpuid>
801067ad:	85 c0                	test   %eax,%eax
801067af:	0f 84 9b 00 00 00    	je     80106850 <trap+0x210>
    lapiceoi();
801067b5:	e8 86 c3 ff ff       	call   80102b40 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067ba:	e8 61 d4 ff ff       	call   80103c20 <myproc>
801067bf:	85 c0                	test   %eax,%eax
801067c1:	0f 85 22 ff ff ff    	jne    801066e9 <trap+0xa9>
801067c7:	e9 3a ff ff ff       	jmp    80106706 <trap+0xc6>
801067cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801067d0:	e8 2b c2 ff ff       	call   80102a00 <kbdintr>
    lapiceoi();
801067d5:	e8 66 c3 ff ff       	call   80102b40 <lapiceoi>
    break;
801067da:	e9 01 ff ff ff       	jmp    801066e0 <trap+0xa0>
801067df:	90                   	nop
    uartintr();
801067e0:	e8 3b 02 00 00       	call   80106a20 <uartintr>
    lapiceoi();
801067e5:	e8 56 c3 ff ff       	call   80102b40 <lapiceoi>
    break;
801067ea:	e9 f1 fe ff ff       	jmp    801066e0 <trap+0xa0>
801067ef:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801067f0:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
801067f4:	8b 77 38             	mov    0x38(%edi),%esi
801067f7:	e8 04 d4 ff ff       	call   80103c00 <cpuid>
801067fc:	56                   	push   %esi
801067fd:	53                   	push   %ebx
801067fe:	50                   	push   %eax
801067ff:	68 70 89 10 80       	push   $0x80108970
80106804:	e8 57 9e ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106809:	e8 32 c3 ff ff       	call   80102b40 <lapiceoi>
    break;
8010680e:	83 c4 10             	add    $0x10,%esp
80106811:	e9 ca fe ff ff       	jmp    801066e0 <trap+0xa0>
80106816:	8d 76 00             	lea    0x0(%esi),%esi
80106819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80106820:	e8 cb bb ff ff       	call   801023f0 <ideintr>
80106825:	eb 8e                	jmp    801067b5 <trap+0x175>
80106827:	89 f6                	mov    %esi,%esi
80106829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
80106830:	e8 6b d7 ff ff       	call   80103fa0 <exit>
80106835:	e9 1e ff ff ff       	jmp    80106758 <trap+0x118>
8010683a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80106840:	e8 5b d7 ff ff       	call   80103fa0 <exit>
80106845:	e9 bc fe ff ff       	jmp    80106706 <trap+0xc6>
8010684a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106850:	83 ec 0c             	sub    $0xc,%esp
80106853:	68 80 65 11 80       	push   $0x80116580
80106858:	e8 f3 e8 ff ff       	call   80105150 <acquire>
      wakeup(&ticks);
8010685d:	c7 04 24 c0 6d 11 80 	movl   $0x80116dc0,(%esp)
      ticks++;
80106864:	83 05 c0 6d 11 80 01 	addl   $0x1,0x80116dc0
      wakeup(&ticks);
8010686b:	e8 70 da ff ff       	call   801042e0 <wakeup>
      release(&tickslock);
80106870:	c7 04 24 80 65 11 80 	movl   $0x80116580,(%esp)
80106877:	e8 94 e9 ff ff       	call   80105210 <release>
8010687c:	83 c4 10             	add    $0x10,%esp
8010687f:	e9 31 ff ff ff       	jmp    801067b5 <trap+0x175>
80106884:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106887:	e8 74 d3 ff ff       	call   80103c00 <cpuid>
8010688c:	83 ec 0c             	sub    $0xc,%esp
8010688f:	56                   	push   %esi
80106890:	53                   	push   %ebx
80106891:	50                   	push   %eax
80106892:	ff 77 30             	pushl  0x30(%edi)
80106895:	68 94 89 10 80       	push   $0x80108994
8010689a:	e8 c1 9d ff ff       	call   80100660 <cprintf>
      panic("trap");
8010689f:	83 c4 14             	add    $0x14,%esp
801068a2:	68 6b 89 10 80       	push   $0x8010896b
801068a7:	e8 e4 9a ff ff       	call   80100390 <panic>
801068ac:	66 90                	xchg   %ax,%ax
801068ae:	66 90                	xchg   %ax,%ax

801068b0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801068b0:	a1 fc b5 10 80       	mov    0x8010b5fc,%eax
{
801068b5:	55                   	push   %ebp
801068b6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801068b8:	85 c0                	test   %eax,%eax
801068ba:	74 1c                	je     801068d8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068bc:	ba fd 03 00 00       	mov    $0x3fd,%edx
801068c1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801068c2:	a8 01                	test   $0x1,%al
801068c4:	74 12                	je     801068d8 <uartgetc+0x28>
801068c6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068cb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801068cc:	0f b6 c0             	movzbl %al,%eax
}
801068cf:	5d                   	pop    %ebp
801068d0:	c3                   	ret    
801068d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801068d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068dd:	5d                   	pop    %ebp
801068de:	c3                   	ret    
801068df:	90                   	nop

801068e0 <uartputc.part.0>:
uartputc(int c)
801068e0:	55                   	push   %ebp
801068e1:	89 e5                	mov    %esp,%ebp
801068e3:	57                   	push   %edi
801068e4:	56                   	push   %esi
801068e5:	53                   	push   %ebx
801068e6:	89 c7                	mov    %eax,%edi
801068e8:	bb 80 00 00 00       	mov    $0x80,%ebx
801068ed:	be fd 03 00 00       	mov    $0x3fd,%esi
801068f2:	83 ec 0c             	sub    $0xc,%esp
801068f5:	eb 1b                	jmp    80106912 <uartputc.part.0+0x32>
801068f7:	89 f6                	mov    %esi,%esi
801068f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106900:	83 ec 0c             	sub    $0xc,%esp
80106903:	6a 0a                	push   $0xa
80106905:	e8 56 c2 ff ff       	call   80102b60 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010690a:	83 c4 10             	add    $0x10,%esp
8010690d:	83 eb 01             	sub    $0x1,%ebx
80106910:	74 07                	je     80106919 <uartputc.part.0+0x39>
80106912:	89 f2                	mov    %esi,%edx
80106914:	ec                   	in     (%dx),%al
80106915:	a8 20                	test   $0x20,%al
80106917:	74 e7                	je     80106900 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106919:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010691e:	89 f8                	mov    %edi,%eax
80106920:	ee                   	out    %al,(%dx)
}
80106921:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106924:	5b                   	pop    %ebx
80106925:	5e                   	pop    %esi
80106926:	5f                   	pop    %edi
80106927:	5d                   	pop    %ebp
80106928:	c3                   	ret    
80106929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106930 <uartinit>:
{
80106930:	55                   	push   %ebp
80106931:	31 c9                	xor    %ecx,%ecx
80106933:	89 c8                	mov    %ecx,%eax
80106935:	89 e5                	mov    %esp,%ebp
80106937:	57                   	push   %edi
80106938:	56                   	push   %esi
80106939:	53                   	push   %ebx
8010693a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010693f:	89 da                	mov    %ebx,%edx
80106941:	83 ec 0c             	sub    $0xc,%esp
80106944:	ee                   	out    %al,(%dx)
80106945:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010694a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010694f:	89 fa                	mov    %edi,%edx
80106951:	ee                   	out    %al,(%dx)
80106952:	b8 0c 00 00 00       	mov    $0xc,%eax
80106957:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010695c:	ee                   	out    %al,(%dx)
8010695d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106962:	89 c8                	mov    %ecx,%eax
80106964:	89 f2                	mov    %esi,%edx
80106966:	ee                   	out    %al,(%dx)
80106967:	b8 03 00 00 00       	mov    $0x3,%eax
8010696c:	89 fa                	mov    %edi,%edx
8010696e:	ee                   	out    %al,(%dx)
8010696f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106974:	89 c8                	mov    %ecx,%eax
80106976:	ee                   	out    %al,(%dx)
80106977:	b8 01 00 00 00       	mov    $0x1,%eax
8010697c:	89 f2                	mov    %esi,%edx
8010697e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010697f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106984:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106985:	3c ff                	cmp    $0xff,%al
80106987:	74 5a                	je     801069e3 <uartinit+0xb3>
  uart = 1;
80106989:	c7 05 fc b5 10 80 01 	movl   $0x1,0x8010b5fc
80106990:	00 00 00 
80106993:	89 da                	mov    %ebx,%edx
80106995:	ec                   	in     (%dx),%al
80106996:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010699b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010699c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010699f:	bb d4 8a 10 80       	mov    $0x80108ad4,%ebx
  ioapicenable(IRQ_COM1, 0);
801069a4:	6a 00                	push   $0x0
801069a6:	6a 04                	push   $0x4
801069a8:	e8 93 bc ff ff       	call   80102640 <ioapicenable>
801069ad:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801069b0:	b8 78 00 00 00       	mov    $0x78,%eax
801069b5:	eb 13                	jmp    801069ca <uartinit+0x9a>
801069b7:	89 f6                	mov    %esi,%esi
801069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801069c0:	83 c3 01             	add    $0x1,%ebx
801069c3:	0f be 03             	movsbl (%ebx),%eax
801069c6:	84 c0                	test   %al,%al
801069c8:	74 19                	je     801069e3 <uartinit+0xb3>
  if(!uart)
801069ca:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
801069d0:	85 d2                	test   %edx,%edx
801069d2:	74 ec                	je     801069c0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801069d4:	83 c3 01             	add    $0x1,%ebx
801069d7:	e8 04 ff ff ff       	call   801068e0 <uartputc.part.0>
801069dc:	0f be 03             	movsbl (%ebx),%eax
801069df:	84 c0                	test   %al,%al
801069e1:	75 e7                	jne    801069ca <uartinit+0x9a>
}
801069e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069e6:	5b                   	pop    %ebx
801069e7:	5e                   	pop    %esi
801069e8:	5f                   	pop    %edi
801069e9:	5d                   	pop    %ebp
801069ea:	c3                   	ret    
801069eb:	90                   	nop
801069ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069f0 <uartputc>:
  if(!uart)
801069f0:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
{
801069f6:	55                   	push   %ebp
801069f7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801069f9:	85 d2                	test   %edx,%edx
{
801069fb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801069fe:	74 10                	je     80106a10 <uartputc+0x20>
}
80106a00:	5d                   	pop    %ebp
80106a01:	e9 da fe ff ff       	jmp    801068e0 <uartputc.part.0>
80106a06:	8d 76 00             	lea    0x0(%esi),%esi
80106a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106a10:	5d                   	pop    %ebp
80106a11:	c3                   	ret    
80106a12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a20 <uartintr>:

void
uartintr(void)
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106a26:	68 b0 68 10 80       	push   $0x801068b0
80106a2b:	e8 b0 a0 ff ff       	call   80100ae0 <consoleintr>
}
80106a30:	83 c4 10             	add    $0x10,%esp
80106a33:	c9                   	leave  
80106a34:	c3                   	ret    

80106a35 <vector0>:
80106a35:	6a 00                	push   $0x0
80106a37:	6a 00                	push   $0x0
80106a39:	e9 2b fb ff ff       	jmp    80106569 <alltraps>

80106a3e <vector1>:
80106a3e:	6a 00                	push   $0x0
80106a40:	6a 01                	push   $0x1
80106a42:	e9 22 fb ff ff       	jmp    80106569 <alltraps>

80106a47 <vector2>:
80106a47:	6a 00                	push   $0x0
80106a49:	6a 02                	push   $0x2
80106a4b:	e9 19 fb ff ff       	jmp    80106569 <alltraps>

80106a50 <vector3>:
80106a50:	6a 00                	push   $0x0
80106a52:	6a 03                	push   $0x3
80106a54:	e9 10 fb ff ff       	jmp    80106569 <alltraps>

80106a59 <vector4>:
80106a59:	6a 00                	push   $0x0
80106a5b:	6a 04                	push   $0x4
80106a5d:	e9 07 fb ff ff       	jmp    80106569 <alltraps>

80106a62 <vector5>:
80106a62:	6a 00                	push   $0x0
80106a64:	6a 05                	push   $0x5
80106a66:	e9 fe fa ff ff       	jmp    80106569 <alltraps>

80106a6b <vector6>:
80106a6b:	6a 00                	push   $0x0
80106a6d:	6a 06                	push   $0x6
80106a6f:	e9 f5 fa ff ff       	jmp    80106569 <alltraps>

80106a74 <vector7>:
80106a74:	6a 00                	push   $0x0
80106a76:	6a 07                	push   $0x7
80106a78:	e9 ec fa ff ff       	jmp    80106569 <alltraps>

80106a7d <vector8>:
80106a7d:	6a 08                	push   $0x8
80106a7f:	e9 e5 fa ff ff       	jmp    80106569 <alltraps>

80106a84 <vector9>:
80106a84:	6a 00                	push   $0x0
80106a86:	6a 09                	push   $0x9
80106a88:	e9 dc fa ff ff       	jmp    80106569 <alltraps>

80106a8d <vector10>:
80106a8d:	6a 0a                	push   $0xa
80106a8f:	e9 d5 fa ff ff       	jmp    80106569 <alltraps>

80106a94 <vector11>:
80106a94:	6a 0b                	push   $0xb
80106a96:	e9 ce fa ff ff       	jmp    80106569 <alltraps>

80106a9b <vector12>:
80106a9b:	6a 0c                	push   $0xc
80106a9d:	e9 c7 fa ff ff       	jmp    80106569 <alltraps>

80106aa2 <vector13>:
80106aa2:	6a 0d                	push   $0xd
80106aa4:	e9 c0 fa ff ff       	jmp    80106569 <alltraps>

80106aa9 <vector14>:
80106aa9:	6a 0e                	push   $0xe
80106aab:	e9 b9 fa ff ff       	jmp    80106569 <alltraps>

80106ab0 <vector15>:
80106ab0:	6a 00                	push   $0x0
80106ab2:	6a 0f                	push   $0xf
80106ab4:	e9 b0 fa ff ff       	jmp    80106569 <alltraps>

80106ab9 <vector16>:
80106ab9:	6a 00                	push   $0x0
80106abb:	6a 10                	push   $0x10
80106abd:	e9 a7 fa ff ff       	jmp    80106569 <alltraps>

80106ac2 <vector17>:
80106ac2:	6a 11                	push   $0x11
80106ac4:	e9 a0 fa ff ff       	jmp    80106569 <alltraps>

80106ac9 <vector18>:
80106ac9:	6a 00                	push   $0x0
80106acb:	6a 12                	push   $0x12
80106acd:	e9 97 fa ff ff       	jmp    80106569 <alltraps>

80106ad2 <vector19>:
80106ad2:	6a 00                	push   $0x0
80106ad4:	6a 13                	push   $0x13
80106ad6:	e9 8e fa ff ff       	jmp    80106569 <alltraps>

80106adb <vector20>:
80106adb:	6a 00                	push   $0x0
80106add:	6a 14                	push   $0x14
80106adf:	e9 85 fa ff ff       	jmp    80106569 <alltraps>

80106ae4 <vector21>:
80106ae4:	6a 00                	push   $0x0
80106ae6:	6a 15                	push   $0x15
80106ae8:	e9 7c fa ff ff       	jmp    80106569 <alltraps>

80106aed <vector22>:
80106aed:	6a 00                	push   $0x0
80106aef:	6a 16                	push   $0x16
80106af1:	e9 73 fa ff ff       	jmp    80106569 <alltraps>

80106af6 <vector23>:
80106af6:	6a 00                	push   $0x0
80106af8:	6a 17                	push   $0x17
80106afa:	e9 6a fa ff ff       	jmp    80106569 <alltraps>

80106aff <vector24>:
80106aff:	6a 00                	push   $0x0
80106b01:	6a 18                	push   $0x18
80106b03:	e9 61 fa ff ff       	jmp    80106569 <alltraps>

80106b08 <vector25>:
80106b08:	6a 00                	push   $0x0
80106b0a:	6a 19                	push   $0x19
80106b0c:	e9 58 fa ff ff       	jmp    80106569 <alltraps>

80106b11 <vector26>:
80106b11:	6a 00                	push   $0x0
80106b13:	6a 1a                	push   $0x1a
80106b15:	e9 4f fa ff ff       	jmp    80106569 <alltraps>

80106b1a <vector27>:
80106b1a:	6a 00                	push   $0x0
80106b1c:	6a 1b                	push   $0x1b
80106b1e:	e9 46 fa ff ff       	jmp    80106569 <alltraps>

80106b23 <vector28>:
80106b23:	6a 00                	push   $0x0
80106b25:	6a 1c                	push   $0x1c
80106b27:	e9 3d fa ff ff       	jmp    80106569 <alltraps>

80106b2c <vector29>:
80106b2c:	6a 00                	push   $0x0
80106b2e:	6a 1d                	push   $0x1d
80106b30:	e9 34 fa ff ff       	jmp    80106569 <alltraps>

80106b35 <vector30>:
80106b35:	6a 00                	push   $0x0
80106b37:	6a 1e                	push   $0x1e
80106b39:	e9 2b fa ff ff       	jmp    80106569 <alltraps>

80106b3e <vector31>:
80106b3e:	6a 00                	push   $0x0
80106b40:	6a 1f                	push   $0x1f
80106b42:	e9 22 fa ff ff       	jmp    80106569 <alltraps>

80106b47 <vector32>:
80106b47:	6a 00                	push   $0x0
80106b49:	6a 20                	push   $0x20
80106b4b:	e9 19 fa ff ff       	jmp    80106569 <alltraps>

80106b50 <vector33>:
80106b50:	6a 00                	push   $0x0
80106b52:	6a 21                	push   $0x21
80106b54:	e9 10 fa ff ff       	jmp    80106569 <alltraps>

80106b59 <vector34>:
80106b59:	6a 00                	push   $0x0
80106b5b:	6a 22                	push   $0x22
80106b5d:	e9 07 fa ff ff       	jmp    80106569 <alltraps>

80106b62 <vector35>:
80106b62:	6a 00                	push   $0x0
80106b64:	6a 23                	push   $0x23
80106b66:	e9 fe f9 ff ff       	jmp    80106569 <alltraps>

80106b6b <vector36>:
80106b6b:	6a 00                	push   $0x0
80106b6d:	6a 24                	push   $0x24
80106b6f:	e9 f5 f9 ff ff       	jmp    80106569 <alltraps>

80106b74 <vector37>:
80106b74:	6a 00                	push   $0x0
80106b76:	6a 25                	push   $0x25
80106b78:	e9 ec f9 ff ff       	jmp    80106569 <alltraps>

80106b7d <vector38>:
80106b7d:	6a 00                	push   $0x0
80106b7f:	6a 26                	push   $0x26
80106b81:	e9 e3 f9 ff ff       	jmp    80106569 <alltraps>

80106b86 <vector39>:
80106b86:	6a 00                	push   $0x0
80106b88:	6a 27                	push   $0x27
80106b8a:	e9 da f9 ff ff       	jmp    80106569 <alltraps>

80106b8f <vector40>:
80106b8f:	6a 00                	push   $0x0
80106b91:	6a 28                	push   $0x28
80106b93:	e9 d1 f9 ff ff       	jmp    80106569 <alltraps>

80106b98 <vector41>:
80106b98:	6a 00                	push   $0x0
80106b9a:	6a 29                	push   $0x29
80106b9c:	e9 c8 f9 ff ff       	jmp    80106569 <alltraps>

80106ba1 <vector42>:
80106ba1:	6a 00                	push   $0x0
80106ba3:	6a 2a                	push   $0x2a
80106ba5:	e9 bf f9 ff ff       	jmp    80106569 <alltraps>

80106baa <vector43>:
80106baa:	6a 00                	push   $0x0
80106bac:	6a 2b                	push   $0x2b
80106bae:	e9 b6 f9 ff ff       	jmp    80106569 <alltraps>

80106bb3 <vector44>:
80106bb3:	6a 00                	push   $0x0
80106bb5:	6a 2c                	push   $0x2c
80106bb7:	e9 ad f9 ff ff       	jmp    80106569 <alltraps>

80106bbc <vector45>:
80106bbc:	6a 00                	push   $0x0
80106bbe:	6a 2d                	push   $0x2d
80106bc0:	e9 a4 f9 ff ff       	jmp    80106569 <alltraps>

80106bc5 <vector46>:
80106bc5:	6a 00                	push   $0x0
80106bc7:	6a 2e                	push   $0x2e
80106bc9:	e9 9b f9 ff ff       	jmp    80106569 <alltraps>

80106bce <vector47>:
80106bce:	6a 00                	push   $0x0
80106bd0:	6a 2f                	push   $0x2f
80106bd2:	e9 92 f9 ff ff       	jmp    80106569 <alltraps>

80106bd7 <vector48>:
80106bd7:	6a 00                	push   $0x0
80106bd9:	6a 30                	push   $0x30
80106bdb:	e9 89 f9 ff ff       	jmp    80106569 <alltraps>

80106be0 <vector49>:
80106be0:	6a 00                	push   $0x0
80106be2:	6a 31                	push   $0x31
80106be4:	e9 80 f9 ff ff       	jmp    80106569 <alltraps>

80106be9 <vector50>:
80106be9:	6a 00                	push   $0x0
80106beb:	6a 32                	push   $0x32
80106bed:	e9 77 f9 ff ff       	jmp    80106569 <alltraps>

80106bf2 <vector51>:
80106bf2:	6a 00                	push   $0x0
80106bf4:	6a 33                	push   $0x33
80106bf6:	e9 6e f9 ff ff       	jmp    80106569 <alltraps>

80106bfb <vector52>:
80106bfb:	6a 00                	push   $0x0
80106bfd:	6a 34                	push   $0x34
80106bff:	e9 65 f9 ff ff       	jmp    80106569 <alltraps>

80106c04 <vector53>:
80106c04:	6a 00                	push   $0x0
80106c06:	6a 35                	push   $0x35
80106c08:	e9 5c f9 ff ff       	jmp    80106569 <alltraps>

80106c0d <vector54>:
80106c0d:	6a 00                	push   $0x0
80106c0f:	6a 36                	push   $0x36
80106c11:	e9 53 f9 ff ff       	jmp    80106569 <alltraps>

80106c16 <vector55>:
80106c16:	6a 00                	push   $0x0
80106c18:	6a 37                	push   $0x37
80106c1a:	e9 4a f9 ff ff       	jmp    80106569 <alltraps>

80106c1f <vector56>:
80106c1f:	6a 00                	push   $0x0
80106c21:	6a 38                	push   $0x38
80106c23:	e9 41 f9 ff ff       	jmp    80106569 <alltraps>

80106c28 <vector57>:
80106c28:	6a 00                	push   $0x0
80106c2a:	6a 39                	push   $0x39
80106c2c:	e9 38 f9 ff ff       	jmp    80106569 <alltraps>

80106c31 <vector58>:
80106c31:	6a 00                	push   $0x0
80106c33:	6a 3a                	push   $0x3a
80106c35:	e9 2f f9 ff ff       	jmp    80106569 <alltraps>

80106c3a <vector59>:
80106c3a:	6a 00                	push   $0x0
80106c3c:	6a 3b                	push   $0x3b
80106c3e:	e9 26 f9 ff ff       	jmp    80106569 <alltraps>

80106c43 <vector60>:
80106c43:	6a 00                	push   $0x0
80106c45:	6a 3c                	push   $0x3c
80106c47:	e9 1d f9 ff ff       	jmp    80106569 <alltraps>

80106c4c <vector61>:
80106c4c:	6a 00                	push   $0x0
80106c4e:	6a 3d                	push   $0x3d
80106c50:	e9 14 f9 ff ff       	jmp    80106569 <alltraps>

80106c55 <vector62>:
80106c55:	6a 00                	push   $0x0
80106c57:	6a 3e                	push   $0x3e
80106c59:	e9 0b f9 ff ff       	jmp    80106569 <alltraps>

80106c5e <vector63>:
80106c5e:	6a 00                	push   $0x0
80106c60:	6a 3f                	push   $0x3f
80106c62:	e9 02 f9 ff ff       	jmp    80106569 <alltraps>

80106c67 <vector64>:
80106c67:	6a 00                	push   $0x0
80106c69:	6a 40                	push   $0x40
80106c6b:	e9 f9 f8 ff ff       	jmp    80106569 <alltraps>

80106c70 <vector65>:
80106c70:	6a 00                	push   $0x0
80106c72:	6a 41                	push   $0x41
80106c74:	e9 f0 f8 ff ff       	jmp    80106569 <alltraps>

80106c79 <vector66>:
80106c79:	6a 00                	push   $0x0
80106c7b:	6a 42                	push   $0x42
80106c7d:	e9 e7 f8 ff ff       	jmp    80106569 <alltraps>

80106c82 <vector67>:
80106c82:	6a 00                	push   $0x0
80106c84:	6a 43                	push   $0x43
80106c86:	e9 de f8 ff ff       	jmp    80106569 <alltraps>

80106c8b <vector68>:
80106c8b:	6a 00                	push   $0x0
80106c8d:	6a 44                	push   $0x44
80106c8f:	e9 d5 f8 ff ff       	jmp    80106569 <alltraps>

80106c94 <vector69>:
80106c94:	6a 00                	push   $0x0
80106c96:	6a 45                	push   $0x45
80106c98:	e9 cc f8 ff ff       	jmp    80106569 <alltraps>

80106c9d <vector70>:
80106c9d:	6a 00                	push   $0x0
80106c9f:	6a 46                	push   $0x46
80106ca1:	e9 c3 f8 ff ff       	jmp    80106569 <alltraps>

80106ca6 <vector71>:
80106ca6:	6a 00                	push   $0x0
80106ca8:	6a 47                	push   $0x47
80106caa:	e9 ba f8 ff ff       	jmp    80106569 <alltraps>

80106caf <vector72>:
80106caf:	6a 00                	push   $0x0
80106cb1:	6a 48                	push   $0x48
80106cb3:	e9 b1 f8 ff ff       	jmp    80106569 <alltraps>

80106cb8 <vector73>:
80106cb8:	6a 00                	push   $0x0
80106cba:	6a 49                	push   $0x49
80106cbc:	e9 a8 f8 ff ff       	jmp    80106569 <alltraps>

80106cc1 <vector74>:
80106cc1:	6a 00                	push   $0x0
80106cc3:	6a 4a                	push   $0x4a
80106cc5:	e9 9f f8 ff ff       	jmp    80106569 <alltraps>

80106cca <vector75>:
80106cca:	6a 00                	push   $0x0
80106ccc:	6a 4b                	push   $0x4b
80106cce:	e9 96 f8 ff ff       	jmp    80106569 <alltraps>

80106cd3 <vector76>:
80106cd3:	6a 00                	push   $0x0
80106cd5:	6a 4c                	push   $0x4c
80106cd7:	e9 8d f8 ff ff       	jmp    80106569 <alltraps>

80106cdc <vector77>:
80106cdc:	6a 00                	push   $0x0
80106cde:	6a 4d                	push   $0x4d
80106ce0:	e9 84 f8 ff ff       	jmp    80106569 <alltraps>

80106ce5 <vector78>:
80106ce5:	6a 00                	push   $0x0
80106ce7:	6a 4e                	push   $0x4e
80106ce9:	e9 7b f8 ff ff       	jmp    80106569 <alltraps>

80106cee <vector79>:
80106cee:	6a 00                	push   $0x0
80106cf0:	6a 4f                	push   $0x4f
80106cf2:	e9 72 f8 ff ff       	jmp    80106569 <alltraps>

80106cf7 <vector80>:
80106cf7:	6a 00                	push   $0x0
80106cf9:	6a 50                	push   $0x50
80106cfb:	e9 69 f8 ff ff       	jmp    80106569 <alltraps>

80106d00 <vector81>:
80106d00:	6a 00                	push   $0x0
80106d02:	6a 51                	push   $0x51
80106d04:	e9 60 f8 ff ff       	jmp    80106569 <alltraps>

80106d09 <vector82>:
80106d09:	6a 00                	push   $0x0
80106d0b:	6a 52                	push   $0x52
80106d0d:	e9 57 f8 ff ff       	jmp    80106569 <alltraps>

80106d12 <vector83>:
80106d12:	6a 00                	push   $0x0
80106d14:	6a 53                	push   $0x53
80106d16:	e9 4e f8 ff ff       	jmp    80106569 <alltraps>

80106d1b <vector84>:
80106d1b:	6a 00                	push   $0x0
80106d1d:	6a 54                	push   $0x54
80106d1f:	e9 45 f8 ff ff       	jmp    80106569 <alltraps>

80106d24 <vector85>:
80106d24:	6a 00                	push   $0x0
80106d26:	6a 55                	push   $0x55
80106d28:	e9 3c f8 ff ff       	jmp    80106569 <alltraps>

80106d2d <vector86>:
80106d2d:	6a 00                	push   $0x0
80106d2f:	6a 56                	push   $0x56
80106d31:	e9 33 f8 ff ff       	jmp    80106569 <alltraps>

80106d36 <vector87>:
80106d36:	6a 00                	push   $0x0
80106d38:	6a 57                	push   $0x57
80106d3a:	e9 2a f8 ff ff       	jmp    80106569 <alltraps>

80106d3f <vector88>:
80106d3f:	6a 00                	push   $0x0
80106d41:	6a 58                	push   $0x58
80106d43:	e9 21 f8 ff ff       	jmp    80106569 <alltraps>

80106d48 <vector89>:
80106d48:	6a 00                	push   $0x0
80106d4a:	6a 59                	push   $0x59
80106d4c:	e9 18 f8 ff ff       	jmp    80106569 <alltraps>

80106d51 <vector90>:
80106d51:	6a 00                	push   $0x0
80106d53:	6a 5a                	push   $0x5a
80106d55:	e9 0f f8 ff ff       	jmp    80106569 <alltraps>

80106d5a <vector91>:
80106d5a:	6a 00                	push   $0x0
80106d5c:	6a 5b                	push   $0x5b
80106d5e:	e9 06 f8 ff ff       	jmp    80106569 <alltraps>

80106d63 <vector92>:
80106d63:	6a 00                	push   $0x0
80106d65:	6a 5c                	push   $0x5c
80106d67:	e9 fd f7 ff ff       	jmp    80106569 <alltraps>

80106d6c <vector93>:
80106d6c:	6a 00                	push   $0x0
80106d6e:	6a 5d                	push   $0x5d
80106d70:	e9 f4 f7 ff ff       	jmp    80106569 <alltraps>

80106d75 <vector94>:
80106d75:	6a 00                	push   $0x0
80106d77:	6a 5e                	push   $0x5e
80106d79:	e9 eb f7 ff ff       	jmp    80106569 <alltraps>

80106d7e <vector95>:
80106d7e:	6a 00                	push   $0x0
80106d80:	6a 5f                	push   $0x5f
80106d82:	e9 e2 f7 ff ff       	jmp    80106569 <alltraps>

80106d87 <vector96>:
80106d87:	6a 00                	push   $0x0
80106d89:	6a 60                	push   $0x60
80106d8b:	e9 d9 f7 ff ff       	jmp    80106569 <alltraps>

80106d90 <vector97>:
80106d90:	6a 00                	push   $0x0
80106d92:	6a 61                	push   $0x61
80106d94:	e9 d0 f7 ff ff       	jmp    80106569 <alltraps>

80106d99 <vector98>:
80106d99:	6a 00                	push   $0x0
80106d9b:	6a 62                	push   $0x62
80106d9d:	e9 c7 f7 ff ff       	jmp    80106569 <alltraps>

80106da2 <vector99>:
80106da2:	6a 00                	push   $0x0
80106da4:	6a 63                	push   $0x63
80106da6:	e9 be f7 ff ff       	jmp    80106569 <alltraps>

80106dab <vector100>:
80106dab:	6a 00                	push   $0x0
80106dad:	6a 64                	push   $0x64
80106daf:	e9 b5 f7 ff ff       	jmp    80106569 <alltraps>

80106db4 <vector101>:
80106db4:	6a 00                	push   $0x0
80106db6:	6a 65                	push   $0x65
80106db8:	e9 ac f7 ff ff       	jmp    80106569 <alltraps>

80106dbd <vector102>:
80106dbd:	6a 00                	push   $0x0
80106dbf:	6a 66                	push   $0x66
80106dc1:	e9 a3 f7 ff ff       	jmp    80106569 <alltraps>

80106dc6 <vector103>:
80106dc6:	6a 00                	push   $0x0
80106dc8:	6a 67                	push   $0x67
80106dca:	e9 9a f7 ff ff       	jmp    80106569 <alltraps>

80106dcf <vector104>:
80106dcf:	6a 00                	push   $0x0
80106dd1:	6a 68                	push   $0x68
80106dd3:	e9 91 f7 ff ff       	jmp    80106569 <alltraps>

80106dd8 <vector105>:
80106dd8:	6a 00                	push   $0x0
80106dda:	6a 69                	push   $0x69
80106ddc:	e9 88 f7 ff ff       	jmp    80106569 <alltraps>

80106de1 <vector106>:
80106de1:	6a 00                	push   $0x0
80106de3:	6a 6a                	push   $0x6a
80106de5:	e9 7f f7 ff ff       	jmp    80106569 <alltraps>

80106dea <vector107>:
80106dea:	6a 00                	push   $0x0
80106dec:	6a 6b                	push   $0x6b
80106dee:	e9 76 f7 ff ff       	jmp    80106569 <alltraps>

80106df3 <vector108>:
80106df3:	6a 00                	push   $0x0
80106df5:	6a 6c                	push   $0x6c
80106df7:	e9 6d f7 ff ff       	jmp    80106569 <alltraps>

80106dfc <vector109>:
80106dfc:	6a 00                	push   $0x0
80106dfe:	6a 6d                	push   $0x6d
80106e00:	e9 64 f7 ff ff       	jmp    80106569 <alltraps>

80106e05 <vector110>:
80106e05:	6a 00                	push   $0x0
80106e07:	6a 6e                	push   $0x6e
80106e09:	e9 5b f7 ff ff       	jmp    80106569 <alltraps>

80106e0e <vector111>:
80106e0e:	6a 00                	push   $0x0
80106e10:	6a 6f                	push   $0x6f
80106e12:	e9 52 f7 ff ff       	jmp    80106569 <alltraps>

80106e17 <vector112>:
80106e17:	6a 00                	push   $0x0
80106e19:	6a 70                	push   $0x70
80106e1b:	e9 49 f7 ff ff       	jmp    80106569 <alltraps>

80106e20 <vector113>:
80106e20:	6a 00                	push   $0x0
80106e22:	6a 71                	push   $0x71
80106e24:	e9 40 f7 ff ff       	jmp    80106569 <alltraps>

80106e29 <vector114>:
80106e29:	6a 00                	push   $0x0
80106e2b:	6a 72                	push   $0x72
80106e2d:	e9 37 f7 ff ff       	jmp    80106569 <alltraps>

80106e32 <vector115>:
80106e32:	6a 00                	push   $0x0
80106e34:	6a 73                	push   $0x73
80106e36:	e9 2e f7 ff ff       	jmp    80106569 <alltraps>

80106e3b <vector116>:
80106e3b:	6a 00                	push   $0x0
80106e3d:	6a 74                	push   $0x74
80106e3f:	e9 25 f7 ff ff       	jmp    80106569 <alltraps>

80106e44 <vector117>:
80106e44:	6a 00                	push   $0x0
80106e46:	6a 75                	push   $0x75
80106e48:	e9 1c f7 ff ff       	jmp    80106569 <alltraps>

80106e4d <vector118>:
80106e4d:	6a 00                	push   $0x0
80106e4f:	6a 76                	push   $0x76
80106e51:	e9 13 f7 ff ff       	jmp    80106569 <alltraps>

80106e56 <vector119>:
80106e56:	6a 00                	push   $0x0
80106e58:	6a 77                	push   $0x77
80106e5a:	e9 0a f7 ff ff       	jmp    80106569 <alltraps>

80106e5f <vector120>:
80106e5f:	6a 00                	push   $0x0
80106e61:	6a 78                	push   $0x78
80106e63:	e9 01 f7 ff ff       	jmp    80106569 <alltraps>

80106e68 <vector121>:
80106e68:	6a 00                	push   $0x0
80106e6a:	6a 79                	push   $0x79
80106e6c:	e9 f8 f6 ff ff       	jmp    80106569 <alltraps>

80106e71 <vector122>:
80106e71:	6a 00                	push   $0x0
80106e73:	6a 7a                	push   $0x7a
80106e75:	e9 ef f6 ff ff       	jmp    80106569 <alltraps>

80106e7a <vector123>:
80106e7a:	6a 00                	push   $0x0
80106e7c:	6a 7b                	push   $0x7b
80106e7e:	e9 e6 f6 ff ff       	jmp    80106569 <alltraps>

80106e83 <vector124>:
80106e83:	6a 00                	push   $0x0
80106e85:	6a 7c                	push   $0x7c
80106e87:	e9 dd f6 ff ff       	jmp    80106569 <alltraps>

80106e8c <vector125>:
80106e8c:	6a 00                	push   $0x0
80106e8e:	6a 7d                	push   $0x7d
80106e90:	e9 d4 f6 ff ff       	jmp    80106569 <alltraps>

80106e95 <vector126>:
80106e95:	6a 00                	push   $0x0
80106e97:	6a 7e                	push   $0x7e
80106e99:	e9 cb f6 ff ff       	jmp    80106569 <alltraps>

80106e9e <vector127>:
80106e9e:	6a 00                	push   $0x0
80106ea0:	6a 7f                	push   $0x7f
80106ea2:	e9 c2 f6 ff ff       	jmp    80106569 <alltraps>

80106ea7 <vector128>:
80106ea7:	6a 00                	push   $0x0
80106ea9:	68 80 00 00 00       	push   $0x80
80106eae:	e9 b6 f6 ff ff       	jmp    80106569 <alltraps>

80106eb3 <vector129>:
80106eb3:	6a 00                	push   $0x0
80106eb5:	68 81 00 00 00       	push   $0x81
80106eba:	e9 aa f6 ff ff       	jmp    80106569 <alltraps>

80106ebf <vector130>:
80106ebf:	6a 00                	push   $0x0
80106ec1:	68 82 00 00 00       	push   $0x82
80106ec6:	e9 9e f6 ff ff       	jmp    80106569 <alltraps>

80106ecb <vector131>:
80106ecb:	6a 00                	push   $0x0
80106ecd:	68 83 00 00 00       	push   $0x83
80106ed2:	e9 92 f6 ff ff       	jmp    80106569 <alltraps>

80106ed7 <vector132>:
80106ed7:	6a 00                	push   $0x0
80106ed9:	68 84 00 00 00       	push   $0x84
80106ede:	e9 86 f6 ff ff       	jmp    80106569 <alltraps>

80106ee3 <vector133>:
80106ee3:	6a 00                	push   $0x0
80106ee5:	68 85 00 00 00       	push   $0x85
80106eea:	e9 7a f6 ff ff       	jmp    80106569 <alltraps>

80106eef <vector134>:
80106eef:	6a 00                	push   $0x0
80106ef1:	68 86 00 00 00       	push   $0x86
80106ef6:	e9 6e f6 ff ff       	jmp    80106569 <alltraps>

80106efb <vector135>:
80106efb:	6a 00                	push   $0x0
80106efd:	68 87 00 00 00       	push   $0x87
80106f02:	e9 62 f6 ff ff       	jmp    80106569 <alltraps>

80106f07 <vector136>:
80106f07:	6a 00                	push   $0x0
80106f09:	68 88 00 00 00       	push   $0x88
80106f0e:	e9 56 f6 ff ff       	jmp    80106569 <alltraps>

80106f13 <vector137>:
80106f13:	6a 00                	push   $0x0
80106f15:	68 89 00 00 00       	push   $0x89
80106f1a:	e9 4a f6 ff ff       	jmp    80106569 <alltraps>

80106f1f <vector138>:
80106f1f:	6a 00                	push   $0x0
80106f21:	68 8a 00 00 00       	push   $0x8a
80106f26:	e9 3e f6 ff ff       	jmp    80106569 <alltraps>

80106f2b <vector139>:
80106f2b:	6a 00                	push   $0x0
80106f2d:	68 8b 00 00 00       	push   $0x8b
80106f32:	e9 32 f6 ff ff       	jmp    80106569 <alltraps>

80106f37 <vector140>:
80106f37:	6a 00                	push   $0x0
80106f39:	68 8c 00 00 00       	push   $0x8c
80106f3e:	e9 26 f6 ff ff       	jmp    80106569 <alltraps>

80106f43 <vector141>:
80106f43:	6a 00                	push   $0x0
80106f45:	68 8d 00 00 00       	push   $0x8d
80106f4a:	e9 1a f6 ff ff       	jmp    80106569 <alltraps>

80106f4f <vector142>:
80106f4f:	6a 00                	push   $0x0
80106f51:	68 8e 00 00 00       	push   $0x8e
80106f56:	e9 0e f6 ff ff       	jmp    80106569 <alltraps>

80106f5b <vector143>:
80106f5b:	6a 00                	push   $0x0
80106f5d:	68 8f 00 00 00       	push   $0x8f
80106f62:	e9 02 f6 ff ff       	jmp    80106569 <alltraps>

80106f67 <vector144>:
80106f67:	6a 00                	push   $0x0
80106f69:	68 90 00 00 00       	push   $0x90
80106f6e:	e9 f6 f5 ff ff       	jmp    80106569 <alltraps>

80106f73 <vector145>:
80106f73:	6a 00                	push   $0x0
80106f75:	68 91 00 00 00       	push   $0x91
80106f7a:	e9 ea f5 ff ff       	jmp    80106569 <alltraps>

80106f7f <vector146>:
80106f7f:	6a 00                	push   $0x0
80106f81:	68 92 00 00 00       	push   $0x92
80106f86:	e9 de f5 ff ff       	jmp    80106569 <alltraps>

80106f8b <vector147>:
80106f8b:	6a 00                	push   $0x0
80106f8d:	68 93 00 00 00       	push   $0x93
80106f92:	e9 d2 f5 ff ff       	jmp    80106569 <alltraps>

80106f97 <vector148>:
80106f97:	6a 00                	push   $0x0
80106f99:	68 94 00 00 00       	push   $0x94
80106f9e:	e9 c6 f5 ff ff       	jmp    80106569 <alltraps>

80106fa3 <vector149>:
80106fa3:	6a 00                	push   $0x0
80106fa5:	68 95 00 00 00       	push   $0x95
80106faa:	e9 ba f5 ff ff       	jmp    80106569 <alltraps>

80106faf <vector150>:
80106faf:	6a 00                	push   $0x0
80106fb1:	68 96 00 00 00       	push   $0x96
80106fb6:	e9 ae f5 ff ff       	jmp    80106569 <alltraps>

80106fbb <vector151>:
80106fbb:	6a 00                	push   $0x0
80106fbd:	68 97 00 00 00       	push   $0x97
80106fc2:	e9 a2 f5 ff ff       	jmp    80106569 <alltraps>

80106fc7 <vector152>:
80106fc7:	6a 00                	push   $0x0
80106fc9:	68 98 00 00 00       	push   $0x98
80106fce:	e9 96 f5 ff ff       	jmp    80106569 <alltraps>

80106fd3 <vector153>:
80106fd3:	6a 00                	push   $0x0
80106fd5:	68 99 00 00 00       	push   $0x99
80106fda:	e9 8a f5 ff ff       	jmp    80106569 <alltraps>

80106fdf <vector154>:
80106fdf:	6a 00                	push   $0x0
80106fe1:	68 9a 00 00 00       	push   $0x9a
80106fe6:	e9 7e f5 ff ff       	jmp    80106569 <alltraps>

80106feb <vector155>:
80106feb:	6a 00                	push   $0x0
80106fed:	68 9b 00 00 00       	push   $0x9b
80106ff2:	e9 72 f5 ff ff       	jmp    80106569 <alltraps>

80106ff7 <vector156>:
80106ff7:	6a 00                	push   $0x0
80106ff9:	68 9c 00 00 00       	push   $0x9c
80106ffe:	e9 66 f5 ff ff       	jmp    80106569 <alltraps>

80107003 <vector157>:
80107003:	6a 00                	push   $0x0
80107005:	68 9d 00 00 00       	push   $0x9d
8010700a:	e9 5a f5 ff ff       	jmp    80106569 <alltraps>

8010700f <vector158>:
8010700f:	6a 00                	push   $0x0
80107011:	68 9e 00 00 00       	push   $0x9e
80107016:	e9 4e f5 ff ff       	jmp    80106569 <alltraps>

8010701b <vector159>:
8010701b:	6a 00                	push   $0x0
8010701d:	68 9f 00 00 00       	push   $0x9f
80107022:	e9 42 f5 ff ff       	jmp    80106569 <alltraps>

80107027 <vector160>:
80107027:	6a 00                	push   $0x0
80107029:	68 a0 00 00 00       	push   $0xa0
8010702e:	e9 36 f5 ff ff       	jmp    80106569 <alltraps>

80107033 <vector161>:
80107033:	6a 00                	push   $0x0
80107035:	68 a1 00 00 00       	push   $0xa1
8010703a:	e9 2a f5 ff ff       	jmp    80106569 <alltraps>

8010703f <vector162>:
8010703f:	6a 00                	push   $0x0
80107041:	68 a2 00 00 00       	push   $0xa2
80107046:	e9 1e f5 ff ff       	jmp    80106569 <alltraps>

8010704b <vector163>:
8010704b:	6a 00                	push   $0x0
8010704d:	68 a3 00 00 00       	push   $0xa3
80107052:	e9 12 f5 ff ff       	jmp    80106569 <alltraps>

80107057 <vector164>:
80107057:	6a 00                	push   $0x0
80107059:	68 a4 00 00 00       	push   $0xa4
8010705e:	e9 06 f5 ff ff       	jmp    80106569 <alltraps>

80107063 <vector165>:
80107063:	6a 00                	push   $0x0
80107065:	68 a5 00 00 00       	push   $0xa5
8010706a:	e9 fa f4 ff ff       	jmp    80106569 <alltraps>

8010706f <vector166>:
8010706f:	6a 00                	push   $0x0
80107071:	68 a6 00 00 00       	push   $0xa6
80107076:	e9 ee f4 ff ff       	jmp    80106569 <alltraps>

8010707b <vector167>:
8010707b:	6a 00                	push   $0x0
8010707d:	68 a7 00 00 00       	push   $0xa7
80107082:	e9 e2 f4 ff ff       	jmp    80106569 <alltraps>

80107087 <vector168>:
80107087:	6a 00                	push   $0x0
80107089:	68 a8 00 00 00       	push   $0xa8
8010708e:	e9 d6 f4 ff ff       	jmp    80106569 <alltraps>

80107093 <vector169>:
80107093:	6a 00                	push   $0x0
80107095:	68 a9 00 00 00       	push   $0xa9
8010709a:	e9 ca f4 ff ff       	jmp    80106569 <alltraps>

8010709f <vector170>:
8010709f:	6a 00                	push   $0x0
801070a1:	68 aa 00 00 00       	push   $0xaa
801070a6:	e9 be f4 ff ff       	jmp    80106569 <alltraps>

801070ab <vector171>:
801070ab:	6a 00                	push   $0x0
801070ad:	68 ab 00 00 00       	push   $0xab
801070b2:	e9 b2 f4 ff ff       	jmp    80106569 <alltraps>

801070b7 <vector172>:
801070b7:	6a 00                	push   $0x0
801070b9:	68 ac 00 00 00       	push   $0xac
801070be:	e9 a6 f4 ff ff       	jmp    80106569 <alltraps>

801070c3 <vector173>:
801070c3:	6a 00                	push   $0x0
801070c5:	68 ad 00 00 00       	push   $0xad
801070ca:	e9 9a f4 ff ff       	jmp    80106569 <alltraps>

801070cf <vector174>:
801070cf:	6a 00                	push   $0x0
801070d1:	68 ae 00 00 00       	push   $0xae
801070d6:	e9 8e f4 ff ff       	jmp    80106569 <alltraps>

801070db <vector175>:
801070db:	6a 00                	push   $0x0
801070dd:	68 af 00 00 00       	push   $0xaf
801070e2:	e9 82 f4 ff ff       	jmp    80106569 <alltraps>

801070e7 <vector176>:
801070e7:	6a 00                	push   $0x0
801070e9:	68 b0 00 00 00       	push   $0xb0
801070ee:	e9 76 f4 ff ff       	jmp    80106569 <alltraps>

801070f3 <vector177>:
801070f3:	6a 00                	push   $0x0
801070f5:	68 b1 00 00 00       	push   $0xb1
801070fa:	e9 6a f4 ff ff       	jmp    80106569 <alltraps>

801070ff <vector178>:
801070ff:	6a 00                	push   $0x0
80107101:	68 b2 00 00 00       	push   $0xb2
80107106:	e9 5e f4 ff ff       	jmp    80106569 <alltraps>

8010710b <vector179>:
8010710b:	6a 00                	push   $0x0
8010710d:	68 b3 00 00 00       	push   $0xb3
80107112:	e9 52 f4 ff ff       	jmp    80106569 <alltraps>

80107117 <vector180>:
80107117:	6a 00                	push   $0x0
80107119:	68 b4 00 00 00       	push   $0xb4
8010711e:	e9 46 f4 ff ff       	jmp    80106569 <alltraps>

80107123 <vector181>:
80107123:	6a 00                	push   $0x0
80107125:	68 b5 00 00 00       	push   $0xb5
8010712a:	e9 3a f4 ff ff       	jmp    80106569 <alltraps>

8010712f <vector182>:
8010712f:	6a 00                	push   $0x0
80107131:	68 b6 00 00 00       	push   $0xb6
80107136:	e9 2e f4 ff ff       	jmp    80106569 <alltraps>

8010713b <vector183>:
8010713b:	6a 00                	push   $0x0
8010713d:	68 b7 00 00 00       	push   $0xb7
80107142:	e9 22 f4 ff ff       	jmp    80106569 <alltraps>

80107147 <vector184>:
80107147:	6a 00                	push   $0x0
80107149:	68 b8 00 00 00       	push   $0xb8
8010714e:	e9 16 f4 ff ff       	jmp    80106569 <alltraps>

80107153 <vector185>:
80107153:	6a 00                	push   $0x0
80107155:	68 b9 00 00 00       	push   $0xb9
8010715a:	e9 0a f4 ff ff       	jmp    80106569 <alltraps>

8010715f <vector186>:
8010715f:	6a 00                	push   $0x0
80107161:	68 ba 00 00 00       	push   $0xba
80107166:	e9 fe f3 ff ff       	jmp    80106569 <alltraps>

8010716b <vector187>:
8010716b:	6a 00                	push   $0x0
8010716d:	68 bb 00 00 00       	push   $0xbb
80107172:	e9 f2 f3 ff ff       	jmp    80106569 <alltraps>

80107177 <vector188>:
80107177:	6a 00                	push   $0x0
80107179:	68 bc 00 00 00       	push   $0xbc
8010717e:	e9 e6 f3 ff ff       	jmp    80106569 <alltraps>

80107183 <vector189>:
80107183:	6a 00                	push   $0x0
80107185:	68 bd 00 00 00       	push   $0xbd
8010718a:	e9 da f3 ff ff       	jmp    80106569 <alltraps>

8010718f <vector190>:
8010718f:	6a 00                	push   $0x0
80107191:	68 be 00 00 00       	push   $0xbe
80107196:	e9 ce f3 ff ff       	jmp    80106569 <alltraps>

8010719b <vector191>:
8010719b:	6a 00                	push   $0x0
8010719d:	68 bf 00 00 00       	push   $0xbf
801071a2:	e9 c2 f3 ff ff       	jmp    80106569 <alltraps>

801071a7 <vector192>:
801071a7:	6a 00                	push   $0x0
801071a9:	68 c0 00 00 00       	push   $0xc0
801071ae:	e9 b6 f3 ff ff       	jmp    80106569 <alltraps>

801071b3 <vector193>:
801071b3:	6a 00                	push   $0x0
801071b5:	68 c1 00 00 00       	push   $0xc1
801071ba:	e9 aa f3 ff ff       	jmp    80106569 <alltraps>

801071bf <vector194>:
801071bf:	6a 00                	push   $0x0
801071c1:	68 c2 00 00 00       	push   $0xc2
801071c6:	e9 9e f3 ff ff       	jmp    80106569 <alltraps>

801071cb <vector195>:
801071cb:	6a 00                	push   $0x0
801071cd:	68 c3 00 00 00       	push   $0xc3
801071d2:	e9 92 f3 ff ff       	jmp    80106569 <alltraps>

801071d7 <vector196>:
801071d7:	6a 00                	push   $0x0
801071d9:	68 c4 00 00 00       	push   $0xc4
801071de:	e9 86 f3 ff ff       	jmp    80106569 <alltraps>

801071e3 <vector197>:
801071e3:	6a 00                	push   $0x0
801071e5:	68 c5 00 00 00       	push   $0xc5
801071ea:	e9 7a f3 ff ff       	jmp    80106569 <alltraps>

801071ef <vector198>:
801071ef:	6a 00                	push   $0x0
801071f1:	68 c6 00 00 00       	push   $0xc6
801071f6:	e9 6e f3 ff ff       	jmp    80106569 <alltraps>

801071fb <vector199>:
801071fb:	6a 00                	push   $0x0
801071fd:	68 c7 00 00 00       	push   $0xc7
80107202:	e9 62 f3 ff ff       	jmp    80106569 <alltraps>

80107207 <vector200>:
80107207:	6a 00                	push   $0x0
80107209:	68 c8 00 00 00       	push   $0xc8
8010720e:	e9 56 f3 ff ff       	jmp    80106569 <alltraps>

80107213 <vector201>:
80107213:	6a 00                	push   $0x0
80107215:	68 c9 00 00 00       	push   $0xc9
8010721a:	e9 4a f3 ff ff       	jmp    80106569 <alltraps>

8010721f <vector202>:
8010721f:	6a 00                	push   $0x0
80107221:	68 ca 00 00 00       	push   $0xca
80107226:	e9 3e f3 ff ff       	jmp    80106569 <alltraps>

8010722b <vector203>:
8010722b:	6a 00                	push   $0x0
8010722d:	68 cb 00 00 00       	push   $0xcb
80107232:	e9 32 f3 ff ff       	jmp    80106569 <alltraps>

80107237 <vector204>:
80107237:	6a 00                	push   $0x0
80107239:	68 cc 00 00 00       	push   $0xcc
8010723e:	e9 26 f3 ff ff       	jmp    80106569 <alltraps>

80107243 <vector205>:
80107243:	6a 00                	push   $0x0
80107245:	68 cd 00 00 00       	push   $0xcd
8010724a:	e9 1a f3 ff ff       	jmp    80106569 <alltraps>

8010724f <vector206>:
8010724f:	6a 00                	push   $0x0
80107251:	68 ce 00 00 00       	push   $0xce
80107256:	e9 0e f3 ff ff       	jmp    80106569 <alltraps>

8010725b <vector207>:
8010725b:	6a 00                	push   $0x0
8010725d:	68 cf 00 00 00       	push   $0xcf
80107262:	e9 02 f3 ff ff       	jmp    80106569 <alltraps>

80107267 <vector208>:
80107267:	6a 00                	push   $0x0
80107269:	68 d0 00 00 00       	push   $0xd0
8010726e:	e9 f6 f2 ff ff       	jmp    80106569 <alltraps>

80107273 <vector209>:
80107273:	6a 00                	push   $0x0
80107275:	68 d1 00 00 00       	push   $0xd1
8010727a:	e9 ea f2 ff ff       	jmp    80106569 <alltraps>

8010727f <vector210>:
8010727f:	6a 00                	push   $0x0
80107281:	68 d2 00 00 00       	push   $0xd2
80107286:	e9 de f2 ff ff       	jmp    80106569 <alltraps>

8010728b <vector211>:
8010728b:	6a 00                	push   $0x0
8010728d:	68 d3 00 00 00       	push   $0xd3
80107292:	e9 d2 f2 ff ff       	jmp    80106569 <alltraps>

80107297 <vector212>:
80107297:	6a 00                	push   $0x0
80107299:	68 d4 00 00 00       	push   $0xd4
8010729e:	e9 c6 f2 ff ff       	jmp    80106569 <alltraps>

801072a3 <vector213>:
801072a3:	6a 00                	push   $0x0
801072a5:	68 d5 00 00 00       	push   $0xd5
801072aa:	e9 ba f2 ff ff       	jmp    80106569 <alltraps>

801072af <vector214>:
801072af:	6a 00                	push   $0x0
801072b1:	68 d6 00 00 00       	push   $0xd6
801072b6:	e9 ae f2 ff ff       	jmp    80106569 <alltraps>

801072bb <vector215>:
801072bb:	6a 00                	push   $0x0
801072bd:	68 d7 00 00 00       	push   $0xd7
801072c2:	e9 a2 f2 ff ff       	jmp    80106569 <alltraps>

801072c7 <vector216>:
801072c7:	6a 00                	push   $0x0
801072c9:	68 d8 00 00 00       	push   $0xd8
801072ce:	e9 96 f2 ff ff       	jmp    80106569 <alltraps>

801072d3 <vector217>:
801072d3:	6a 00                	push   $0x0
801072d5:	68 d9 00 00 00       	push   $0xd9
801072da:	e9 8a f2 ff ff       	jmp    80106569 <alltraps>

801072df <vector218>:
801072df:	6a 00                	push   $0x0
801072e1:	68 da 00 00 00       	push   $0xda
801072e6:	e9 7e f2 ff ff       	jmp    80106569 <alltraps>

801072eb <vector219>:
801072eb:	6a 00                	push   $0x0
801072ed:	68 db 00 00 00       	push   $0xdb
801072f2:	e9 72 f2 ff ff       	jmp    80106569 <alltraps>

801072f7 <vector220>:
801072f7:	6a 00                	push   $0x0
801072f9:	68 dc 00 00 00       	push   $0xdc
801072fe:	e9 66 f2 ff ff       	jmp    80106569 <alltraps>

80107303 <vector221>:
80107303:	6a 00                	push   $0x0
80107305:	68 dd 00 00 00       	push   $0xdd
8010730a:	e9 5a f2 ff ff       	jmp    80106569 <alltraps>

8010730f <vector222>:
8010730f:	6a 00                	push   $0x0
80107311:	68 de 00 00 00       	push   $0xde
80107316:	e9 4e f2 ff ff       	jmp    80106569 <alltraps>

8010731b <vector223>:
8010731b:	6a 00                	push   $0x0
8010731d:	68 df 00 00 00       	push   $0xdf
80107322:	e9 42 f2 ff ff       	jmp    80106569 <alltraps>

80107327 <vector224>:
80107327:	6a 00                	push   $0x0
80107329:	68 e0 00 00 00       	push   $0xe0
8010732e:	e9 36 f2 ff ff       	jmp    80106569 <alltraps>

80107333 <vector225>:
80107333:	6a 00                	push   $0x0
80107335:	68 e1 00 00 00       	push   $0xe1
8010733a:	e9 2a f2 ff ff       	jmp    80106569 <alltraps>

8010733f <vector226>:
8010733f:	6a 00                	push   $0x0
80107341:	68 e2 00 00 00       	push   $0xe2
80107346:	e9 1e f2 ff ff       	jmp    80106569 <alltraps>

8010734b <vector227>:
8010734b:	6a 00                	push   $0x0
8010734d:	68 e3 00 00 00       	push   $0xe3
80107352:	e9 12 f2 ff ff       	jmp    80106569 <alltraps>

80107357 <vector228>:
80107357:	6a 00                	push   $0x0
80107359:	68 e4 00 00 00       	push   $0xe4
8010735e:	e9 06 f2 ff ff       	jmp    80106569 <alltraps>

80107363 <vector229>:
80107363:	6a 00                	push   $0x0
80107365:	68 e5 00 00 00       	push   $0xe5
8010736a:	e9 fa f1 ff ff       	jmp    80106569 <alltraps>

8010736f <vector230>:
8010736f:	6a 00                	push   $0x0
80107371:	68 e6 00 00 00       	push   $0xe6
80107376:	e9 ee f1 ff ff       	jmp    80106569 <alltraps>

8010737b <vector231>:
8010737b:	6a 00                	push   $0x0
8010737d:	68 e7 00 00 00       	push   $0xe7
80107382:	e9 e2 f1 ff ff       	jmp    80106569 <alltraps>

80107387 <vector232>:
80107387:	6a 00                	push   $0x0
80107389:	68 e8 00 00 00       	push   $0xe8
8010738e:	e9 d6 f1 ff ff       	jmp    80106569 <alltraps>

80107393 <vector233>:
80107393:	6a 00                	push   $0x0
80107395:	68 e9 00 00 00       	push   $0xe9
8010739a:	e9 ca f1 ff ff       	jmp    80106569 <alltraps>

8010739f <vector234>:
8010739f:	6a 00                	push   $0x0
801073a1:	68 ea 00 00 00       	push   $0xea
801073a6:	e9 be f1 ff ff       	jmp    80106569 <alltraps>

801073ab <vector235>:
801073ab:	6a 00                	push   $0x0
801073ad:	68 eb 00 00 00       	push   $0xeb
801073b2:	e9 b2 f1 ff ff       	jmp    80106569 <alltraps>

801073b7 <vector236>:
801073b7:	6a 00                	push   $0x0
801073b9:	68 ec 00 00 00       	push   $0xec
801073be:	e9 a6 f1 ff ff       	jmp    80106569 <alltraps>

801073c3 <vector237>:
801073c3:	6a 00                	push   $0x0
801073c5:	68 ed 00 00 00       	push   $0xed
801073ca:	e9 9a f1 ff ff       	jmp    80106569 <alltraps>

801073cf <vector238>:
801073cf:	6a 00                	push   $0x0
801073d1:	68 ee 00 00 00       	push   $0xee
801073d6:	e9 8e f1 ff ff       	jmp    80106569 <alltraps>

801073db <vector239>:
801073db:	6a 00                	push   $0x0
801073dd:	68 ef 00 00 00       	push   $0xef
801073e2:	e9 82 f1 ff ff       	jmp    80106569 <alltraps>

801073e7 <vector240>:
801073e7:	6a 00                	push   $0x0
801073e9:	68 f0 00 00 00       	push   $0xf0
801073ee:	e9 76 f1 ff ff       	jmp    80106569 <alltraps>

801073f3 <vector241>:
801073f3:	6a 00                	push   $0x0
801073f5:	68 f1 00 00 00       	push   $0xf1
801073fa:	e9 6a f1 ff ff       	jmp    80106569 <alltraps>

801073ff <vector242>:
801073ff:	6a 00                	push   $0x0
80107401:	68 f2 00 00 00       	push   $0xf2
80107406:	e9 5e f1 ff ff       	jmp    80106569 <alltraps>

8010740b <vector243>:
8010740b:	6a 00                	push   $0x0
8010740d:	68 f3 00 00 00       	push   $0xf3
80107412:	e9 52 f1 ff ff       	jmp    80106569 <alltraps>

80107417 <vector244>:
80107417:	6a 00                	push   $0x0
80107419:	68 f4 00 00 00       	push   $0xf4
8010741e:	e9 46 f1 ff ff       	jmp    80106569 <alltraps>

80107423 <vector245>:
80107423:	6a 00                	push   $0x0
80107425:	68 f5 00 00 00       	push   $0xf5
8010742a:	e9 3a f1 ff ff       	jmp    80106569 <alltraps>

8010742f <vector246>:
8010742f:	6a 00                	push   $0x0
80107431:	68 f6 00 00 00       	push   $0xf6
80107436:	e9 2e f1 ff ff       	jmp    80106569 <alltraps>

8010743b <vector247>:
8010743b:	6a 00                	push   $0x0
8010743d:	68 f7 00 00 00       	push   $0xf7
80107442:	e9 22 f1 ff ff       	jmp    80106569 <alltraps>

80107447 <vector248>:
80107447:	6a 00                	push   $0x0
80107449:	68 f8 00 00 00       	push   $0xf8
8010744e:	e9 16 f1 ff ff       	jmp    80106569 <alltraps>

80107453 <vector249>:
80107453:	6a 00                	push   $0x0
80107455:	68 f9 00 00 00       	push   $0xf9
8010745a:	e9 0a f1 ff ff       	jmp    80106569 <alltraps>

8010745f <vector250>:
8010745f:	6a 00                	push   $0x0
80107461:	68 fa 00 00 00       	push   $0xfa
80107466:	e9 fe f0 ff ff       	jmp    80106569 <alltraps>

8010746b <vector251>:
8010746b:	6a 00                	push   $0x0
8010746d:	68 fb 00 00 00       	push   $0xfb
80107472:	e9 f2 f0 ff ff       	jmp    80106569 <alltraps>

80107477 <vector252>:
80107477:	6a 00                	push   $0x0
80107479:	68 fc 00 00 00       	push   $0xfc
8010747e:	e9 e6 f0 ff ff       	jmp    80106569 <alltraps>

80107483 <vector253>:
80107483:	6a 00                	push   $0x0
80107485:	68 fd 00 00 00       	push   $0xfd
8010748a:	e9 da f0 ff ff       	jmp    80106569 <alltraps>

8010748f <vector254>:
8010748f:	6a 00                	push   $0x0
80107491:	68 fe 00 00 00       	push   $0xfe
80107496:	e9 ce f0 ff ff       	jmp    80106569 <alltraps>

8010749b <vector255>:
8010749b:	6a 00                	push   $0x0
8010749d:	68 ff 00 00 00       	push   $0xff
801074a2:	e9 c2 f0 ff ff       	jmp    80106569 <alltraps>
801074a7:	66 90                	xchg   %ax,%ax
801074a9:	66 90                	xchg   %ax,%ax
801074ab:	66 90                	xchg   %ax,%ax
801074ad:	66 90                	xchg   %ax,%ax
801074af:	90                   	nop

801074b0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801074b0:	55                   	push   %ebp
801074b1:	89 e5                	mov    %esp,%ebp
801074b3:	57                   	push   %edi
801074b4:	56                   	push   %esi
801074b5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801074b6:	89 d3                	mov    %edx,%ebx
{
801074b8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
801074ba:	c1 eb 16             	shr    $0x16,%ebx
801074bd:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
801074c0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801074c3:	8b 06                	mov    (%esi),%eax
801074c5:	a8 01                	test   $0x1,%al
801074c7:	74 27                	je     801074f0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801074c9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801074ce:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801074d4:	c1 ef 0a             	shr    $0xa,%edi
}
801074d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801074da:	89 fa                	mov    %edi,%edx
801074dc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801074e2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801074e5:	5b                   	pop    %ebx
801074e6:	5e                   	pop    %esi
801074e7:	5f                   	pop    %edi
801074e8:	5d                   	pop    %ebp
801074e9:	c3                   	ret    
801074ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801074f0:	85 c9                	test   %ecx,%ecx
801074f2:	74 2c                	je     80107520 <walkpgdir+0x70>
801074f4:	e8 47 b3 ff ff       	call   80102840 <kalloc>
801074f9:	85 c0                	test   %eax,%eax
801074fb:	89 c3                	mov    %eax,%ebx
801074fd:	74 21                	je     80107520 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801074ff:	83 ec 04             	sub    $0x4,%esp
80107502:	68 00 10 00 00       	push   $0x1000
80107507:	6a 00                	push   $0x0
80107509:	50                   	push   %eax
8010750a:	e8 51 dd ff ff       	call   80105260 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010750f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107515:	83 c4 10             	add    $0x10,%esp
80107518:	83 c8 07             	or     $0x7,%eax
8010751b:	89 06                	mov    %eax,(%esi)
8010751d:	eb b5                	jmp    801074d4 <walkpgdir+0x24>
8010751f:	90                   	nop
}
80107520:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107523:	31 c0                	xor    %eax,%eax
}
80107525:	5b                   	pop    %ebx
80107526:	5e                   	pop    %esi
80107527:	5f                   	pop    %edi
80107528:	5d                   	pop    %ebp
80107529:	c3                   	ret    
8010752a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107530 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107530:	55                   	push   %ebp
80107531:	89 e5                	mov    %esp,%ebp
80107533:	57                   	push   %edi
80107534:	56                   	push   %esi
80107535:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107536:	89 d3                	mov    %edx,%ebx
80107538:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010753e:	83 ec 1c             	sub    $0x1c,%esp
80107541:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107544:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107548:	8b 7d 08             	mov    0x8(%ebp),%edi
8010754b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107550:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107553:	8b 45 0c             	mov    0xc(%ebp),%eax
80107556:	29 df                	sub    %ebx,%edi
80107558:	83 c8 01             	or     $0x1,%eax
8010755b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010755e:	eb 15                	jmp    80107575 <mappages+0x45>
    if(*pte & PTE_P)
80107560:	f6 00 01             	testb  $0x1,(%eax)
80107563:	75 45                	jne    801075aa <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107565:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107568:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010756b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010756d:	74 31                	je     801075a0 <mappages+0x70>
      break;
    a += PGSIZE;
8010756f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107575:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107578:	b9 01 00 00 00       	mov    $0x1,%ecx
8010757d:	89 da                	mov    %ebx,%edx
8010757f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107582:	e8 29 ff ff ff       	call   801074b0 <walkpgdir>
80107587:	85 c0                	test   %eax,%eax
80107589:	75 d5                	jne    80107560 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010758b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010758e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107593:	5b                   	pop    %ebx
80107594:	5e                   	pop    %esi
80107595:	5f                   	pop    %edi
80107596:	5d                   	pop    %ebp
80107597:	c3                   	ret    
80107598:	90                   	nop
80107599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801075a3:	31 c0                	xor    %eax,%eax
}
801075a5:	5b                   	pop    %ebx
801075a6:	5e                   	pop    %esi
801075a7:	5f                   	pop    %edi
801075a8:	5d                   	pop    %ebp
801075a9:	c3                   	ret    
      panic("remap");
801075aa:	83 ec 0c             	sub    $0xc,%esp
801075ad:	68 dc 8a 10 80       	push   $0x80108adc
801075b2:	e8 d9 8d ff ff       	call   80100390 <panic>
801075b7:	89 f6                	mov    %esi,%esi
801075b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801075c0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801075c0:	55                   	push   %ebp
801075c1:	89 e5                	mov    %esp,%ebp
801075c3:	57                   	push   %edi
801075c4:	56                   	push   %esi
801075c5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801075c6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801075cc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801075d2:	83 ec 1c             	sub    $0x1c,%esp
801075d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801075d8:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801075da:	89 4d dc             	mov    %ecx,-0x24(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801075dd:	0f 83 90 00 00 00    	jae    80107673 <deallocuvm.part.0+0xb3>
801075e3:	89 55 e0             	mov    %edx,-0x20(%ebp)
801075e6:	eb 68                	jmp    80107650 <deallocuvm.part.0+0x90>
801075e8:	90                   	nop
801075e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
801075f0:	8b 30                	mov    (%eax),%esi
801075f2:	f7 c6 01 00 00 00    	test   $0x1,%esi
801075f8:	74 4b                	je     80107645 <deallocuvm.part.0+0x85>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801075fa:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107600:	0f 84 8e 00 00 00    	je     80107694 <deallocuvm.part.0+0xd4>
        panic("kfree");
      acquire(&lock);
80107606:	83 ec 0c             	sub    $0xc,%esp
80107609:	68 e0 4d 12 80       	push   $0x80124de0
8010760e:	e8 3d db ff ff       	call   80105150 <acquire>
      // if no other page table is pointing to the page,remove it
      if(--pg_refcount[pa >> PGSHIFT] == 0)
80107613:	89 f1                	mov    %esi,%ecx
80107615:	83 c4 10             	add    $0x10,%esp
80107618:	c1 e9 0c             	shr    $0xc,%ecx
8010761b:	0f b6 81 e0 6d 11 80 	movzbl -0x7fee9220(%ecx),%eax
80107622:	8d 50 ff             	lea    -0x1(%eax),%edx
80107625:	84 d2                	test   %dl,%dl
80107627:	88 91 e0 6d 11 80    	mov    %dl,-0x7fee9220(%ecx)
8010762d:	74 51                	je     80107680 <deallocuvm.part.0+0xc0>
      {
      char *v = P2V(pa);
      kfree(v);
      }
      release(&lock);
8010762f:	83 ec 0c             	sub    $0xc,%esp
80107632:	68 e0 4d 12 80       	push   $0x80124de0
80107637:	e8 d4 db ff ff       	call   80105210 <release>
      *pte = 0;
8010763c:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80107642:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107645:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010764b:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
8010764e:	73 23                	jae    80107673 <deallocuvm.part.0+0xb3>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107650:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107653:	31 c9                	xor    %ecx,%ecx
80107655:	89 da                	mov    %ebx,%edx
80107657:	e8 54 fe ff ff       	call   801074b0 <walkpgdir>
    if(!pte)
8010765c:	85 c0                	test   %eax,%eax
    pte = walkpgdir(pgdir, (char*)a, 0);
8010765e:	89 c7                	mov    %eax,%edi
    if(!pte)
80107660:	75 8e                	jne    801075f0 <deallocuvm.part.0+0x30>
      a += (NPTENTRIES - 1) * PGSIZE;
80107662:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107668:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010766e:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80107671:	72 dd                	jb     80107650 <deallocuvm.part.0+0x90>
    }
  }
  return newsz;
}
80107673:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107676:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107679:	5b                   	pop    %ebx
8010767a:	5e                   	pop    %esi
8010767b:	5f                   	pop    %edi
8010767c:	5d                   	pop    %ebp
8010767d:	c3                   	ret    
8010767e:	66 90                	xchg   %ax,%ax
      kfree(v);
80107680:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107683:	81 c6 00 00 00 80    	add    $0x80000000,%esi
      kfree(v);
80107689:	56                   	push   %esi
8010768a:	e8 f1 af ff ff       	call   80102680 <kfree>
8010768f:	83 c4 10             	add    $0x10,%esp
80107692:	eb 9b                	jmp    8010762f <deallocuvm.part.0+0x6f>
        panic("kfree");
80107694:	83 ec 0c             	sub    $0xc,%esp
80107697:	68 66 82 10 80       	push   $0x80108266
8010769c:	e8 ef 8c ff ff       	call   80100390 <panic>
801076a1:	eb 0d                	jmp    801076b0 <seginit>
801076a3:	90                   	nop
801076a4:	90                   	nop
801076a5:	90                   	nop
801076a6:	90                   	nop
801076a7:	90                   	nop
801076a8:	90                   	nop
801076a9:	90                   	nop
801076aa:	90                   	nop
801076ab:	90                   	nop
801076ac:	90                   	nop
801076ad:	90                   	nop
801076ae:	90                   	nop
801076af:	90                   	nop

801076b0 <seginit>:
{
801076b0:	55                   	push   %ebp
801076b1:	89 e5                	mov    %esp,%ebp
801076b3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801076b6:	e8 45 c5 ff ff       	call   80103c00 <cpuid>
801076bb:	69 c0 b4 00 00 00    	imul   $0xb4,%eax,%eax
  pd[0] = size-1;
801076c1:	b9 2f 00 00 00       	mov    $0x2f,%ecx
801076c6:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  lgdt(c->gdt, sizeof(c->gdt));
801076ca:	8d 90 d0 3a 11 80    	lea    -0x7feec530(%eax),%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801076d0:	c7 80 d8 3a 11 80 ff 	movl   $0xffff,-0x7feec528(%eax)
801076d7:	ff 00 00 
801076da:	c7 80 dc 3a 11 80 00 	movl   $0xcf9a00,-0x7feec524(%eax)
801076e1:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801076e4:	c7 80 e0 3a 11 80 ff 	movl   $0xffff,-0x7feec520(%eax)
801076eb:	ff 00 00 
801076ee:	c7 80 e4 3a 11 80 00 	movl   $0xcf9200,-0x7feec51c(%eax)
801076f5:	92 cf 00 
  pd[1] = (uint)p;
801076f8:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801076fc:	c1 ea 10             	shr    $0x10,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801076ff:	c7 80 e8 3a 11 80 ff 	movl   $0xffff,-0x7feec518(%eax)
80107706:	ff 00 00 
80107709:	66 89 55 f6          	mov    %dx,-0xa(%ebp)
8010770d:	c7 80 ec 3a 11 80 00 	movl   $0xcffa00,-0x7feec514(%eax)
80107714:	fa cf 00 
  asm volatile("lgdt (%0)" : : "r" (pd));
80107717:	8d 55 f2             	lea    -0xe(%ebp),%edx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010771a:	c7 80 f0 3a 11 80 ff 	movl   $0xffff,-0x7feec510(%eax)
80107721:	ff 00 00 
80107724:	c7 80 f4 3a 11 80 00 	movl   $0xcff200,-0x7feec50c(%eax)
8010772b:	f2 cf 00 
8010772e:	0f 01 12             	lgdtl  (%edx)
  c = &cpus[cpuid()];
80107731:	05 60 3a 11 80       	add    $0x80113a60,%eax
  proc = 0;
80107736:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
8010773d:	00 00 00 00 
  c = &cpus[cpuid()];
80107741:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
}
80107747:	c9                   	leave  
80107748:	c3                   	ret    
80107749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107750 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107750:	a1 14 4e 12 80       	mov    0x80124e14,%eax
{
80107755:	55                   	push   %ebp
80107756:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107758:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010775d:	0f 22 d8             	mov    %eax,%cr3
}
80107760:	5d                   	pop    %ebp
80107761:	c3                   	ret    
80107762:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107770 <switchuvm>:
{
80107770:	55                   	push   %ebp
80107771:	89 e5                	mov    %esp,%ebp
80107773:	57                   	push   %edi
80107774:	56                   	push   %esi
80107775:	53                   	push   %ebx
80107776:	83 ec 1c             	sub    $0x1c,%esp
80107779:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010777c:	85 db                	test   %ebx,%ebx
8010777e:	0f 84 cb 00 00 00    	je     8010784f <switchuvm+0xdf>
  if(p->kstack == 0)
80107784:	8b 43 08             	mov    0x8(%ebx),%eax
80107787:	85 c0                	test   %eax,%eax
80107789:	0f 84 da 00 00 00    	je     80107869 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010778f:	8b 43 04             	mov    0x4(%ebx),%eax
80107792:	85 c0                	test   %eax,%eax
80107794:	0f 84 c2 00 00 00    	je     8010785c <switchuvm+0xec>
  pushcli();
8010779a:	e8 e1 d8 ff ff       	call   80105080 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010779f:	e8 dc c3 ff ff       	call   80103b80 <mycpu>
801077a4:	89 c6                	mov    %eax,%esi
801077a6:	e8 d5 c3 ff ff       	call   80103b80 <mycpu>
801077ab:	89 c7                	mov    %eax,%edi
801077ad:	e8 ce c3 ff ff       	call   80103b80 <mycpu>
801077b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801077b5:	83 c7 08             	add    $0x8,%edi
801077b8:	e8 c3 c3 ff ff       	call   80103b80 <mycpu>
801077bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801077c0:	83 c0 08             	add    $0x8,%eax
801077c3:	ba 67 00 00 00       	mov    $0x67,%edx
801077c8:	c1 e8 18             	shr    $0x18,%eax
801077cb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801077d2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801077d9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801077df:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801077e4:	83 c1 08             	add    $0x8,%ecx
801077e7:	c1 e9 10             	shr    $0x10,%ecx
801077ea:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801077f0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801077f5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801077fc:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107801:	e8 7a c3 ff ff       	call   80103b80 <mycpu>
80107806:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010780d:	e8 6e c3 ff ff       	call   80103b80 <mycpu>
80107812:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107816:	8b 73 08             	mov    0x8(%ebx),%esi
80107819:	e8 62 c3 ff ff       	call   80103b80 <mycpu>
8010781e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107824:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107827:	e8 54 c3 ff ff       	call   80103b80 <mycpu>
8010782c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107830:	b8 28 00 00 00       	mov    $0x28,%eax
80107835:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107838:	8b 43 04             	mov    0x4(%ebx),%eax
8010783b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107840:	0f 22 d8             	mov    %eax,%cr3
}
80107843:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107846:	5b                   	pop    %ebx
80107847:	5e                   	pop    %esi
80107848:	5f                   	pop    %edi
80107849:	5d                   	pop    %ebp
  popcli();
8010784a:	e9 71 d8 ff ff       	jmp    801050c0 <popcli>
    panic("switchuvm: no process");
8010784f:	83 ec 0c             	sub    $0xc,%esp
80107852:	68 e2 8a 10 80       	push   $0x80108ae2
80107857:	e8 34 8b ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
8010785c:	83 ec 0c             	sub    $0xc,%esp
8010785f:	68 0d 8b 10 80       	push   $0x80108b0d
80107864:	e8 27 8b ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80107869:	83 ec 0c             	sub    $0xc,%esp
8010786c:	68 f8 8a 10 80       	push   $0x80108af8
80107871:	e8 1a 8b ff ff       	call   80100390 <panic>
80107876:	8d 76 00             	lea    0x0(%esi),%esi
80107879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107880 <inituvm>:
{
80107880:	55                   	push   %ebp
80107881:	89 e5                	mov    %esp,%ebp
80107883:	57                   	push   %edi
80107884:	56                   	push   %esi
80107885:	53                   	push   %ebx
80107886:	83 ec 1c             	sub    $0x1c,%esp
80107889:	8b 45 08             	mov    0x8(%ebp),%eax
8010788c:	8b 75 10             	mov    0x10(%ebp),%esi
8010788f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107892:	8b 45 0c             	mov    0xc(%ebp),%eax
80107895:	89 45 e0             	mov    %eax,-0x20(%ebp)
  mem = kalloc();
80107898:	e8 a3 af ff ff       	call   80102840 <kalloc>
  acquire(&lock);
8010789d:	83 ec 0c             	sub    $0xc,%esp
  mem = kalloc();
801078a0:	89 c3                	mov    %eax,%ebx
  acquire(&lock);
801078a2:	68 e0 4d 12 80       	push   $0x80124de0
  pg_refcount[V2P(mem) >> PGSHIFT] = pg_refcount[V2P(mem) >> PGSHIFT] + 1 ;
801078a7:	8d bb 00 00 00 80    	lea    -0x80000000(%ebx),%edi
  acquire(&lock);
801078ad:	e8 9e d8 ff ff       	call   80105150 <acquire>
  pg_refcount[V2P(mem) >> PGSHIFT] = pg_refcount[V2P(mem) >> PGSHIFT] + 1 ;
801078b2:	89 f8                	mov    %edi,%eax
  release(&lock);
801078b4:	c7 04 24 e0 4d 12 80 	movl   $0x80124de0,(%esp)
  pg_refcount[V2P(mem) >> PGSHIFT] = pg_refcount[V2P(mem) >> PGSHIFT] + 1 ;
801078bb:	c1 e8 0c             	shr    $0xc,%eax
801078be:	80 80 e0 6d 11 80 01 	addb   $0x1,-0x7fee9220(%eax)
  release(&lock);
801078c5:	e8 46 d9 ff ff       	call   80105210 <release>
  if(sz >= PGSIZE)
801078ca:	83 c4 10             	add    $0x10,%esp
801078cd:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801078d3:	77 3f                	ja     80107914 <inituvm+0x94>
  memset(mem, 0, PGSIZE);
801078d5:	83 ec 04             	sub    $0x4,%esp
801078d8:	68 00 10 00 00       	push   $0x1000
801078dd:	6a 00                	push   $0x0
801078df:	53                   	push   %ebx
801078e0:	e8 7b d9 ff ff       	call   80105260 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801078e5:	58                   	pop    %eax
801078e6:	5a                   	pop    %edx
801078e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078ea:	6a 06                	push   $0x6
801078ec:	b9 00 10 00 00       	mov    $0x1000,%ecx
801078f1:	57                   	push   %edi
801078f2:	31 d2                	xor    %edx,%edx
801078f4:	e8 37 fc ff ff       	call   80107530 <mappages>
  memmove(mem, init, sz);
801078f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801078fc:	89 75 10             	mov    %esi,0x10(%ebp)
801078ff:	83 c4 10             	add    $0x10,%esp
80107902:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107905:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107908:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010790b:	5b                   	pop    %ebx
8010790c:	5e                   	pop    %esi
8010790d:	5f                   	pop    %edi
8010790e:	5d                   	pop    %ebp
  memmove(mem, init, sz);
8010790f:	e9 fc d9 ff ff       	jmp    80105310 <memmove>
    panic("inituvm: more than a page");
80107914:	83 ec 0c             	sub    $0xc,%esp
80107917:	68 21 8b 10 80       	push   $0x80108b21
8010791c:	e8 6f 8a ff ff       	call   80100390 <panic>
80107921:	eb 0d                	jmp    80107930 <loaduvm>
80107923:	90                   	nop
80107924:	90                   	nop
80107925:	90                   	nop
80107926:	90                   	nop
80107927:	90                   	nop
80107928:	90                   	nop
80107929:	90                   	nop
8010792a:	90                   	nop
8010792b:	90                   	nop
8010792c:	90                   	nop
8010792d:	90                   	nop
8010792e:	90                   	nop
8010792f:	90                   	nop

80107930 <loaduvm>:
{
80107930:	55                   	push   %ebp
80107931:	89 e5                	mov    %esp,%ebp
80107933:	57                   	push   %edi
80107934:	56                   	push   %esi
80107935:	53                   	push   %ebx
80107936:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107939:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107940:	0f 85 91 00 00 00    	jne    801079d7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107946:	8b 75 18             	mov    0x18(%ebp),%esi
80107949:	31 db                	xor    %ebx,%ebx
8010794b:	85 f6                	test   %esi,%esi
8010794d:	75 1a                	jne    80107969 <loaduvm+0x39>
8010794f:	eb 6f                	jmp    801079c0 <loaduvm+0x90>
80107951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107958:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010795e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107964:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107967:	76 57                	jbe    801079c0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107969:	8b 55 0c             	mov    0xc(%ebp),%edx
8010796c:	8b 45 08             	mov    0x8(%ebp),%eax
8010796f:	31 c9                	xor    %ecx,%ecx
80107971:	01 da                	add    %ebx,%edx
80107973:	e8 38 fb ff ff       	call   801074b0 <walkpgdir>
80107978:	85 c0                	test   %eax,%eax
8010797a:	74 4e                	je     801079ca <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
8010797c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010797e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107981:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107986:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010798b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107991:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107994:	01 d9                	add    %ebx,%ecx
80107996:	05 00 00 00 80       	add    $0x80000000,%eax
8010799b:	57                   	push   %edi
8010799c:	51                   	push   %ecx
8010799d:	50                   	push   %eax
8010799e:	ff 75 10             	pushl  0x10(%ebp)
801079a1:	e8 2a a3 ff ff       	call   80101cd0 <readi>
801079a6:	83 c4 10             	add    $0x10,%esp
801079a9:	39 f8                	cmp    %edi,%eax
801079ab:	74 ab                	je     80107958 <loaduvm+0x28>
}
801079ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801079b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801079b5:	5b                   	pop    %ebx
801079b6:	5e                   	pop    %esi
801079b7:	5f                   	pop    %edi
801079b8:	5d                   	pop    %ebp
801079b9:	c3                   	ret    
801079ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801079c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801079c3:	31 c0                	xor    %eax,%eax
}
801079c5:	5b                   	pop    %ebx
801079c6:	5e                   	pop    %esi
801079c7:	5f                   	pop    %edi
801079c8:	5d                   	pop    %ebp
801079c9:	c3                   	ret    
      panic("loaduvm: address should exist");
801079ca:	83 ec 0c             	sub    $0xc,%esp
801079cd:	68 3b 8b 10 80       	push   $0x80108b3b
801079d2:	e8 b9 89 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801079d7:	83 ec 0c             	sub    $0xc,%esp
801079da:	68 d8 8b 10 80       	push   $0x80108bd8
801079df:	e8 ac 89 ff ff       	call   80100390 <panic>
801079e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801079ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801079f0 <allocuvm>:
{
801079f0:	55                   	push   %ebp
801079f1:	89 e5                	mov    %esp,%ebp
801079f3:	57                   	push   %edi
801079f4:	56                   	push   %esi
801079f5:	53                   	push   %ebx
801079f6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801079f9:	8b 7d 10             	mov    0x10(%ebp),%edi
801079fc:	85 ff                	test   %edi,%edi
801079fe:	0f 88 cc 00 00 00    	js     80107ad0 <allocuvm+0xe0>
  if(newsz < oldsz)
80107a04:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107a07:	0f 82 b3 00 00 00    	jb     80107ac0 <allocuvm+0xd0>
  a = PGROUNDUP(oldsz);
80107a0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a10:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107a16:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107a1c:	39 75 10             	cmp    %esi,0x10(%ebp)
80107a1f:	0f 86 9e 00 00 00    	jbe    80107ac3 <allocuvm+0xd3>
80107a25:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107a28:	8b 7d 08             	mov    0x8(%ebp),%edi
80107a2b:	eb 5c                	jmp    80107a89 <allocuvm+0x99>
80107a2d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107a30:	83 ec 04             	sub    $0x4,%esp
    mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107a33:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    memset(mem, 0, PGSIZE);
80107a39:	68 00 10 00 00       	push   $0x1000
80107a3e:	6a 00                	push   $0x0
80107a40:	50                   	push   %eax
80107a41:	e8 1a d8 ff ff       	call   80105260 <memset>
    mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107a46:	58                   	pop    %eax
80107a47:	5a                   	pop    %edx
80107a48:	6a 06                	push   $0x6
80107a4a:	53                   	push   %ebx
80107a4b:	89 f2                	mov    %esi,%edx
80107a4d:	b9 00 10 00 00       	mov    $0x1000,%ecx
    pg_refcount[V2P(mem) >> PGSHIFT] = pg_refcount[V2P(mem) >> PGSHIFT] + 1 ;
80107a52:	c1 eb 0c             	shr    $0xc,%ebx
    mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107a55:	89 f8                	mov    %edi,%eax
  for(; a < newsz; a += PGSIZE){
80107a57:	81 c6 00 10 00 00    	add    $0x1000,%esi
    mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107a5d:	e8 ce fa ff ff       	call   80107530 <mappages>
    acquire(&lock);
80107a62:	c7 04 24 e0 4d 12 80 	movl   $0x80124de0,(%esp)
80107a69:	e8 e2 d6 ff ff       	call   80105150 <acquire>
    pg_refcount[V2P(mem) >> PGSHIFT] = pg_refcount[V2P(mem) >> PGSHIFT] + 1 ;
80107a6e:	80 83 e0 6d 11 80 01 	addb   $0x1,-0x7fee9220(%ebx)
    release(&lock);
80107a75:	c7 04 24 e0 4d 12 80 	movl   $0x80124de0,(%esp)
80107a7c:	e8 8f d7 ff ff       	call   80105210 <release>
  for(; a < newsz; a += PGSIZE){
80107a81:	83 c4 10             	add    $0x10,%esp
80107a84:	39 75 10             	cmp    %esi,0x10(%ebp)
80107a87:	76 57                	jbe    80107ae0 <allocuvm+0xf0>
    mem = kalloc();
80107a89:	e8 b2 ad ff ff       	call   80102840 <kalloc>
    if(mem == 0){
80107a8e:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107a90:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107a92:	75 9c                	jne    80107a30 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107a94:	83 ec 0c             	sub    $0xc,%esp
80107a97:	68 59 8b 10 80       	push   $0x80108b59
80107a9c:	e8 bf 8b ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80107aa1:	83 c4 10             	add    $0x10,%esp
80107aa4:	8b 45 0c             	mov    0xc(%ebp),%eax
80107aa7:	39 45 10             	cmp    %eax,0x10(%ebp)
80107aaa:	76 24                	jbe    80107ad0 <allocuvm+0xe0>
80107aac:	89 c1                	mov    %eax,%ecx
80107aae:	8b 55 10             	mov    0x10(%ebp),%edx
80107ab1:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80107ab4:	31 ff                	xor    %edi,%edi
80107ab6:	e8 05 fb ff ff       	call   801075c0 <deallocuvm.part.0>
80107abb:	eb 06                	jmp    80107ac3 <allocuvm+0xd3>
80107abd:	8d 76 00             	lea    0x0(%esi),%esi
    return oldsz;
80107ac0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107ac3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ac6:	89 f8                	mov    %edi,%eax
80107ac8:	5b                   	pop    %ebx
80107ac9:	5e                   	pop    %esi
80107aca:	5f                   	pop    %edi
80107acb:	5d                   	pop    %ebp
80107acc:	c3                   	ret    
80107acd:	8d 76 00             	lea    0x0(%esi),%esi
80107ad0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107ad3:	31 ff                	xor    %edi,%edi
}
80107ad5:	89 f8                	mov    %edi,%eax
80107ad7:	5b                   	pop    %ebx
80107ad8:	5e                   	pop    %esi
80107ad9:	5f                   	pop    %edi
80107ada:	5d                   	pop    %ebp
80107adb:	c3                   	ret    
80107adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107ae0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107ae3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ae6:	5b                   	pop    %ebx
80107ae7:	89 f8                	mov    %edi,%eax
80107ae9:	5e                   	pop    %esi
80107aea:	5f                   	pop    %edi
80107aeb:	5d                   	pop    %ebp
80107aec:	c3                   	ret    
80107aed:	8d 76 00             	lea    0x0(%esi),%esi

80107af0 <deallocuvm>:
{
80107af0:	55                   	push   %ebp
80107af1:	89 e5                	mov    %esp,%ebp
80107af3:	8b 55 0c             	mov    0xc(%ebp),%edx
80107af6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107af9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107afc:	39 d1                	cmp    %edx,%ecx
80107afe:	73 10                	jae    80107b10 <deallocuvm+0x20>
}
80107b00:	5d                   	pop    %ebp
80107b01:	e9 ba fa ff ff       	jmp    801075c0 <deallocuvm.part.0>
80107b06:	8d 76 00             	lea    0x0(%esi),%esi
80107b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107b10:	89 d0                	mov    %edx,%eax
80107b12:	5d                   	pop    %ebp
80107b13:	c3                   	ret    
80107b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107b20 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107b20:	55                   	push   %ebp
80107b21:	89 e5                	mov    %esp,%ebp
80107b23:	57                   	push   %edi
80107b24:	56                   	push   %esi
80107b25:	53                   	push   %ebx
80107b26:	83 ec 0c             	sub    $0xc,%esp
80107b29:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107b2c:	85 f6                	test   %esi,%esi
80107b2e:	74 59                	je     80107b89 <freevm+0x69>
80107b30:	31 c9                	xor    %ecx,%ecx
80107b32:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107b37:	89 f0                	mov    %esi,%eax
80107b39:	e8 82 fa ff ff       	call   801075c0 <deallocuvm.part.0>
80107b3e:	89 f3                	mov    %esi,%ebx
80107b40:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107b46:	eb 0f                	jmp    80107b57 <freevm+0x37>
80107b48:	90                   	nop
80107b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b50:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107b53:	39 fb                	cmp    %edi,%ebx
80107b55:	74 23                	je     80107b7a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107b57:	8b 03                	mov    (%ebx),%eax
80107b59:	a8 01                	test   $0x1,%al
80107b5b:	74 f3                	je     80107b50 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107b5d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107b62:	83 ec 0c             	sub    $0xc,%esp
80107b65:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107b68:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107b6d:	50                   	push   %eax
80107b6e:	e8 0d ab ff ff       	call   80102680 <kfree>
80107b73:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107b76:	39 fb                	cmp    %edi,%ebx
80107b78:	75 dd                	jne    80107b57 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107b7a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107b7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b80:	5b                   	pop    %ebx
80107b81:	5e                   	pop    %esi
80107b82:	5f                   	pop    %edi
80107b83:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107b84:	e9 f7 aa ff ff       	jmp    80102680 <kfree>
    panic("freevm: no pgdir");
80107b89:	83 ec 0c             	sub    $0xc,%esp
80107b8c:	68 71 8b 10 80       	push   $0x80108b71
80107b91:	e8 fa 87 ff ff       	call   80100390 <panic>
80107b96:	8d 76 00             	lea    0x0(%esi),%esi
80107b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ba0 <setupkvm>:
{
80107ba0:	55                   	push   %ebp
80107ba1:	89 e5                	mov    %esp,%ebp
80107ba3:	56                   	push   %esi
80107ba4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107ba5:	e8 96 ac ff ff       	call   80102840 <kalloc>
80107baa:	85 c0                	test   %eax,%eax
80107bac:	89 c6                	mov    %eax,%esi
80107bae:	74 42                	je     80107bf2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107bb0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107bb3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107bb8:	68 00 10 00 00       	push   $0x1000
80107bbd:	6a 00                	push   $0x0
80107bbf:	50                   	push   %eax
80107bc0:	e8 9b d6 ff ff       	call   80105260 <memset>
80107bc5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107bc8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107bcb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107bce:	83 ec 08             	sub    $0x8,%esp
80107bd1:	8b 13                	mov    (%ebx),%edx
80107bd3:	ff 73 0c             	pushl  0xc(%ebx)
80107bd6:	50                   	push   %eax
80107bd7:	29 c1                	sub    %eax,%ecx
80107bd9:	89 f0                	mov    %esi,%eax
80107bdb:	e8 50 f9 ff ff       	call   80107530 <mappages>
80107be0:	83 c4 10             	add    $0x10,%esp
80107be3:	85 c0                	test   %eax,%eax
80107be5:	78 19                	js     80107c00 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107be7:	83 c3 10             	add    $0x10,%ebx
80107bea:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107bf0:	75 d6                	jne    80107bc8 <setupkvm+0x28>
}
80107bf2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107bf5:	89 f0                	mov    %esi,%eax
80107bf7:	5b                   	pop    %ebx
80107bf8:	5e                   	pop    %esi
80107bf9:	5d                   	pop    %ebp
80107bfa:	c3                   	ret    
80107bfb:	90                   	nop
80107bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107c00:	83 ec 0c             	sub    $0xc,%esp
80107c03:	56                   	push   %esi
      return 0;
80107c04:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107c06:	e8 15 ff ff ff       	call   80107b20 <freevm>
      return 0;
80107c0b:	83 c4 10             	add    $0x10,%esp
}
80107c0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107c11:	89 f0                	mov    %esi,%eax
80107c13:	5b                   	pop    %ebx
80107c14:	5e                   	pop    %esi
80107c15:	5d                   	pop    %ebp
80107c16:	c3                   	ret    
80107c17:	89 f6                	mov    %esi,%esi
80107c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c20 <kvmalloc>:
{
80107c20:	55                   	push   %ebp
80107c21:	89 e5                	mov    %esp,%ebp
80107c23:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107c26:	e8 75 ff ff ff       	call   80107ba0 <setupkvm>
80107c2b:	a3 14 4e 12 80       	mov    %eax,0x80124e14
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107c30:	05 00 00 00 80       	add    $0x80000000,%eax
80107c35:	0f 22 d8             	mov    %eax,%cr3
}
80107c38:	c9                   	leave  
80107c39:	c3                   	ret    
80107c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c40 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107c40:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107c41:	31 c9                	xor    %ecx,%ecx
{
80107c43:	89 e5                	mov    %esp,%ebp
80107c45:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107c48:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c4b:	8b 45 08             	mov    0x8(%ebp),%eax
80107c4e:	e8 5d f8 ff ff       	call   801074b0 <walkpgdir>
  if(pte == 0)
80107c53:	85 c0                	test   %eax,%eax
80107c55:	74 05                	je     80107c5c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107c57:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107c5a:	c9                   	leave  
80107c5b:	c3                   	ret    
    panic("clearpteu");
80107c5c:	83 ec 0c             	sub    $0xc,%esp
80107c5f:	68 82 8b 10 80       	push   $0x80108b82
80107c64:	e8 27 87 ff ff       	call   80100390 <panic>
80107c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107c70 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107c70:	55                   	push   %ebp
80107c71:	89 e5                	mov    %esp,%ebp
80107c73:	57                   	push   %edi
80107c74:	56                   	push   %esi
80107c75:	53                   	push   %ebx
80107c76:	83 ec 0c             	sub    $0xc,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;

  if((d = setupkvm()) == 0)
80107c79:	e8 22 ff ff ff       	call   80107ba0 <setupkvm>
80107c7e:	85 c0                	test   %eax,%eax
80107c80:	89 c7                	mov    %eax,%edi
80107c82:	0f 84 ac 00 00 00    	je     80107d34 <copyuvm+0xc4>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107c88:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c8b:	85 c0                	test   %eax,%eax
80107c8d:	0f 84 ad 00 00 00    	je     80107d40 <copyuvm+0xd0>
80107c93:	31 f6                	xor    %esi,%esi
80107c95:	eb 3a                	jmp    80107cd1 <copyuvm+0x61>
80107c97:	89 f6                	mov    %esi,%esi
80107c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);

    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) // map the child's page table to same addresses
      goto bad;
    acquire(&lock);
80107ca0:	83 ec 0c             	sub    $0xc,%esp
    pg_refcount[pa >> PGSHIFT] = pg_refcount[pa >> PGSHIFT] + 1; // increase ref count
80107ca3:	c1 eb 0c             	shr    $0xc,%ebx
  for(i = 0; i < sz; i += PGSIZE){
80107ca6:	81 c6 00 10 00 00    	add    $0x1000,%esi
    acquire(&lock);
80107cac:	68 e0 4d 12 80       	push   $0x80124de0
80107cb1:	e8 9a d4 ff ff       	call   80105150 <acquire>
    pg_refcount[pa >> PGSHIFT] = pg_refcount[pa >> PGSHIFT] + 1; // increase ref count
80107cb6:	80 83 e0 6d 11 80 01 	addb   $0x1,-0x7fee9220(%ebx)
    release(&lock);
80107cbd:	c7 04 24 e0 4d 12 80 	movl   $0x80124de0,(%esp)
80107cc4:	e8 47 d5 ff ff       	call   80105210 <release>
  for(i = 0; i < sz; i += PGSIZE){
80107cc9:	83 c4 10             	add    $0x10,%esp
80107ccc:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107ccf:	76 6f                	jbe    80107d40 <copyuvm+0xd0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107cd1:	8b 45 08             	mov    0x8(%ebp),%eax
80107cd4:	31 c9                	xor    %ecx,%ecx
80107cd6:	89 f2                	mov    %esi,%edx
80107cd8:	e8 d3 f7 ff ff       	call   801074b0 <walkpgdir>
80107cdd:	85 c0                	test   %eax,%eax
80107cdf:	0f 84 7d 00 00 00    	je     80107d62 <copyuvm+0xf2>
    if(!(*pte & PTE_P))
80107ce5:	8b 10                	mov    (%eax),%edx
80107ce7:	f6 c2 01             	test   $0x1,%dl
80107cea:	74 69                	je     80107d55 <copyuvm+0xe5>
    *pte &= ~PTE_W; // make this page table unwritable
80107cec:	89 d1                	mov    %edx,%ecx
    pa = PTE_ADDR(*pte);
80107cee:	89 d3                	mov    %edx,%ebx
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) // map the child's page table to same addresses
80107cf0:	83 ec 08             	sub    $0x8,%esp
    *pte &= ~PTE_W; // make this page table unwritable
80107cf3:	83 e1 fd             	and    $0xfffffffd,%ecx
    flags = PTE_FLAGS(*pte);
80107cf6:	81 e2 fd 0f 00 00    	and    $0xffd,%edx
    pa = PTE_ADDR(*pte);
80107cfc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    *pte &= ~PTE_W; // make this page table unwritable
80107d02:	89 08                	mov    %ecx,(%eax)
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) // map the child's page table to same addresses
80107d04:	52                   	push   %edx
80107d05:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107d0a:	53                   	push   %ebx
80107d0b:	89 f2                	mov    %esi,%edx
80107d0d:	89 f8                	mov    %edi,%eax
80107d0f:	e8 1c f8 ff ff       	call   80107530 <mappages>
80107d14:	83 c4 10             	add    $0x10,%esp
80107d17:	85 c0                	test   %eax,%eax
80107d19:	79 85                	jns    80107ca0 <copyuvm+0x30>
  }
  lcr3(V2P(pgdir)); // Flush the page table
  return d;

bad:
  freevm(d);
80107d1b:	83 ec 0c             	sub    $0xc,%esp
80107d1e:	57                   	push   %edi
80107d1f:	e8 fc fd ff ff       	call   80107b20 <freevm>
  lcr3(V2P(pgdir)); // Flush the page table
80107d24:	8b 45 08             	mov    0x8(%ebp),%eax
80107d27:	05 00 00 00 80       	add    $0x80000000,%eax
80107d2c:	0f 22 d8             	mov    %eax,%cr3
  return 0;
80107d2f:	31 ff                	xor    %edi,%edi
80107d31:	83 c4 10             	add    $0x10,%esp
}
80107d34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d37:	89 f8                	mov    %edi,%eax
80107d39:	5b                   	pop    %ebx
80107d3a:	5e                   	pop    %esi
80107d3b:	5f                   	pop    %edi
80107d3c:	5d                   	pop    %ebp
80107d3d:	c3                   	ret    
80107d3e:	66 90                	xchg   %ax,%ax
  lcr3(V2P(pgdir)); // Flush the page table
80107d40:	8b 45 08             	mov    0x8(%ebp),%eax
80107d43:	05 00 00 00 80       	add    $0x80000000,%eax
80107d48:	0f 22 d8             	mov    %eax,%cr3
}
80107d4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d4e:	89 f8                	mov    %edi,%eax
80107d50:	5b                   	pop    %ebx
80107d51:	5e                   	pop    %esi
80107d52:	5f                   	pop    %edi
80107d53:	5d                   	pop    %ebp
80107d54:	c3                   	ret    
      panic("copyuvm: page not present");
80107d55:	83 ec 0c             	sub    $0xc,%esp
80107d58:	68 a6 8b 10 80       	push   $0x80108ba6
80107d5d:	e8 2e 86 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107d62:	83 ec 0c             	sub    $0xc,%esp
80107d65:	68 8c 8b 10 80       	push   $0x80108b8c
80107d6a:	e8 21 86 ff ff       	call   80100390 <panic>
80107d6f:	90                   	nop

80107d70 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107d70:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107d71:	31 c9                	xor    %ecx,%ecx
{
80107d73:	89 e5                	mov    %esp,%ebp
80107d75:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107d78:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d7b:	8b 45 08             	mov    0x8(%ebp),%eax
80107d7e:	e8 2d f7 ff ff       	call   801074b0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107d83:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107d85:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107d86:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107d88:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107d8d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107d90:	05 00 00 00 80       	add    $0x80000000,%eax
80107d95:	83 fa 05             	cmp    $0x5,%edx
80107d98:	ba 00 00 00 00       	mov    $0x0,%edx
80107d9d:	0f 45 c2             	cmovne %edx,%eax
}
80107da0:	c3                   	ret    
80107da1:	eb 0d                	jmp    80107db0 <copyout>
80107da3:	90                   	nop
80107da4:	90                   	nop
80107da5:	90                   	nop
80107da6:	90                   	nop
80107da7:	90                   	nop
80107da8:	90                   	nop
80107da9:	90                   	nop
80107daa:	90                   	nop
80107dab:	90                   	nop
80107dac:	90                   	nop
80107dad:	90                   	nop
80107dae:	90                   	nop
80107daf:	90                   	nop

80107db0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107db0:	55                   	push   %ebp
80107db1:	89 e5                	mov    %esp,%ebp
80107db3:	57                   	push   %edi
80107db4:	56                   	push   %esi
80107db5:	53                   	push   %ebx
80107db6:	83 ec 1c             	sub    $0x1c,%esp
80107db9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107dbc:	8b 55 0c             	mov    0xc(%ebp),%edx
80107dbf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107dc2:	85 db                	test   %ebx,%ebx
80107dc4:	75 40                	jne    80107e06 <copyout+0x56>
80107dc6:	eb 70                	jmp    80107e38 <copyout+0x88>
80107dc8:	90                   	nop
80107dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107dd0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107dd3:	89 f1                	mov    %esi,%ecx
80107dd5:	29 d1                	sub    %edx,%ecx
80107dd7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107ddd:	39 d9                	cmp    %ebx,%ecx
80107ddf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107de2:	29 f2                	sub    %esi,%edx
80107de4:	83 ec 04             	sub    $0x4,%esp
80107de7:	01 d0                	add    %edx,%eax
80107de9:	51                   	push   %ecx
80107dea:	57                   	push   %edi
80107deb:	50                   	push   %eax
80107dec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107def:	e8 1c d5 ff ff       	call   80105310 <memmove>
    len -= n;
    buf += n;
80107df4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107df7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80107dfa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107e00:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107e02:	29 cb                	sub    %ecx,%ebx
80107e04:	74 32                	je     80107e38 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107e06:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107e08:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107e0b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107e0e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107e14:	56                   	push   %esi
80107e15:	ff 75 08             	pushl  0x8(%ebp)
80107e18:	e8 53 ff ff ff       	call   80107d70 <uva2ka>
    if(pa0 == 0)
80107e1d:	83 c4 10             	add    $0x10,%esp
80107e20:	85 c0                	test   %eax,%eax
80107e22:	75 ac                	jne    80107dd0 <copyout+0x20>
  }
  return 0;
}
80107e24:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107e27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107e2c:	5b                   	pop    %ebx
80107e2d:	5e                   	pop    %esi
80107e2e:	5f                   	pop    %edi
80107e2f:	5d                   	pop    %ebp
80107e30:	c3                   	ret    
80107e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e38:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107e3b:	31 c0                	xor    %eax,%eax
}
80107e3d:	5b                   	pop    %ebx
80107e3e:	5e                   	pop    %esi
80107e3f:	5f                   	pop    %edi
80107e40:	5d                   	pop    %ebp
80107e41:	c3                   	ret    
80107e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107e50 <pagefault>:


//Page Fault Handling
void 
pagefault(uint err_code)
{
80107e50:	55                   	push   %ebp
80107e51:	89 e5                	mov    %esp,%ebp
80107e53:	57                   	push   %edi
80107e54:	56                   	push   %esi
80107e55:	53                   	push   %ebx
80107e56:	83 ec 1c             	sub    $0x1c,%esp
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107e59:	0f 20 d3             	mov    %cr2,%ebx
  // get the faulting virtual address from the CR2 register
  uint va = rcr2();
  uint pa;
  pte_t *pte;
  char *mem;
  if(va >= KERNBASE)
80107e5c:	85 db                	test   %ebx,%ebx
80107e5e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107e64:	0f 88 f4 00 00 00    	js     80107f5e <pagefault+0x10e>
    cprintf("Illegal memory access on cpu %d addr 0x%x, kill proc %s with pid %d\n",
                                            cpu->apicid, va, proc->name, proc->pid);
    proc->killed = 1;
    return;
  }
  if((pte = walkpgdir(proc->pgdir, (void*)va, 0))==0)
80107e6a:	8b 40 04             	mov    0x4(%eax),%eax
80107e6d:	31 c9                	xor    %ecx,%ecx
80107e6f:	89 da                	mov    %ebx,%edx
80107e71:	e8 3a f6 ff ff       	call   801074b0 <walkpgdir>
80107e76:	85 c0                	test   %eax,%eax
80107e78:	89 c6                	mov    %eax,%esi
80107e7a:	0f 84 d8 00 00 00    	je     80107f58 <pagefault+0x108>
    cprintf("Illegal memory access on cpu %d addr 0x%x, kill proc %s with pid %d\n",
                                            cpu->apicid, va, proc->name, proc->pid);
    proc->killed = 1;
    return;
  }
  if(!(*pte & PTE_U))
80107e80:	8b 00                	mov    (%eax),%eax
80107e82:	a8 04                	test   $0x4,%al
80107e84:	0f 84 ce 00 00 00    	je     80107f58 <pagefault+0x108>
    cprintf("Illegal memory access on cpu %d addr 0x%x, kill proc %s with pid %d\n",
                                            cpu->apicid, va, proc->name, proc->pid);
    proc->killed = 1;
    return;
  }
    if(!(*pte & PTE_P))
80107e8a:	a8 01                	test   $0x1,%al
80107e8c:	0f 84 c6 00 00 00    	je     80107f58 <pagefault+0x108>
    cprintf("Illegal memory access on cpu %d addr 0x%x, kill proc %s with pid %d\n",
                                            cpu->apicid, va, proc->name, proc->pid);
    proc->killed = 1;
    return;
  }
  if(*pte & PTE_W)
80107e92:	a8 02                	test   $0x2,%al
80107e94:	0f 85 57 01 00 00    	jne    80107ff1 <pagefault+0x1a1>
    panic("Unknown page fault due to a writable pte");
  }
  else
  {
    // get the physical address from the  given page table entry
    pa = PTE_ADDR(*pte);
80107e9a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    acquire(&lock);
80107e9f:	83 ec 0c             	sub    $0xc,%esp
    pa = PTE_ADDR(*pte);
80107ea2:	89 c3                	mov    %eax,%ebx
    acquire(&lock);
80107ea4:	68 e0 4d 12 80       	push   $0x80124de0
    pa = PTE_ADDR(*pte);
80107ea9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(pg_refcount[pa >> PGSHIFT] == 1)
80107eac:	c1 eb 0c             	shr    $0xc,%ebx
    acquire(&lock);
80107eaf:	e8 9c d2 ff ff       	call   80105150 <acquire>
    if(pg_refcount[pa >> PGSHIFT] == 1)
80107eb4:	83 c4 10             	add    $0x10,%esp
80107eb7:	80 bb e0 6d 11 80 01 	cmpb   $0x1,-0x7fee9220(%ebx)
80107ebe:	0f 84 fc 00 00 00    	je     80107fc0 <pagefault+0x170>
      *pte |= PTE_W;  // remove the read-only restriction on the trapping page
    }
    else
    {
      // Current process is the first one that tries to write to this page
      if(pg_refcount[pa >> PGSHIFT] > 1)
80107ec4:	0f 8e 0e 01 00 00    	jle    80107fd8 <pagefault+0x188>
      {
        release(&lock);
80107eca:	83 ec 0c             	sub    $0xc,%esp
80107ecd:	68 e0 4d 12 80       	push   $0x80124de0
80107ed2:	e8 39 d3 ff ff       	call   80105210 <release>
        if((mem = kalloc()) == 0)
80107ed7:	e8 64 a9 ff ff       	call   80102840 <kalloc>
80107edc:	83 c4 10             	add    $0x10,%esp
80107edf:	85 c0                	test   %eax,%eax
80107ee1:	89 c7                	mov    %eax,%edi
80107ee3:	0f 84 af 00 00 00    	je     80107f98 <pagefault+0x148>
          cprintf("Illegal memory access");
          proc->killed = 1;
          return;
        }
        // copy the contents from the original memory page pointed the virtual address
        memmove(mem, (char*)P2V(pa), PGSIZE);
80107ee9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107eec:	83 ec 04             	sub    $0x4,%esp
80107eef:	68 00 10 00 00       	push   $0x1000
80107ef4:	05 00 00 00 80       	add    $0x80000000,%eax
80107ef9:	50                   	push   %eax
80107efa:	57                   	push   %edi
        acquire(&lock);
        pg_refcount[pa >> PGSHIFT] = pg_refcount[pa >> PGSHIFT] - 1;
        pg_refcount[V2P(mem) >> PGSHIFT] = pg_refcount[V2P(mem) >> PGSHIFT] + 1;
80107efb:	81 c7 00 00 00 80    	add    $0x80000000,%edi
        memmove(mem, (char*)P2V(pa), PGSIZE);
80107f01:	e8 0a d4 ff ff       	call   80105310 <memmove>
        acquire(&lock);
80107f06:	c7 04 24 e0 4d 12 80 	movl   $0x80124de0,(%esp)
80107f0d:	e8 3e d2 ff ff       	call   80105150 <acquire>
        pg_refcount[V2P(mem) >> PGSHIFT] = pg_refcount[V2P(mem) >> PGSHIFT] + 1;
80107f12:	89 f8                	mov    %edi,%eax
        pg_refcount[pa >> PGSHIFT] = pg_refcount[pa >> PGSHIFT] - 1;
80107f14:	80 ab e0 6d 11 80 01 	subb   $0x1,-0x7fee9220(%ebx)
        release(&lock);
        *pte = V2P(mem) | PTE_P | PTE_W | PTE_U;  // point the given page table entry to the new page
80107f1b:	83 cf 07             	or     $0x7,%edi
        pg_refcount[V2P(mem) >> PGSHIFT] = pg_refcount[V2P(mem) >> PGSHIFT] + 1;
80107f1e:	c1 e8 0c             	shr    $0xc,%eax
        release(&lock);
80107f21:	c7 04 24 e0 4d 12 80 	movl   $0x80124de0,(%esp)
        pg_refcount[V2P(mem) >> PGSHIFT] = pg_refcount[V2P(mem) >> PGSHIFT] + 1;
80107f28:	80 80 e0 6d 11 80 01 	addb   $0x1,-0x7fee9220(%eax)
        release(&lock);
80107f2f:	e8 dc d2 ff ff       	call   80105210 <release>
        *pte = V2P(mem) | PTE_P | PTE_W | PTE_U;  // point the given page table entry to the new page
80107f34:	89 3e                	mov    %edi,(%esi)
80107f36:	83 c4 10             	add    $0x10,%esp
        release(&lock);
        panic("Pagefault due to wrong ref count");
      }
    }
    // Flush TLB for process since page table entries changed
    lcr3(V2P(proc->pgdir));
80107f39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107f3f:	8b 40 04             	mov    0x4(%eax),%eax
80107f42:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107f47:	0f 22 d8             	mov    %eax,%cr3
  }
}
80107f4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f4d:	5b                   	pop    %ebx
80107f4e:	5e                   	pop    %esi
80107f4f:	5f                   	pop    %edi
80107f50:	5d                   	pop    %ebp
80107f51:	c3                   	ret    
80107f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                                            cpu->apicid, va, proc->name, proc->pid);
80107f58:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("Illegal memory access on cpu %d addr 0x%x, kill proc %s with pid %d\n",
80107f5e:	83 ec 0c             	sub    $0xc,%esp
                                            cpu->apicid, va, proc->name, proc->pid);
80107f61:	83 c0 6c             	add    $0x6c,%eax
    cprintf("Illegal memory access on cpu %d addr 0x%x, kill proc %s with pid %d\n",
80107f64:	ff 70 a4             	pushl  -0x5c(%eax)
80107f67:	50                   	push   %eax
                                            cpu->apicid, va, proc->name, proc->pid);
80107f68:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
    cprintf("Illegal memory access on cpu %d addr 0x%x, kill proc %s with pid %d\n",
80107f6e:	53                   	push   %ebx
80107f6f:	0f b6 00             	movzbl (%eax),%eax
80107f72:	50                   	push   %eax
80107f73:	68 fc 8b 10 80       	push   $0x80108bfc
80107f78:	e8 e3 86 ff ff       	call   80100660 <cprintf>
    proc->killed = 1;
80107f7d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    return;
80107f83:	83 c4 20             	add    $0x20,%esp
    proc->killed = 1;
80107f86:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
}
80107f8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f90:	5b                   	pop    %ebx
80107f91:	5e                   	pop    %esi
80107f92:	5f                   	pop    %edi
80107f93:	5d                   	pop    %ebp
80107f94:	c3                   	ret    
80107f95:	8d 76 00             	lea    0x0(%esi),%esi
          cprintf("Illegal memory access");
80107f98:	83 ec 0c             	sub    $0xc,%esp
80107f9b:	68 c0 8b 10 80       	push   $0x80108bc0
80107fa0:	e8 bb 86 ff ff       	call   80100660 <cprintf>
          proc->killed = 1;
80107fa5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
          return;
80107fab:	83 c4 10             	add    $0x10,%esp
          proc->killed = 1;
80107fae:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
          return;
80107fb5:	eb d6                	jmp    80107f8d <pagefault+0x13d>
80107fb7:	89 f6                	mov    %esi,%esi
80107fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&lock);
80107fc0:	83 ec 0c             	sub    $0xc,%esp
80107fc3:	68 e0 4d 12 80       	push   $0x80124de0
80107fc8:	e8 43 d2 ff ff       	call   80105210 <release>
      *pte |= PTE_W;  // remove the read-only restriction on the trapping page
80107fcd:	83 0e 02             	orl    $0x2,(%esi)
80107fd0:	83 c4 10             	add    $0x10,%esp
80107fd3:	e9 61 ff ff ff       	jmp    80107f39 <pagefault+0xe9>
        release(&lock);
80107fd8:	83 ec 0c             	sub    $0xc,%esp
80107fdb:	68 e0 4d 12 80       	push   $0x80124de0
80107fe0:	e8 2b d2 ff ff       	call   80105210 <release>
        panic("Pagefault due to wrong ref count");
80107fe5:	c7 04 24 70 8c 10 80 	movl   $0x80108c70,(%esp)
80107fec:	e8 9f 83 ff ff       	call   80100390 <panic>
    panic("Unknown page fault due to a writable pte");
80107ff1:	83 ec 0c             	sub    $0xc,%esp
80107ff4:	68 44 8c 10 80       	push   $0x80108c44
80107ff9:	e8 92 83 ff ff       	call   80100390 <panic>
