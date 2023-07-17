import json,strformat

type Speech* = ref object
  narrator*: string
  happy*: int
  fun*: int
  angry*: int
  sad*: int
  speed*: int
  pitch*: int
  text*: string

type
  SpeechInitError* = object of IOError

proc createSpeech*(json:JsonNode, text:string) :Speech=
  result = new Speech
  try:
    result.narrator = json{"narrator"}.getStr("Japanese Female 1")
    result.happy = json{"emotion"}{"happy"}.getInt(0)
    result.fun = json{"emotion"}{"fun"}.getInt(0)
    result.angry = json{"emotion"}{"angry"}.getInt(0)
    result.sad = json{"emotion"}{"sad"}.getInt(0)
    result.speed = json{"speed"}.getInt(100)
    result.pitch = json{"pitch"}.getInt(0)
    result.text = text
  except:
    raise newException(SpeechInitError, fmt"request body is invalid")
