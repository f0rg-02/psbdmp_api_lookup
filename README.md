# psbdmp_api_lookup
A simple script to lookup pastes based on various keywords using https://psbdmp.ws

### Requirenments:

- bash
- uuidgen
- curl

------

### Usage:

```
usage() {  # Function: Print a help message.
  echo "Usage: $0 
  [ -d DOMAIN TO SEARCH FOR IN PSBDMP.WS ] 
  [ -e EMAIL TO SEARCH FOR IN PSBDMP.WS ] 
  [ -g GENERAL KEYWORD TO SEARCH FOR IN PSBDMP.WS ] 
  [ -o OUTPUT FOLDER TO SAVE RESULTS TO] 
  [ -h SHOW THIS HELP ]" 1>&2
  echo "---------------"
  echo "Examples: "
  echo "Search for domains - ./script.sh -d domain.com"
  echo "Search for emails  - ./script.sh -e foo@bar.com"
  echo "General search     - ./script.sh -g foobar"

}
```

------

### To download:

```
git clone https://github.com/f0rg-02/psbdmp_api_lookup/
```

------

### To run:

```
cd psbdmp_api_lookup/ or whatever path it is saved to
chmod +x
./lookup_psbdmp.sh
```

------

More scripts:

https://github.com/f0rg-02/bash

My notes directly from Obsidian:

https://github.com/f0rg-02/Notes

------

If you like my work or whatever, you can buy me a coffee:


<a href="https://www.buymeacoffee.com/alex_f0rg"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=alex_f0rg&button_colour=FF5F5F&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00" /></a>

My goal is to get to $50 so that way I can work toward buying better hardware and whatnot so I can continue doing my research and work.
