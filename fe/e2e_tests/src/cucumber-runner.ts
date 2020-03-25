import * as execa from 'execa';
import { generateReport } from './html-report';

export function runTests(feature, tags, parallelWorkersCount) {
  const featureFile = !!feature ? feature : 'src/features';
  const tagsParams = !!tags ? ['--tags', tags] : [];
  const runInParallelOpts = !!parallelWorkersCount ? ['--parallel', parallelWorkersCount] : [];
  console.log('executing cucumber tests');
  return execa(
    'cucumber-js',
    [
      '--require-module',
      'ts-node/register',
      '--require',
      'src/features/**/*.ts',
      '--require',
      'src/hooks/*.ts',
      '--format',
      'node_modules/cucumber-pretty',
      '--format',
      'json:reports/cucumber.json',
      ...runInParallelOpts,
      featureFile,
      ...tagsParams,
    ],
    {
      stdio: 'inherit',
    }
  )
    .then(() => generateReport())
    .catch(e => {
      return generateReport().then(() => {
        return Promise.reject(e);
      });
    });
}
