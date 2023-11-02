### Show all packages that don't have any other packages depending on it
```bash
#https://askubuntu.com/a/1481433
# Write to file
echo "The following packages are not a dependency to any installed package:" > "$dpkg_file"
# Write to screen
echo "Scanning packages ..."

# Function to write non-dependencies to file
dpkg-query -Wf '${Package} ${Status}${Priority}\n' |
  grep -v 'required\|important\|standard' |
  grep 'installed' |
  awk '{ print $1 }' |
xargs apt-cache rdepends --installed |
  awk '! /Reverse Depends:/ {
    tp = $0
    n++
  }
  /Reverse Depends:/ {
    if (n == 1 && NR != 2) {
        print "  " p
    }
    n = 0
    p = tp
  }
  END {
    if (n == 0) {
        print "  " p
    }
  }' >> "$dpkg_file"

# Final overview
echo -e "\nSTATUS\n======"
echo "  Total packages scanned : $(dpkg-query -Wf '${Package}${Status}${Priority}\n' | grep -v 'required\|important\|standard' | grep 'installed' | wc -l)"
echo "  Candidates for removal : $(tail -n +2 $dpkg_file | wc -l)"
echo "  Script execution time  : $SECONDS seconds"
```
---
