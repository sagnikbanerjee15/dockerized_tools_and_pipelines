class: Workflow
cwlVersion: v1.0
id: generate_annotation_file_for_construct_ha_primers
label: generate_annotation_file_for_construct_HA_primers
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: reference
    type: File
    'sbg:x': -498
    'sbg:y': -354
  - id: primers
    type: File?
    'sbg:x': -831.764404296875
    'sbg:y': -17.5
  - id: three_prime_homology_arm
    type: File?
    'sbg:x': -846.764404296875
    'sbg:y': -161.5
  - id: five_prime_homology_arm
    type: File?
    'sbg:x': -817.764404296875
    'sbg:y': 184.5
  - id: construct
    type: File
    'sbg:x': -792.764404296875
    'sbg:y': 346.5
outputs:
  - id: construct_HA_primer_gtf
    outputSource:
      - convertsamtogtf/output
    type: File?
    'sbg:x': 120.423095703125
    'sbg:y': -56.5
  - id: construct_gtf
    outputSource:
      - convertsamtogtf_1/output
    type: File?
    'sbg:x': 122.29290008544922
    'sbg:y': 221.3472137451172
steps:
  - id: minimap2
    in:
      - id: output_format
        default: SAM
      - id: reference
        source: reference
      - id: raw_reads_filename
        source: merge_fasta_sequences/output
    out:
      - id: output_sam
      - id: output_paf
    run: ../../minimap2/2.24/minimap2.cwl
    label: minimap2
    'sbg:x': -263
    'sbg:y': -182
  - id: merge_fasta_sequences
    in:
      - id: construct
        source: construct
      - id: five_prime_homology_arm
        source: five_prime_homology_arm
      - id: three_prime_homology_arm
        source: three_prime_homology_arm
      - id: primers
        source: primers
    out:
      - id: output
    run: ./merge_fasta_sequences.cwl
    label: merge_fasta_sequences
    'sbg:x': -471.764404296875
    'sbg:y': -47.5
  - id: convertsamtogtf
    in:
      - id: sam_format_inputfilename
        source: minimap2/output_sam
    out:
      - id: output
    run: ./convertsamtogtf.cwl
    label: convertSAMToGTF
    'sbg:x': -52.576904296875
    'sbg:y': -188.5
  - id: minimap3
    in:
      - id: output_format
        default: SAM
      - id: reference
        source: reference
      - id: raw_reads_filename
        source: construct
    out:
      - id: output_sam
      - id: output_paf
    run: ../../minimap2/2.24/minimap2.cwl
    label: minimap2
    'sbg:x': -229.59527587890625
    'sbg:y': 113.96613311767578
  - id: convertsamtogtf_1
    in:
      - id: sam_format_inputfilename
        source: minimap3/output_sam
    out:
      - id: output
    run: ./convertsamtogtf.cwl
    label: convertSAMToGTF
    'sbg:x': -8.038732528686523
    'sbg:y': 124.19062805175781
requirements: []
