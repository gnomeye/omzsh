# Archlinux zsh aliases and functions
# for gnomeye
# Usage is also described at https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins
alias lpac='pacman-color'
alias spac='sudo pacman-color'
alias pacupg='sudo pacman-color -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='sudo pacman-color -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman-color -U'          # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman-color -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman-color -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman-color -Si'              # Display information about a given package in the repositories
alias pacreps='pacman-color -Ss'             # Search for package(s) in the repositories
alias pacse='pacreps'
alias pacloc='pacman-color -Qi'              # Display information about a given package in the local database
alias paclocs='pacman-color -Qs'             # Search for package(s) in the local database
alias pacups='pacman-color -Qu'		     # show updates
alias paclocl='pacman-color -Qm'	     # show locally installed packages
alias paclocpretty="pacman -Qi | sed '/^Depends On/,/^Required By/{ s/^Required By.*$//; H; d }; /^Name/!d; /^Name/{ n;x;}'| sed '/^$/s//==================================================================================/'"
alias pacremtod='echo -e "Packages removed today:\n" && grep $(date +%F) /var/log/pacman.log | grep removed | cl 4-'
alias pacinsttod='echo -e "Packages installed today:\n" && grep $(date +%F) /var/log/pacman.log | grep installed | cl 4-'
alias pacupdtod='echo -e "Packages updated today:\n" && grep $(date +%F) /var/log/pacman.log | grep upgraded | cl 4-'
#if packer then update with packer
if [[ -x `which packer` ]]; then
  alias pacupd='sudo packer -Su'
else
  alias pacupd='sudo pacman-color -Su'
fi
alias pacinsd='sudo pacman-color -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman-color -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

# https://bbs.archlinux.org/viewtopic.php?id=93683
paclist() {
  sudo pacman-color -Qei $(pacman-color -Qu|cut -d" " -f 1)|awk ' BEGIN {FS=":"}/^Name/{printf("\033[1;36m%s\033[1;37m", $2)}/^Description/{print $2}'
}

alias paclsorphans='sudo pacman-color -Qdt'
alias pacrmorphans='sudo pacman-color -Rs $(pacman -Qtdq)'

pacdisowned() {
  tmp=${TMPDIR-/tmp}/pacman-disowned-$UID-$$
  db=$tmp/db
  fs=$tmp/fs

  mkdir "$tmp"
  trap  'rm -rf "$tmp"' EXIT

  pacman-color -Qlq | sort -u > "$db"

  find /bin /etc /lib /sbin /usr \
      ! -name lost+found \
        \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"
}
