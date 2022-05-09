class: Workflow
cwlVersion: v1.0
id: pacbio_data_analysis
label: pacbio_data_analysis
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: input_alignment
    type: File
    'sbg:x': 0
    'sbg:y': 134.4312286376953
  - id: threads
    type: int?
    'sbg:x': 9.548253059387207
    'sbg:y': -108.21353912353516
  - id: reference
    type: File
    'sbg:x': -7.956881046295166
    'sbg:y': 383.89935302734375
outputs:
  - id: output_bed
    outputSource:
      - bedtools_genomecoveragebed/output_bed
    type: File?
    'sbg:x': 1569.0911865234375
    'sbg:y': -170.16627502441406
steps:
  - id: samtools_view
    in:
      - id: input_alignment
        source: input_alignment
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
    'sbg:x': 434.87860107421875
    'sbg:y': -343.0368957519531
  - id: convertsamtofastq
    in:
      - id: sam_format_inputfilename
        source: samtools_view/output_sam
    out:
      - id: output_fastq
    run: ./convertsamtofastq.cwl
    label: convertSAMToFASTQ
    'sbg:x': 687.6016235351562
    'sbg:y': -338.58514404296875
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
    'sbg:x': 356.84967041015625
    'sbg:y': 137.5585174560547
  - id: removepooralignments
    in:
      - id: input_samfilename
        source: samtools_sort/output_sam
    out:
      - id: output_sam
    run: ./removepooralignments.cwl
    label: removePoorAlignments
    'sbg:x': 1076.30712890625
    'sbg:y': -95.87464141845703
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
    'sbg:x': 705.12744140625
    'sbg:y': 126.41888427734375
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
    'sbg:x': 916.4747924804688
    'sbg:y': -7.256659030914307
  - id: bedtools_genomecoveragebed
    in:
      - id: ibam
        source: samtools_view_2/output_bam
    out:
      - id: output_bed
    run: ../../bedtools/2.27.1/bedtools-genomecoveragebed.cwl
    label: bedtools genomecoveragebed
    'sbg:x': 1425.4195556640625
    'sbg:y': -251.52615356445312
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
    'sbg:x': 1209.6845703125
    'sbg:y': -219.6299591064453
requirements: []
