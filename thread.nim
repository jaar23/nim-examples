import std/locks

var lock: Lock
var counter {.guard: lock}: int

proc incCounter (i: int) {.thread.} = 
   for j in 0 .. i:
     withLock lock:
       var local = counter
       local += 1
       counter = local

const N = 1000

proc main() = 
  var th1, th2, th3: Thread[int]
  createThread(th1, incCounter, N)
  createThread(th2, incCounter, N)
  createThread(th3, incCounter, N)
  joinThreads(th1, th2, th3)

main()
echo N, ":", counter
