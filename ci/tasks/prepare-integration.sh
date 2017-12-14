#!/bin/bash

set -e -x

inputDir=  outputDir=  versionFile=  manifest=  artifactId=  packaging=

while [ $# -gt 0 ]; do
  case $1 in
    -i | --input-dir )
      inputDir=$2
      shift
      ;;
    -o | --output-dir )
      outputDir=$2
      shift
      ;;
    -v | --version-file )
      versionFile=$2
      shift
      ;;
    -m | --manifest )
      manifest=$2
      shift
      ;;
    -a | --artifactId )
      artifactId=$2
      shift
      ;;
    -p | --packaging )
      packaging=$2
      shift
      ;;
    * )
      echo "Unrecognized option: $1" 1>&2
      exit 1
      ;;
  esac
  shift
done

error_and_exit() {
  echo $1 >&2
  exit 1
}

if [ ! -d "$inputDir" ]; then
  error_and_exit "missing input directory: $inputDir"
fi
if [ ! -d "$outputDir" ]; then
  error_and_exit "missing output directory: $outputDir"
fi
if [ ! -f "$versionFile" ]; then
  error_and_exit "missing version file: $versionFile"
fi
if [ ! -f "$manifest" ]; then
  error_and_exit "missing manifest file: $manifest"
fi
if [ -z "$artifactId" ]; then
  error_and_exit "missing artifactId!"
fi
if [ -z "$packaging" ]; then
  error_and_exit "missing packaging!"
fi

version=`cat $versionFile`
artifactName="${artifactId}-${version}.${packaging}"
#appName="${artifactId}-${version}"
appName="${artifactId}"

echo $version
echo $artifactName
echo $appName

inputArtifact="$inputDir/$artifactName"
outputArtifact="$outputDir/$artifactName"


if [ ! -f "$inputArtifact" ]; then
  error_and_exit "can not find artifact: $inputArtifact"
fi

cp $inputArtifact $outputArtifact

# copy the manifest to the output directory and process it
outputManifest=$outputDir/manifest.yml

cp $manifest $outputManifest

# the path in the manifest is always relative to the manifest itself
sed -i -- "s|path: .*$|path: $artifactName|g" $outputManifest
#sed -i -- "/path: .*$/d" $outputManifest


sed -i "s|name: .*$|name: $appName|g" $outputManifest


cat $outputManifest

