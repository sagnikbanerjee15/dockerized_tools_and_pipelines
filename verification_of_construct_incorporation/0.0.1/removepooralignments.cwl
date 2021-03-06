class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: removepooralignments
baseCommand:
  - removePoorAlignments
inputs:
  - id: input_samfilename
    type: File
    inputBinding:
      position: 0
      prefix: '--input_samfilename'
      shellQuote: false
outputs:
  - id: output_sam
    type: File?
    outputBinding:
      glob: '*sam'
label: removePoorAlignments
arguments:
  - position: 0
    prefix: '--output_samfilename'
    shellQuote: false
    valueFrom: |-
      ${
          return inputs.input_samfilename.nameroot + "_cleaned.sam"
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: >-
      ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/verification_of_construct_incorporation:0.0.1
  - class: InlineJavascriptRequirement
