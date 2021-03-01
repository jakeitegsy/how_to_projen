function continue_prompt {
  read -p "press ENTER to continue..."
}

ProjectName="ProjectName"
UserName=$(git config --get user.name)
Email=$(git config --get user.email)

mkdir $ProjectName
cd $ProjectName
git init
npx projen new awscdk-construct
git add .
git commit -am "Initialize new AWSCDK-Construct"

filename=".projenrc.js"
cat $filename
continue_prompt
cat << EOF > $filename
const { NpmAccess } = require('projen');
const { ProjectType } = require('projen');
const { AwsCdkConstructLibrary } = require('projen');
const { DependabotScheduleInterval } = require('projen/lib/github');

const project = new AwsCdkConstructLibrary({
  author: '$UserName',
  authorAddress: '$Email',
  cdkVersion: '1.73.0',
  jsiiFqn: 'projen.AwsCdkConstructLibrary',
  name: '$ProjectName',
  repositoryUrl: 'https://github.com/$UserName/$ProjectName.git',
  defaultReleaseBranch: 'main',

  /* AwsCdkConstructLibraryOptions */
  cdkAssert: true,
  cdkDependencies: ['@aws-cdk/core', '@aws-cdk/aws-lambda'],
  docgen: true,
  eslint: true,
  publishToNuget: {
    dotNetNamespace: '$UserName.examples',
    packageId: '$ProjectName.Test'
  },
  publishToPyPi: {
    distName: '$ProjectName',
    module: '$ProjectName'
  },

  /* NodePackageOptions */
  npmAccess: NpmAccess.PUBLIC,

  /* NodeProjectOptions */
  dependabot: true,
  dependabotOptions: {
    automerge: false,
    ignoreProjen: false,
    scheduleInterval: DependabotScheduleInterval.WEEKLY,
  },
  gitignore: ['.idea'],
  releaseBranches: ['main'],
  releaseToNpm: true,
  releaseWorkflow: true,

  /* ProjectOptions */
  projectType: ProjectType.LIB,
});

project.synth()
EOF
cat $filename
git add .
git commit -am "Setup Projen options"
continue_prompt
npx projen

filename='src/index.ts'
cat << EOF > $filename
import { Code, Function, Runtime } from '@aws-cdk/aws-lambda';
import { Construct, Duration } from '@aws-cdk/core';

export class InlineLambdaConstruct extends Construct {
  constructor(parent: Construct, name: string) {
    super(parent, name);

    new Function(this, 'SampleFunction', {
      runtime: Runtime.NODEJS_12_X,
      code: Code.fromInline('exports.handler = function(event, context, callback) { console.log("Event: ", event); callback(); };'),
      handler: 'index.handler',
      timeout: Duration.seconds(10),
    });
  }
}
EOF
cat $filename
git add .
git commit -am "Create Custom InlineLambdaConstruct"
continue_prompt

rm -rf "test/hello.test.ts"
filename="test/index.test.ts"
cat << EOF > $filename
import { countResources, expect as expectCDK } from '@aws-cdk/assert';
import { App, Stack } from '@aws-cdk/core';
import { InlineLambdaConstruct } from '../src';

test('Simple test', () => {
  const app = new App();
  const stack = new Stack(app, 'TestStack');

  new InlineLambdaConstruct(stack, 'SimpleInlineLambdaConstruct');

  expectCDK(stack).to(countResources('AWS::Lambda::Function', 1));
})
EOF
cat $filename
git add .
git commit -am "Add test"
continue_prompt
npx projen build

git remote $ProjectName git@github.com:$UserName/$ProjectName 
git push -u $ProjectName main
