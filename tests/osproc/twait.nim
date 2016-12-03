discard """
  file: "twait.nim"
  output: ""
"""
import osproc, os, times

const filename = when defined(Windows): "tafalse.exe" else: "tafalse"
let dir = getCurrentDir() / "tests" / "osproc"
doAssert fileExists(dir / filename)

var p = startProcess(filename, dir)
doAssert(waitForExit(p) == QuitFailure)

p = startProcess(filename, dir)
os.sleep(1000) # make sure process has exited already

let atStart = getTime()
const msWait = 2000

try: 
  discard waitForExit(p, msWait) 
except OSError:
  echo "OSException"

# check that we don't have to wait msWait milliseconds
doAssert(getTime() <  atStart + milliseconds(msWait))
