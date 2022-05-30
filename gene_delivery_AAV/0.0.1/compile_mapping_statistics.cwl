class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: compile_mapping_statistics
baseCommand:
  - compile_mapping_statistics
inputs:
  - id: name_sorted_sam_alignment_file
    type: File
    inputBinding:
      position: 0
      prefix: '--name_sorted_sam_alignment_file'
      shellQuote: false
  - id: name_of_coverage_bed
    type: File
    inputBinding:
      position: 0
      prefix: '--name_of_coverage_bed'
      shellQuote: false
  - id: gene_annotation_gtf
    type: File
    inputBinding:
      position: 0
      prefix: '--gene_annotation_gtf'
      shellQuote: false
outputs:
  - id: output_mapping_stats
    type: File
    outputBinding:
      glob: '*mapping_stats'
  - id: output_mapping_stats.log
    type: File
    outputBinding:
      glob: '*mapping_stats.log'
label: compile_mapping_statistics
arguments:
  - position: 0
    prefix: '--output_prefix'
    shellQuote: false
    valueFrom: >-
      ${return inputs.name_sorted_sam_alignment_file.nameroot +
      "_mapping_stats"}
  - position: 0
    prefix: '--logfilename'
    shellQuote: false
    valueFrom: >-
      ${return inputs.name_sorted_sam_alignment_file.nameroot +
      "_mapping_stats.log"}
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: >-
      ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/gene_delivery_aav:0.0.1
  - class: InlineJavascriptRequirement
