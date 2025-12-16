## <ins> 0.8 </ins>

- New `Rebuild Package` option, for scenarios where an installed package needs to be rebuilt (cleanbuild).
- New `Toggle Aur Helper/Tool` option, for now, this simply toggles between `paru` or `yay` as the aur operator.

## <ins> 0.7 </ins>

- The aur PKGBUILD is fixed to no longer assume paruse needs an update based on latest git commit. Sorry about that.
- New `View Install History` option will list your last 100 installed/uninstalled package activity, sorted by date and time.
- The `View Install History` option has new flags (`paruse -i`|`paruse -history`) to skip Main Menu launch.
- The `Fetch Arch News` option (paru -Pw) could sometimes take 10-15 seconds just to return a server error (if arch servers are down). This is now handled more gracefully, by limiting the command to a 3 second response time. While also pinging & displaying both arch and aur sites server status.
- The `Fetch Arch News` option now *also* fetches recent headlines from https://www.phoronix.com/linux/Arch+Linux, a straight-forward and informative news source.

## <ins> 0.6 </ins>

- while browsing repositories, the `(installed)` label for already installed packages is now more obvious (colored)
- all submenus now have consistent and specific-to-menu action headers above indexed content
- restore packagelist, right info pane is a little more descriptive
- removed unnecessary placeholder message
- sed formatting corrections
- included basic flags to skip main menu on launch
```
    -v  -view     → View package list
    -a  -add      → Add/browse packages
    -r  -rem      → Remove package
    -p  -purge    → Purge package
    -u  -up       → Update system
    -d  -data     → Package stats
    -c  -cache    → Clean cache
    -s  -sync     → Sync package list
    -rs -restore  → Restore from backup
    -b  -backup   → Backup package list
    -n  -news     → Fetch Arch news
    -h  -help     → Help
```

## <ins> 0.5 </ins>

*"Due to recent events/attacks made against the aur, when browsing for packages, paruse will now display PKGBUILD details while browsing, this is handled by a simple curl + query for the packages aur.archlinux.org link."*

- Added a PKGBUILD & source tree review ff390c6
- Added "Updates Available" dialog 5075767

<img width="585" height="117" alt="image" src="https://github.com/user-attachments/assets/1127cf3d-6d90-43fd-87c6-2595801ce83d" />

<img width="100%"  alt="image" src="https://github.com/user-attachments/assets/36d2d172-b21a-4535-af9f-8782d9b77a91" />

<img width="2102" height="1054" alt="image" src="https://github.com/user-attachments/assets/e842342e-e90a-4c3b-adcd-dd2d2ccac639" />

## <ins> 0.4r </ins>

- remove package & purge package now handle batch package inputs more smoothly
- remove package & purge package filter out inputs that do not exist (package is not installed) and preceed with the task for remaining inputs
- 2 new options
- package data briefing (using paru -Ps to include a total package overview)
- package cache cleaning (using paru -Scc to include cache cleaning options, useful when needing to handle clean rebuilds)
- slight text formatting
- + option description adjustment

## <ins> 0.3rc </ins>

- Evolved the structure of Paruse to function more like a Main Menu with submenus (jump to functions, rather than loop through cases)
- Included more prevelant `help` doc in right pane, with basic explanation of what each options does, as well as the command it performs
- As before, paru operations remain untouched, intervention & interaction untouched
- `Install full packagelist` now displayed in fzf, with selected/hovered file contents displayed in right pane, and packagelist options displayed in left pane
- Included simple `arch news fetch` option

![Vid_20250714_094941-ezgif com-crop](https://github.com/user-attachments/assets/6f73d3ac-bef4-4f00-ba0a-e0f234756cad)

## <ins> 0.2.r </ins>

- adjustment for double clicking package additions for 2) Add package
- allow multi package input for 2) Add package
- included command overview via h) Help

## <ins> 0.1.rc </ins>

- Paruse was made public.