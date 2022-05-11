class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: minimap2
baseCommand:
  - minimap2
inputs:
  - id: activate_homopolymer_kmer
    type: boolean?
  - 'sbg:toolDefaultValue': '200000'
    id: max_intron_length
    type: int?
    inputBinding:
      position: 0
      prefix: '-G'
      shellQuote: false
  - 'sbg:toolDefaultValue': '5'
    id: max_secondary_alignments
    type: int?
    inputBinding:
      position: 0
      prefix: '-N'
      shellQuote: false
  - 'sbg:toolDefaultValue': SAM
    id: output_format
    type:
      - 'null'
      - type: enum
        symbols:
          - SAM
          - PAF
        name: output_format
  - id: reference
    type: File
    inputBinding:
      position: 99
      shellQuote: false
  - id: raw_reads_filename
    type: File
    inputBinding:
      position: 100
      shellQuote: false
  - id: cs_tag
    type: boolean?
  - id: output_MD_tag
    type: boolean?
  - id: eqx
    type: boolean?
  - 'sbg:toolDefaultValue': '1'
    id: threads
    type: int?
    inputBinding:
      position: 0
      prefix: '-t'
      shellQuote: false
  - id: use_soft_clipping_for_secondary_alignments
    type: boolean?
outputs:
  - id: output_sam
    type: File?
    outputBinding:
      glob: '*sam'
  - id: output_paf
    type: File?
    outputBinding:
      glob: '*paf'
label: minimap2
arguments:
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          if(inputs.activate_homopolymer_kmer){ return "-H"}
          else {return ""}
      }
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          if(inputs.output_format=="SAM"){ return "-a";}
          else {return ""}
      }
  - position: 0
    prefix: '-o'
    shellQuote: false
    valueFrom: |-
      ${
          if(inputs.output_format=="SAM")
          {
              return inputs.raw_reads_filename.nameroot + "_aligned.sam"
          }
          else(inputs.output_format=="PAF")
          {
              return inputs.raw_reads_filename.nameroot + "_aligned.paf"
          }
      }
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          if(inputs.cs_tag)
          {
              return "--cs=long";
          }
          else
          {
              return "";
          }
      }
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          if(inputs.output_MD_tag) { return "--MD" }
          else { return ""}
      }
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: '${ if(inputs.eqx) {return "--eqx"} else {return ""} }'
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: >-
      ${ if(inputs.use_soft_clipping_for_secondary_alignments){ return "-Y" }
      else {return ""}

      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/minimap2:2.24'
  - class: InlineJavascriptRequirement
