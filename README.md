Taco (Work in Progress)
==========

Taco is a simple command-line tool for managing items. It's minimal,
straightforward, and you can use it with your favorite text editor.

Getting Started
----------
You can install Taco as a gem:

    $ gem install taco

You may also create an alias to save keystrokes

    alias t='taco'

Taco can work with multiple list files too.  You can maintain one list
(default: '~/.tacos') or project-specific taco files.


Making a Taco
----------

### Add items

We don't have to use quotes!

    $ taco add Check out rubyrags.com
    Added: Check out rubyrags.com: @

    TACOS:
    ----------------------------------------------------
    [1] Check out rubyrags.com
    ----------------------------------------------------                      

Create a new item with context

    $ taco add Buy Duck Typing shirt from rubyrags.com @work
    Added: Buy Duck Typing shirt from rubyrags.com: @work

    TACOS:
    ----------------------------------------------------
    [1] Check out rubyrags.com                      
    [2] Buy Duck Typing shirt from rubyrags.com     work
    ----------------------------------------------------

    $ taco add Buy Ruby Nerd shirt from rubyrags.com @work
    Added: Buy Ruby Nerd shirt from rubyrags.com: @work

    TACOS:
    ----------------------------------------------------
    [1] Check out rubyrags.com                      
    [2] Buy Duck Typing shirt from rubyrags.com     work
    [3] Buy Ruby Nerd shirt from rubyrags.com       work
    ----------------------------------------------------

### List items

Prints the items in a nice, tabbed format.

    $ taco list

    TACOS:
    ----------------------------------------------------
    [1] Check out rubyrags.com                      
    [2] Buy Duck Typing shirt from rubyrags.com     work
    [3] Buy Ruby Nerd shirt from rubyrags.com       work
    ----------------------------------------------------

    $ todo list @work

    TACOS:
    ----------------------------------------------------
    [2] Buy Duck Typing shirt from rubyrags.com     work
    [3] Buy Ruby Nerd shirt from rubyrags.com       work
    ----------------------------------------------------

### Deleting items

Use the item number to `delete` it. `del` also works.

    $ taco delete 1
    Deleted: Check out rubyrags.com: @

    TACOS:
    ----------------------------------------------------              
    [1] Buy Duck Typing shirt from rubyrags.com     work
    [2] Buy Ruby Nerd shirt from rubyrags.com       work
    ----------------------------------------------------     

    # To delete all the todos:
    $ taco clear
    All 2 items cleared!

### Completing items

Use the item number to complete the item.  This will simply archive the item

    $ taco done 2
    Done: Buy Duck Typing shirt from rubyrags.com: @done

### Prioritizing items

To bump an item higher on the list:

    $ taco bump 2
    Bump: Buy Duck Typing shirt from rubyrags.com: @work

Help
----------
Help is just a command away.

    $ taco help

Manually Edit
----------
If you want to edit the underlying list directly, make sure your $EDITOR
environment variable is set, and run:

    $ taco edit

Then you can see your list in a beautifully formated yaml file!

Ohai, Command Line!
----------
Since it's the command line we have all the goodies available to use

    $ taco list | grep Nerd
    [2] Buy Ruby Nerd shirt from rubyrags.com       work




