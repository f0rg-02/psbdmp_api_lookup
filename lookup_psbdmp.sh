#!/usr/bin/env bash

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

exit_abnormal() { # Function: Exit with error.
  usage
  echo "---------------"
  echo "Exiting!"
  exit 1
}

no_args() {
        echo "[!] Not all required arugments were supplied"
        echo "---------------"
        exit_abnormal
        exit
}

DOMAIN=""
GENERAL_SRCH=""
EMAIL=""
OUTPUT_FOLDER=""

# Check if args were inputted

while getopts "d:g:e:o:h" opt
do
        case ${opt} in
        d)
                DOMAIN="${OPTARG}"

                if [[ -z "$DOMAIN" ]]
                then
                        no_args
                fi
                ;;
        g)
                GENERAL_SRCH="${OPTARG}"

                if [[ -z "$GENERAL_SRCH" ]]
                then
                        no_args
                fi
                ;;
        e)
                EMAIL="${OPTARG}"

                if [[ -z "$EMAIL" ]]
                then
                        no_args
                fi
                ;;
        o)
                OUTPUT_FOLDER="${OPTARG}"
                ;;
        h)
                echo "---------------"
                exit_abnormal
                ;;
        esac
done

FULL_DIR=""

# Output folder true or false
# Set to 0 for false if folder not specified and 1 for true if folder specified
OUTPUT_FILE=0 

if [[ -n "$OUTPUT_FOLDER" ]]
then
        # Create the output folder
        mkdir -p "$OUTPUT_FOLDER"
        OUTPUT_FILE=1 # Set to true

fi


function scrape() {
        echo "Searching pastebin..."
        ids=$(curl -s -X GET "$url" | jq -r ".[] | .id")

        echo "Got all ids"
       
        while IFS= read -r id
        do
                #output=$(curl -s -X GET "https://psbdmp.ws/api/v3/dump/"$id"")
                
                if [[ $OUTPUT_FILE == 1 ]]
                then
                        output_file$("$OUTPUT_FOLDER"/dumps/$(uuidgen).txt)
                        echo "Creating output file: "$output_file""
                        mkdir -p "$OUTPUT_FOLDER"/dumps # Unneeded for the most part, but I could care less to make this better

                        # Can create large dump files
                        # Don't really recommend since it would 
                        # be smarter to parse for the info you want
                        # via piping the stdout to whatever in your
                        # shell or script.

                        curl -s -X GET "https://psbdmp.ws/api/v3/dump/"$id"" >> "$output_file"
                fi
                
                sleep 5 # Sleep for 5 seconds to not be too obnoxious with our API lookup
        done <<< "$ids"

        echo ""
        echo "Done!"

        exit 0
        return 0
}

if [[ -n "$GENERAL_SRCH" ]]
then
        url=https://psbdmp.ws/api/search/"$GENERAL_SRCH"
        scrape
fi

if [[ -n "$EMAIL" ]]
then
        url=https://psbdmp.ws/api/search/email/"$EMAIL"
        scrape
fi

if [[ -n "$DOMAIN" ]]
then
        url=https://psbdmp.ws/api/search/domain/"$DOMAIN"
        scrape
fi