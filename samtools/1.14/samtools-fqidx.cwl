class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_fqidx
baseCommand:
  - samtools
  - fqidx
inputs:
  - id: input_fastq
    type: File
    inputBinding:
      position: 100
      shellQuote: false
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: '*fai'
label: samtools-fqidx
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/samtools:1.14'
