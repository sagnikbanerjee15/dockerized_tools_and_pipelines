class: Workflow
cwlVersion: v1.0
id: pacbio_data_analysis
label: pacbio_data_analysis
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: raw_reads_in_bam
    type: File
    'sbg:x': 0
    'sbg:y': -136.84185791015625
  - id: threads
    type: int?
    'sbg:x': 0
    'sbg:y': 106.640625
  - id: reference
    type: File
    'sbg:x': 0
    'sbg:y': 213.1875
  - id: three_prime_homology_arm
    type: File?
    'sbg:x': 0
    'sbg:y': 0
  - id: primers
    type: File?
    'sbg:x': 0
    'sbg:y': 426.3515625
  - id: five_prime_homology_arm
    type: File?
    'sbg:x': 0
    'sbg:y': 533.015625
  - id: construct
    type: File
    'sbg:x': 0
    'sbg:y': 639.65625
outputs:
  - id: reference_coverage_bw
    outputSource:
      - bedgraph_to_bigwig/output
    type: File?
    'sbg:x': 2378.322509765625
    'sbg:y': -36.332271575927734
  - id: output_fastq
    outputSource:
      - convertsamtofastq/output_fastq
    type: File?
    'sbg:x': 814.0066528320312
    'sbg:y': 439.533203125
  - id: output
    outputSource:
      - samtools_fqidx/output
    type: File?
    'sbg:x': 887.62353515625
    'sbg:y': 16.62744140625
  - id: output_1
    outputSource:
      - samtools_faidx/output
    type: File?
    'sbg:x': 491.34521484375
    'sbg:y': 423.8700256347656
steps:
  - id: samtools_view
    in:
      - id: input_alignment
        source: raw_reads_in_bam
      - id: output_format
        default: SAM
      - id: threads
        source: threads
    out:
      - id: output_bam
      - id: output_sam
      - id: output_cram
    run: ../../samtools/1.14/samtools-view.cwl
    label: samtools view
    'sbg:x': 351.78961181640625
    'sbg:y': -9.471904754638672
  - id: convertsamtofastq
    in:
      - id: sam_format_inputfilename
        source: samtools_view/output_sam
    out:
      - id: output_fastq
    run: ./convertsamtofastq.cwl
    label: convertSAMToFASTQ
    'sbg:x': 681.5868530273438
    'sbg:y': 319.875
  - id: minimap2
    in:
      - id: output_format
        default: SAM
      - id: reference
        source: reference
      - id: raw_reads_filename
        source: convertsamtofastq/output_fastq
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
    'sbg:x': 977.8368530273438
    'sbg:y': 305.8515625
  - id: removepooralignments
    in:
      - id: input_samfilename
        source: samtools_sort/output_sam
    out:
      - id: output_sam
    run: ./removepooralignments.cwl
    label: removePoorAlignments
    'sbg:x': 1783.8193359375
    'sbg:y': 319.78125
  - id: samtools_view_1
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
    'sbg:x': 1252.911376953125
    'sbg:y': 305.875
  - id: samtools_sort
    in:
      - id: input_alignment
        source: samtools_view_1/output_bam
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
    'sbg:x': 1518.365478515625
    'sbg:y': 305.875
  - id: bedtools_genomecoveragebed
    in:
      - id: ibam
        source: samtools_view_2/output_bam
      - id: d
        default: false
      - id: bga
        default: true
    out:
      - id: output_bed
    run: ../../bedtools/2.27.1/bedtools-genomecoveragebed.cwl
    label: bedtools genomecoveragebed
    'sbg:x': 2302.6015625
    'sbg:y': 319.78125
  - id: samtools_view_2
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
    'sbg:x': 2037.1474609375
    'sbg:y': 305.875
  - id: samtools_faidx
    in:
      - id: input_fasta
        source: reference
    out:
      - id: output
    run: ../../samtools/1.14/samtools-faidx.cwl
    label: samtools-faidx
    'sbg:x': 390.4232177734375
    'sbg:y': 334.7137756347656
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
    'sbg:x': 354.90118408203125
    'sbg:y': 475.78533935546875
  - id: bedgraph_to_bigwig
    in:
      - id: coverage_over_reference_bed_format
        source: bedtools_genomecoveragebed/output_bed
      - id: crom_sizes
        source: samtools_faidx/output
    out:
      - id: output
    run: ../../bedgraph_to_bigwig/2.8/bedgraph_to_bigwig.cwl
    label: bedgraph_to_bigwig
    'sbg:x': 2260.750244140625
    'sbg:y': 73.93431091308594
  - id: pbaa_cluster
    in:
      - id: num-threads
        source: threads
      - id: min-read-qv
        default: 40
      - id: reference
        source: reference
      - id: raw_reads_in_fastq
        source: convertsamtofastq/output_fastq
      - id: output_prefix
        default: whole_consensus
      - id: pile-size
        default: 10
      - id: max-reads-per-guide
        default: 200
      - id: iterations
        default: 5
    out: []
    run: ../../pbbioconda/1.14/pbaa-cluster.cwl
    label: pbaa cluster
    'sbg:x': 1188.1558837890625
    'sbg:y': 631.19384765625
  - id: samtools_fqidx
    in:
      - id: input_fastq
        source: convertsamtofastq/output_fastq
    out:
      - id: output
    run: ../../samtools/1.14/samtools-fqidx.cwl
    label: samtools-fqidx
    'sbg:x': 718.3206787109375
    'sbg:y': 35.04830551147461
requirements:
  - class: SubworkflowFeatureRequirement
