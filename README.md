# Voicepeaky

[![license](https://img.shields.io/github/license/solaoi/voicepeaky)](https://github.com/solaoi/voicepeaky/blob/main/LICENSE)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/solaoi/voicepeaky)](https://github.com/solaoi/voicepeaky/releases)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/solaoi?color=db61a2)](https://github.com/sponsors/solaoi)

This is a server to use voicepeak as api.

## Requirements

- [VOICEPEAK 商用可能 6ナレーターセット](https://www.ah-soft.com/voice/6nare/index.html)
- [VOICEPEAK 商用可能 ナレーター](https://www.ah-soft.com/voice/narrator/index.html)

## Usage

### Serve

```sh
voicepeaky -p 9999 -s
```

Option is below.

| Option    | Description                              | Default | Required |
| --------- | ---------------------------------------- | ------- | -------- |
| -p,--port | specify the port you want to serve       | 8080    | false    |
| -s,--skip | skip old text when new text is requested | -       | false    |

### Request

```sh
curl -X POST -H "Content-Type: application/json" -d '@sample.json' localhost:9999
```

RequestBody (JSON Format) is below.
see a sample [here](https://raw.githubusercontent.com/solaoi/voicepeaky/main/sample.json).

| Field         | Type                    | Default             | Required |
| ------------- | ----------------------- | ------------------- | -------- |
| narrator      | string*1                | "Japanese Female 1" | false    |
| emotion       | JSONObject              | -                   | false    |
| emotion/happy | number(0 - 100)         | 0                   | false    |
| emotion/fun   | number(0 - 100)         | 0                   | false    |
| emotion/angry | number(0 - 100)         | 0                   | false    |
| emotion/sad   | number(0 - 100)         | 0                   | false    |
| speed         | number(50 - 200)        | 100                 | false    |
| pitch         | number(-300 - 300)      | 0                   | false    |
| text          | string                  | -                   | true     |

*1
| Types of Narrators    | Requirements                                                                       |
| --------------------- | ---------------------------------------------------------------------------------- |
| Japanese Male Child   | [VOICEPEAK 商用可能 ナレーター](https://www.ah-soft.com/voice/narrator/index.html)    |
| Japanese Female Child | [VOICEPEAK 商用可能 6ナレーターセット](https://www.ah-soft.com/voice/6nare/index.html) |
| Japanese Male 1       | [VOICEPEAK 商用可能 6ナレーターセット](https://www.ah-soft.com/voice/6nare/index.html) |
| Japanese Male 2       | [VOICEPEAK 商用可能 6ナレーターセット](https://www.ah-soft.com/voice/6nare/index.html) |
| Japanese Male 3       | [VOICEPEAK 商用可能 6ナレーターセット](https://www.ah-soft.com/voice/6nare/index.html) |
| Japanese Male 4       | [VOICEPEAK 商用可能 ナレーター](https://www.ah-soft.com/voice/narrator/index.html)    |
| Japanese Female 1     | [VOICEPEAK 商用可能 6ナレーターセット](https://www.ah-soft.com/voice/6nare/index.html) |
| Japanese Female 2     | [VOICEPEAK 商用可能 6ナレーターセット](https://www.ah-soft.com/voice/6nare/index.html) |
| Japanese Female 3     | [VOICEPEAK 商用可能 6ナレーターセット](https://www.ah-soft.com/voice/6nare/index.html) |
| Japanese Female 4     | [VOICEPEAK 商用可能 ナレーター](https://www.ah-soft.com/voice/narrator/index.html)    |

## Install

### 1. Mac

```
# Install
brew install solaoi/tap/voicepeaky
# Update
brew upgrade voicepeaky
```

### 2. BinaryRelease

```sh
# Install with wget or curl
## set the latest version on releases.
VERSION=v1.0.4
## set the OS you use. (macos)
OS=linux
## case you use wget
wget https://github.com/solaoi/voicepeaky/releases/download/$VERSION/voicepeaky${OS}.tar.gz
## case you use curl
curl -LO https://github.com/voicepeaky/broly/releases/download/$VERSION/voicepeaky${OS}.tar.gz
## extract
tar xvf ./voicepeaky${OS}.tar.gz
## move it to a location in your $PATH, such as /usr/local/bin.
mv ./voicepeaky /usr/local/bin/
```

### 3. Nimble

```sh
# Install & Update
nimble install voicepeaky
```

## Note

Voicepeak occasionally crashes; Voicepeaky will automatically retry, but if an error popup appears, please close it.
