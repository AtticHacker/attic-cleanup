Attic-Cleanup
=============

About
=====
Attic-cleanup is a gem to manage files on your computer.

If you ever feel like you need to store your files you can throw them in your attic.

Let's say your attic is filled with files and folders and you just want to get them out of the way.

If you use the attic-cleanup gem all the files in the specified location will be moved into ~/MyAttic/Date-today.

An example of Date-today is ~/MyAttic/2011-11-23.

You can set specific location that you want to manage and create shortcuts for them.

A log will be kept of which files are moved to where, so if you ever forgot where you stored a specific file

you can find it in the log.txt file in the MyAttic folder.


Notes
=====
This gem has NOT been tested on Windows, and there's a big chance it won't work correctly.

This gem is still in beta, and moves, creates and deletes files / folders.

I use this gem every day and have never lost any folders or files.

However, if something does go wrong and you lose any files or folders I will not be held responsible.

Use at own risk

Installation
============
gem install attic-cleanup


Usage
=====
Attic-cleanup is easy to use.
Here are a few examples to help you understand how to use it.

Example: We want to store all the files from our Desktop into MyAttic.
======================================================================
attic-cleanup store -a -f

This line will store all the files from your Desktop to the MyAttic folder.

-a is an option to selected all the files.

-f is an option to force move everything, you wont have to type "y" to confirm.

You don't have to specify a path because Desktop is automatically the default location.

If you want to change your default location, you can simply do that in the default_path.txt file.


Another Example: I want to move certain items from my Projects folder, I made a shortcut called projects
========================================================================================================
attic-cleanup store @projects


This line will take you to the projects folder, the @ sign stands for shortcut.

In the custom_paths.txt file you can set your own shortcuts. You can also create them with the 'new' command.

It's easy to do and there are already a few pre-generated shortcuts for you.

Since we didn't use the -a option, we can choose which files we want to store.

Now type 'ls' to view all the files and their IDs.

Then type the IDs of the files you wish to store. example: 1,3,6,12,25

Press enter, since we didn't use the -f option we will be asked if we want to move the files.

Type y to continue or type n to exit.

Once you press y all the file will be moved to the MyAttic folder and every file will be printed in the log.txt file.


Checking which shortcuts are available
======================================
attic-cleanup shortcuts


This will display every shortcut in the custom_paths.txt file.


Creating a new shortcut with the 'new' command
==============================================
attic-cleanup new --name projects --path ~/MyProjects/CurrentProject


This will generate a new shortcut. The shortcut name will be @projects and the path will be ~/MyProjects/CurrentProject

You can always adjust shortcuts and default location in MyAttic folder.

Setting default with the 'default' command
==========================================
attic-cleanup default ~/MyProject


This will adjust the default location for the store command to ~/MyProject instead of Desktop


Adding files to ignore
========================
attic-cleanup ignore ~/Desktop/MyProject

This will add the path to MyProject to the ignore_files.txt file.
Every path in this file will be ignored if you try to store it (or all).
So let's say you want to store all the files that are on your desktop except the MyProject folder.
You just add it to the ignore_files.txt file or use the ignore command.
Once you try to store all the files on your Desktop, it will skip MyProjects folder.
