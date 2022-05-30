class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: rearrange_spurious_alignments
baseCommand:
  - rearrange_spurious_alignments
inputs:
  - id: name_sorted_sam_alignment_file
    type: File
    inputBinding:
      position: 0
      prefix: '--name_sorted_sam_alignment_file'
      shellQuote: false
  - 'sbg:toolDefaultValue': '40'
    id: min_percentage_of_mapped_read_length
    type: int?
    inputBinding:
      position: 0
      prefix: '--min_percentage_of_mapped_read_length'
  - id: verbose
    type: File?
    inputBinding:
      position: 0
      prefix: '--verbose'
      shellQuote: false
outputs:
  - id: output_log
    type: File?
    outputBinding:
      glob: '*log'
  - id: output_sam
    type: File?
    outputBinding:
      glob: '*sam'
label: rearrange_spurious_alignments
arguments:
  - position: 0
    prefix: '--name_of_output_samfile'
    shellQuote: false
    valueFrom: >-
      ${return inputs.name_sorted_sam_alignment_file.nameroot +
      "_spurious_alignments_removed.sam"}
  - position: 0
    prefix: '--logfilename'
    shellQuote: false
    valueFrom: >-
      ${return inputs.name_sorted_sam_alignment_file.nameroot +
      "_remove_spurious_alignment.log"}
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: >-
      ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/gene_delivery_aav:0.0.1
