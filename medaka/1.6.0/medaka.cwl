class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: medaka
baseCommand:
  - medaka_consensus
inputs:
  - id: threads
    type: int?
    inputBinding:
      position: 0
      prefix: '-t'
      shellQuote: false
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '-d'
      shellQuote: false
  - id: input_fastq
    type: File
    inputBinding:
      position: 0
      prefix: '-i'
      shellQuote: false
outputs:
  - id: consensus
    type: File
    outputBinding:
      glob: '${return "nanopore_consensus/*consensus.fasta"}'
label: medaka
arguments:
  - position: 0
    prefix: '-f'
    shellQuote: false
  - position: 0
    prefix: '-o'
    valueFrom: '${return "nanopore_consensus"}'
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: ontresearch/medaka
  - class: InlineJavascriptRequirement
