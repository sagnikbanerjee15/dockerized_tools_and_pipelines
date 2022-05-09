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
    'sbg:x': -35.837646484375
    'sbg:y': -270.5
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
      - id: reference
        source: reference
      - id: raw_reads_filename
        source: convertsamtofastq/output_fastq
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
    'sbg:x': -188
    'sbg:y': -263
requirements: []
