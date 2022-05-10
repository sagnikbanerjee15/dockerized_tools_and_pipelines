class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: pbaa_cluster
baseCommand: []
inputs:
  - 'sbg:toolDefaultValue': '1'
    id: num-threads
    type: int?
    inputBinding:
      position: 0
      prefix: '--num-threads'
      shellQuote: false
  - 'sbg:toolDefaultValue': '3'
    id: filter
    type: int?
    inputBinding:
      position: 0
      prefix: '--filter'
      shellQuote: false
    doc: >-
      Low coverage kmer count cutoff. Automatically adjusted by
      min-var-frequency
  - 'sbg:toolDefaultValue': '20'
    id: trim-ends
    type: int?
    inputBinding:
      position: 0
      prefix: '--trim-ends'
      shellQuote: false
    doc: Number of bases to trim from both sides of reads during graph construction
  - 'sbg:toolDefaultValue': '0.05'
    id: min-var-frequency
    type: float?
    inputBinding:
      position: 0
      prefix: '--min-var-frequency'
      shellQuote: false
    doc: Minimum variant frequency
  - id: no-cluster-by-length
    type: boolean?
    inputBinding:
      position: 0
      shellQuote: false
    doc: Disable fallback length clustering if no variants were discovered.
  - 'sbg:toolDefaultValue': '0.1'
    id: min-cluster-frequency
    type: float?
    inputBinding:
      position: 0
      prefix: '--min-cluster-frequency'
      shellQuote: false
    doc: Low frequency cluster cutoff.
  - 'sbg:toolDefaultValue': '5'
    id: min-cluster-read-count
    type: int?
    inputBinding:
      position: 0
      prefix: '--min-cluster-read-count'
      shellQuote: false
  - id: off-target-groups
    type: string?
    inputBinding:
      position: 0
      prefix: '--off-target-groups'
      shellQuote: false
    doc: 'Group names to exclude, i.e. these loci are off-target (not amplified).'
  - 'sbg:toolDefaultValue': '15000'
    id: max-amplicon-size
    type: int?
    inputBinding:
      position: 0
      prefix: '--max-amplicon-size'
      shellQuote: false
    doc: 'Upper read length cutoff, longer reads will be skipped.'
  - id: min-read-qv
    type: int?
    inputBinding:
      position: 0
      prefix: '--min-read-qv'
      shellQuote: false
    doc: Low read QV cutoff
  - id: reference
    type: File
    inputBinding:
      position: 101
      shellQuote: false
  - id: raw_reads_in_fastq
    type: File
    inputBinding:
      position: 102
      shellQuote: false
  - id: output_prefix
    type: string
    inputBinding:
      position: 103
      prefix: ''
      shellQuote: false
    doc: Output prefix for run.
  - 'sbg:toolDefaultValue': '30'
    id: pile-size
    type: int?
    inputBinding:
      position: 0
      prefix: '--pile-size'
      shellQuote: false
    doc: >-
      The number of best alignments to keep for each read during error
      correction.
  - 'sbg:toolDefaultValue': '1000'
    id: max-alignments-per-read
    type: int?
    inputBinding:
      position: 0
      prefix: '--max-alignments-per-read'
    doc: 'The number of random alignments, for each read, within a guide grouping'
  - 'sbg:toolDefaultValue': '500'
    id: max-reads-per-guide
    type: int?
    inputBinding:
      position: 0
      prefix: '--max-reads-per-guide'
      shellQuote: false
    doc: The number randomly selected reads to use within a guide grouping
  - 'sbg:toolDefaultValue': '9'
    id: iterations
    type: int?
    inputBinding:
      position: 0
      prefix: '--iterations'
    doc: Number of iterations to run k-means
  - 'sbg:toolDefaultValue': '1984'
    id: seed
    type: int?
    inputBinding:
      position: 0
      prefix: '--seed'
    doc: Randomization seed
  - id: pbaa_basecommand
    type: File?
    inputBinding:
      position: -1
      prefix: pbaa cluster
      shellQuote: false
outputs: []
label: pbaa cluster
arguments:
  - position: -2
    prefix: ''
    shellQuote: false
    valueFrom: |-
      ${
          return "cp " + inputs.reference.path + " . && samtools faidx "+ inputs.reference.basename + " && cp " + inputs.raw_reads_in_fastq.path + " . && samtools fqidx " + inputs.reference.basename +" &&"
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/pbbioconda:1.14'
  - class: InlineJavascriptRequirement
