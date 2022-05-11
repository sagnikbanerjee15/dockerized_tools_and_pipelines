class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: extract_long_reads_containing_complete_construct
baseCommand: []
inputs:
  - id: reads_overlapping_partially_with_construct_bed
    type: File
  - id: raw_reads
    type: File
  - id: type_of_sequencing
    type:
      type: enum
      symbols:
        - nanopore
        - pacbio
      name: type_of_sequencing
outputs:
  - id: output_fastq
    type: File?
    outputBinding:
      glob: '*reads_overlapping_partially_with_construct.fastq'
label: extract_long_reads_containing_complete_construct
arguments:
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return "cat " + inputs.reads_overlapping_partially_with_construct_bed.path + " |cut -f16 > reads_ids_overlapping_partially_with_construct && " + "grep -A 3 --no-group-separator -f reads_ids_overlapping_partially_with_construct " + inputs.raw_reads.path + " > " + inputs.type_of_sequencing + "_reads_overlapping_partially_with_construct.fastq"
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: ubuntu
  - class: InlineJavascriptRequirement
