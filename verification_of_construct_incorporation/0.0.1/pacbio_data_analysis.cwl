class: Workflow
cwlVersion: v1.0
id: pacbio_data_analysis
label: pacbio_data_analysis
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: input_alignment
    type: File
    'sbg:x': -897.8372802734375
    'sbg:y': -298.5
  - id: threads
    type: int?
    'sbg:x': -833.837646484375
    'sbg:y': -431.5
  - id: reference
    type: File
    'sbg:x': -671.837646484375
    'sbg:y': -459.5
outputs:
  - id: output_sam
    outputSource:
      - removepooralignments/output_sam
    type: File?
    'sbg:x': -56.837646484375
    'sbg:y': -195.5
  - id: output_sam_1
    outputSource:
      - samtools_view/output_sam
    type: File?
    'sbg:x': -540.837646484375
    'sbg:y': 51.5
  - id: output_fastq
    outputSource:
      - convertsamtofastq/output_fastq
    type: File?
    'sbg:x': -379.837646484375
    'sbg:y': -31.5
  - id: output_sam_2
    outputSource:
      - minimap2/output_sam
    type: File?
    'sbg:x': -257.837646484375
    'sbg:y': -5.5
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
    'sbg:x': -701
    'sbg:y': -228
  - id: convertsamtofastq
    in:
      - id: sam_format_inputfilename
        source: samtools_view/output_sam
    out:
      - id: output_fastq
    run: ./convertsamtofastq.cwl
    label: convertSAMToFASTQ
    'sbg:x': -491.8372802734375
    'sbg:y': -206.5
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
    'sbg:x': -344
    'sbg:y': -256
  - id: removepooralignments
    in:
      - id: input_samfilename
        source: minimap2/output_sam
    out:
      - id: output_sam
    run: ./removepooralignments.cwl
    label: removePoorAlignments
    'sbg:x': -198
    'sbg:y': -304
requirements: []
