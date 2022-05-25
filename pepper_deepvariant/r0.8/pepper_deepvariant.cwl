class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: pepper_deepvariant
baseCommand: []
inputs:
  - id: reads_mapped_to_reference_bam
    type: File
    inputBinding:
      position: 0
      prefix: '-b'
      shellQuote: false
      valueFrom: '${return self.basename}'
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '-f'
      shellQuote: false
      valueFrom: '${return self.basename}'
  - id: threads
    type: int?
    inputBinding:
      position: 0
      prefix: '-t'
      shellQuote: false
  - id: ont_r10_q20
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--ont_r10_q20'
      shellQuote: false
  - 'sbg:toolDefaultValue': 'True'
    id: only_pepper
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--only_pepper'
      shellQuote: false
outputs:
  - id: PEPPER_VARIANT_FULL
    type: File?
    outputBinding:
      glob: '${return "pepper_deepvariant_output"/"*PEPPER_VARIANT_FULL.vcf.gz"}'
label: pepper_deepvariant
arguments:
  - position: 0
    prefix: '-o'
    shellQuote: false
    valueFrom: '${return "pepper_deepvariant_output"}'
  - position: -1
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return "cp " + inputs.reference.path + " . && " + " samtools faidx " + inputs.reference.basename + " && cp " + inputs.reads_mapped_to_reference_bam.path + " . && samtools index " + inputs.reads_mapped_to_reference_bam.basename + " && run_pepper_margin_deepvariant call_variant "
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'kishwars/pepper_deepvariant:r0.8'
  - class: InlineJavascriptRequirement
