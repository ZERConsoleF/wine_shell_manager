# Wine Shell Manager
 ## Introduce
 This project can manage wine containers and a few wine settings.

 ## How to install
 ### First
 You must have `wine` and can get `bash`, `dpkg`, `git` in your environment.
  - Suggest OS environment:Debian 11.0 and over

 ## Second
  - Pull repos ```git clone https://github.com/ZERConsoleF/wine_shell_manager.git``` in your computer.
  - Goto you directory ```cd wine_shell_manager```, Run command ```chmod +x INSTALL.sh;./INSTALL.sh```.
    - Suggest:We suggest you install in default, and dont install deb package.
  - Run command ```wine-manager_runner.sh``` to check installion.

 ## How to uninstall
  - It just run ```./UNINSTALL.sh``` in install directory or run ```dpkg --purge wine-manager``` if you have installed deb package.

 ## Finally
  - Have Fun!

 ## Fix BUGGY
  - Pulseaudio maybe crash in unexcepted! 
 
 ## Add function
  - Create Desktop in your environment

## UPDATE Progress
 - ===Hidden 2 Information===
 - [2023/04/07 --:--:--] Push inital project
 - [2023/04/07 --:--:--] Push uninstall function
 - [2023/04/08 00:00:--] Chnage README
 - [2023/04/08 00:03:--] Chnage README
 - [2023/04/12 23:26:04] Fix up something and change install ways.
   - PATH:./adm.sprit.d/inital.sh;./wineman.sprit.d/inital.sh
 - [2023/04/19 20:24:35] Fix up something and change install ways (and uninstall).
   - Fix bug:
     - pulseaudio start failure.
     - improve install and uninstall ways.
 - [2023/04/19 20:55:35] Fix up something and change install ways (and uninstall).
   - Fix bug:
     - pulseaudio start failure.
     - improve install and uninstall ways.
     - fix user login problem.
 - [2023/04/21 21:54:35] To deal with user login problems.
 - [2023/07/01 01:37:24] Fix up something,change install ways and create new function.
   - Fix bug:
     - pulseaudio maybe crash in unexcepted!
   - Add function:
     - create desktop in your environment.
