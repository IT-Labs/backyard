import * as path from 'path';

class PathHelper {
  root(...folders: string[]): string {
    return path.join(__dirname, '../../', ...folders);
  }

  src(...folders: string[]): string {
    return path.join(this.root(), 'src', ...folders);
  }

  build(...folders: string[]): string {
    return path.join(this.root(), 'build', ...folders);
  }
}

export const pathHelper = new PathHelper();
