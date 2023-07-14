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
    result.narrator = json["narrator"].getStr
    result.happy = json["emotion"]["happy"].getInt
    result.fun = json["emotion"]["fun"].getInt
    result.angry = json["emotion"]["angry"].getInt
    result.sad = json["emotion"]["sad"].getInt
    result.speed = json["speed"].getInt
    result.pitch = json["pitch"].getInt
    result.text = text
  except:
    raise newException(SpeechInitError, fmt"request body is invalid")
