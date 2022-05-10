class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bedgraph_to_bigwig
baseCommand:
  - bedGraphToBigWig
inputs:
  - id: coverage_over_reference_bed_format
    type: File
    inputBinding:
      position: 100
      shellQuote: false
  - id: crom_sizes
    type: File
    inputBinding:
      position: 101
      shellQuote: false
      valueFrom: '${return self.path+".fai"}'
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: '*bw'
label: bedgraph_to_bigwig
arguments:
  - position: 0
    prefix: coverage_over_reference_bw_format
    valueFrom: |-
      ${
          return inputs.coverage_over_reference_bed_format.nameroot + ".bw"
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: >-
      ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/bedgraph_to_bigwig:2.8
  - class: InlineJavascriptRequirement
