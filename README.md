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
