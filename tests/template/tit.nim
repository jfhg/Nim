
# bug #1337

template someIt(a, pred: expr): expr =
  var it {.inject.} = 0
  pred

proc aProc(n: auto) =
  n.someIt(echo(it))

aProc(89)
