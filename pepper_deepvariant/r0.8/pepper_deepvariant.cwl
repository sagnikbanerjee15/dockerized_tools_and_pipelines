class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: pepper_deepvariant
baseCommand:
  - run_pepper_margin_deepvariant call_variant
inputs:
  - id: reads_mapped_to_reference_bam
    type: File
    inputBinding:
      position: 0
      prefix: '-b'
      shellQuote: false
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '-f'
      shellQuote: false
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
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'kishwars/pepper_deepvariant:r0.8'
  - class: InlineJavascriptRequirement
