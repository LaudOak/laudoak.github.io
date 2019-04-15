---
layout: post
title: 🦄 Text Search and Processing
category: 其他
---

## grep

##### 1.reference:

[GNU Grep 3.3](https://www.gnu.org/software/grep/manual/grep.html)

[grep, egrep, fgrep, rgrep - print lines matching a pattern](http://linuxcommand.org/lc3_man_pages/grep1.html)

[grep(1) - Linux man page](https://linux.die.net/man/1/grep)

##### 2.几个常用option

- Matching Control

__`-e<patterns> --regexp=<patterns>`__  Use patterns as one or more patterns; newlines within patterns separate each pattern from the next. If this option is used multiple times or iscombined with the -f (--file) option, search for all patterns given. (-e is specified by POSIX.)
-E  Use extended regular expression syntax. Equivalent to the deprecated egrep command.

- General Output Control

__`-c --count`__  Suppress normal output; instead print a count of matching lines for each input file. With the -v (--invert-match) option, count non-matching lines. (-c is specified by POSIX.)

__`-m<num>, --max-count=<num>`__  Stop reading a file after NUM matching lines.If the input is standard input from a regular file, and NUM matching lines are output,grep ensures  that the standard input is positioned to just after the last matching line before exiting, regardless of the presence of trailing context lines.This enables a calling process to resume a search.When grep stops after NUM matching lines,it outputs any trailing context lines.When the -c or --count option is also used,grep does not output a count greater than NUM. When the -v or --invert-match option is also used, grep stops after outputting NUM non-matching lines.

- Output Line Prefix Control

__`-n --line-number`__  Prefix each line of output with the 1-based line number within its input file. (-n is specified by POSIX.)

__`-o --only-matching`__  Output ony the matching segment of each line, rather than the full contents of each matched line

- Context Line Control(Context lines are non-matching lines that are near a matching line. They are output only if one of the following options are used. Regardless of how these options are set, grep never outputs any given line more than once. If the -o (--only-matching) option is specified, these options have no effect and a warning is given upon their use.)

__`-A<num> --after-context=<num>`__  Print num lines of trailing context after matching lines.

__`-B<num> --before-context=<num>`__  Print num lines of leading context before matching lines.
	
__`-C<num> --context=<num>`__  Print num lines of leading and trailing output context.

- File and Directory Selection

__`-r --recursive`__  For each directory operand, read and process all files in that directory, recursively. Follow symbolic links on the command line, but skip symlinks that are encountered recursively. Note that if no file operand is given, grep searches the working directory. This is the same as the ‘--directories=recurse’ option.


## awk

## examples

##### 1️⃣ grep OR,AND,NOT operator

[Linux Grep OR, Grep AND, Grep NOT Operator Examples](https://www.thegeekstuff.com/2011/10/grep-or-and-not-operators/)

```
# OR
grep 'pattern1\|pattern2' filename
grep -E 'pattern1|pattern2' filename
grep -e pattern1 -e pattern2 filename

# AND
grep -E 'pattern1.*pattern2' filename
grep -E 'pattern1' filename | grep -E 'pattern2'

# NOT
grep -v 'pattern1' filename

```

##### 2️⃣ 多条件分组

```
grep -o 'pattern1\|pattern2' filename | awk '{arr[$0]++}END{for(i in arr){print i,arr[i]}}' | sort -k2 -n
```

##### 3️⃣

##### 4️⃣

##### 5️⃣

##### 6️⃣

##### 7️⃣

##### 8️⃣

##### 9️⃣


