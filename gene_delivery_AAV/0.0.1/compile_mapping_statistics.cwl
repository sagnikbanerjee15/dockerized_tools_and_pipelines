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
  - id: output_mapping_stats_log
    type: File
    outputBinding:
      glob: '*log'
  - id: output_read_length_vs_number_of_times_mapped
    type: File
    outputBinding:
      glob: '*read_length_vs_number_of_times_mapped.pdf'
  - id: output_hits_in_regions
    type: File
    outputBinding:
      glob: '*hits_in_regions.csv'
  - id: output_distribution_of_read_lengths_for_uniquely_mapped_reads
    type: File
    outputBinding:
      glob: '*distribution_of_read_lengths_for_uniquely_mapped_reads.pdf'
  - id: >-
      output_distribution_of_read_lengths_for_uniquely_mapped_vs_multi_mapped_reads
    type: File
    outputBinding:
      glob: >-
        *distribution_of_read_lengths_for_uniquely_mapped_vs_multi_mapped_reads.pdf
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
