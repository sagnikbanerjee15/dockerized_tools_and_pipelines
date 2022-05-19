class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_sort
baseCommand:
  - samtools
  - sort
inputs:
  - id: input_alignment
    type: File
    inputBinding:
      position: 100
      shellQuote: false
  - id: output_format
    type:
      - 'null'
      - type: enum
        symbols:
          - SAM
          - BAM
          - CRAM
        name: output_format
    inputBinding:
      position: 0
      prefix: '--output-fmt'
      shellQuote: false
  - id: threads
    type: int?
    inputBinding:
      position: 0
      prefix: '-@'
      shellQuote: false
  - id: sort_by_name
    type: boolean?
outputs:
  - id: output_bam
    type: File?
    outputBinding:
      glob: '*bam'
  - id: output_sam
    type: File?
    outputBinding:
      glob: '*sam'
  - id: output_cram
    type: File?
    outputBinding:
      glob: '*cram'
label: samtools sort
arguments:
  - position: 0
    prefix: '-o'
    shellQuote: false
    valueFrom: |-
      ${
        var suffix=".bam"
        if( inputs.output_format == "CRAM"){suffix='.cram'}
        if( inputs.output_format == "SAM"){suffix='.sam'}
        if( inputs.output_format == "BAM"){suffix='.bam'}
        
        if (inputs.sort_by_name)
          return inputs.input_alignment.nameroot + ".sortedByName" + suffix
        else
          return inputs.input_alignment.nameroot + ".sortedByPos" + suffix
      }
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          if(inputs.sort_by_name) {return "-n"}
          else {return ""}
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/samtools:1.14'
  - class: InlineJavascriptRequirement
