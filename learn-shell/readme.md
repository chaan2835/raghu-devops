1. How to write a shell script
2. printing
3. variables
4. Inputs
5. Conditions
6. loop
7. functions
8. Exit status
9. Quotes
10. SED editor

-------------
deleting some lines
    based on line numbers
        sed -i -e '1d' filename -->this will delete line1 in the mentioned file
    string based delete
        sed -i -e '/nologin/ d' filename --> this will delete the specific lines which are having the string that we mentioned in the file
---------
adding some lines
    based on line numbers
        sed -i -e '1 a Hello' filename --> this will add hello in the list line in the mentioned filename
        sed -i -e '/mongo/ a hello world' filename --> this will search for mongo and replace it with hello world in the mentioned file

    modify/update
        sed -i -e '2 c gud mrng' filename --> this will add gud mrng in line two

        sed -i -e '/centos/ c Hello galaxy' filename --> this will find the line which contains centos and replace that line with Hello galaxy in the mentioned file
-----------
modify/substitute(find and replace) some words

    sed -i -e 's|bin|BIN|' filename --> this is just like find and replace command
    here it is finding bin and replacing it with BIN in the mentioned filename in 1st occurance only

    sed -i -e 's|bin|BIN|g' filename --> this will find bin and replace it with BIN in all occurances
--------------
delete some word/words

    sed -i e 's|bin||g' filename --> this will find bin word and remove it from all occurances in the mentioned file
------------------

colour code syntax for shell scripting

syntax--> echo -e "\e[COLmMESSAGE\e[0m"

-e --> enables \e (enables colour in echo command)
all the inputs must be there in quotes only
\e --> enable the color
COLm --> color code
    shell script supports only --> Red(31m),Green(32m),Yellow(33m),Blue(34m),Magenta(35m),Cyan(36m)
\e[0m --> Disable the color
    once we enable the we have to disable it otherwise it'll follow for next lines also

================================

$0 --> script name
$1 to $n --> arguments parsed in the order
$*,$@ --> al arguments
$# --> Number of arguments