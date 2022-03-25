class: Workflow
cwlVersion: 'sbg:draft-2'
id: star_generate_index
label: star_generate_index
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - type:
      - File
      - type: array
        items: File
    id: '#genomeFastaFiles'
    'sbg:includeInPorts': true
    'sbg:x': -1176
    'sbg:y': -353
  - type:
      - File
      - type: array
        items: File
    id: '#genomeFastaFiles_1'
    'sbg:includeInPorts': true
    'sbg:x': -1067
    'sbg:y': -181
  - type:
      - File
      - type: array
        items: File
    id: '#genome_fasta_files'
    'sbg:x': -1202
    'sbg:y': -482
    'sbg:includeInPorts': true
outputs: []
steps:
  - id: '#genomesaindexnbases'
    inputs:
      - id: '#genomesaindexnbases.genome_fasta_files'
        source:
          - '#genomeFastaFiles'
          - '#genomeFastaFiles_1'
          - '#genome_fasta_files'
    outputs:
      - id: '#genomesaindexnbases.output'
    run: ../../scripts/genomesaindexnbases.cwl
    label: genomeSAindexNbases
    'sbg:x': -882
    'sbg:y': -496
  - id: '#genomechrbinnbits'
    inputs:
      - id: '#genomechrbinnbits.genome_fasta_files'
        source:
          - '#genomeFastaFiles'
          - '#genomeFastaFiles_1'
          - '#genome_fasta_files'
    outputs:
      - id: '#genomechrbinnbits.output'
    run: ../../scripts/genomechrbinnbits.cwl
    label: genomeChrBinNbits
    'sbg:x': -799
    'sbg:y': -72
  - id: '#star_generate_index'
    inputs:
      - id: '#star_generate_index.genomeFastaFiles'
        source:
          - '#genomeFastaFiles'
          - '#genomeFastaFiles_1'
          - '#genome_fasta_files'
      - id: '#star_generate_index.genomeSAindexNbases'
        source: '#genomesaindexnbases.output'
      - id: '#star_generate_index.genomeChrBinNbits'
        source: '#genomechrbinnbits.output'
    outputs:
      - id: '#star_generate_index.output'
    run: ./star-generate-index.cwl
    label: star-generate-index
    'sbg:x': -595.1328125
    'sbg:y': -280
