Red [
	Title:  "Test for JSON parser"
  	Author: "..."
  	File:   %fuzz.red
  	Tabs:   4
  	Rights:  "Copyright (C) 2018 Red Foundation. All rights reserved."
  	License: {
  		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/
    	BSL-License.txt
	}
]

fuzzer: context [
    fuzz: func [payload_list [file!] fileToImport [file!] funcToRun] [
        try [
            #include fileToImport 
            payloads: read/lines payload_list
            ;--print do json/load-str "loop 5 [print 2]"
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
