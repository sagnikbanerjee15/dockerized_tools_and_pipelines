class: Workflow
cwlVersion: v1.0
id: nanopore_data_analysis
label: nanopore_data_analysis
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: threads
    type: int
    'sbg:x': 232.9730682373047
    'sbg:y': -438.83319091796875
  - id: reference
    type: File
    'sbg:x': -936.0846557617188
    'sbg:y': -148.04232788085938
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
  - id: raw_reads_mapped_to_reference_bam
    outputSource:
      - samtools_sort_1/output_bam
    type: File?
    'sbg:x': 1079.3994140625
    'sbg:y': 182.40530395507812
  - id: coverage
    outputSource:
      - bedgraph_to_bigwig/output
    type: File?
    'sbg:x': 1483.3304443359375
    'sbg:y': -70.13324737548828
  - id: nanopore_consensus_mapped_to_reference_bam
    outputSource:
      - samtools_sort_2/output_bam
    type: File?
    'sbg:x': 735.728271484375
    'sbg:y': 636.8272094726562
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
    'sbg:x': 170.1985626220703
    'sbg:y': -77.68306732177734
  - id: removepooralignments
    in:
      - id: input_samfilename
        source: samtools_sort/output_sam
    out:
      - id: output_sam
    run: ./removepooralignments.cwl
    label: removePoorAlignments
    'sbg:x': 400.8860778808594
    'sbg:y': -49.89140701293945
  - id: samtools_view_1
    in:
      - id: input_alignment
        source: removepooralignments/output_sam
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
    'sbg:x': 601.502685546875
    'sbg:y': -32.69550704956055
  - id: samtools_sort_1
    in:
      - id: input_alignment
        source: samtools_view_1/output_bam
      - id: threads
        source: threads
    out:
      - id: output_bam
      - id: output_sam
      - id: output_cram
    run: ../../samtools/1.14/samtools-sort.cwl
    label: samtools sort
    'sbg:x': 828.0722045898438
    'sbg:y': -12.731947898864746
  - id: bedtools_genomecoveragebed
    in:
      - id: ibam
        source: samtools_sort_1/output_bam
      - id: bga
        default: true
    out:
      - id: output_bed
    run: ../../bedtools/2.27.1/bedtools-genomecoveragebed.cwl
    label: bedtools genomecoveragebed
    'sbg:x': 1089.7012939453125
    'sbg:y': -53.089351654052734
  - id: bedgraph_to_bigwig
    in:
      - id: coverage_over_reference_bed_format
        source: bedtools_genomecoveragebed/output_bed
      - id: crom_sizes
        source: reference
    out:
      - id: output
    run: ../../bedgraph_to_bigwig/2.8/bedgraph_to_bigwig.cwl
    label: bedgraph_to_bigwig
    'sbg:x': 1295.6107177734375
    'sbg:y': -180.5395965576172
  - id: medaka
    in:
      - id: threads
        source: threads
      - id: reference
        source: reference
      - id: input_fastq
        source: raw_reads_fastq
    out:
      - id: consensus
    run: ../../medaka/1.6.0/medaka.cwl
    label: medaka
    'sbg:x': -154.9082794189453
    'sbg:y': 438.41717529296875
  - id: minimap3
    in:
      - id: output_format
        default: SAM
      - id: reference
        source: reference
      - id: raw_reads_filename
        source: medaka/consensus
      - id: cs_tag
        default: true
      - id: output_MD_tag
        default: true
      - id: eqx
        default: true
      - id: threads
        source: threads
    out:
      - id: output_sam
      - id: output_paf
    run: ../../minimap2/2.24/minimap2.cwl
    label: minimap2
    'sbg:x': 159.2534637451172
    'sbg:y': 443.250244140625
  - id: samtools_view_2
    in:
      - id: input_alignment
        source: minimap3/output_sam
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
    'sbg:x': 433.4349060058594
    'sbg:y': 440.7100524902344
  - id: samtools_sort_2
    in:
      - id: input_alignment
        source: samtools_view_2/output_bam
      - id: output_format
        default: BAM
      - id: threads
        source: threads
    out:
      - id: output_bam
      - id: output_sam
      - id: output_cram
    run: ../../samtools/1.14/samtools-sort.cwl
    label: samtools sort
    'sbg:x': 622
    'sbg:y': 430.1153564453125
requirements:
  - class: SubworkflowFeatureRequirement
