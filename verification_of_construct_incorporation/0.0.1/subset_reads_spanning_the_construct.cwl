class: Workflow
cwlVersion: v1.0
id: subset_reads_spanning_the_construct
label: subset_reads_spanning_the_construct
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: reference
    type: File
    'sbg:x': -658.6488647460938
    'sbg:y': -336.5
  - id: construct_fasta
    type: File
    'sbg:x': -686.6488647460938
    'sbg:y': -100.5
  - id: raw_reads_mapped_to_reference_bam
    type:
      - File
      - type: array
        items: File
    'sbg:x': -495.4268798828125
    'sbg:y': -566.5
  - id: raw_reads
    type: File
    'sbg:x': -467.4268798828125
    'sbg:y': 100.5
outputs:
  - id: output_fastq
    outputSource:
      - extract_long_reads_containing_complete_construct/output_fastq
    type: File?
    'sbg:x': 245.5731201171875
    'sbg:y': -89.5
steps:
  - id: minimap2
    in:
      - id: output_format
        default: SAM
      - id: reference
        source: reference
      - id: raw_reads_filename
        source: construct_fasta
    out:
      - id: output_sam
      - id: output_paf
    run: ../../minimap2/2.24/minimap2.cwl
    label: minimap2
    'sbg:x': -463
    'sbg:y': -229
  - id: samtools_view
    in:
      - id: input_alignment
        source: minimap2/output_sam
      - id: output_format
        default: BAM
    out:
      - id: output_bam
      - id: output_sam
      - id: output_cram
    run: ../../samtools/1.14/samtools-view.cwl
    label: samtools view
    'sbg:x': -304.9083557128906
    'sbg:y': -305.55804443359375
  - id: bedtools_intersect
    in:
      - id: inputB
        source:
          - raw_reads_mapped_to_reference_bam
      - id: inputA
        source: samtools_view/output_bam
      - id: output_prefix
        default: pacbio__reads_overlapping_partially_with_construct
    out:
      - id: output
    run: ../../bedtools/2.27.1/bedtools-intersect.cwl
    label: bedtools intersect
    'sbg:x': -122.4296875
    'sbg:y': -358.5
  - id: extract_long_reads_containing_complete_construct
    in:
      - id: reads_overlapping_partially_with_construct_bed
        source: bedtools_intersect/output
      - id: raw_reads
        source: raw_reads
      - id: type_of_sequencing
        default: pacbio
    out:
      - id: output_fastq
    run: ./extract_long_reads_containing_complete_construct.cwl
    label: extract_long_reads_containing_complete_construct
    'sbg:x': 35
    'sbg:y': -267
requirements: []
