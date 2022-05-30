class: Workflow
cwlVersion: v1.0
id: pacbio_data_analysis
label: pacbio_data_analysis
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: reference
    type: File
    'sbg:x': -554.5944213867188
    'sbg:y': -288.34765625
  - id: input_fastq_file
    type: File
    'sbg:x': -546.6011352539062
    'sbg:y': -145.5
  - id: threads
    type: int?
    'sbg:x': -541.826171875
    'sbg:y': -436.1009216308594
outputs:
  - id: output_sam
    outputSource:
      - samtools_sort/output_sam
    type: File?
    'sbg:x': 83.34493255615234
    'sbg:y': -140.1543426513672
steps:
  - id: minimap2
    in:
      - id: activate_homopolymer_kmer
        default: true
      - id: output_format
        default: SAM
      - id: reference
        source: reference
      - id: raw_reads_filename
        source: input_fastq_file
      - id: cs_tag
        default: true
      - id: output_MD_tag
        default: true
      - id: eqx
        default: true
      - id: threads
        source: threads
      - id: use_soft_clipping_for_secondary_alignments
        default: true
    out:
      - id: output_sam
      - id: output_paf
    run: ../../minimap2/2.24/minimap2.cwl
    label: minimap2
    'sbg:x': -417
    'sbg:y': -223
  - id: samtools_view
    in:
      - id: input_alignment
        source: minimap2/output_sam
      - id: output_format
        default: BAM
      - id: threads
        source: threads
    out:
      - id: output_bam
      - id: output_sam
      - id: output_cram
    run: ../../samtools/1.14/samtools-view.cwl
    label: samtools view
    'sbg:x': -230.88023376464844
    'sbg:y': -215.439697265625
  - id: samtools_sort
    in:
      - id: input_alignment
        source: samtools_view/output_bam
      - id: output_format
        default: SAM
      - id: threads
        source: threads
      - id: sort_by_name
        default: true
    out:
      - id: output_bam
      - id: output_sam
      - id: output_cram
    run: ../../samtools/1.14/samtools-sort.cwl
    label: samtools sort
    'sbg:x': -67.15911102294922
    'sbg:y': -218.6595458984375
requirements: []
