class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: convertsamtogtf
baseCommand:
  - convertSAMToGTF
inputs:
  - id: sam_format_inputfilename
    type: File
    inputBinding:
      position: 0
      prefix: '--sam_format_inputfilename'
      shellQuote: false
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: '*gtf'
label: convertSAMToGTF
arguments:
  - position: 0
    prefix: '--gtf_format_outputfilename'
    valueFrom: |-
      ${
          return inputs.sam_format_inputfilename.nameroot + ".gtf"
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: >-
      ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/verification_of_construct_incorporation:0.0.1
