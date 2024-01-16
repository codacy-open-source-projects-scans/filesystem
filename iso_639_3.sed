#This sed file for parsing iso639-3 file is not in use at the moment
#(as there are too many entries - but keeping it for future use)
1,/<iso_639_3_entries/b

# on each new iso-code process the current one
\!\(<iso_639_3_entry\|</iso_639_entries>\)!{
    x
    s/^$//
    # we are on the first iso-code--nothing to process here
    t
    # process and write to output
    s/\s\+/ /g
    s/<iso_639_3_entry//
    s!/\s*>!!
    # use '%' as a separator of parsed and unparsed input
    s/\(.*\)id="\([^"]\+\)"\(.*\)/\2 % \1 \3/
    t clear1
    : clear1
    s/\([^%]\+\)%\(.*\)part1_code="\([^"]\+\)"\(.*\)/\1\t\3 % \2 \4/
    #  clear subst. memory for the next t
    t clear
    # no 639-1 code--write xx
    s/%/\tXX %/
    :clear
    t clear2
    : clear2
    s/\([^%]\+\)%\(.*\)part2_code="\([^"]\+\)"\(.*\)/\1\t\3 % \2 \4/
    t name
    # no 639-1 code--write xx
    s/%/\tXX %/
    :name
    s/\([^%]\+\)%\(.*\)name="\([^"]\+\)"\(.*\)/\1\t\3/
    s/ \t/\t/g
    p
    b
    :noout
}

H
