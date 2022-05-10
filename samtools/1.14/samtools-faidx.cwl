class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_faidx
baseCommand:
  - ln
  - '-s'
inputs:
  - id: fa
    type: File
    inputBinding:
      position: 1
    doc: FastA file for reference genome
outputs:
  - id: fai
    type: File
    outputBinding:
      glob: '*.fai'
label: samtools-faidx
arguments:
  - position: 2
    prefix: ''
    valueFrom: $(inputs.fa.path)
  - position: 3
    valueFrom: '&&'
  - position: 4
    valueFrom: samtools
  - position: 5
    valueFrom: faidx
  - position: 6
    prefix: ''
    valueFrom: $(inputs.fa.basename)
  - position: 7
    valueFrom: '&&'
  - position: 8
    valueFrom: rm
  - position: 9
    valueFrom: $(inputs.fa.basename)
hints:
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/samtools:1.14'
requirements:
  - class: InlineJavascriptRequirement
