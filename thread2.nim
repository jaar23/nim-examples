import std/locks

var lock: Lock
type 
  Obj = ref object 
    data: string

  Param = object
    obj: Obj
    param: string

type ParamRef = ref Param

proc update*(param: ref Param) {.thread.} =
  echo "\ninside thread func"
  withLock lock:
    echo "a: ", param.obj.data
    echo "b: ", param.param
    param.obj.data &= param.param & " "

proc main() = 
  var o {.guard: lock} = Obj(data: "---")
  var th1, th2: Thread[ParamRef]
  
  var param = (ref Param)(obj: o, param: "hello")
  createThread(th1, update, param)
  
  var param2 = (ref Param)(obj: o, param: "world")
  createThread(th2, update, param2)
  
  joinThreads(th1, th2)
  
  withLock lock:
    echo "\nprint result"
    echo o.data


main()
