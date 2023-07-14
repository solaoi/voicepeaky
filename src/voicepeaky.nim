import httpbeast,os,strutils,parseopt,json,asyncdispatch,options,threadpool,times,algorithm,osproc
import speech

let workspace = "/tmp/voicepeaky"
var speeches: seq[Speech]
var is_skip: bool

proc getArgs():tuple[port:int, skip:bool] =
  result = (port:8080, skip:false)
  var opt = parseopt.initOptParser( os.commandLineParams().join(" ") )
  for kind, key, val in opt.getopt():
    case key
    of "port", "p":
      case kind
      of parseopt.cmdLongOption, parseopt.cmdShortOption:
        opt.next()
        result.port = opt.key.parseInt()
      else: discard
    of "skip", "s":
      result.skip = true

proc onRequest(req: Request): Future[void]{.async.} = 
  var isSend:bool
  {.cast(gcsafe).}:
    if req.httpMethod == some(HttpPost):
      try:
        let requestBody = req.body.get.parseJson

        let text = requestBody["text"].getStr
        var textArr: seq[Speech]
        for line in splitLines(text):
          for temp in line.split("。"):
            for value in temp.split("、"):
              if not value.isEmptyOrWhitespace():
                let speech = createSpeech(requestBody, value)
                textArr.add(speech)
        if is_skip:
          speeches = @[]
        speeches = @textArr.reversed & @speeches

        req.send(Http201)
      except Exception:
        let
          headers = "Content-type: application/json; charset=utf-8"
          response = %*{"message": "Error occurred."}
        req.send(Http400, $response, headers)
      finally:
        isSend=true
        break
  if not isSend:
    req.send(Http404)

proc pollingFiles() {.thread.} =
  {.cast(gcsafe).}:
    while true:
      var files: seq[string]
      for f in walkDir(workspace):
        files.add(f.path)
      files.sort();
      for file in files:
        let _ = execCmd("afplay " & file)
        removeFile(file)

proc pollingSpeeches() {.thread.} =
  {.cast(gcsafe).}:
    while true:
      if speeches.len != 0:
        let speech = speeches.pop()
        let _ = execCmd("/Applications/voicepeak.app/Contents/MacOS/voicepeak --say " & speech.text &
                " --narrator \"" & speech.narrator &
                "\" --emotion happy=" & $speech.happy &
                ",fun=" & $speech.fun &
                ",angry=" & $speech.fun &
                ",sad=" & $speech.fun &
                " --speed " & $speech.speed &
                " --pitch " & $speech.pitch &
                " --out " & workspace & "/" & $now() & ".wav")

when isMainModule:
  if not dirExists(workspace):
    createDir(workspace)

  spawn pollingSpeeches()
  spawn pollingFiles()

  let (port, skip) = getArgs()
  is_skip = skip
  let settings = initSettings(Port(port))
  run(onRequest, settings)
