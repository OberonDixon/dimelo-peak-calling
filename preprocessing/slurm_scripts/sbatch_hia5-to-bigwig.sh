#!/bin/bash
#SBATCH --job-name=hia5-to-bigwig
#SBATCH --account=fc_nilah
#SBATCH --partition=savio3
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:45:00
#SBATCH --output=/clusterfs/nilah/oberon/repos/dimelo-peak-calling/preprocessing/slurm_logs/hia5-to-bigwig_%A_%a.out
#SBATCH --error=/clusterfs/nilah/oberon/repos/dimelo-peak-calling/preprocessing/slurm_logs/hia5-to-bigwig_%A_%a.err
#SBATCH --array=1-23
# Command(s) to run:
module load python

# Use SLURM_ARRAY_TASK_ID as the chromosome number, with 23 mapped to "X"
if [ "${SLURM_ARRAY_TASK_ID}" == "23" ]; then
    chr="X"
else
    chr="${SLURM_ARRAY_TASK_ID}"
fi

export LD_LIBRARY_PATH=/clusterfs/nilah/oberon/python/lib/:${LD_LIBRARY_PATH}

conda run -n dimelo_arbitrary_basemod_dev /clusterfs/nilah/oberon/repos/dimelo-peak-calling/preprocessing/process_dimelo-to-bigwig.py --chromosome chr${chr} --output_folder /global/scratch/users/dixonluinenburg/whole_genome_bigwigs/Hia5-free/chr${chr}/ --bam_file /clusterfs/nilah/ayesha/dimelo/prod_free_Hia5_mod_mappings.sorted.bam --name hia5_free --reference_genome /clusterfs/nilah/oberon/dimelo_dev_source/test_inputs/genomes/chm13.draft_v1.0.fasta