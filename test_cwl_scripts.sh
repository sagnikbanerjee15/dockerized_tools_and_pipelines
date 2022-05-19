#!/bin/bash

################################################################################################################################################################################################################################################################
# Samtools
################################################################################################################################################################################################################################################################

# Samtools view convert BAM to SAM format

export SAMTOOLS_VERSION=1.14

echo "Samtools view"

cwltool \
--debug \
samtools/${SAMTOOLS_VERSION}/samtools-view.cwl \
--input_alignment sample_test_data/pacbio.bam \
--output_format SAM \
--threads 10 \
1> sample_test_data/samtools-view-bam-to-sam.output \
2> sample_test_data/samtools-view-bam-to-sam.error

rm -rf pacbio.sam

# Samtools sort 

echo "Samtools sort"

cwltool \
--debug \
samtools/${SAMTOOLS_VERSION}/samtools-sort.cwl \
--input_alignment sample_test_data/pacbio.bam \
--output_format SAM \
--threads 10 \
1> sample_test_data/samtools-sort-by-name.output \
2> sample_test_data/samtools-sort-by-name.error

rm -rf pacbio.sortedByPos.sam

################################################################################################################################################################################################################################################################
# Minimap2
################################################################################################################################################################################################################################################################

export MINIMAP2_VERSION=2.24

cwltool \
--debug \
minimap2/${MINIMAP2_VERSION}/minimap2.cwl \
