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
      - rearrange_spurious_alignments/output_sam
    type: File?
    'sbg:x': 260.30303955078125
    'sbg:y': -348.71209716796875
  - id: output_log
    outputSource:
      - rearrange_spurious_alignments/output_log
    type: File?
    'sbg:x': 274.52288818359375
    'sbg:y': -95.91481018066406
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
  - id: rearrange_spurious_alignments
    in:
      - id: name_sorted_sam_alignment_file
        source: samtools_sort/output_sam
    out:
      - id: output_log
      - id: output_sam
    run: ./rearrange_spurious_alignments.cwl
    label: rearrange_spurious_alignments
    'sbg:x': 155.3823699951172
    'sbg:y': -234.779296875
requirements: []
