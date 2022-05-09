class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bedtools_genomecoveragebed
baseCommand:
  - bedtools
  - genomecovergaebed
inputs: []
outputs: []
label: bedtools genomecoveragebed
requirements:
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/docker_tools_and_pipelines/bedtools:2.27.1'
