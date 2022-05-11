class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bedgraph_to_bigwig
baseCommand: []
inputs:
  - id: coverage_over_reference_bed_format
    type: File
    inputBinding:
      position: 1
      shellQuote: false
  - id: crom_sizes
    type: File
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: '*bw'
label: bedgraph_to_bigwig
arguments:
  - position: 3
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return  "coverage.bw"
      }
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: >-
      ${     return "cp " + inputs.crom_sizes.path + " . && samtools faidx "+
      inputs.crom_sizes.basename + " && bedGraphToBigWig " }
  - position: 2
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return inputs.crom_sizes.basename + ".fai"
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: >-
      ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/bedgraph_to_bigwig:2.8
  - class: InlineJavascriptRequirement
