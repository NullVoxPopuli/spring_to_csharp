# Spring to C#
Converts XML config files from SpringFramework.NET to C# files.


Seriously, who thought instantiating complex objects in 10k line long XML files was a good idea?

This is a command-line tool.
It could be included in projects... but that would be weird.

Down with XML!

Notes:
 - Unfortunately, this does not figure not add the namespaces of everything (yet). It totally, could, cause spring is as verbose as Charles Dickens. Just load up the resulting file in visual studio to fix all that.


## Usage

    $ irb
    2.2.1 :001 > require 'spring_to_csharp'
     => true
    2.2.1 :002 > SpringToCSharp.run


## Limitations

### Unknown List Type

When spring doesn't specify the type of a list

```xml
<list>
  <value>0</value>
  <value>1</value>
  <value>2</value>
</list>
```
Is that a list of doubles, integers, or an unsigned variant?

Currently, the type parameter on the generated `List` constructor is blank. e.g.: `new List<>(){...}`

### Unspecified Enums

When the value of an enum, is just the enum key, and doesn't specify what enum it is from.

```xml
<constructor-arg name="direction" value="Low"/>
```

There is no way to know what enum the value `Low` comes from.
