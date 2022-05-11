class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: deepvariant_snp_call
baseCommand: []
inputs:
  - id: reference
    type: File
  - id: reads_mapped_to_reference_bam
    type: File
  - id: type
    type:
      type: enum
      symbols:
        - nanopore
        - pacbio
      name: type
  - 'sbg:toolDefaultValue': '1'
    id: cpu
    type: int?
outputs:
  - id: output_vcf
    type: File?
    outputBinding:
      glob: '*vcf'
label: deepvariant-snp-call
arguments:
  - position: 1
    prefix: ''
    shellQuote: false
    valueFrom: '${return "--model_type=PACBIO"}'
  - position: 2
    prefix: ''
    shellQuote: false
    valueFrom: '${return "--vcf_stats_report 0 "}'
  - position: 3
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return "--ref="+inputs.reference.basename
      }
  - position: 4
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return "--reads=" + inputs.reads_mapped_to_reference_bam.basename
      }
  - position: 5
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return "--output_vcf=" + inputs.type + "_deepvariant.vcf"
      }
  - position: 6
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return "--num_shards=" + inputs.cpu
      }
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return "cp " + inputs.reference.path + " . && " + " samtools faidx " + inputs.reference.basename + " && cp " + inputs.reads_mapped_to_reference_bam.path + " . && samtools index " + inputs.reads_mapped_to_reference_bam.basename + " && run_deepvariant "
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'google/deepvariant:1.3.0'
  - class: InlineJavascriptRequirement
