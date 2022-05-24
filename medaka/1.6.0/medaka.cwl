class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: medaka
baseCommand: []
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
      valueFrom: '${return self.basename}'
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
  - position: 1
    prefix: '-f'
    shellQuote: false
  - position: 2
    prefix: '-o'
    shellQuote: false
    valueFrom: '${return "nanopore_consensus"}'
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return "cp " + inputs.reference.path + " . && " + " samtools faidx " + inputs.reference.basename + " && medaka_consensus "
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: ontresearch/medaka
  - class: InlineJavascriptRequirement
