class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: medaka
baseCommand:
  - medaka_consensus
inputs: []
outputs: []
label: medaka
requirements:
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/medaka:1.6.0'
