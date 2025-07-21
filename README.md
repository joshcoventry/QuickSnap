# QuickSnap
A GUI wrapper of the screencapture command for macOS

## Intro
QuickSnap was originally released as a shareware REALBasic application written by me in 2007.

I started a Swift rewrite in 2018.

I started this project to learn Swift, and my eventual plan is to finish this rewrite so that the app is fully feature complete.

## Features

QuickSnap provides a friendly Mac interface for the screencapture cli program built into macOS.

A little window pops up allowing the user to:

- Choose a capture mode (Screen, Selection, Window, Screen Recording, Selection Recording)

A preferences window allows users to set:
- Filename
- Location of saved screenshots
- File format of saved screenshots
- Play capture sound 
- Timer (in seconds)
- Copy capture to clipboard
- Capture cursor in screenshot
- Resize screenshot
- Carry out an action after capture (system beep, open screenshot, etc)

## Planned features

- Watermarking
- Screenshot history (browse/open past screenshots)