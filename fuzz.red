Red [
	Title:  "Red Fuzzer"
  	Author: "..."
  	File:   %fuzz.red
  	Tabs:   4
  	Rights:  "????????"
  	License: {
        MIT
	}
]

fuzzer: context [
    fuzz: func [payload_list [file!] fileToImport [file!] funcToRun] [
        try [
            #include fileToImport 
            payloads: read/lines payload_list
            foreach [line] payloads [
                print json/load-str line
                do print :funcToRun [line]
            ]
        ] [
            print "error"
        ]
    ]
]

args: system/options/args
payload_list: make file! pick args 1
fileToImport: make file! pick args 2
funcToRun: pick args 3

fuzzer/fuzz payload_list fileToImport funcToRun
