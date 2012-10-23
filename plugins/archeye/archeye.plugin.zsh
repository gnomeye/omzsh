# Archlinux zsh aliases and functions
# for gnomeye
# Usage is also described at https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins

# Look for yaourt, and add some useful functions if we have it.
if [[ -x `which pacman-color` ]]; then
  alias pac='pacman-color'
else
  alias pac='pacman'
fi
alias spac='sudo pac'
alias lpac='pac'
# Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
alias pacupg='spac -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='spac -S'           # Install specific package(s) from the repositories
alias pacins='spac -U'          # Install specific package not from the repositories but from a file 
alias pacre='spac -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='spac -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='lpac -Si'              # Display information about a given package in the repositories
alias pacreps='lpac -Ss'             # Search for package(s) in the repositories
alias pacloc='lpac -Qi'              # Display information about a given package in the local database
alias paclocs='lpac -Qs'             # Search for package(s) in the local database
alias pacups='lpac -Qu'		     # show updates
alias paclocl='lpac -Qm'	     # show locally installed packages
alias pacremtod='echo -e "Packages removed today:\n" && grep $(date +%F) /var/log/pacman.log | grep removed | cl 4-'
alias pacinsttod='echo -e "Packages installed today:\n" && grep $(date +%F) /var/log/pacman.log | grep installed | cl 4-'
#if packer then update with packer
if [[ -x `which packer` ]]; then
  alias pacupd='sudo packer -Su'
else
  alias pacupd='spac -Su'
fi
alias pacinsd='spac -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='spac -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

# https://bbs.archlinux.org/viewtopic.php?id=93683
paclist() {
  spac -Qei $(lpac -Qu|cut -d" " -f 1)|awk ' BEGIN {FS=":"}/^Name/{printf("\033[1;36m%s\033[1;37m", $2)}/^Description/{print $2}'
}

alias paclsorphans='spac -Qdt'
alias pacrmorphans='spac -Rs $(pacman -Qtdq)'

pacdisowned() {
  tmp=${TMPDIR-/tmp}/pacman-disowned-$UID-$$
  db=$tmp/db
  fs=$tmp/fs

  mkdir "$tmp"
  trap  'rm -rf "$tmp"' EXIT

  lpac -Qlq | sort -u > "$db"

  find /bin /etc /lib /sbin /usr \
      ! -name lost+found \
        \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"
}
