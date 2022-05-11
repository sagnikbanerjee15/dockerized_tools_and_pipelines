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
    'sbg:x': 967.1021118164062
    'sbg:y': -315.7394714355469
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
  - id: samtofastq
    outputSource:
      - convertsamtofastq/output_fastq
    type: File?
    'sbg:x': 775.9324951171875
    'sbg:y': -80.70379638671875
  - id: output_consensus_whole
    outputSource:
      - pbaa_cluster/output_consensus
    type: File?
    'sbg:x': 736.6906127929688
    'sbg:y': 1195.7142333984375
  - id: output_consensus_construct
    outputSource:
      - pbaa_cluster_1/output_consensus
    type: File?
    'sbg:x': 981.56591796875
    'sbg:y': 1151.041015625
  - id: construct_HA_primer_gtf
    outputSource:
      - >-
        generate_annotation_file_for_construct_ha_primers/construct_HA_primer_gtf
    type: File?
    'sbg:x': 504.62884521484375
    'sbg:y': -708.591064453125
  - id: construct_gtf
    outputSource:
      - generate_annotation_file_for_construct_ha_primers/construct_gtf
    type: File?
    'sbg:x': 595.1997680664062
    'sbg:y': -557.8221435546875
  - id: bedgraph_to_bigwig
    outputSource:
      - bedgraph_to_bigwig/output
    type: File?
    'sbg:x': 2652.6669921875
    'sbg:y': 106.60791015625
  - id: subset_of_reads_spanning_the_construct
    outputSource:
      - subset_reads_spanning_the_construct/output_fastq
    type: File?
    'sbg:x': 1100.8858642578125
    'sbg:y': 923.2574462890625
  - id: genomecoveragebed
    outputSource:
      - bedtools_genomecoveragebed/output_bed
    type: File?
    'sbg:x': 2468.722412109375
    'sbg:y': 542.3655395507812
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
    'sbg:x': 350.0289611816406
    'sbg:y': -594.9917602539062
  - id: subset_reads_spanning_the_construct
    in:
      - id: reference
        source: reference
      - id: construct_fasta
        source: construct
      - id: raw_reads_mapped_to_reference_bam
        source:
          - samtools_view_2/output_bam
      - id: raw_reads
        source: convertsamtofastq/output_fastq
    out:
      - id: output_fastq
    run: ./subset_reads_spanning_the_construct.cwl
    label: subset_reads_spanning_the_construct
    'sbg:x': 953.411865234375
    'sbg:y': 681.9188232421875
  - id: pbaa_cluster
    in:
      - id: reference
        source: reference
      - id: raw_reads_in_fastq
        source: convertsamtofastq/output_fastq
      - id: output_prefix
        default: whole
    out:
      - id: output_consensus
    run: ../../pbbioconda/1.14/pbaa-cluster.cwl
    label: pbaa cluster
    'sbg:x': 580.433837890625
    'sbg:y': 1039.3826904296875
  - id: pbaa_cluster_1
    in:
      - id: reference
        source: reference
      - id: raw_reads_in_fastq
        source: subset_reads_spanning_the_construct/output_fastq
      - id: output_prefix
        default: construct_spanning
    out:
      - id: output_consensus
    run: ../../pbbioconda/1.14/pbaa-cluster.cwl
    label: pbaa cluster
    'sbg:x': 849.74609375
    'sbg:y': 979.0034790039062
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
    'sbg:x': 2486.458984375
    'sbg:y': 177.99783325195312
requirements:
  - class: SubworkflowFeatureRequirement
