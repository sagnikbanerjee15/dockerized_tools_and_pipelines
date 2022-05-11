class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: merge_consensus_sequences
baseCommand:
  - merge_consensus_sequences
inputs:
  - id: whole_consensus_passed
    type: File
    inputBinding:
      position: 0
      prefix: '--whole_consensus_passed'
      shellQuote: false
  - id: whole_consensus_failed
    type: File
    inputBinding:
      position: 0
      prefix: '--whole_consensus_failed'
      shellQuote: false
  - id: construct_consensus_passed
    type: File
    inputBinding:
      position: 0
      prefix: '--construct_consensus_passed'
      shellQuote: false
  - id: construct_consensus_failed
    type: File
    inputBinding:
      position: 0
      prefix: '--construct_consensus_failed'
      shellQuote: false
  - id: output_filename_prefix
    type: string
    inputBinding:
      position: 0
      prefix: '--output_filename_prefix'
      shellQuote: false
outputs:
  - id: output_merged_consensus_fasta
    type: File?
    outputBinding:
      glob: '*fasta'
label: merge_consensus_sequences
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: >-
      ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/verification_of_construct_incorporation:0.0.1
