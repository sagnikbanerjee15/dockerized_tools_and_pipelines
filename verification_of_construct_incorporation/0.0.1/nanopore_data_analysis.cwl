class: Workflow
cwlVersion: v1.0
id: nanopore_data_analysis
label: nanopore_data_analysis
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: threads
    type: int?
    'sbg:x': 232.9730682373047
    'sbg:y': -438.83319091796875
  - id: reference
    type: File
    'sbg:x': -908.8624877929688
    'sbg:y': -168.88734436035156
  - id: raw_reads_fastq
    type: File
    'sbg:x': -908.1009521484375
    'sbg:y': -24.57863998413086
  - id: three_prime_homology_arm
    type: File?
    'sbg:x': -910.3744506835938
    'sbg:y': 126.7403793334961
  - id: primers
    type: File?
    'sbg:x': -912.3767700195312
    'sbg:y': 282.94451904296875
  - id: five_prime_homology_arm
    type: File?
    'sbg:x': -912.3767700195312
    'sbg:y': 425.0008544921875
  - id: construct
    type: File
    'sbg:x': -909.42138671875
    'sbg:y': 605.2978515625
outputs:
  - id: construct_HA_primer_gtf
    outputSource:
      - >-
        generate_annotation_file_for_construct_ha_primers/construct_HA_primer_gtf
    type: File?
    'sbg:x': -308.356689453125
    'sbg:y': -534.7080078125
  - id: construct_gtf
    outputSource:
      - generate_annotation_file_for_construct_ha_primers/construct_gtf
    type: File?
    'sbg:x': -284.1935729980469
    'sbg:y': -418.1564025878906
steps:
  - id: minimap2
    in:
      - id: output_format
        default: SAM
      - id: reference
        source: reference
      - id: raw_reads_filename
        source: raw_reads_fastq
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
    'sbg:x': -310.5078125
    'sbg:y': -119.5
  - id: generate_annotation_file_for_construct_ha_primers
    in:
      - id: reference
        source: reference
      - id: primers
        source: primers
      - id: three_prime_homology_arm
        source: three_prime_homology_arm
      - id: five_prime_homology_arm
        source: five_prime_homology_arm
      - id: construct
        source: construct
    out:
      - id: construct_HA_primer_gtf
      - id: construct_gtf
    run: ./generate_annotation_file_for_construct_ha_primers.cwl
    label: generate_annotation_file_for_construct_HA_primers
    'sbg:x': -453.33538818359375
    'sbg:y': -359.8933410644531
  - id: samtools_view
    in:
      - id: input_alignment
        source: minimap2/output_sam
      - id: threads
        source: threads
    out:
      - id: output_bam
      - id: output_sam
      - id: output_cram
    run: ../../samtools/1.14/samtools-view.cwl
    label: samtools view
    'sbg:x': -38.48085403442383
    'sbg:y': -99.96817779541016
  - id: samtools_sort
    in:
      - id: input_alignment
        source: samtools_view/output_bam
      - id: threads
        source: threads
    out:
      - id: output_bam
      - id: output_sam
      - id: output_cram
    run: ../../samtools/1.14/samtools-sort.cwl
    label: samtools sort
    'sbg:x': 170.1985626220703
    'sbg:y': -77.68306732177734
requirements:
  - class: SubworkflowFeatureRequirement
