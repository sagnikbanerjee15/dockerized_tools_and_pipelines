class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_faidx
baseCommand:
  - samtools
  - faidx
inputs:
  - id: input_fasta
    type: File
    inputBinding:
      position: 100
      shellQuote: false
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: '*fai'
label: samtools-faidx
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/samtools:1.14'
  - class: InlineJavascriptRequirement
