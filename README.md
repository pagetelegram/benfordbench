# benfordbench
BenfordBench is a Fraud Analysis tool using Benford's Law to evaluate probability of fraud or disorder in large data pools.

In addition to benford cruve comparisions for fraud analysis, this program can do error reporting if a certain user specified percent exceeds the prior user specified sampling chunck. Error reporting represents probable fraud/disorder of a sample chunk of (usually) 10,000 or more. The error log and chunks are logged to seperate files *.err and *.ben respectively.

To compile you will need the FreeBasic Compiler (fbc) for Linux. Alternatively you can also use the Linux version of QB64 to compile.

To compile after installing fbc, specify this way:

fbc -lang qb benford.bas


Details on our use of an earlier (DOS) incarnation of this program at <a href="benfordbench.org">benfordbench.org</a>

Program has been redeveloped for Linux and currently I am using it to assess cancer identification in human DNA of SRR1294492.
