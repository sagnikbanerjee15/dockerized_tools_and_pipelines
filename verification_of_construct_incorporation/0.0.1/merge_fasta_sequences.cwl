class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: merge_fasta_sequences
baseCommand:
  - merge_fasta_sequences
inputs:
  - id: construct
    type: File
    inputBinding:
      position: 0
      prefix: '--construct'
      shellQuote: false
  - id: five_prime_homology_arm
    type: File?
    inputBinding:
      position: 0
      prefix: '--five_ha'
      shellQuote: false
  - id: three_prime_homology_arm
    type: File?
    inputBinding:
      position: 0
      prefix: '--three_ha'
      shellQuote: false
  - id: primers
    type: File?
    inputBinding:
      position: 0
      prefix: '--primers'
      shellQuote: false
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: '*fasta'
label: merge_fasta_sequences
arguments:
  - position: 0
    prefix: '--output_filename'
    shellQuote: false
    valueFrom: '"input_fasta_sequences_merged.fasta"'
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: >-
      ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/verification_of_construct_incorporation:0.0.1
