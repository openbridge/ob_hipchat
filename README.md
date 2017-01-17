![Hippy](https://github.com/openbridge/ob_hipchat/blob/master/images/hipchat.png)

Hippy: A Bash Hipchat Client
===========

**Hippy** is Bash script to send messages to [HipChat][hc]. **Hippy** is perfect for those looking to create clean, minimal Docker containers.

## Why Hippy?
**Hippy** does not require any special packages or libraries (other than Bash). This makes it a perfect companion for minimal Docker containers.

The **Hippy** `hipchat` script is approximately `8KB`. A python Hipchat client may use approximately `10MB+` once all the supporting python packages, dependencies and libraries were installed. On alpine linux, bash is about `618KB`, so the overall footptint at `< 650KB` is pretty small.

*One caveat*: If you already are using Python and have the packages, dependencies and libraries required for a Python based HipChat client, that might be the way to go! The same is true for Java, Go, PHP or whatever your preference is.

## How Does It Work?

Once you have it installed and configured sending a message is as simple as:

```bash
hipchat -i "hello hipchat world"
```

[hc]: http://www.hipchat.com

### Commands

Command-line options are passed into Hippy. A list of options is available by executing ```hipchat -h```.
```bash
-h Show this message
-C Path to config file
-t API token
-r Room ID
-f From name
-c Message color (yellow, red, green, purple or random - default: yellow)
-m Message format (html or text - default: html)
-i Message to send to room, allows you to specify input via command line instead of stdin
-l Message status (critical, warning, unknown, ok, down, up)
-n Trigger notification for people in the room (default: True)
-o API host (api.hipchat.com)
-v API version (default: v2)
```

Here is an example:
```bash
hipchat -t 123123213131231lj3l1 -r devops -f server-o1 -i "System is at 90% capcity" -l critical -n True
```

## Configuration

Place `hipchat` into `/usr/bin` or whatever location best suits you.

The default install for me is typically `/usr/bin` but you can do whatever works for you. If you place the script into a location like `/usr/local/bin/hipchat` you need to adjust any examples provided in the README accordingly.

### Environment
`hipchat` can be configured in command line mode, with environment variables, a config file or combination of all three.

* Command-line options
* Environment variables
* Configuration file


#### Command-line
You can pass the values into the script:
```bash
cat message.txt | HIPCHAT_TOKEN=<token> HIPCHAT_ROOM_ID=<room id> hipchat -f "System"
```
Here is another example passing variables to Hippy:
```bash
hipchat -t 292932932921989108301938 -r pizza -f deliverybot -i "Your pizza is almost ready"
```

#### Environment variables

All options available as command-line options can be passed in as environment variables.

Environment variable | Description
-------------------- | -----------
HIPCHAT_TOKEN        | API token
HIPCHAT_ROOM_ID      | Room ID
HIPCHAT_FROM         | Who sent the message
HIPCHAT_COLOR        | Message color (yellow, red, green, purple or random - default: gray)
HIPCHAT_FORMAT       | Message format (html or text - default: html)
HIPCHAT_NOTIFY       | Trigger notification for people in the room (default: True)
HIPCHAT_HOST         | API host (api.hipchat.com)
HIPCHAT_LEVEL        | Message state (i.e., critical, warning, unknown, ok)
HIPCHAT_API          | API version (only v2 is supported)

You will likely NOT want to edit `HIPCHAT_HOST`, `HIPCHAT_API` or `HIPCHAT_FORMAT` from defaults unless you have specific use cases to do so.

#### Setting Environment Variables

You can set the environment variables in a Docker run command:
```bash
docker run -it -v /mnt:/mnt alpine
-e HIPCHAT_ROOM_ID=<roomid>
-e HIPCHAT_TOKEN=<token>
bash
```
You can simply export the variables on the command line:
```bash
export HIPCHAT_ROOM_ID=<roomid>
export HIPCHAT_TOKEN=<token>
```

Once you have the variables set, you can send a message:
```bash
hipchat -i "Ok: We love pizza!"
```

You can also use other variables when sending a message: For example, below `${TAG}` is a variable that defines the current user. This will sent the FROM message to originate from `${TAG}`. The mesage also has set notifications `-n` to `True` and `-l` to `OK`.
 ```bash
hipchat -f ${TAG} -n True -i "Hello World, Im Ok" -l OK
```

### Using A Configuration file

All environment variables can be specified in a configuration file. There may be cases where a configuration file is preferred.  If this is your preferred path, you can create a configuration file and place it in a location like this: ```/etc/hipchat.conf```

#### Format

Lets assume your configuration is located here ```/etc/hipchat.conf```. The contents of that file should look like this:

```bash
TOKEN=${HIPCHAT_TOKEN:-<inserttoken>}
ROOM_ID=${HIPCHAT_ROOM_ID:-<insertroom>}
FROM=${HIPCHAT_FROM:-<insertfrom>}
COLOR=${HIPCHAT_COLOR:-<insertcolor>}
FORMAT=${HIPCHAT_FORMAT:-html}
MESSAGE=${HIPCHAT_MESSAGE:-html}
NOTIFY=${HIPCHAT_NOTIFY:-<insertnotify>}
HOST=${HIPCHAT_HOST:-api.hipchat.com}
LEVEL=${HIPCHAT_LEVEL:-<insertlevel>}
API=${HIPCHAT_API:-v2}
```
With your config setup, it would end up looking like this:
```bash
TOKEN=${HIPCHAT_TOKEN:-213910239AS0123i123213jl123jl}
ROOM_ID=${HIPCHAT_ROOM_ID:-general}
FROM=${HIPCHAT_FROM:-pizzalover}
COLOR=${HIPCHAT_COLOR:-green}
FORMAT=${HIPCHAT_FORMAT:-html}
MESSAGE=${HIPCHAT_MESSAGE:-html}
NOTIFY=${HIPCHAT_NOTIFY:-0}
HOST=${HIPCHAT_HOST:-api.hipchat.com}
LEVEL=${HIPCHAT_LEVEL:-OK}
API=${HIPCHAT_API:-v2}
```

### Importing Your Config File
To use your configuration file, you need to set the `-C` and provide the path to the file:
```bash
$ hipchat -C "/etc/hipchat.conf" -i "Ok: We love pizza!"
```

if your configuration file was located someplace other than `/etc/hipchat.conf`, then you simply pass the location to the script:
```bash
$ hipchat -C "/opt/usr/hipchat.conf" -i "Ok: We love pizza!"
```

## Reference
**Hippy** is based off of the Hipchat CLI client
https://github.com/hipchat/hipchat-cli

## License

The MIT License (MIT) Copyright (c)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
