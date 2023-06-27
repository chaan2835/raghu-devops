syntax--> echo -e "\e[COLmMESSAGE\e[0m"

-e --> enables \e (enables colour in echo command)
all the inputs must be there in quotes only
\e --> enable the color
COLm --> color code
    shell script supports only --> Red(31m),Green(32m),Yellow(33m),Blue(34m),Magenta(35m),Cyan(36m)
\e[0m --> Disable the color
    once we enable the we have to disable it otherwise it'll follow for next lines also