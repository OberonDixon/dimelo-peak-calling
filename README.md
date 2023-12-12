# dimelo-peak-calling
Peak calling prototypes for DiMeLo-seq. 

The purpose of this repository is to test a few approaches for calling binding peaks for various protein binding datasets with Directed Methylation and Long Read Sequencing, DiMeLo-seq.

## subfolders
### preprocessing

The scripts in here run the dimelo_arbitrary_basemod_dev branch, https://github.com/OberonDixon/dimelo/tree/arbitrary_basemod_dev, which allows for rapid full-genome pileups and single-read processing. Currently it is set up to run on savio3 nodes on the Berkeley high performance cluster, which allows ~90GB of memory. A smaller bases cap per process would be necessary to run this elsewhere without crashing.

### utils

This code is there to give an interface to load bigwigs to arrays from specifically the validMOD and modMOD suffix format used by the dimelo dev package.

### train hmms

The various notebooks use pomegranate, a statistical modeling package, to train HMMs. There is also some simple p-value testing with scipy as a baseline against which to comapre.