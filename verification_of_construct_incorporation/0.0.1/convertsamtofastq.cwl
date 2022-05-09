class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: convertsamtofastq
baseCommand:
  - convertSAMToFASTQ
inputs:
  - id: sam_format_inputfilename
    type: File
    inputBinding:
      position: 0
      prefix: '--sam_format_inputfilename'
outputs:
  - id: output_fastq
    type: File?
    outputBinding:
      glob: '*fastq'
label: convertSAMToFASTQ
arguments:
  - position: 0
    prefix: '--fastq_format_outputfilename'
    valueFrom: '${ return inputs.sam_format_inputfilename.nameroot + ".fastq"  }'
requirements:
  - class: DockerRequirement
    dockerPull: >-
      ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/verification_of_construct_incorporation:0.0.1
  - class: InlineJavascriptRequirement
