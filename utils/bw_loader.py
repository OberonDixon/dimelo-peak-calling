import pyBigWig
import numpy as np
from pathlib import Path

def bigwig_to_arrays_by_chrom(directory,prefix,mod,chromosome,start_co,end_co):
    directory_path = Path(directory)
    valid_path = directory_path / (prefix + chromosome + '_bigwig_valid' + mod + '.bw')
    mod_path = directory_path / (prefix + chromosome + '_bigwig_mod' + mod + '.bw')
    with pyBigWig.open(str(valid_path)) as bw:
        contigs = bw.chroms()       
        if chromosome in contigs.keys() and end_co<contigs[chromosome]:
            valid_array = np.nan_to_num(np.array(bw.values(chromosome,start_co,end_co)))
        else:
            print(f'invalid chromosome coordinates {chromosome}:{start_co}-{end_co}')
            return 0
    with pyBigWig.open(str(mod_path)) as bw:
        contigs = bw.chroms()       
        if chromosome in contigs.keys() and end_co<contigs[chromosome]:
            mod_array = np.nan_to_num(np.array(bw.values(chromosome,start_co,end_co)))
        else:
            print(f'invalid chromosome coordinates {chromosome}:{start_co}-{end_co}')
            return 0
    return valid_array,mod_array

def arrays_to_windows(valid_array,modified_array,window_size,window_step):
    return 0

